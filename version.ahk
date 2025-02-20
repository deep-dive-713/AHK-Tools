; 定数定義
global VERSION := "0.0.0"
CONFIG_DIR := A_ScriptDir . "\config"
CONFIG_FILE := CONFIG_DIR . "\settings.ini"
LOG_DIR := A_ScriptDir . "\logs"
DEBUG_LOG := LOG_DIR . "\debug.log"
ERROR_LOG := LOG_DIR . "\error.log"

; メッセージ定義（UTF-8で保存すること）
UPDATE_TITLE = アップデート通知
UPDATE_AVAILABLE = 新しいバージョンが利用可能です！
CURRENT_VERSION = 現在のバージョン: 
NEW_VERSION = 新しいバージョン: 
PRERELEASE_TEXT = （プレリリース）
RELEASE_NOTES = 更新内容:
BTN_DOWNLOAD = ダウンロードページへ
BTN_REMIND = 後で通知
BTN_SKIP = このバージョンをスキップ

; 初期化処理
InitializeConfig() {
    global CONFIG_DIR, CONFIG_FILE, LOG_DIR, DEBUG_LOG, ERROR_LOG
    
    ; ディレクトリの作成
    IfNotExist, %CONFIG_DIR%
    {
        FileCreateDir, %CONFIG_DIR%
        if ErrorLevel
        {
            MsgBox, Failed to create config directory: %CONFIG_DIR%
            return false
        }
    }
    
    IfNotExist, %LOG_DIR%
    {
        FileCreateDir, %LOG_DIR%
        if ErrorLevel
        {
            MsgBox, Failed to create log directory: %LOG_DIR%
            return false
        }
    }
    
    ; 設定ファイルの初期化
    IfNotExist, %CONFIG_FILE%
    {
        IniWrite, "", %CONFIG_FILE%, Update, SkipVersion
        if ErrorLevel
        {
            MsgBox, Failed to initialize config file: %CONFIG_FILE%
            return false
        }
    }
    
    ; ログファイルの初期化
    IfNotExist, %DEBUG_LOG%
    {
        FileAppend,, %DEBUG_LOG%
        if ErrorLevel
        {
            MsgBox, Failed to initialize debug log: %DEBUG_LOG%
            return false
        }
    }
    
    IfNotExist, %ERROR_LOG%
    {
        FileAppend,, %ERROR_LOG%
        if ErrorLevel
        {
            MsgBox, Failed to initialize error log: %ERROR_LOG%
            return false
        }
    }
    
    return true
}

; ログ出力関数
WriteLog(message, isError = false) {
    global DEBUG_LOG, ERROR_LOG
    
    FormatTime, timestamp,, yyyy-MM-dd HH:mm:ss
    logFile := isError ? ERROR_LOG : DEBUG_LOG
    
    FileAppend, %timestamp% - %message%`n, %logFile%
    if ErrorLevel
    {
        MsgBox, Failed to write to log file: %logFile%
    }
}

; 設定ファイルの操作
WriteSkipVersion(version) {
    IniWrite, %version%, %CONFIG_FILE%, Update, SkipVersion
}

ReadSkipVersion() {
    IniRead, skipVersion, %CONFIG_FILE%, Update, SkipVersion, ""
    return skipVersion
}

; アップデートチェック
CheckUpdate() {
    try {
        ; 初期化
        InitializeConfig()
        WriteLog("Starting update check")
        
        ; GitHubからリリース情報を取得
        url := "https://api.github.com/repos/deep-dive-713/AHK-Tools/releases"
        WriteLog("Downloading from: " . url)
        
        tmpFile := A_ScriptDir . "\temp_release.json"
        UrlDownloadToFile, %url%, %tmpFile%
        
        if (!FileExist(tmpFile)) {
            throw "Failed to download release information"
        }
        
        FileRead, responseText, %tmpFile%
        FileDelete, %tmpFile%
        
        WriteLog("Response: " . responseText)
        
        ; バージョン情報の解析
        RegExMatch(responseText, "U)""tag_name"":""([^""]+)""", tag)
        WriteLog("Found tag: " . tag1)
        
        ; バージョン番号の抽出
        latestVersion := RegExReplace(tag1, "^v")
        WriteLog("Extracted version: " . latestVersion)
        WriteLog("Current VERSION: " . VERSION)
        
        ; スキップバージョンのチェック
        skipVersion := ReadSkipVersion()
        if (skipVersion = latestVersion) {
            WriteLog("Skipping version: " . latestVersion)
            return
        }
        
        ; バージョン比較
        if (latestVersion != VERSION) {
            RegExMatch(responseText, "U)""prerelease"":([^,]+)", isPrerelease)
            preReleaseText := isPrerelease1 = "true" ? PRERELEASE_TEXT : ""
            
            RegExMatch(responseText, "U)""body"":""([^""]+)""", releaseNotes)
            notes := releaseNotes1 ? "`n`n" . RELEASE_NOTES . "`n" . releaseNotes1 : ""
            
            message := UPDATE_AVAILABLE . "`n"
                    . CURRENT_VERSION . VERSION . "`n"
                    . NEW_VERSION . latestVersion . preReleaseText
                    . notes
            
            WriteLog("Showing update notification")
            
            Gui, UpdateNotify:New, +AlwaysOnTop
            Gui, Font, s10
            Gui, Add, Text,, %message%
            Gui, Add, Button, gOpenReleasePage w120, %BTN_DOWNLOAD%
            Gui, Add, Button, gRemindLater x+10 w120, %BTN_REMIND%
            Gui, Add, Button, gSkipVersion x+10 w120, %BTN_SKIP%
            Gui, Show,, %UPDATE_TITLE%
            return
            
            OpenReleasePage:
                Run, https://github.com/deep-dive-713/AHK-Tools/releases/latest
                Gui, UpdateNotify:Destroy
            return
            
            RemindLater:
                Gui, UpdateNotify:Destroy
            return
            
            SkipVersion:
                WriteSkipVersion(latestVersion)
                WriteLog("Version skipped: " . latestVersion)
                Gui, UpdateNotify:Destroy
            return
        }
        
    } catch e {
        error_msg := "Error: " . (IsObject(e) ? "Download failed" : e)
        WriteLog(error_msg, true)
        WriteLog("Debug: " . e, true)
    }
}
