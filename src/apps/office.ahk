;=========================================
; Microsoft Office関連の設定
;=========================================
;-----------------------------------------
; Excel: 拡張機能
;-----------------------------------------
#IfWinActive ahk_exe EXCEL.EXE
    ; Shift+ホイール上で左スクロール
    +WheelUp::
        SetScrollLockState, On
        SendInput {Left}
        SetScrollLockState, Off
    Return
    ; Shift+下ホイールで右スクロール
    +WheelDown::
        SetScrollLockState, On
        SendInput {Right}
        SetScrollLockState, Off
    Return
    ;     ; 左スクロール（チルト左）
    ;     WheelLeft::
    ;     SetScrollLockState, On
    ;     SendInput {Left}
    ;     SetScrollLockState, Off
    ; Return
    ;     ; 右スクロール（チルト右）
    ;     WheelRight::
    ;     SetScrollLockState, On
    ;     SendInput {Right}
    ;     SetScrollLockState, Off
    ; Return

    ; シート切り替えショートカット
    F13 & WheelUp::  Send, ^{PgUp} ; マウスホイール上でシートを左へ
    F13 & WheelDown::Send, ^{PgDn} ; マウスホイール下でシートを右へ
    F13 & y::Send, ^{PgUp}         ; F13+Yでシートを左へ
    F13 & u::Send, ^{PgDn}         ; F13+Uでシートを右へ

    ; F13キーのダブルタップでセル編集（F2）
    F13::
        Keywait, F13, U            ; F13キーが離されるまで待機
        Keywait, F13, D T0.2       ; 0.2秒以内に次のF13キーが押されるのを待機
        If (ErrorLevel=1)          ; タイムアウトした場合（シングルタップ）
        {
            Send,{F13}
        }
        else                       ; ダブルタップの場合
        {
            Send, {F2}
        }
    return
    
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
            Send, +{Enter}          ; Alt+Enterで改行を挿入
        }
    return
    
#IfWinActive

;-----------------------------------------
; OneNote: カスタムスクロールと移動
;-----------------------------------------
#IfWinActive ahk_exe ONENOTE.EXE
    ; F13との組み合わせでカーソル移動
    F13 & i::dllcall("keybd_event", int, 0x26, int, 0, int, 1, int, 0) ; F13+Iで上へ
    F13 & k::dllcall("keybd_event", int, 0x28, int, 0, int, 1, int, 0) ; F13+Kで下へ
    F13 & WheelUp::Send, ^{PgUp}      ; F13+ホイール上で上のページへ
    F13 & WheelDown::Send, ^{PgDn}    ; F13+ホイール下 で下のページへ
    F13 & WheelLeft::Send, ^+{Tab}    ; F13+ホイール左 で左のタブへ
    F13 & WheelRight::Send, ^{Tab}    ; F13+ホイール右 で右のタブへ
    Shift & WheelLeft::Send, {Left}   ; Shift+ホイール左 で左へカーソル移動
    Shift & WheelRight::Send, {Right} ; Shift+ホイール左 で右へカーソル移動

    ; カスタムスクロール制御
    ; Shift+ホイールで左右スクロール
    +WheelUp::
    ControlGetFocus, fcontrol, A
    Loop 1
        SendMessage, 0x114, 0, 0, %fcontrol%, A
    return
    +WheelDown::
    ControlGetFocus, fcontrol, A
    Loop 1
        SendMessage, 0x114, 1, 0, %fcontrol%, A
    return
    
    ; チルトホイールの左右スクロール
    WheelLeft::
    ControlGetFocus, fcontrol, A
    Loop 1
        SendMessage, 0x114, 0, 0, %fcontrol%, A
    return
    WheelRight::
    ControlGetFocus, fcontrol, A
    Loop 1
        SendMessage, 0x114, 1, 0, %fcontrol%, A
    return
#IfWinActive

;-----------------------------------------
; Outlook: マウスホイールで左右スクロール
;-----------------------------------------
#IfWinActive ahk_exe OUTLOOK.EXE
    +WheelUp::  Send, {WheelLeft}  ; Shift+ホイール上で左スクロール
    +WheelDown::Send, {WheelRight} ; Shift+ホイール下で右スクロール
#IfWinActive
