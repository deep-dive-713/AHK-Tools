; VWP時 JIS配列キーボード 記号入力対応
; (参考)US配列スキャンコード：https://so-zou.jp/pc/keyboard/scan-code.htm

#IfWinActive, ahk_exe etxc.exe
    ; 1段目
    !::Send, +{sc002} ; !
    "::Send, +{sc028} ; "
    #::Send, +{sc004} ; #
    $::Send, +{sc005} ; $
    %::Send, +{sc006} ; %
    &::Send, +{sc008} ; &
    '::Send,  {sc028} ; '
    (::Send, +{sc00A} ; (
    )::Send, +{sc00B} ; )
    -::Send,  {sc00C} ; -
    =::Send,  {sc00D} ; =
    ^::Send, +{sc007} ; ^
    ~::Send, +{sc029} ; ~
    \::Send,  {sc02B} ; \
    |::Send, +{sc02B} ; |

    ; 2段目
    @::Send, +{sc003}   ; @
    `::Send,  {sc029 2} ; ` (半角/全角 を2回送信している)
    [::Send,  {sc01A}   ; [
    {::Send, +{sc01A}   ; {}
    
    ; 3段目
    `;::    Send,  {sc027} ; ;
    +;::    Send, +{sc00D} ; +
    sc028:: Send, +{sc027} ; :
    +sc028::Send, +{sc009} ; +
    ]::     Send,  {sc01B} ; ]
    }::     Send, +{sc01B} ; }

    ; 4段目
    sc073:: Send,  {sc02B} ; \
    +sc073::Send, +{sc00C} ; _

    ; US配列の(['],["],[:]) 入力対応 
        ^sc028:: Send,  {sc028} ; Ctrl         + : -> '
        ^+sc028::Send, +{sc028} ; Ctrl + Shift + : -> "
        ^+;::    Send, +{sc027} ; Ctrl + Shift + ; -> :

    ; F13 + キー コマンド
        ; _
        F13 & -::Send, +{sc00C} ; F13 + "-" -> "_"

        ; "
        F13 & 7::Send, +{sc028} ; F13 + 7 -> "

        ; { [
        F13 & 8::
        if GetKeyState("Shift") {
            Send, +{sc01A}      ; F13 + Shift + 8 -> {
            return
        }
        Send, {sc01A}           ; F13         + 8 -> [
        return

        ; } ]
        F13 & 9::
        if GetKeyState("Shift") {
            Send, +{sc01B}      ; F13 + Shift + 9 -> }
            return
        }
        Send, {sc01B}           ; F13         + 9 -> ]
        return

    ; IME切り替え
        sc07B::Send, !{sc029}
#IfWinActive
