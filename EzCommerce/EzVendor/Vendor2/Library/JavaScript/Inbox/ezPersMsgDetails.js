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
     if(confirm("Do You Want To Delete"))
     {
	document.myForm.DelFlag.value = 'Y';
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
          alert(plzFolMov_L);
          document.returnValue=false;
   }
   else
   {
               document.returnValue=true;
   }
}
