#!l:: {
    ; モニター情報の取得
    MonitorCount := MonitorGetCount()
    debugInfo := "【モニター情報】`n"
    debugInfo .= Format("モニター総数: {1}`n`n", MonitorCount)
    
    Loop MonitorCount {
        ; 作業領域の取得
        MonitorGetWorkArea(A_Index, &WALeft, &WATop, &WARight, &WABottom)
        ; 物理的な領域の取得
        MonitorGet(A_Index, &Left, &Top, &Right, &Bottom)
        
        debugInfo .= Format("モニター {1}:`n", A_Index)
        debugInfo .= Format("  物理領域: Left={1}, Top={2}, Right={3}, Bottom={4}`n", Left, Top, Right, Bottom)
        debugInfo .= Format("  作業領域: Left={1}, Top={2}, Right={3}, Bottom={4}`n", WALeft, WATop, WARight, WABottom)
        debugInfo .= Format("  物理サイズ: {1}x{2}`n", Right - Left, Bottom - Top)
        debugInfo .= Format("  作業サイズ: {1}x{2}`n`n", WARight - WALeft, WABottom - WATop)
    }
    
    MsgBox debugInfo
    
    ; 画像パスの設定
    imagePath0 := "C:\Users\deep_dive_\Pictures\keymap\layer0-1.jpg"
    imagePath1 := "C:\Users\deep_dive_\Pictures\keymap\layer2-3.jpg"

    ; 画像サイズを取得
    tempGui := Gui()
    pic0 := tempGui.AddPicture(, imagePath0)
    pic1 := tempGui.AddPicture(, imagePath1)
    
    ; GUIを表示して実際のサイズを取得
    tempGui.Show("Hide")
    
    ; 画像サイズを保存
    pic0.GetPos(&x0, &y0, &width0, &height0)
    pic1.GetPos(&x1, &y1, &width1, &height1)
    
    ; 一時的なGUIを破棄
    tempGui.Destroy()

    ; 数値を整数に丸める
    roundWidth0  := Round(width0)
    roundHeight0 := Round(height0)
    roundWidth1  := Round(width1)
    roundHeight1 := Round(height1)

    if (MonitorCount > 1) {
        ; サブディスプレイがある場合、サブディスプレイに表示
        MonitorGetWorkArea(2, &Left, &Top, &Right, &Bottom)  ; 参照渡しで値を取得
        x_CF := 3 / 4
        y_CF := 45 / 58

        monitorWidth := (Right  - Left) * x_CF
        monitorHeight := (Bottom - Top) * y_CF
        
        xPos1 := Left + (monitorWidth - (roundWidth0 + roundWidth1)) / 3
        yPos1 := (monitorHeight - roundHeight0) / 2 
        xPos2 := Left + (monitorWidth - (roundWidth0 + roundWidth1)) / 3 * 2 + roundWidth0
        yPos2 := Top + (monitorHeight - roundHeight1) / 2
    } else {
        ; メインディスプレイのみの場合、そこに表示
        MonitorGetWorkArea(1, &Left, &Top, &Right, &Bottom)  ; 参照渡しで値を取得
        monitorWidth := Right - Left
        monitorHeight := Bottom - Top

        ; 拡大率を設定（例：0.5倍）
        scale := 0.5

        ; 数値を整数に丸める
        roundWidth0  := Round(width0 * scale)
        roundHeight0 := Round(height0 * scale)
        roundWidth1  := Round(width1 * scale)
        roundHeight1 := Round(height1 * scale)
        
        ; メインディスプレイの中央に寄せて表示
        xPos1 := Left + (monitorWidth - roundWidth0 * 2) / 3
        yPos1 := Top + (monitorHeight - roundHeight0) / 2
        xPos2 := Right - (monitorWidth - roundWidth1 * 2) / 3 - roundWidth1
        yPos2 := Top + (monitorHeight - roundHeight1) / 2
    }
    
    ; GUI作成と表示（1枚目）
    Layer1 := Gui()
    Layer1.Opt("+AlwaysOnTop -Caption")
    Layer1.AddPicture(Format("w{1} h{2}", roundWidth0, roundHeight0), imagePath0)
    Layer1.Show(Format("x{1} y{2} w{3} h{4}", xPos1, yPos1, roundWidth0, roundHeight0))
    
    ; GUI作成と表示（2枚目）
    Layer2 := Gui()
    Layer2.Opt("+AlwaysOnTop -Caption")
    Layer2.AddPicture(Format("w{1} h{2}", roundWidth1, roundHeight1), imagePath1)
    Layer2.Show(Format("x{1} y{2} w{3} h{4}", xPos2, yPos2, roundWidth1, roundHeight1))
    
    
    ; キーが離されるまで待機
    KeyWait "l"
    
    ; 両方のGUIを破棄
    Layer1.Destroy()
    Layer2.Destroy()
    
    ; モニター情報取得後にデバッグ情報を表示（デバッグ用）
    if (MonitorCount > 1) {
        MonitorGetWorkArea(2, &Left, &Top, &Right, &Bottom)
        monitorWidth := Right - Left
        monitorHeight := Bottom - Top
        
        debugInfo := "【デバッグ情報（サブディスプレイ）】`n"
        debugInfo .= Format("モニターサイズ: {1}x{2}`n", monitorWidth, monitorHeight)
        debugInfo .= Format("モニター座標: Left={1}, Top={2}, Right={3}, Bottom={4}`n`n", Left, Top, Right, Bottom)
        
        debugInfo .= Format("画像1サイズ: {1}x{2}`n", roundWidth0, roundHeight0)
        debugInfo .= Format("画像2サイズ: {1}x{2}`n`n", roundWidth1, roundHeight1)
        
        xPos1 := Left + (monitorWidth - roundWidth0 * 2) / 3
        yPos1 := Top + (monitorHeight - roundHeight0) / 2
        xPos2 := Right - (monitorWidth - roundWidth1 * 2) / 3 - roundWidth1
        yPos2 := Top + (monitorHeight - roundHeight1) / 2
        
        debugInfo .= Format("画像1位置: x={1}, y={2}`n", xPos1, yPos1)
        debugInfo .= Format("画像2位置: x={1}, y={2}`n", xPos2, yPos2)
        
        MsgBox debugInfo
    } else {
        MonitorGetWorkArea(1, &Left, &Top, &Right, &Bottom)
        monitorWidth := Right - Left
        monitorHeight := Bottom - Top
        
        debugInfo := "【デバッグ情報（メインディスプレイ）】`n"
        debugInfo .= Format("モニターサイズ: {1}x{2}`n", monitorWidth, monitorHeight)
        debugInfo .= Format("モニター座標: Left={1}, Top={2}, Right={3}, Bottom={4}`n`n", Left, Top, Right, Bottom)
        
        scale := 0.5
        roundWidth0  := Round(width0 * scale)
        roundHeight0 := Round(height0 * scale)
        roundWidth1  := Round(width1 * scale)
        roundHeight1 := Round(height1 * scale)
        
        debugInfo .= Format("画像1サイズ(スケール後): {1}x{2}`n", roundWidth0, roundHeight0)
        debugInfo .= Format("画像2サイズ(スケール後): {1}x{2}`n`n", roundWidth1, roundHeight1)
        
        xPos1 := Left + (monitorWidth - roundWidth0 * 2) / 3
        yPos1 := Top + (monitorHeight - roundHeight0) / 2
        xPos2 := Right - (monitorWidth - roundWidth1 * 2) / 3 - roundWidth1
        yPos2 := Top + (monitorHeight - roundHeight1) / 2
        
        debugInfo .= Format("画像1位置: x={1}, y={2}`n", xPos1, yPos1)
        debugInfo .= Format("画像2位置: x={1}, y={2}", xPos2, yPos2)
        
        MsgBox debugInfo
    }
}

