function setAction() {
	document.forms[0].action= "../Inbox/ezReplyPersMsg.jsp";
	document.returnValue = true;
}
function setActionNew() {
	document.forms[0].action= "../Inbox/ezReplyPersMsg.jsp";
	document.returnValue = true;
}
function setDeleteFlag() 
{
     if(confirm("do you want to delete"))
     {
	document.MsgInfo.DelFlag.value = 'Y';
	document.returnValue = true;
     }
     else
     {
          document.returnValue= false;
     }
}
function setRemDateWindow(msgID)
{
	var url = "ezSetReminderDate.jsp?MessageID=" + msgID;
	var hWnd = 	window.open(url,"UserWindow","width=400,height=250,resizable=yes,scrollbars=auto");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}
function setExpDateWindow(msgID)
{
	var url = "ezSetExpiryDate.jsp?MessageID=" + msgID;
	var hWnd = 	window.open(url,"UserWindow","width=400,height=250,resizable=yes,scrollbars=auto");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}
function move()
{
	if(document.myForm.ToFolder.selectedIndex==0)
	{
		alert("Please select the folder to which you the mail to be moved.")
		document.myForm.ToFolder.focus();
		return false;
	}
}