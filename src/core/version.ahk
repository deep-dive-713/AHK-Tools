;=========================================
; バージョン管理とアップデートチェック機能
;=========================================
#Requires AutoHotkey v1.1
#Include %A_ScriptDir%\Lib\JSON.ahk  ; JSONライブラリを追加

;=========================================
; グローバル変数の定義
;=========================================
global VERSION := "0.0.1"                    ; 現在のバージョン
global CHECK_INTERVAL_HOURS := 1            ; アップデートチェックの間隔（時間）
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

;=========================================
; アップデートチェック関数
;=========================================
; アップデートチェックを初期化（起動時に実行）
InitializeUpdateCheck() {
    ; 起動時にチェック
    CheckUpdate()
    
    ; 定期チェックを設定
    SetTimer, CheckUpdateWithInterval, % CHECK_INTERVAL_MS
}

; 定期的なアップデートチェックを行う関数
CheckUpdateWithInterval() {
    ; 前回のチェック時刻を読み込み
    IniRead, lastCheck, %A_ScriptDir%\config.ini, Update, LastCheck, 0
    
    ; 前回のチェックから指定時間が経過したかを確認
    timeDiff := A_Now
    EnvSub, timeDiff, lastCheck, Hours
    
    ; 指定時間が経過していれば新バージョンをチェック
    if (timeDiff >= CHECK_INTERVAL_HOURS) {
        CheckUpdate()
        ; 最終チェック時刻を更新
        IniWrite, %A_Now%, %A_ScriptDir%\config.ini, Update, LastCheck
    }
}

; GitHubから最新バージョンを取得してチェックする関数
CheckUpdate() {
    try {
        WriteLog("Starting update check")
        
        url := "https://api.github.com/repos/deep-dive-713/AHK-Tools/releases"
        tmpFile := A_ScriptDir . "\temp_release.json"
        
        WriteLog("Downloading from: " . url)
        UrlDownloadToFile, %url%, %tmpFile%
        
        if (!FileExist(tmpFile)) {
            throw "Failed to download release information"
        }
        
        FileRead, responseText, %tmpFile%
        FileDelete, %tmpFile%
        
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
ShowUpdateNotification(latestVersion, releaseNotes, isPrerelease) {
    message := "New version available!`n"
            . "Current version: " . VERSION . "`n"
            . "New version: " . latestVersion . (isPrerelease ? " (Pre-release)" : "")
            . notesText := releaseNotes ? "`n`nRelease Notes:`n" . releaseNotes : ""
    
    MsgBox, 4,, %message%
    IfMsgBox Yes
    {
        Run, https://github.com/deep-dive-713/AHK-Tools/releases/latest
    }
}

;=========================================
; 初期化実行
;=========================================
InitializeUpdateCheck()
