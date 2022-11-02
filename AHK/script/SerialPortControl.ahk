#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force
SetTimer, Timer, On

Gui, Add, GroupBox, x6 y17 w300 h90 , Inputs
Gui, Add, GroupBox, x6 y127 w300 h90 , Outputs
Gui, Add, CheckBox, x26 y47 w50 h20 , DCD
Gui, Add, CheckBox, x96 y47 w50 h20 , DSR
Gui, Add, CheckBox, vCTS x166 y47 w50 h20 , CTS
Gui, Add, CheckBox, x236 y47 w50 h20 , RI
Gui, Add, CheckBox, Checked0 vTXD gTimer x26 y157 w50 h20 , TXD
Gui, Add, CheckBox, Checked0 vDTR gTimer x136 y157 w50 h20 , DTR
Gui, Add, CheckBox, Checked0 vRTS gTimer x236 y157 w50 h20 , RTS
Gui, Add, Radio, Group vCOM1 gCOM1 x76 y247 w50 h20 , COM1
Gui, Add, Radio, Checked vCOM2 gCOM2 x186 y247 w50 h20 , COM2

Gui, Show, x232 y138 h297 w316, OItest

 

mode = COM2:baud=9600 parity=N data=8 stop=1 dtr=Off 
Port_BuildCommDCB(mode)


Port_OPENCOM("COM2")
Port_SetCommState(nCid, &DCB)
IfLess, nCid, 0
{
	Port_OPENCOM("COM1")
	GuiControl, , COM1, 1
}
IfEqual, nCid, 0
	Msgbox, 0, Port, COM Interface Error
Gosub, Outputs
Return



COM1:
Port_CLOSECOM(nCid)
Port_OPENCOM("COM1") 
IfLess, nCid, 0
	Msgbox, 0, Port, COM1 not available
Gosub, Outputs	
return

COM2:
Port_CLOSECOM(nCid)
Port_OPENCOM("COM2") 
IfLess, nCid, 0
	Msgbox, 0, Port, COM2 not available
Gosub, Outputs	
return

Timer:
gui Submit,NoHide
Port_DCD(nCid)
Port_DSR(nCid)
Port_CTS(nCid)
Port_RI(nCid)
IfEqual, DTR, 1
	Port_DTR(nCid, 5)
Else 
	Port_DTR(nCid, 6)
IfEqual, RTS, 1
	Port_RTS(nCid, 3)
Else 
	Port_RTS(nCid, 4)
IfEqual, TXD, 1
	Port_TXD(nCid, 8)
Else
	Port_TXD(nCid, 9)
IfEqual, S_CTS, 16
	GuiControl, , CTS, 1
Else
	GuiControl, , CTS, 0
IfEqual, S_RI, 64
	GuiControl, , RI, 1
Else
	GuiControl, , RI, 0	
IfEqual, S_DCD, 128
	GuiControl, , DCD, 1
Else
	GuiControl, , DCD, 0
IfEqual, S_DSR, 32
	GuiControl, , DSR, 1
Else
	GuiControl, , DSR, 0		
Return

Outputs:
Port_DTR(nCid, 6)
Port_RTS(nCid, 4)
Port_TXD(nCid, 9)
Return

GuiClose:
Port_CLOSECOM(nCid)
ExitApp


Port_RTS(nCid, x)
{
	Port_EscapeCommFunction(nCid, x)
}

Port_DTR(nCid, x)
{
	Port_EscapeCommFunction(nCid, x)
}

Port_TXD(nCid, x)
{
	Port_EscapeCommFunction(nCid, x)
}

Port_CTS(nCid)
{
	Global S_CTS
	S_CTS := Port_GetCommModemStatus(nCid)
	Return 
}

Port_DSR(nCid)
{
	Global S_DSR
	S_DSR := Port_GetCommModemStatus(nCid)
}

Port_RI(nCid)
{
	Global S_RI
	S_RI := Port_GetCommModemStatus(nCid)
}

Port_DCD(nCid)
{
	Global S_DCD
	S_DCD := Port_GetCommModemStatus(nCid)
}

Port_OPENCOM(port) {
global nCid
nCid := DllCall("CreateFile"
				,"Str", port					
				,"Uint", 0x80000000 | 0x40000000
				,"Uint", 3
				,"UInt", 0
				,"UInt", 3
				,"Uint", 0
				,"UInt", 0
				,"Cdecl Int")
	Return nCid
}
; Closes an open communications device.
Port_CLOSECOM(hObject) {
DllCall( "CloseHandle"
				, "UInt",hObject ) 
Return
}

; Directs a specified communications device to perform a function.
Port_EscapeCommFunction(nCid, nFunc) {
DllCall("EscapeCommFunction"
				, "Uint",nCid
				, "Uint",nFunc
				,"Cdecl Int")
Return
}

; Retrieves modem control-register values.
Port_GetCommModemStatus(nCid) {
VarSetCapacity(lpModemStat, 28)
x := DllCall("GetCommModemStatus"
				, "Uint",nCid				
				, "Int *",lpModemStat
				,"Cdecl Uint")
Return lpModemStat
}

; Fills a specified DCB structure with values specified in a device-control string. 
; The device-control string uses the syntax of the mode command.
Port_BuildCommDCB(mode) {
global DCB
VarSetCapacity(DCB, 28)
cs := DllCall("BuildCommDCB"
				, "str", mode		; The device-control information. example: mode = COM1:baud=9600 parity=N data=8 stop=1
				, "UInt", &DCB)		; A pointer to a DCB structure that receives the information.
Return cs							; If the function succeeds, the return value is nonzero. If the function fails, the return value is zero
}

; Configures a communications device according to the specifications in a device-control block (a DCB structure). 
; The function reinitializes all hardware and control settings, but it does not empty output or input queues.
Port_SetCommState(nCid, DCB) { 
cs := DllCall("SetCommState"
				, "Uint", nCid		; A handle to the communications device. The CreateFile function returns this handle.
				, "Uint", DCB)		; A pointer to a DCB structure that contains the configuration information for the 
									; specified communications device.
Return cs							; If the function succeeds, the return value is nonzero. If the function fails, the return value is zero
}