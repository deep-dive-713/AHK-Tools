;=========================================
; 編集操作関連のショートカット
;=========================================
F13 & o:: Send "{Blind}{BackSpace}"  ; F13 + o         → BackSpace
F13 & p:: Send "{Blind}{Delete}"     ; F13 + p         → Delete
F13 & n:: Send "{Blind}{PgUp}"       ; F13 + n         → Page Up
F13 & m:: Send "{Blind}{PgDn}"       ; F13 + m         → Page Down
F13 & BS::Send "{Blind}{Delete}"     ; F13 + BackSpace → Delete

F13 & t::Send "^{PgUp}"             ; F13 + T → 上のページへ
F13 & g::Send "^{PgDn}"             ; F13 + G → 下のページへ
F13 & e::Send "^+{Tab}"             ; F13 + E → 左のタブへ
F13 & r::Send "^{Tab}"              ; F13 + R → 右のタブへ

;=========================================
; PDF改行コード処理機能
;=========================================
F13 & v:: {  ; F13 + V → PDF改行コード処理してそのまま貼り付け
    ; クリップボードの内容を取得
    clipboard_content := A_Clipboard
    
    ; 改行コードを統一（CRLF → LF、CR → LF）
    processed_content := StrReplace(clipboard_content, "`r`n", " ")
    processed_content := StrReplace(processed_content, "`r", " ")
    processed_content := StrReplace(processed_content, "`n", " ")
    
    ; 連続する空白を1つに統一（2つ以上の空白を1つに）
    processed_content := RegExReplace(processed_content, " {2,}", " ")
    
    ; 行頭・行末の空白を削除
    processed_content := RegExReplace(processed_content, "^ +| +$", "")
    
    ; 句読点の前後の空白を削除
    processed_content := RegExReplace(processed_content, "\s+([。、，．])", "$1")
    processed_content := RegExReplace(processed_content, "([。、，．])\s+", "$1")
    
    ; 処理された内容をクリップボードに戻す
    A_Clipboard := processed_content
    
    ; そのまま貼り付け
    Send "^v"
}


