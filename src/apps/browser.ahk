;=========================================
; ブラウザ関連の設定
;=========================================
#HotIf WinActive("ahk_exe msedge.exe") or WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe brave.exe")
    F13 & WheelUp::  Send "^+{Tab}" ; F13 + ホイール上 → 前のタブ
    F13 & WheelDown::Send "^{Tab}"  ; F13 + ホイール下 → 次のタブ
    F13 & e::Send "^+{Tab}"         ; F13 + e → 前のタブ
    F13 & r::Send "^{Tab}"          ; F13 + r → 次のタブ

    ; Shiftキーのダブルタップで改行を挿入
    Shift:: {
        KeyWait "Shift"                 ; Shiftキーが離されるまで待機
        if !KeyWait("Shift", "D T0.1")  ; 0.1秒以内に次のShiftキーが押されるのを待機
            Send "{Shift}"              ; シングルタップの場合：通常のShiftキー
        else                            ; ダブルタップの場合
            Send "+{Enter}"             ; Shift + Enter → 改行を挿入
    }
#HotIf
