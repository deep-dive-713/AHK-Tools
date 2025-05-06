;=========================================
; カーソル移動関連のショートカット
;=========================================
; 使用したい設定のコメントアウトを解除して使用してください。
; 複数の設定を同時に有効にすると、キーの競合が発生する可能性があります。

;=========================================
; デフォルト設定（IJKL配列）
;=========================================
; カーソルキー
F13 & l::Send "{Blind}{Right}"      ; 右カーソル移動
F13 & j::Send "{Blind}{Left}"       ; 左カーソル移動
F13 & i::Send "{Blind}{Up}"         ; 上カーソル移動
F13 & k::Send "{Blind}{Down}"       ; 下カーソル移動

; 行頭・行末
F13 & h::Send "{Blind}{Home}"       ; 行頭へ移動
F13 & `;::Send "{Blind}{End}"       ; 行末へ移動

; 文節移動
F13 & y::Send "{Blind}^{Left}"      ; 前の単語の先頭へ
F13 & u::Send "{Blind}^{Right}"     ; 次の単語の先頭へ

; その他の機能キー
F13 & e::Send "{Blind}{Escape}"     ; エスケープキー
F13 & Space:: {                     ; Enterキー
    if GetKeyState("Shift") {
        Send "!{Enter}"             ; Shift押しながら：Alt+Enter（改行を挿入）
        return
    }
    Send "{Enter}"                  ; 通常：Enter
}

;=========================================
; Vimライクな設定（HJKL配列）
;=========================================
/*
; Vimのような直感的なカーソル移動を実現します
; 基本的なカーソル移動（HJKLキー）
F13 & h::Send "{Blind}{Left}"       ; h - 左へ移動
F13 & j::Send "{Blind}{Down}"       ; j - 下へ移動
F13 & k::Send "{Blind}{Up}"         ; k - 上へ移動
F13 & l::Send "{Blind}{Right}"      ; l - 右へ移動

; 単語単位の移動
F13 & w::Send "^{Right}"            ; w - 次の単語の先頭へ
F13 & b::Send "^{Left}"             ; b - 前の単語の先頭へ

; 行頭・行末
F13 & 0::Send "{Home}"              ; 0 - 行頭へ
F13 & $::Send "{End}"               ; $ - 行末へ

; ページ移動
F13 & ^f::Send "{PgDn}"             ; Ctrl+f - 1ページ下へ
F13 & ^b::Send "{PgUp}"             ; Ctrl+b - 1ページ上へ

; ファイル内移動
F13 & g:: {                         ; g/G - ファイルの先頭/末尾
    if GetKeyState("Shift") {
        Send "^{End}"               ; G  - ファイル末尾へ
        return
    }
    Send "^{Home}"                  ; gg - ファイル先頭へ
}
*/
