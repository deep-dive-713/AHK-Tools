;=========================================
; AHK-Tools メインスクリプト
;=========================================
#Requires AutoHotkey v1.1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

;=========================================
; 基本設定
;=========================================
#SingleInstance, Force       ; 重複起動を防止
SendMode Input               ; 高速なキー送信モードを使用
SetWorkingDir %A_ScriptDir%  ; スクリプトの作業ディレクトリを設定
#HotkeyInterval, 2000        ; ホットキーの連打制限間隔
#MaxHotkeysPerInterval, 200  ; ホットキーの連打制限回数

;=========================================
; サブスクリプトの実行と終了処理
;=========================================
; word_ppt.ahkを別プロセスとして実行し、PIDを保存
Run, AutoHotkey.exe "%A_ScriptDir%\src\apps\word_ppt.ahk",,,WordPptPID
; Run, AutoHotkey.exe "%A_ScriptDir%\src\apps\word_ppt_2016.ahk",,,WordPptPID ; Office2016用

; スクリプト終了時の処理
OnExit, ExitSub

;=========================================
; 外部スクリプトの読み込み
;=========================================
; バージョン管理とアップデート機能
#Include %A_ScriptDir%\src\core\version.ahk

; 基本機能
#Include %A_ScriptDir%\src\core\search.ahk

; F13 + キー コマンド群
#Include %A_ScriptDir%\src\shortcuts\cursor_movement.ahk   ; カーソル移動
#Include %A_ScriptDir%\src\shortcuts\editing.ahk           ; テキスト編集
#Include %A_ScriptDir%\src\shortcuts\mouse_actions.ahk     ; マウス操作
#Include %A_ScriptDir%\src\shortcuts\symbols.ahk           ; 記号入力

; アプリケーション固有の設定
#Include %A_ScriptDir%\src\apps\office.ahk                ; Microsoft Office
; #Include %A_ScriptDir%\src\apps\office2016.ahk            ; Microsoft Office2016用
#Include %A_ScriptDir%\src\apps\browser.ahk               ; ブラウザ
#Include %A_ScriptDir%\src\apps\JIS2US.ahk                ; JIS/US配列変換（JIS配列キーボードを使っている人向け、US配列の人は要コメントアウト）
#Include %A_ScriptDir%\src\apps\other_apps.ahk            ; その他アプリ

;=========================================
; キー送信の説明
;=========================================
/*
Send, {key}      ; キーを1回送信
Send, {key n}    ; キーをn回送信
Send, {key down} ; キーを押し続ける
Send, {key up}   ; キーを離す
SendInput        ; 高速なキー送信
SendPlay         ; UIオートメーション対応
SendEvent        ; 従来のキー送信方式
SendRaw          ; 特殊文字をそのまま送信
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
; 基本的なショートカット
;=========================================
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

;=========================================
; 終了処理
;=========================================
ExitSub:
    ; word_ppt.ahkプロセスを終了
    Process, Close, %WordPptPID%
    ExitApp
