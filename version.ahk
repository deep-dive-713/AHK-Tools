;=========================================
; バージョン管理とアップデートチェック機能
;=========================================
#Requires AutoHotkey v1.1
#Include %A_ScriptDir%\Lib\JSON.ahk  ; JSONライブラリを追加
SetWorkingDir %A_ScriptDir%

;=========================================
; グローバル変数の定義
;=========================================
global VERSION := "1.0.0"            ; 現在のバージョン
global CHECK_INTERVAL := 24          ; アップデートチェックの間隔（24時間 = 1日）

;=========================================
; アップデートチェック関連の関数
;=========================================
; 定期的なアップデートチェックを行う関数
CheckUpdateWithInterval() {
    ; 前回のチェック時刻を読み込み
    IniRead, lastCheck, %A_ScriptDir%\config.ini, Update, LastCheck, 0
    
    ; 前回のチェックから24時間が経過したかを確認
    timeDiff := A_Now
    EnvSub, timeDiff, lastCheck, Hours
    
    ; 24時間が経過していれば新バージョンをチェック
    if (timeDiff >= CHECK_INTERVAL) {
        CheckUpdate()
        ; 最終チェック時刻を更新
        IniWrite, %A_Now%, %A_ScriptDir%\config.ini, Update, LastCheck
    }
}

; GitHubから最新バージョンを取得してチェックする関数
CheckUpdate() {
    try {
        ; GitHubのAPIを使用して最新バージョン情報を取得
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", "https://api.github.com/repos/YourUsername/AHK-Tools/releases/latest", false)
        whr.Send()
        
        ; レスポンスをJSONとして解析
        response := JSON.Load(whr.ResponseText)
        latestVersion := StrReplace(response.tag_name, "v", "")
        
        ; 新バージョンが利用可能な場合はユーザーに通知
        if (latestVersion != VERSION) {
          releaseBody := response["body"]
          releaseUrl := response["html_url"]
          
          MsgBox, 4, AHK-Tools アップデート通知, 新しいバージョン（v%latestVersion%）が利用可能です。`n`n【更新内容】`n%releaseBody%`n`nダウンロードページを開きますか？
          
          IfMsgBox Yes
              Run %releaseUrl%
      }
  } catch e {
      ; エラー時は静かに失敗（ユーザーの作業を妨げない）
      FileAppend, Update check failed: %e%.Message`n, %A_ScriptDir%\error.log
  }
}

;=========================================
; タイマー設定
;=========================================
; 24時間（1日）ごとにアップデートチェックを実行
SetTimer, CheckUpdateWithInterval, 86400000  ; 86400000ミリ秒 = 24時間
