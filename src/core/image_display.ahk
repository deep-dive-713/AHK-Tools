#!l:: {  ; ホットキーはブロック構文を使用
    ; モニター情報の取得
    MonitorCount := MonitorGetCount()
    
    ; 画像パスの設定
    imagePath0 := "C:\Users\deep_dive_\Pictures\keymap\layer0-1.jpg"
    imagePath1 := "C:\Users\deep_dive_\Pictures\keymap\layer2-3.jpg"

    ; GUI作成用の変数
    Layer1 := Gui()
    Layer2 := Gui()

    ; 画像サイズを取得と調整
    pic0 := Layer1.Add("Picture",, imagePath0)
    width0 := pic0.Pos[3]
    height0 := pic0.Pos[4]
    Layer1.Destroy()

    pic1 := Layer2.Add("Picture",, imagePath1)
    width1 := pic1.Pos[3]
    height1 := pic1.Pos[4]
    Layer2.Destroy()

    ; 数値を整数に丸める
    roundWidth0  := Round(width0)
    roundHeight0 := Round(height0)
    roundWidth1  := Round(width1)
    roundHeight1 := Round(height1)

    if (MonitorCount > 1) {
        ; サブディスプレイがある場合、サブディスプレイに表示
        Mon2 := MonitorGetWorkArea(2)
        monitorWidth := Mon2.Right - Mon2.Left
        monitorHeight := Mon2.Bottom - Mon2.Top
        
        xPos1 := Mon2.Left + (monitorWidth - roundWidth0 * 2) / 3
        yPos1 := Mon2.Top + (monitorHeight - roundHeight0) / 2
        xPos2 := Mon2.Right - (monitorWidth - roundWidth1 * 2) / 3 - roundWidth1
        yPos2 := Mon2.Top + (monitorHeight - roundHeight1) / 2
    } else {
        ; メインディスプレイのみの場合、そこに表示
        Mon1 := MonitorGetWorkArea(1)
        monitorWidth := Mon1.Right - Mon1.Left
        monitorHeight := Mon1.Bottom - Mon1.Top

        ; 拡大率を設定（例：0.5倍）
        scale := 0.5

        ; 数値を整数に丸める
        roundWidth0  := Round(width0 * 2)
        roundHeight0 := Round(height0 * 2)
        roundWidth1  := Round(width1 * 2)
        roundHeight1 := Round(height1 * 2)
        
        ; メインディスプレイの中央に寄せて表示
        xPos1 := Mon1.Left + (monitorWidth - roundWidth0 * 2) / 3
        yPos1 := Mon1.Top + (monitorHeight - roundHeight0) / 2
        xPos2 := Mon1.Right - (monitorWidth - roundWidth1 * 2) / 3 - roundWidth1
        yPos2 := Mon1.Top + (monitorHeight - roundHeight1) / 2
    }
    
    ; GUI作成と表示（1枚目）
    Layer1 := Gui()
    Layer1.Opt("+AlwaysOnTop -Caption")
    Layer1.Add("Picture",, imagePath0)
    Layer1.Show(Format("x{1} y{2}", xPos1, yPos1))
    
    ; GUI作成と表示（2枚目）
    Layer2 := Gui()
    Layer2.Opt("+AlwaysOnTop -Caption")
    Layer2.Add("Picture",, imagePath1)
    Layer2.Show(Format("x{1} y{2}", xPos2, yPos2))
    
    ; キーが離されるまで待機
    KeyWait "l"
    
    ; 両方のGUIを破棄
    Layer1.Destroy()
    Layer2.Destroy()
}

