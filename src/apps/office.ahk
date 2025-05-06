;=========================================
; Microsoft Office関連の設定
;=========================================
;-----------------------------------------
; Excel: 拡張機能
;-----------------------------------------
#HotIf WinActive("ahk_exe EXCEL.EXE")
    ; Shift+ホイール上で左スクロール
    +WheelUp:: {
        SetScrollLockState true
        Send "{Left}"
        SetScrollLockState false
    }

    ; Shift+下ホイールで右スクロール
    +WheelDown:: {
        SetScrollLockState true
        Send "{Right}"
        SetScrollLockState false
    }

    ; シート切り替えショートカット
    F13 & WheelUp::Send "^{PgUp}"    ; マウスホイール上でシートを左へ
    F13 & WheelDown::Send "^{PgDn}"   ; マウスホイール下でシートを右へ
    F13 & y::Send "^{PgUp}"          ; F13+Yでシートを左へ
    F13 & u::Send "^{PgDn}"          ; F13+Uでシートを右へ

    ; F13キーのダブルタップでセル編集（F2）
    F13:: {
        KeyWait "F13"                 ; F13キーが離されるまで待機
        if !KeyWait("F13", "D T0.1") { ; 0.1秒以内に次のF13キーが押されるのを待機
            Send "{F13}"
        } else {                      ; ダブルタップの場合
            Send "{F2}"
        }
    }
    
    ; Shiftキーのダブルタップで改行を挿入
    Shift:: {
        KeyWait "Shift"               ; Shiftキーが離されるまで待機
        if !KeyWait("Shift", "D T0.1") { ; 0.1秒以内に次のShiftキーが押されるのを待機
            Send "{Shift}"            ; 通常のShiftキーとして動作
        } else {                      ; ダブルタップの場合
            Send "!{Enter}"           ; Alt+Enterで改行を挿入
        }
    }
#HotIf

;-----------------------------------------
; OneNote: カスタムスクロールと移動
;-----------------------------------------
#HotIf WinActive("ahk_exe ONENOTE.EXE")
    ; F13との組み合わせでカーソル移動
    F13 & i::DllCall("keybd_event", "UInt", 0x26, "UInt", 0, "UInt", 1, "Ptr", 0) ; F13+Iで上へ
    F13 & k::DllCall("keybd_event", "UInt", 0x28, "UInt", 0, "UInt", 1, "Ptr", 0) ; F13+Kで下へ
    F13 & WheelUp::Send "^{PgUp}"       ; F13+ホイール上で上のページへ
    F13 & WheelDown::Send "^{PgDn}"     ; F13+ホイール下で下のページへ
    F13 & WheelLeft::Send "^+{Tab}"     ; F13+ホイール左で左のタブへ
    F13 & WheelRight::Send "^{Tab}"     ; F13+ホイール右で右のタブへ
    Shift & WheelLeft::Send "{Left}"    ; Shift+ホイール左で左へカーソル移動
    Shift & WheelRight::Send "{Right}"  ; Shift+ホイール左で右へカーソル移動

    ; カスタムスクロール制御
    ; Shift+ホイールで左右スクロール
    +WheelUp:: {
        fcontrol := ControlGetFocus("A")
        SendMessage(0x114, 0, 0, fcontrol, "A")
    }
    
    +WheelDown:: {
        fcontrol := ControlGetFocus("A")
        SendMessage(0x114, 1, 0, fcontrol, "A")
    }
#HotIf

;-----------------------------------------
; Outlook: マウスホイールで左右スクロール
;-----------------------------------------
#HotIf WinActive("ahk_exe OUTLOOK.EXE")
    +WheelUp::Send "{WheelLeft}"    ; Shift+ホイール上で左スクロール
    +WheelDown::Send "{WheelRight}" ; Shift+ホイール下で右スクロール
#HotIf
