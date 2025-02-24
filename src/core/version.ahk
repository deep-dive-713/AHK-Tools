;=========================================
; バージョン管理とアップデートチェック機能
;=========================================
#Requires AutoHotkey v1.1
#Include %A_ScriptDir%\Lib\JSON.ahk  ; JSONライブラリを追加

;=========================================
; グローバル変数の定義
;=========================================
global VERSION := "0.0.1"                    ; 現在のバージョン
global CHECK_INTERVAL_HOURS := 1             ; アップデートチェックの間隔（時間）
; global CHECK_INTERVAL_MS := 10000            ; デバッグ用
global CHECK_INTERVAL_MS := CHECK_INTERVAL_HOURS * 60 * 60 * 1000  ; ミリ秒に変換
global LOG_DIR := A_ScriptDir . "\logs"      ; ログディレクトリのパス
global ERROR_LOG := LOG_DIR . "\error.log"   ; エラーログのパス
global DEBUG_LOG := LOG_DIR . "\debug.log"   ; デバッグログのパス
global CONFIG_DIR := A_ScriptDir . "\config"        ; configディレクトリのパス
global CONFIG_FILE := CONFIG_DIR . "\settings.ini"  ; configファイルのパス

;=========================================
; 初期化実行
;=========================================
; ログディレクトリの作成
IfNotExist, %LOG_DIR%
{
    FileCreateDir, %LOG_DIR%
    if ErrorLevel  ; エラーが発生した場合
    {
        MsgBox, Failed to create logs directory
        ExitApp
    }
}

; 設定ディレクトリの作成
IfNotExist, %CONFIG_DIR%
{
    FileCreateDir, %CONFIG_DIR%
    if ErrorLevel  ; エラーが発生した場合
    {
        MsgBox, Failed to create configs directory
        ExitApp
    }
}

InitializeUpdateCheck()

