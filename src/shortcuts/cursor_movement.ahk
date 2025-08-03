;=========================================
; カーソル移動関連のショートカット
;=========================================
; 使用したい設定のコメントアウトを解除して使用してください。
; 複数の設定を同時に有効にすると、キーの競合が発生する可能性があります。

;=========================================
; デフォルト設定（IJKL配列）
;=========================================
; カーソルキー
F13 & l::Send "{Blind}{Right}"      ; F13 + l → 右カーソル移動
F13 & j::Send "{Blind}{Left}"       ; F13 + j → 左カーソル移動
F13 & i::Send "{Blind}{Up}"         ; F13 + i → 上カーソル移動
F13 & k::Send "{Blind}{Down}"       ; F13 + k → 下カーソル移動

; 行頭・行末
F13 & h::Send "{Blind}{Home}"       ; F13 + h → 行頭へ移動
F13 & `;::Send "{Blind}{End}"       ; F13 + ; → 行末へ移動

; 文節移動
F13 & y::Send "{Blind}^{Left}"      ; F13 + y → 前の単語の先頭へ
F13 & u::Send "{Blind}^{Right}"     ; F13 + u → 次の単語の先頭へ

; その他の機能キー
F13 & Space:: {                     ; F13 + Space   → Enter
    if GetKeyState("Shift") {
        Send "!{Enter}"             ; Shift + Alt + Enter → 改行
        return
    }
    Send "{Enter}"                  ; Enter → 改行
}

;=========================================
; Vimライクな設定（HJKL配列）
;=========================================
/*
; Vimのような直感的なカーソル移動を実現します
; 基本的なカーソル移動（HJKLキー）
F13 & h::Send "{Blind}{Left}"       ; F13 + h → 左へ移動
F13 & j::Send "{Blind}{Down}"       ; F13 + j → 下へ移動
F13 & k::Send "{Blind}{Up}"         ; F13 + k → 上へ移動
F13 & l::Send "{Blind}{Right}"      ; F13 + l → 右へ移動

; 単語単位の移動
F13 & w::Send "^{Right}"            ; F13 + w → 次の単語の先頭へ
F13 & b::Send "^{Left}"             ; F13 + b → 前の単語の先頭へ

; 行頭・行末
F13 & 0::Send "{Home}"              ; F13 + 0 → 行頭へ
F13 & $::Send "{End}"               ; F13 + $ → 行末へ

; ページ移動
F13 & ^f::Send "{PgDn}"             ; F13 + Ctrl + f → 1ページ下へ
F13 & ^b::Send "{PgUp}"             ; F13 + Ctrl + b → 1ページ上へ

; ファイル内移動
F13 & g:: {                         ; g/G - ファイルの先頭/末尾
    if GetKeyState("Shift") {
        Send "^{End}"               ; F13 + Shift + G → ファイル末尾へ
        return
    }
    Send "^{Home}"                  ; F13 + g → ファイル先頭へ
}
*/
