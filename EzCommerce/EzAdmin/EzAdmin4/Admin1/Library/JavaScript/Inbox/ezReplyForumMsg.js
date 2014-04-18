function VerifyEmptyFields() 
	{
	if (document.ReplyMsg.msgSubject.value == "" )
		{
		alert("Please enter Subject.");
		document.forms[0].msgSubject.focus();
		document.returnValue = false;
		return;
		}
	else
		{
		document.returnValue = true;
		}
	}	
