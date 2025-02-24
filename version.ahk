;=========================================
; バージョン管理とアップデートチェック機能
;=========================================
#Include %A_ScriptDir%\Lib\JSON.ahk  ; JSONライブラリを追加

;=========================================
; グローバル変数の定義
;=========================================
global VERSION := "0.0.1"                    ; 現在のバージョン
global CHECK_INTERVAL_HOURS := 24            ; アップデートチェックの間隔（時間）
global CHECK_INTERVAL_MS := CHECK_INTERVAL_HOURS * 60 * 60 * 1000  ; ミリ秒に変換
global LOG_DIR := A_ScriptDir . "\logs"      ; ログディレクトリのパス
global ERROR_LOG := LOG_DIR . "\error.log"   ; エラーログのパス
global DEBUG_LOG := LOG_DIR . "\debug.log"   ; デバッグログのパス

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
; アップデートチェック関連の関数
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
        ; 初期化
        WriteLog("Starting update check")
        
        ; プレリリースも含めて全てのリリースを取得
        url := "https://api.github.com/repos/deep-dive-713/AHK-Tools/releases"
        tmpFile := A_ScriptDir . "\temp_release.json"
        
        WriteLog("Downloading from: " . url)
        UrlDownloadToFile, %url%, %tmpFile%
        
        if (!FileExist(tmpFile)) {
            throw "Failed to download release information"
        }
        
        FileRead, responseText, %tmpFile%
        FileDelete, %tmpFile%
        
        ; デバッグ情報の記録
        WriteLog("Response: " . responseText)
        
        ; レスポンスの解析
        RegExMatch(responseText, "U)""tag_name"":""([^""]+)""", tag)
        WriteLog("Found tag: " . tag1)
        
        ; バージョン番号の抽出
        latestVersion := RegExReplace(tag1, "^v")
        WriteLog("Extracted version: " . latestVersion)
        WriteLog("Current VERSION: " . VERSION)
        
        if (latestVersion = "") {
            WriteLog("Error: Latest version is empty", true)
            return
        }
        
        WriteLog("Comparing versions: [Latest: " . latestVersion . "] [Current: " . VERSION . "]")
        
        if (latestVersion != VERSION) {
            WriteLog("Update needed: versions are different")
            MsgBox, 4,, Update available (%latestVersion%). Would you like to open the download page?
            
            IfMsgBox Yes
                Run, https://github.com/deep-dive-713/AHK-Tools/releases/latest
        } else {
            WriteLog("No update needed: versions are same")
        }
        
    } catch e {
        WriteLog("Error: " . (IsObject(e) ? "Download failed" : e), true)
        WriteLog("Debug: " . e, true)
    }
}

;=========================================
; 初期化実行
;=========================================
InitializeUpdateCheck()
