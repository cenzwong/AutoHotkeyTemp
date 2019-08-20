; DOM示例.ahk

; DOM 文档:
; 	http://www.w3school.com.cn/xmldom/xmldom_reference.asp
; 	http://www.w3schools.com/jsref/dom_obj_all.asp
; 	http://www.w3school.com.cn/htmldom/htmldom_reference.asp

#NoEnv
#SingleInstance Force
SetBatchLines -1
ListLines Off
ComObjError(False)

; =================================
;		界面
; =================================
Gui, Margin, 0, 0
Gui Add, ActiveX, w800 h500 vWB, Shell.Explorer
Gui, Show

; =================================
;		打开网页，并等待加载完毕
; =================================
OpenLoginPage:
WB.Navigate("http://ahkscript.org/boards/ucp.php?mode=login")
While WB.readystate != 4 or WB.busy
	Sleep 10

; 如果已经登录则退出
if !InStr(WB.LocationUrl, "login")
{
	Gui, +OwnDialogs
	MsgBox, 36, 确认退出登录, 脚本需要退出论坛的登录，是否允许？（因为此脚本是在登录页面进行演示的）
	IfMsgBox, No
	{
		MsgBox, 好吧。请手工退出登录后再运行此脚本。再见！
		ExitApp
	}

	; 退出登录
	WB.document.getElementById("menubar").all.tags("a")[0].Click()
	While WB.readystate != 4 or WB.busy
		Sleep 10

	Goto, OpenLoginPage
}

; =================================
;		修改网页
; =================================
doc := WB.doc
doc.getElementById("username").Disabled := True ; 禁用【用户名输入框】
doc.getElementById("password").Disabled := True ; 禁用【密码输入框】
doc.getElementById("username").style.backgroundColor := "A0FABF" ; 修改【用户名输入框】背景色
doc.getElementById("password").style.backgroundColor := "FDCAAE" ; 修改【密码输入框】背景色
doc.getElementById("login").value := "点击登录 :)" ; 修改【登录按钮】文字
doc.getElementById("login").style.Color := "Red"   ; 修改【登录按钮】文字颜色
doc.getElementById("login").style.backgroundColor := "FFFF00" ; 修改【登录按钮】背景颜色
doc.images[0].src := "http://t1.qpic.cn/mblogpic/7d0ba55a04cb2e504246/2000.jpg" ; 修改 logo 图片

; =================================
;		监测事件
; =================================
; 监测 doc 事件
ComObjConnect(doc, doc_events)

; 监测登录按钮所在 form 的事件
form := doc.forms[0]
ComObjConnect(form, "LoginForm_")

; 监测登录按钮事件
LogInBtn := doc.getElementById("login")
ComObjConnect(LogInBtn, "LogInBtn_")

; 监测登录按钮上级<TD>事件
LogInBtnPTD := LogInBtn.parentNode
ComObjConnect(LogInBtnPTD, "LogInBtnPTD_")

; =================================
;		设置定时移动登录按钮
; =================================
LogInBtn.style.position := "relative" ; 按钮位置设为相对位置
MoveStep                := -50 ; 按钮移动步伐
BtnW                    := LogInBtn.offsetWidth ; 按钮宽度
BtnPW                   := LogInBtn.parentNode.offsetWidth ; 按钮的上级元素的宽度
SetTimer, Move_LogInBtn, 200
Return

; =================================
;		移动登录按钮
; =================================
Move_LogInBtn:
	x += MoveStep
	LogInBtn.style.left := x

	BtnX := LogInBtn.offsetLeft
	MoveStep := ( BtnX < Abs(MoveStep) || (BtnX + BtnW >= BtnPW) ) ? -MoveStep : MoveStep
Return

; =================================
;		关闭界面则退出脚本
; =================================
GuiClose:
ExitApp

; ================================================== 以下是函数 ==================================================

; =================================
;		整个 wb 文档的事件
; =================================
Class doc_events
{
	oncontextmenu(doc) {
		doc.parentWindow.event.returnvalue := False ; 取消事件的动作
		MsgBox, 右键被禁用了
	}

	OnClick(doc) {
	    if doc.parentWindow.event.srcElement.name in username,password
	    	doc.parentWindow.event.srcElement.value := doc.parentWindow.event.srcElement.name
	}

	ondblclick(doc) {
		MsgBox, 检测到双击
	}
}

; =================================
;		登录按钮所在 form 的事件
; =================================
LoginForm_onsubmit(form) {
	form.document.parentWindow.event.returnvalue := False ; 取消事件的动作
	form.document.getElementById("login").value := "点击登录 :)" ; 按钮文字会被网页恢复，这里重新修改【登录按钮】文字
	MsgBox, 登录动作被取消了
}

; =================================
;		登录按钮上级 <TD> 的事件
; =================================

; 鼠标悬停
LogInBtnPTD_onmouseover(LogInBtn) {
	SetTimer, Move_LogInBtn, Off ; 停止移动按钮
}

; 鼠标移开
LogInBtnPTD_onmouseout(LogInBtn) {
	SetTimer, Move_LogInBtn, 200 ; 恢复移动按钮
}

; =================================
;		登录按钮的事件
; =================================

; 鼠标悬停
LogInBtn_onmouseover(LogInBtn) {
	LogInBtn.style.backgroundColor := "FDD0FD"
}

; 鼠标移开
LogInBtn_onmouseout(LogInBtn) {
	LogInBtn.style.backgroundColor := "FFFF00"
}