; ; キー配列を表示（キーを押している間のみ）
; #!L::
;     ; モニター情報の取得
;     SysGet, MonitorCount, MonitorCount
;     if (MonitorCount > 1) {
;         SysGet, Mon2, Monitor, 2
        
;         ; 先に両方のGUIを作成
;         CreateKeymap("C:\Users\deep_dive_\Pictures\keymap\layer0-1.jpg", "Layer1", "left")
;         CreateKeymap("C:\Users\deep_dive_\Pictures\keymap\layer2-3.jpg", "Layer2", "right")
        
;         ; 両方のGUIを同時に表示
;         ShowAllKeymaps()
        
;         ; キーが離されるまで待機
;         KeyWait, L
        
;         ; 両方のGUIを破棄
;         Gui, Layer1:Destroy
;         Gui, Layer2:Destroy
;         Gui, keyMap:Destroy
;     }
; return

; ; ShowKeymap(imagePath) {
; CreateKeymap(imagePath, guiName, position) {
;     global Mon2Left, Mon2Right, Mon2Top, Mon2Bottom
    
;     ; 画像サイズを取得と調整
;     Gui, Add, Picture, hwndPicHwnd, %imagePath%
;     ControlGetPos, , , width, height, , ahk_id %PicHwnd%
;     Gui, Destroy

;     ; 拡大率を設定（例：1.5倍）
;     scale := 1

;     ; 数値を整数に丸める（拡大率を適用）
;     roundWidth := Round(width * scale)
;     roundHeight := Round(height * scale)
    
;     ; GUI作成
;     ; Gui, KeyMap:New
;     Gui, %guiName%:New
;     Gui, %guiName%:+AlwaysOnTop -Caption +LastFound
;     ; WinSet, Transparent, 180
    
;     ; Gui, KeyMap:Add, Picture,, %imagePath% 
;     Gui, %guiName%:Add, Picture,, %imagePath% 
;     ; Gui, KeyMap%position%:Add, Picture, w%roundWidth% h%roundHeight%, %imagePath%
    
;     ; 位置調整
;     ; centerX := Mon2Left + (Mon2Right - Mon2Left - roundWidth) / 2
;     if (position = "left") {
;         centerX := Mon2Left + (Mon2Right - Mon2Left - roundWidth * 2) / 3
;     } else {
;         centerX := Mon2Right - (Mon2Right - Mon2Left - roundWidth * 2) / 3 - roundWidth
;     }
;     centerY := Mon2Top + (Mon2Bottom - Mon2Top - roundHeight) / 2
    
;     ; ; デバッグ情報を表示
;     ; MsgBox, %debugInfo%
;     ; debugInfo := "monitor info:`n"
;     ; debugInfo .= "Mon2Left: " . Mon2Left . "`n"
;     ; debugInfo .= "Mon2Right: " . Mon2Right . "`n"
;     ; debugInfo .= "Mon2Top: " . Mon2Top . "`n"
;     ; debugInfo .= "Mon2Bottom: " . Mon2Bottom . "`n"
;     ; debugInfo .= "`nmonitor size:`n"
;     ; debugInfo .= "width: " . (Mon2Right - Mon2Left) . "`n"
;     ; debugInfo .= "height: " . (Mon2Bottom - Mon2Top) . "`n"
;     ; debugInfo .= "`image size:`n"
;     ; debugInfo .= "ImageWidth: " . roundWidth . "`n"
;     ; debugInfo .= "ImageHeight: " . roundHeight . "`n"
;     ; debugInfo .= "`center position:`n"
;     ; debugInfo .= "centerX: " . centerX . "`n"
;     ; debugInfo .= "centerY: " . centerY . "`n"
    
;     ; 位置情報を保存
;     if (guiName = "Layer1") {
;         Layer1_X := centerX
;         Layer1_Y := centerY
;     } else if (guiName = "Layer2") {
;         Layer2_X := centerX
;         Layer2_Y := centerY
;     }
; }

; ; 全てのGUIを同時に表示
; ShowAllKeymaps() {
;     global Layer1_X, Layer1_Y, Layer2_X, Layer2_Y
    
;     ; 座標を文字列として組み立ててから表示
;     pos1 := "x" . Layer1_X . " y" . Layer1_Y
;     pos2 := "x" . Layer2_X . " y" . Layer2_Y
    
;     Gui, Layer1:Show, %pos1%
;     Gui, Layer2:Show, %pos2%
; }
