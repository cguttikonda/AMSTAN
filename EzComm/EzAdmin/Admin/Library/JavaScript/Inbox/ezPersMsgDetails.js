function setAction() {
	document.forms[0].action= "../Inbox/ezReplyPersMsg.jsp";
	document.forms[0].submit();
}
function setActionNew() {
	document.forms[0].action= "../Inbox/ezReplyPersMsg.jsp";
	document.forms[0].submit();
}
function setDeleteFlag() 
{
     if(confirm("do you want to delete"))
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
          alert("pls select the folder to move");
          document.returnValue=false;    
   }
   else
   {
           //document.returnValue=true; 
          document.myForm.submit();
   }
}
