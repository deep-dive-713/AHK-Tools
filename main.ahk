#Requires AutoHotkey v1.1

;=====================================
; キー送信の文法
;=====================================
; Send, {key}      ; キーを1回送信
; Send, {key n}    ; キーをn回送信
; Send, {key down} ; キーを押し続ける
; Send, {key up}   ; キーを離す
; SendInput        ; 高速なキー送信
; SendPlay         ; UIオートメーション対応
; SendEvent        ; 従来のキー送信方式
; SendRaw          ; 特殊文字をそのまま送信

;=====================================
; 修飾キーの文法
;=====================================
; # = Windowsキー
; ! = Altキー
; ^ = Controlキー
; + = Shiftキー
; < = 左修飾キー (例: <^)
; > = 右修飾キー (例: >^)

;=====================================
; 基本設定
;=====================================
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%

;=====================================
; サブスクリプトの実行
;=====================================
; office.ahkを別プロセスとして通常モードで実行
; UI Accessモードではoffice.ahk内のCOMオブジェクトが正常に動作しないため、
; 別プロセスとして通常モードで実行する
Run, AutoHotkey.exe "%A_ScriptDir%\apps\office.ahk"

; スクリプト終了時の処理を登録
; main.ahkが終了する際に、office.ahkも確実に終了させる
OnExit, ExitSub

;=====================================
; 基本設定の追加
;=====================================
#HotkeyInterval, 2000
#MaxHotkeysPerInterval, 200

;=====================================
; 外部スクリプトの読み込み
;=====================================
#Include %A_ScriptDir%/Search.ahk

;=====================================
; 基本的なショートカット
;=====================================
; CapsLock切り替え
RShift & F13::
    if(GetKeyState("CapsLock", "T")){
        SetCapsLockState,AlwaysOff
    } else {
        SetCapsLockState,On
    }
return

; テキスト検索
+MButton::search()

;=====================================
; F13 + キー コマンド群
;=====================================
; カーソル移動
#Include %A_ScriptDir%\shortcuts/cursor_movement.ahk

; テキスト編集
#Include %A_ScriptDir%\shortcuts/editing.ahk

; マウス操作
#Include %A_ScriptDir%\shortcuts/mouse_actions.ahk

; 記号入力
#Include %A_ScriptDir%\shortcuts/symbols.ahk

;=====================================
; アプリケーション固有の設定
;=====================================
; Microsoft Office
#Include %A_ScriptDir%\apps/office.ahk

; ブラウザ
#Include %A_ScriptDir%\apps/browser.ahk

; VWP用 JIS配列をUS配列に変換
; JIS配列のキーボードを使用している場合に、US配列として認識させる
#Include %A_ScriptDir%\apps/JIS2US.ahk

; その他アプリケーション
#Include %A_ScriptDir%\apps/other_apps.ahk

;=====================================
; 終了処理
;=====================================
ExitSub:
; office.ahkプロセスを終了
; 裏で動き続けるのを防ぎ、システムリソースを適切に解放する
Process, Close, AutoHotkey.exe "%A_ScriptDir%\apps\office.ahk"
ExitApp
