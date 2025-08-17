;=========================================
; Microsoft Office関連の設定
;=========================================
;-----------------------------------------
; Excel: 拡張機能
;-----------------------------------------
#HotIf WinActive("ahk_exe EXCEL.EXE")
    ; Shift+ホイール上で左スクロール
    +WheelUp:: {
        SetScrollLockState(true)
        Send "{Left}"
        SetScrollLockState(false)
    }

    ; Shift+下ホイールで右スクロール
    +WheelDown:: {
        SetScrollLockState(true)
        Send "{Right}"
        SetScrollLockState(false)
    }

    ; シート切り替えショートカット
    F13 & WheelUp::Send "^{PgUp}"    ; F13 + ホイール上 → シートを左へ
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
    +WheelUp::Send "{WheelLeft}"    ; Shift + ホイール上 → 左スクロール
    +WheelDown::Send "{WheelRight}" ; Shift + ホイール下 → 右スクロール
#HotIf