;=========================================
; ログ出力関数
;=========================================
WriteLog(message, isError = false) {
    global LOG_DIR, ERROR_LOG, DEBUG_LOG
    
    ; タイムスタンプの生成
    FormatTime, timestamp,, yyyy-MM-dd HH:mm:ss
    logMessage = %timestamp% - %message%`n
    
    ; ログファイルの選択とメッセージの書き込み
    logFile := isError ? ERROR_LOG : DEBUG_LOG
    FileAppend, %logMessage%, %logFile%
}

;=========================================
; 設定ファイルの読み書き
;=========================================
WriteSkipVersion(version) {
    global CONFIG_FILE
    IniWrite, %version%, %CONFIG_FILE%, Update, SkipVersion
}

ReadSkipVersion() {
    global CONFIG_FILE
    IniRead, skipVersion, %CONFIG_FILE%, Update, SkipVersion, ""
    return skipVersion
}

; ;=========================================
; ; アップデートチェック関数
; ;=========================================
InitializeUpdateCheck() {
    ; 初期化ログ
    WriteLog("Initializing update check system")

    ; 定期チェックを設定
    WriteLog("Setting timer for: " . CHECK_INTERVAL_HOURS . " h") 
    SetTimer, CheckUpdateWithInterval, %CHECK_INTERVAL_MS%  ; %を追加
}

; ;=========================================
; ; 定期チェック用のラベル
; ;=========================================
CheckUpdateWithInterval:
    ; WriteLog("Running scheduled update check") ; debug
    CheckUpdate()
return

; GitHubから最新バージョンを取得してチェックする関数
CheckUpdate() {
    try {
        ; WriteLog("Starting update check") ; debug
        
        url := "https://api.github.com/repos/deep-dive-713/AHK-Tools/releases"
        tmpFile := A_ScriptDir . "\temp_release.json"

        ; APIリクエストヘッダーの設定
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", url, true)
        whr.SetRequestHeader("User-Agent", "AHK-Tools")
        
        ; WriteLog("Sending API request") ; debug
        whr.Send()
        whr.WaitForResponse()
        
        ; レスポンスヘッダーのチェック
        remainingRequests := whr.GetResponseHeader("X-RateLimit-Remaining")
        ; WriteLog("Remaining API requests: " . remainingRequests)  ; debug
        
        if (whr.Status = 403) {
            WriteLog("Rate limit exceeded. Status: " . whr.Status, true)
            return
        }
        
        responseText := whr.ResponseText
        ; レスポンスの内容確認
        ; WriteLog("Response received: " . (responseText ? "Yes" : "No"))  ; debug
        
        ; JSONとしてパース
        releases := JSON.Load(responseText)
        if (!releases || !releases.Length()) {
            throw "No releases found"
        }

        ; 最新リリースの情報を取得
        latestRelease := releases[1]
        tag := latestRelease.tag_name
        isPrerelease := latestRelease.prerelease
        releaseNotes := latestRelease.body
        
        ; バージョン番号の抽出
        latestVersion := RegExReplace(tag, "^v")
        
        WriteLog("Latest version: " . latestVersion)
        WriteLog("Is prerelease: " . (isPrerelease ? "Yes" : "No"))
        WriteLog("Current version: " . VERSION)
        
        if (latestVersion != VERSION) {
            ShowUpdateNotification(latestVersion, releaseNotes, isPrerelease)
        }
        
    } catch e {
        WriteLog("Error: " . (IsObject(e) ? "JSON parsing failed" : e), true)
    }
}

;=========================================
; 通知GUI関数（最小限の機能）
;=========================================
; ShowUpdateNotification(latestVersion, releaseNotes, isPrerelease) {
;     Gui, UpdateNotify:New, +AlwaysOnTop
;     Gui, Font, s12, Segoe UI
    
;     ; ヘッダー
;     ; if (FileExist(A_ScriptDir . "\assets\update-icon.png")) {
;     ;     Gui, Add, Picture, x10 y10 w32 h32, %A_ScriptDir%\assets\update-icon.png
;     ; }
;     Gui, Add, Text, x50 y15 cBlue, % "New Version Available: v" . latestVersion
    
;     ; ボタン
;     Gui, Add, Button, x10 y290 w120 h30 gAutoUpdate, Auto Update
;     Gui, Add, Button, x140 y290 w120 h30 gOpenReleasePage, Download Page
;     Gui, Add, Button, x270 y290 w120 h30 gRemindLater, Remind Later
    
;     ; 設定
;     Gui, Add, CheckBox, x10 y330 vSkipPrerelease, Skip pre-release versions
    
;     Gui, Show,, Update Available
; }

ShowUpdateNotification(latestVersion, releaseNotes, isPrerelease) {
    ; WriteLog("Starting ShowUpdateNotification")   ; debug
    
    try {
        Gui, UpdateNotify:New, +AlwaysOnTop
        ; WriteLog("Created GUI window")   ; debug
        
        Gui, Font, s12, Segoe UI
        
        ; バージョン情報
        Gui, Add, Text, x10 y10, % "New Version Available: v" . latestVersion

        Gui, Add, GroupBox, x10 y40 w680 h70, Version Info
        Gui, Add, Text, x20 y60, % "Current: v" . VERSION
        Gui, Add, Text, x20 y80, % "Latest: v" . latestVersion . (isPrerelease ? " (Beta)" : "")
        
        ; リリースノート
        if (releaseNotes) {
            Gui, Add, GroupBox, x10 y130 w680 h300, Release Notes
            Gui, Add, Edit, x20 y150 w660 h280 ReadOnly, %releaseNotes%
        }
        
        ; ボタン
        Gui, Add, Button, x10 y440 w130 h30 gOpenReleasePage, Download Page
        Gui, Add, Button, x140 y440 w120 h30 gRemindLater, Remind Later
        
        ; WriteLog("Added all GUI elements")  ; デバッグログ
        
        Gui, Show,, Update Available
        ; WriteLog("GUI should be visible now")  ; デバッグログ
        
    } catch e {
        WriteLog("Error in ShowUpdateNotification: " . e, true)  ; エラーログ
    }
}

;=========================================
; GUIイベントハンドラ
;=========================================
; AutoUpdate:
;     Gui, UpdateNotify:Destroy
;     ; TODO: 自動アップデート機能の実装
;     WriteLog("Auto update clicked")
; return

OpenReleasePage:
    WriteLog("OpenReleasePage clicked")  ; デバッグログ
    Gui, UpdateNotify:Destroy
    Run, https://github.com/deep-dive-713/AHK-Tools/releases/latest
return

RemindLater:
    WriteLog("RemindLater clicked")  ; デバッグログ
    Gui, UpdateNotify:Destroy
return

UpdateNotifyGuiClose:
UpdateNotifyGuiEscape:
    WriteLog("GUI closed")  ; デバッグログ
    Gui, UpdateNotify:Destroy
return
