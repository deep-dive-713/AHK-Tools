;=========================================
; ブラウザ関連の設定
;=========================================
#IfWinActive, ahk_exe msedge.exe
    F13 & WheelUp::  Send, ^+{Tab}    ; 前のタブ
    F13 & WheelDown::Send,  ^{Tab}    ; 次のタブ
    F13 & y::Send, ^+{Tab}            ; 前のタブ
    F13 & u::Send,  ^{Tab}            ; 次のタブ

    ; Shiftキーのダブルタップで改行を挿入
    Shift::
        Keywait, Shift, U           ; Shiftキーが離されるまで待機
        Keywait, Shift, D T0.2      ; 0.2秒以内に次のShiftキーが押されるのを待機
        If (ErrorLevel=1)           ; タイムアウトした場合（シングルタップ）
        {
            Send,{Shift}            ; 通常のShiftキーとして動作
        }
        else                        ; ダブルタップの場合
        {
            Send, +{Enter}          ; Shift+Enterで改行を挿入
        }
    return
#IfWinActive
