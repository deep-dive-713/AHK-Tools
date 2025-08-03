;=========================================
; JIS/US配列変換設定
;=========================================
; VWP時 JIS配列キーボード 記号入力対応
; (参考)US配列スキャンコード：https://so-zou.jp/pc/keyboard/scan-code.htm

; グローバル変数で状態管理
global JIS2USEnabled := true

; トグル用ホットキー (例: Win + F13)
RShift & Esc:: ToggleJIS2US()

; トグル関数
ToggleJIS2US() {
    global JIS2USEnabled
    JIS2USEnabled := !JIS2USEnabled
    
    ; 状態をツールチップで表示
    status := JIS2USEnabled ? "有効" : "無効"
    ToolTip "JIS/US配列変換: " status
    SetTimer () => ToolTip(), -1000  ; 1秒後に消去
}

#HotIf WinActive("ahk_exe etxc.exe") and JIS2USEnabled
    ; 1段目
    !::Send "{?}"   ; !
    "::Send "+{sc028}"   ; "
    #::Send "+{sc004}"   ; #
    $::Send "+{sc005}"   ; $
    %::Send "+{sc006}"   ; %
    &::Send "+{sc008}"   ; &
    '::Send "{sc028}"    ; '
    (::Send "+{sc00A}"   ; (
    )::Send "+{sc00B}"   ; )
    -::Send "{sc00C}"    ; -
    =::Send "{sc00D}"    ; =
    ^::Send "+{sc007}"   ; ^
    ~::Send "+{sc029}"   ; ~
    \::Send "{sc02B}"    ; \
    |::Send "+{sc02B}"   ; |

    ; 2段目
    @::Send "+{sc003}"   ; @
    `::Send "{sc029 2}"  ; ` (半角/全角 を2回送信している)
    [::Send "{sc01A}"    ; [
    {::Send "+{sc01A}"   ; {
    
    ; 3段目
    `;::Send "{sc027}"      ; ;
    +;::Send "+{sc00D}"     ; +
    sc028::Send "+{sc027}"  ; :
    +sc028::Send "+{sc009}" ; +
    ]::Send "{sc01B}"       ; ]
    }::Send "+{sc01B}"      ; }

    ; 4段目
    sc073::Send "{sc02B}"   ; \
    +sc073::Send "+{sc00C}" ; _

    ; US配列の(['],["],[:]) 入力対応 
    ^sc028::Send "{sc028}"   ; Ctrl         + : → '
    ^+sc028::Send "+{sc028}" ; Ctrl + Shift + : → "
    ^+;::Send "+{sc027}"     ; Ctrl + Shift + ; → :

    ; F13 + キー コマンド
    ; _
    F13 & -::Send "+{sc00C}" ; F13 + "-" → "_"

    ; "
    F13 & 7::Send "+{sc028}" ; F13 + 7 → "

    ; { [
    F13 & 8:: {
        if GetKeyState("Shift")
            Send "+{sc01A}"   ; F13 + Shift + 8 → {
        else
            Send "{sc01A}"    ; F13         + 8 → [
    }

    ; } ]
    F13 & 9:: {
        if GetKeyState("Shift")
            Send "+{sc01B}"   ; F13 + Shift + 9 → }
        else
            Send "{sc01B}"    ; F13         + 9 → ]
    }

    ; IME切り替え
    sc07B::Send "!{sc029}"
#HotIf
