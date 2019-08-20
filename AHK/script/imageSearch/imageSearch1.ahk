ImagePath := "C:\Users\WM2014.WME-WM2014030\Desktop\Cenz\AHK\script\imageSearch\copyBtn.png"
;ImagePath = C:\Users\WM2014.WME-WM2014030\Desktop\Cenz\AHK\script\imageSearch\copyBtn.png

ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %ImagePath%

if (ErrorLevel = 2)
    MsgBox Could not conduct the search.
else if (ErrorLevel = 1)
    MsgBox Icon could not be found on the screen.
else
    MsgBox The icon was found at %FoundX%x%FoundY%.

MouseMove, FoundX, FoundY , 10
Send {Click}

