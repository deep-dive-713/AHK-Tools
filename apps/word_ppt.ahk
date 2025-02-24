#SingleInstance force

;=========================================
; Word, PowerPoint の設定
;=========================================

;-----------------------------------------
; PowerPoint: マウスホイールで左右スクロール
;-----------------------------------------
#IfWinActive ahk_exe POWERPNT.EXE
    +WheelUp::  ComObjActive("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,0,1)   ; Shift+ホイール上で左スクロール
    +WheelDown::ComObjActive("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,1,0)   ; Shift+ホイール下で右スクロール
    ; WheelLeft::ComObjActive("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,0,1)  ; 左スクロール（チルト左）
    ; WheelRight::ComObjActive("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,1,0) ; 右スクロール（チルト右）
#IfWinActive

;-----------------------------------------
; Word: マウスホイールで左右スクロール
;-----------------------------------------
#IfWinActive ahk_exe WINWORD.EXE
    +WheelUp::  ComObjActive("Word.Application").ActiveWindow.SmallScroll(0,0,0,1) ; Shift+ホイール上で左スクロール
    +WheelDown::ComObjActive("Word.Application").ActiveWindow.SmallScroll(0,0,1,0) ; Shift+ホイール下で右スクロール
    ; WheelLeft:: ComObjActive("Word.Application").ActiveWindow.SmallScroll(0,0,0,1) ; 左スクロール（チルト左）
    ; WheelRight::ComObjActive("Word.Application").ActiveWindow.SmallScroll(0,0,1,0) ; 右スクロール（チルト右）
#IfWinActive
