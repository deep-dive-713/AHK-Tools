;=========================================
; その他アプリケーション設定
;=========================================
;-----------------------------------------
; Notion: 拡張機能
;-----------------------------------------
#IfWinActive ahk_exe Notion.exe
    ; Ctrl+マウスホイールでズーム操作
    ^WheelUp::  Send, ^{+}          ; Ctrl+ホイール上で拡大
    ^WheelDown::Send, ^{-}          ; Ctrl+ホイール下で縮小

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

#IfWinActive ahk_exe Cursor.exe
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

#IfWinActive ahk_exe Mattermost.exe
    ^WheelUp::  Send, ^+{-}
    ^WheelDown::Send, ^{-}
#IfWinActive
