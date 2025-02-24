;=========================================
; カーソル移動関連のショートカット
;=========================================
; 使用したい設定のコメントアウトを解除して使用してください。
; 複数の設定を同時に有効にすると、キーの競合が発生する可能性があります。

;=========================================
; デフォルト設定（IJKL配列）
;=========================================
; カーソルキー
F13 & l:: Send, {Blind}{right}      ; 右カーソル移動
F13 & j:: Send, {Blind}{left}       ; 左カーソル移動
F13 & i:: Send, {Blind}{up}         ; 上カーソル移動
F13 & k:: Send, {Blind}{down}       ; 下カーソル移動

; 行頭・行末
F13 & h:: Send, {Blind}{Home}       ; 行頭へ移動
F13 & `;:: Send, {Blind}{End}        ; 行末へ移動

; その他の機能キー
F13 & e:: Send, {Blind}{Esc}        ; エスケープキー
F13 & Space::                       ; Enterキー
    if GetKeyState("Shift") {
        Send, !{Enter}              ; Shift押しながら：Alt+Enter（改行を挿入）
        return
    }
    Send, {Enter}                   ; 通常：Enter
return

;=========================================
; Vimライクな設定（HJKL配列）
;=========================================
/*
; Vimのような直感的なカーソル移動を実現します
; 基本的なカーソル移動（HJKLキー）
F13 & h:: Send, {Blind}{left}       ; h - 左へ移動
F13 & j:: Send, {Blind}{down}       ; j - 下へ移動
F13 & k:: Send, {Blind}{up}         ; k - 上へ移動
F13 & l:: Send, {Blind}{right}      ; l - 右へ移動

; 単語単位の移動
F13 & w:: Send, ^{right}            ; w - 次の単語の先頭へ
F13 & b:: Send, ^{left}             ; b - 前の単語の先頭へ

; 行頭・行末
F13 & 0:: Send, {Home}              ; 0 - 行頭へ
F13 & $:: Send, {End}               ; $ - 行末へ

; ページ移動
F13 & ^f:: Send, {PgDn}             ; Ctrl+f - 1ページ下へ
F13 & ^b:: Send, {PgUp}             ; Ctrl+b - 1ページ上へ

; ファイル内移動
F13 & g::                           ; g/G - ファイルの先頭/末尾
    if GetKeyState("Shift") {
        Send, ^{End}                ; G  - ファイル末尾へ
        return
    }
    Send, ^{Home}                   ; gg - ファイル先頭へ
return
*/

;=========================================
; Emacsライクな設定
;=========================================
/*
; Emacsの基本的なキーバインドを実現します
; 基本的なカーソル移動
F13 & b:: Send, {Blind}{left}       ; Ctrl+b - 後方（左）へ移動
F13 & f:: Send, {Blind}{right}      ; Ctrl+f - 前方（右）へ移動
F13 & p:: Send, {Blind}{up}         ; Ctrl+p - 前（上）の行へ
F13 & n:: Send, {Blind}{down}       ; Ctrl+n - 次（下）の行へ

; 単語単位の移動
F13 & !f:: Send, ^{right}           ; Alt+f - 次の単語へ
F13 & !b:: Send, ^{left}            ; Alt+b - 前の単語へ

; 行頭・行末
F13 & a:: Send, {Home}              ; Ctrl+a - 行頭へ
F13 & e:: Send, {End}               ; Ctrl+e - 行末へ

; ページスクロール
F13 & v:: Send, {PgUp}              ; Ctrl+v - 1ページ上へ
F13 & !v:: Send, {PgDn}             ; Alt+v  - 1ページ下へ

; ファイル内移動
F13 & !<:: Send, ^{Home}            ; Alt+< - ファイルの先頭へ
F13 & !>:: Send, ^{End}             ; Alt+> - ファイルの末尾へ

; 削除操作
F13 & d:: Send, {Delete}            ; Ctrl+d - カーソル位置の文字を削除
F13 & h:: Send, {BS}                ; Ctrl+h - バックスペース
F13 & k:: Send, +{End}{Delete}      ; Ctrl+k - カーソル位置から行末まで削除
*/

