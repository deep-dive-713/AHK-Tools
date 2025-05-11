;==============================================================================
; 画像表示スクリプト
; 
; 機能：
;   - Windows + Alt + L で2枚のキーマップ画像を表示
;   - マルチモニター対応（メイン/サブディスプレイで異なるDPI処理）
;   - 画像は画面中央に並べて表示
;==============================================================================

#!l:: {
    ;--------------------------------------------------------------------------
    ; 初期設定
    ;--------------------------------------------------------------------------
    ; モニター数を取得
    MonitorCount := MonitorGetCount()
    
    ; 画像ファイルのパス設定
    imagePath0 := "C:\Users\deep_dive_\Documents\AutoHotKey\assets\images\layer0-2.jpg"
    imagePath1 := "C:\Users\deep_dive_\Documents\AutoHotKey\assets\images\layer3-5.jpg"

    ;--------------------------------------------------------------------------
    ; 画像サイズの取得
    ;--------------------------------------------------------------------------
    tempGui := Gui()
    pic0 := tempGui.AddPicture(, imagePath0)
    pic1 := tempGui.AddPicture(, imagePath1)
    
    tempGui.Show("Hide")
    pic0.GetPos(&x0, &y0, &width0, &height0)
    pic1.GetPos(&x1, &y1, &width1, &height1)
    tempGui.Destroy()
    
    ;--------------------------------------------------------------------------
    ; モニター設定と画像位置の計算
    ;--------------------------------------------------------------------------
    if (MonitorCount > 1) {
        ; サブディスプレイ用の設定
        MonitorGetWorkArea(2, &Left, &Top, &Right, &Bottom)
        monitorInfo := { left: Left, top: Top, right: Right, bottom: Bottom }
        
        ; サブディスプレイのDPIスケールを取得
        hMonitor := DllCall("MonitorFromPoint", "int64", 0, "uint", 1, "ptr")
        DllCall("Shcore.dll\GetDpiForMonitor", "ptr", hMonitor, "int", 0, "uint*", &dpiX:=0, "uint*", &dpiY:=0)
        dpiScale := dpiX / 96

        positions := CalculateImagePositions(monitorInfo, width0, height0, width1, height1, dpiScale)
    } else {
        ; メインディスプレイ用の設定
        MonitorGetWorkArea(1, &Left, &Top, &Right, &Bottom)
        monitorInfo := { left: Left, top: Top, right: Right, bottom: Bottom }

        ; メインディスプレイのDPIスケールを取得
        hMonitor := DllCall("MonitorFromPoint", "int64", 0, "uint", 0, "ptr")
        DllCall("Shcore.dll\GetDpiForMonitor", "ptr", hMonitor, "int", 0, "uint*", &dpiX:=0, "uint*", &dpiY:=0)
        dpiScale := dpiX / 96
        
        positions := CalculateImagePositions(monitorInfo, width0, height0, width1, height1, 2)
    }

    ;--------------------------------------------------------------------------
    ; GUI作成と表示
    ;--------------------------------------------------------------------------
    ; 1枚目の画像を表示
    Layer1 := Gui()
    Layer1.Opt("+AlwaysOnTop -Caption")
    Layer1.AddPicture(Format("w{1} h{2}", positions.width0, positions.height0), imagePath0)
    Layer1.Show(Format("x{1} y{2} w{3} h{4}", positions.x1, positions.y1, positions.width0, positions.height0))
    
    ; 2枚目の画像を表示
    Layer2 := Gui()
    Layer2.Opt("+AlwaysOnTop -Caption")
    Layer2.AddPicture(Format("w{1} h{2}", positions.width1, positions.height1), imagePath1)
    Layer2.Show(Format("x{1} y{2} w{3} h{4}", positions.x2, positions.y2, positions.width1, positions.height1))
    
    ; デバッグ情報（必要に応じてコメントを解除）
    ; MsgBox positions.debugInfo

    ;--------------------------------------------------------------------------
    ; クリーンアップ処理
    ;--------------------------------------------------------------------------
    KeyWait "l"    ; キーが離されるまで待機
    Layer1.Destroy()
    Layer2.Destroy()
}

;==============================================================================
; 補助関数
;==============================================================================
/**
 * 画像の配置位置を計算する
 * @param {Object} monitorInfo モニターの座標情報
 * @param {Integer} width0 1枚目の画像の幅
 * @param {Integer} height0 1枚目の画像の高さ
 * @param {Integer} width1 2枚目の画像の幅
 * @param {Integer} height1 2枚目の画像の高さ
 * @param {Float} dpiScale DPIスケール値
 * @returns {Object} 画像の配置情報
 */
CalculateImagePositions(monitorInfo, width0, height0, width1, height1, dpiScale := 2) {
    ; モニターの実効サイズを計算
    monitorWidth := monitorInfo.right - monitorInfo.left
    monitorHeight := monitorInfo.bottom - monitorInfo.top
    eff_monitorWidth := monitorWidth / dpiScale
    eff_monitorHeight := monitorHeight / dpiScale

    ; 画像サイズを整数に丸める
    roundWidth0  := Round(width0)
    roundHeight0 := Round(height0)
    roundWidth1  := Round(width1)
    roundHeight1 := Round(height1)

    ; 2枚の画像の合計幅と配置位置を計算
    totalWidth := roundWidth0 + roundWidth1
    xPos1 := monitorInfo.left + (eff_monitorWidth - totalWidth) / 3 * dpiScale
    yPos1 := monitorInfo.top + (eff_monitorHeight - roundHeight0) / 2 * dpiScale
    xPos2 := monitorInfo.left + ((eff_monitorWidth - totalWidth) * 2 / 3 + roundWidth0) * dpiScale
    yPos2 := monitorInfo.top + (eff_monitorHeight - roundHeight0) / 2 * dpiScale

    ; 計算結果を返す
    return {
        width0: roundWidth0,
        height0: roundHeight0,
        width1: roundWidth1,
        height1: roundHeight1,
        x1: xPos1,
        y1: yPos1,
        x2: xPos2,
        y2: yPos2,
        totalWidth: totalWidth,
        debugInfo: Format(
            "モニターサイズ: {1}x{2}`nモニター座標: Left={3}, Top={4}, Right={5}, Bottom={6}`n" 
            "画像1サイズ: {7}x{8}`n画像2サイズ: {9}x{10}`n合計幅: {11}`n"
            "画像1位置: x={12}, y={13}`n画像2位置: x={14}, y={15}",
            monitorWidth, monitorHeight,
            monitorInfo.left, monitorInfo.top, monitorInfo.right, monitorInfo.bottom,
            roundWidth0, roundHeight0, roundWidth1, roundHeight1, totalWidth,
            xPos1, yPos1, xPos2, yPos2
        )
    }
}
