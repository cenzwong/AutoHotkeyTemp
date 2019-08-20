InputBox, SearchKey, Enter Password, (search key)
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    RunWait https://translate.google.com/?ie=UTF-8&client=zh-ob#view=home&op=translate&sl=auto&tl=zh-CN&text=%SearchKey%,

Sleep, 5000

ClickImage(".\copyBtn.png")
   

