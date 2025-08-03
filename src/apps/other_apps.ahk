;=========================================
; その他アプリケーション設定
;=========================================
;-----------------------------------------
; Notion: 拡張機能
;-----------------------------------------
#HotIf WinActive("ahk_exe Notion.exe")
    ; Ctrl+マウスホイールでズーム操作
    ^WheelUp::Send "^{+}"          ; Ctrl + ホイール上 → 拡大
    ^WheelDown::Send "^{-}"        ; Ctrl + ホイール下 → 縮小

    ; Shiftキーのダブルタップで改行を挿入
    Shift:: {
        KeyWait("Shift")                 ; Shiftキーが離されるまで待機
        if !KeyWait("Shift", "D T0.1") { ; 0.1秒以内に次のShiftキーが押されるのを待機
            Send "{Shift}"               ; シングルタップの場合
        } else {
            Send "+{Enter}"              ; Shift + Enter → 改行を挿入
        }
    }
#HotIf

#HotIf WinActive("ahk_exe Cursor.exe")
    ; Shiftキーのダブルタップで改行を挿入
    Shift:: {
        KeyWait("Shift")                 ; Shiftキーが離されるまで待機
        if !KeyWait("Shift", "D T0.1") { ; 0.1秒以内に次のShiftキーが押されるのを待機
            Send "{Shift}"               ; シングルタップの場合
        } else {
            Send "+{Enter}"              ; Shift + Enter → 改行を挿入
        }
    }
#HotIf

#HotIf WinActive("ahk_exe Mattermost.exe")
    ^WheelUp::Send "^+{-}"    ; Ctrl + ホイール上 → 拡大
    ^WheelDown::Send "^{-}"   ; Ctrl + ホイール下 → 縮小
#HotIf
