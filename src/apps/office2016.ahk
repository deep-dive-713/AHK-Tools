;=========================================
; Microsoft Office関連の設定
;=========================================
;-----------------------------------------
; Excel: 拡張機能
;-----------------------------------------
#HotIf WinActive("ahk_exe EXCEL.EXE")
    ; Shift + ホイール上 → 左スクロール
    +WheelUp:: {
        SetScrollLockState(true)
        Send "{Left}"
        SetScrollLockState(false)
    }

    ; Shift + ホイール下 → 右スクロール
    +WheelDown:: {
        SetScrollLockState(true)
        Send "{Right}"
        SetScrollLockState(false)
    }

    ; チルト左 → 左スクロール
    WheelLeft:: {
        SetScrollLockState(true)
        Send "{Left}"
        SetScrollLockState(false)
    }

    ; チルト右 → 右スクロール
    WheelRight:: {
        SetScrollLockState(true)
        Send "{Right}"
        SetScrollLockState(false)
    }

    ; シート切り替えショートカット
    F13 & WheelUp::  Send "^{PgUp}"  ; F13 + ホイール上 → シートを左へ
    F13 & WheelDown::Send "^{PgDn}"  ; F13 + ホイール下 → シートを右へ
    F13 & e::Send "^{PgUp}"          ; F13 + E         → シートを左へ
    F13 & r::Send "^{PgDn}"          ; F13 + R         → シートを右へ

    ; F13キーのダブルタップでセル編集（F2）
    F13:: {
        KeyWait("F13")                 ; F13キーが離されるまで待機
        if !KeyWait("F13", "D T0.1") { ; 0.1秒以内に次のF13キーが押されるのを待機
            Send "{F13}"               ; シングルタップの場合
        } else {
            Send "{F2}"                ; ダブルタップの場合
        }
    }
    
    ; Shiftキーのダブルタップで改行を挿入
    Shift:: {
        KeyWait("Shift")                 ; Shiftキーが離されるまで待機
        if !KeyWait("Shift", "D T0.1") { ; 0.1秒以内に次のShiftキーが押されるのを待機
            Send "{Shift}"               ; シングルタップの場合
        } else {
            Send "!{Enter}"              ; Shift + Enter → 改行を挿入
        }
    }
#HotIf

;-----------------------------------------
; OneNote: カスタムスクロールと移動
;-----------------------------------------
#HotIf WinActive("ahk_exe ONENOTE.EXE")
    ; F13またはShiftとの組み合わせでカーソル移動
    F13 & i::DllCall("keybd_event", "UInt", 0x26, "UInt", 0, "UInt", 1, "Ptr", 0) ; F13 + I → 上へ
    F13 & k::DllCall("keybd_event", "UInt", 0x28, "UInt", 0, "UInt", 1, "Ptr", 0) ; F13 + K → 下へ
    F13 & WheelUp::Send "^{PgUp}"       ; F13 + ホイール上   → 上のページへ
    F13 & WheelDown::Send "^{PgDn}"     ; F13 + ホイール下   → 下のページへ
    F13 & t::Send "^{PgUp}"             ; F13 + T           → 上のページへ
    F13 & g::Send "^{PgDn}"             ; F13 + G           → 下のページへ
    F13 & e::Send "^+{Tab}"             ; F13 + E           → 左のタブへ
    F13 & r::Send "^{Tab}"              ; F13 + R           → 右のタブへ
    Shift & WheelLeft::Send "^+{Tab}"   ; Shift + ホイール左 → 左のタブへ
    Shift & WheelRight::Send "^{Tab}"   ; Shift + ホイール右 → 右のタブへ

    ; カスタムスクロール制御
    ; Shift+ホイールで左右スクロール
    +WheelUp:: {
        fcontrol := ControlGetFocus("A")    ; コントロールのフォーカスを取得
        Loop 1
            SendMessage(0x114, 0, 0, fcontrol, "A")
    }

    +WheelDown:: {
        fcontrol := ControlGetFocus("A")    ; コントロールのフォーカスを取得
        Loop 1
            SendMessage(0x114, 1, 0, fcontrol, "A")
    }
    
    ; チルトホイールの左右スクロール
    WheelLeft:: {
        fcontrol := ControlGetFocus("A")    ; コントロールのフォーカスを取得
        Loop 1
            SendMessage(0x114, 0, 0, fcontrol, "A")
    }

    WheelRight:: {
        fcontrol := ControlGetFocus("A")    ; コントロールのフォーカスを取得
        Loop 1
            SendMessage(0x114, 1, 0, fcontrol, "A")
    }
#HotIf

;-----------------------------------------
; Outlook: マウスホイールで左右スクロール
;-----------------------------------------
#HotIf WinActive("ahk_exe OUTLOOK.EXE")
    +WheelUp::Send "{WheelLeft}"     ; Shift + ホイール上 → 左スクロール
    +WheelDown::Send "{WheelRight}"  ; Shift + ホイール下 → 右スクロール
#HotIf
