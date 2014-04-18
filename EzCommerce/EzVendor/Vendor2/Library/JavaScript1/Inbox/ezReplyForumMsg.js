function VerifyEmptyFields() 
	{
	if (document.myForm.msgSubject.value == "" )
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
