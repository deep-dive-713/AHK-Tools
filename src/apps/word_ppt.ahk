#Requires AutoHotkey v2.0
#SingleInstance Force

;=========================================
; Mouse Extensions for Word & PowerPoint
;=========================================

;-----------------------------------------
; PowerPoint: Horizontal scrolling with mouse wheel
;-----------------------------------------
#HotIf WinActive("ahk_exe POWERPNT.EXE")
    +WheelUp::   ComObject("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,0,10)   ; Shift+Wheel Up→Scroll Left
    +WheelDown:: ComObject("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,10,0)   ; Shift+Wheel Down→Scroll Right
#HotIf

;-----------------------------------------
; Word: Horizontal scrolling with mouse wheel
;-----------------------------------------
#HotIf WinActive("ahk_exe WINWORD.EXE")
    +WheelUp::   ComObject("Word.Application").ActiveWindow.SmallScroll(0,0,0,10)   ; Shift+Wheel Up→Scroll Left
    +WheelDown:: ComObject("Word.Application").ActiveWindow.SmallScroll(0,0,10,0)   ; Shift+Wheel Down→Scroll Right
#HotIf
