^!g::
InputBox, SearchKey, Enter Password, (search key)
splitText := StrSplit(SearchKey, A_Space)
maxIndex := splitText.MaxIndex()
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    Run https://www.google.com/search?q=%SearchKey%,
return

^!t::
Sleep, 100
Send !r
Sleep, 300
Send l
Sleep, 300
Send s
;CoordMode, Mouse, Screen
;MouseGetPos , OutputVarX, OutputVarY
Sleep, 2000
MouseClick, left, 1207, 364
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {enter}
;MouseMove, OutputVarX, OutputVarY, 50
return

^!n::  ; Ctrl+Alt+N
if WinExist("Untitled - Notepad")
    WinActivate
else
    Run "Notepad"
return

^+c::
; null= 
send ^c
sleep,200
clipboard=%clipboard% ;%null%
tooltip,%clipboard%
sleep,500
tooltip,
return

^+v::
myClipboard := clipboard
sendinput %clipboard%
return

^#c::
MouseGetPos, mouseX, mouseY
; 获得鼠标所在坐标，把鼠标的 X 坐标赋值给变量 mouseX ，同理 mouseY
PixelGetColor, color, %mouseX%, %mouseY%, RGB
; 调用 PixelGetColor 函数，获得鼠标所在坐标的 RGB 值，并赋值给 color
StringRight color,color,6
; 截取 color（第二个 color）右边的6个字符，因为获得的值是这样的：#RRGGBB，一般我们只需要 RRGGBB 部分。把截取到的值再赋给 color（第一个 color）。
clipboard = %color%
; 把 color 的值发送到剪贴板
tooltip, %clipboard%
sleep,500
tooltip,
return