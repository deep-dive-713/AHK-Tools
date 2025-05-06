;=========================================
; ブラウザ関連の設定
;=========================================
#HotIf WinActive("ahk_exe msedge.exe")
    F13 & WheelUp::  Send "^+{Tab}" ; 前のタブ
    F13 & WheelDown::Send "^{Tab}"  ; 次のタブ
    F13 & y::Send "^+{Tab}"         ; 前のタブ
    F13 & u::Send "^{Tab}"          ; 次のタブ

    ; Shiftキーのダブルタップで改行を挿入
    Shift:: {
        KeyWait "Shift"                 ; Shiftキーが離されるまで待機
        if !KeyWait("Shift", "D T0.1")  ; 0.1秒以内に次のShiftキーが押されるのを待機
            Send "{Shift}"              ; シングルタップの場合：通常のShiftキーとして動作
        else                            ; ダブルタップの場合
            Send "+{Enter}"             ; Shift+Enterで改行を挿入
    }
#HotIf
