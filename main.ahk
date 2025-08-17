;=========================================
; AHK-Tools メインスクリプト
;=========================================
#Requires AutoHotkey v2.0
#SingleInstance Force

;=========================================
; キー送信の説明
;=========================================
/*
Send "{key}"      ; キーを1回送信
Send "{key n}"    ; キーをn回送信
Send "{key down}" ; キーを押し続ける
Send "{key up}"   ; キーを離す
*/

;=========================================
; 修飾キーの説明
;=========================================
/*
# = Windowsキー
! = Altキー
^ = Controlキー
+ = Shiftキー
< = 左修飾キー (例: <^)
> = 右修飾キー (例: >^)
*/

;=========================================
; 基本設定
;=========================================
SetWorkingDir A_ScriptDir  ; スクリプトの作業ディレクトリを設定
A_HotkeyInterval := 2000
A_MaxHotkeysPerInterval := 200

;=========================================
; 基本的なショートカット
;=========================================
; CapsLock切り替え
RShift & F13:: {
    if GetKeyState("CapsLock", "T")
        SetCapsLockState "AlwaysOff"
    else
        SetCapsLockState "On"
}

;=========================================
; サブスクリプトの読み込み
;=========================================
; 基本機能
#Include "src\core\search.ahk"          ; クイック検索
#Include "src\core\image_display.ahk"   ; 画像表示

; F13 + キー コマンド群
#Include "src\shortcuts\cursor_movement.ahk"    ; カーソル移動
#Include "src\shortcuts\editing.ahk"            ; テキスト編集
#Include "src\shortcuts\mouse_actions.ahk"      ; マウス操作
#Include "src\shortcuts\symbols.ahk"            ; 記号入力
#Include "src\shortcuts\number.ahk"             ; 数字入力

; アプリケーション固有の設定
#Include "src\apps\office.ahk"          ; Microsoft Office
; #Include "src\apps\office2016.ahk"    ; Microsoft Office 2016用
#Include "src\apps\word_ppt.ahk"        ; MS Word, PowerPoint用
#Include "src\apps\browser.ahk"         ; ブラウザ
#Include "src\apps\JIS2US.ahk"          ; JIS/US配列変換（JIS配列キーボードを使っている人向け、US配列の人は要コメントアウト）
#Include "src\apps\other_apps.ahk"      ; その他アプリ

; バージョン管理とアップデート機能（メンテナンス中）
; #Include "src\core\version.ahk"

;=========================================
; サブスクリプトの実行と終了処理
;=========================================
; word_ppt.ahkを別プロセスとして実行し、PIDを保存
WordPptPID := ""
try {
    exe_path := "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
    script_path := A_ScriptDir "\src\apps\word_ppt.ahk"
    ; script_path := A_ScriptDir "\src\apps\word_ppt_2016.ahk" ; Office2016用
    
    Run '"' exe_path '" "' script_path '"',, "Hide", &WordPptPID
    
    ; for debug
    ; if !WordPptPID {
    ;     MsgBox "PID取得失敗"
    ; } else {
    ;     MsgBox "PID取得成功: " WordPptPID
    ; }
} catch as err {
    MsgBox "エラー発生: " err.Message
}

; スクリプト終了時の処理
OnExit ExitHandler

; =========================================
; 終了処理
; =========================================
ExitSub:
ExitHandler(ExitReason, ExitCode) {
    global WordPptPID
    if WordPptPID
        ProcessClose WordPptPID
}
