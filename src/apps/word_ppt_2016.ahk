#SingleInstance force

;=========================================
; Mouse Extensions for Word & PowerPoint
;=========================================

;-----------------------------------------
; PowerPoint: Horizontal scrolling with mouse wheel
;-----------------------------------------
#HotIf WinActive("ahk_exe POWERPNT.EXE")
    +WheelUp::   ComObject("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,0,10)   ; Shift + ホイール上 → 左スクロール
    +WheelDown:: ComObject("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,10,0)   ; Shift + ホイール下 → 右スクロール
    WheelLeft::  ComObject("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,0,10)   ; チルト左 → 左スクロール
    WheelRight:: ComObject("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,10,0)   ; チルト右 → 右スクロール
#HotIf

;-----------------------------------------
; Word: Horizontal scrolling with mouse wheel
;-----------------------------------------
#HotIf WinActive("ahk_exe WINWORD.EXE")
    +WheelUp::   ComObject("Word.Application").ActiveWindow.SmallScroll(0,0,0,10)   ; Shift + ホイール上 → 左スクロール
    +WheelDown:: ComObject("Word.Application").ActiveWindow.SmallScroll(0,0,10,0)   ; Shift + ホイール下 → 右スクロール
    WheelLeft::  ComObject("Word.Application").ActiveWindow.SmallScroll(0,0,0,10)   ; チルト左 → 左スクロール
    WheelRight:: ComObject("Word.Application").ActiveWindow.SmallScroll(0,0,10,0)   ; チルト右 → 右スクロール
#HotIf

