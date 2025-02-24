;=========================================
; 検索・開く機能
;=========================================
; 選択したテキストに応じて以下の動作を行う：
; 1. URLの場合：ブラウザで開く
; 2. ローカルパスの場合：エクスプローラーで開く
; 3. その他の文字列：Google検索を実行
;=========================================

search(){
    ; クリップボードの内容をバックアップ
    bk := ClipboardAll
    Clipboard := ""
    
    ; 選択テキストをクリップボードにコピー
    Send, ^{c}
    Sleep, 50                        ; クリップボードの操作完了を待つ
    ClipWait, 2                      ; クリップボードにデータが来るまで待つ（最大2秒）
    if ErrorLevel                    ; タイムアウトした場合
    {
        Clipboard := bk              ; クリップボードを復元
        return
    }
    
    ; クリップボードの内容を整形
    selectedText := Trim(Clipboard)  ; 文字列の前後のスペース、タブ、改行を削除
    
    ; パス情報を分解
    SplitPath, selectedText, name, dir, ext, noext, drive  ; Trim後のselectedTextを使用
    
    ; テキストの種類を判定して適切な処理を実行
    if (InStr(selectedText, "http://") = 1 || InStr(selectedText, "https://") = 1 || InStr(selectedText, "www.") = 1){
        ; URLとして処理
        doWeb(selectedText, drive, dir)
    } else if (drive != ""){
        ; ドライブレターがある場合はローカルパスとして処理
        doLocal(selectedText)
    } else {
        ; その他の文字列はGoogle検索
        doWeb(selectedText, drive, dir)
    }
    
    ; クリップボードを元の状態に復元
    Clipboard := bk
}

;=========================================
; ローカルパスを開く
;=========================================
doLocal(selectedPath){
    if (selectedPath != ""){
        ; フルパスを使用してエクスプローラーで開く
        try {
            Run, explorer.exe "%selectedPath%"  ; パスをダブルクオートで囲む
            return true
        } catch {
            MsgBox, エラー: フォルダを開けませんでした。`nPath: %selectedPath%
            return false
        }
    }
    return false
}

;=========================================
; Web関連の処理
;=========================================
doWeb(str, drive, dir){
    isWeb := ""
    ; & をエスケープ
    str := StrReplace(str, "&", "%26")  ; & をエスケープ
    str := StrReplace(str, " ", "+")    ; スペースを+に変換
    if((isWeb := isURL(drive, str)) != ""){                   ; 完全なURLの場合
    }else if((isWeb := isURLlike(str, drive, dir)) != ""){    ; URLっぽい文字列の場合
    }else{
        isWeb := getWebSearch(str)                            ; 検索用URLの生成
    }
    if(isWeb != ""){
        Run, %isWeb%
        return true
    }
    return false
}

;=========================================
; URL判定関連の関数群
;=========================================
; 完全なURLかどうかを判定
isURL(drive, dir){
    if(InStr(dir, "http://") = 1 || InStr(dir, "https://") = 1){
        return dir
    }
    return ""
}

; URLっぽい文字列の判定と修正
isURLlike(str, drive, dir){
    if(InStr(drive, "ttp://") = 1 || InStr(drive, "ttps://") = 1){
        return "h" . dir                    ; 先頭のhを補完
    }else if(drive = "" && InStr(str, "www.") = 1){
        return "http://" . str              ; http://を補完
    }
    return ""
}

; Google検索用URLの生成
getWebSearch(str){
    if(str != ""){
        return "http://www.google.com/search?q=" . str
    }
    return ""
}
