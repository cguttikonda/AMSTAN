function fun1(theField,theImage)
{
	if(theField != null)
	{
		if(theImage != null)
		{
			eval("document.forms[0]."+theField).src=theImage;
		}
	}
}

function fun3(theAction)
{
	if(theAction != null)
	{
		if(theAction=="submit")
		{
			if(chk()==true)
				eval("document.forms[0]."+theAction+"()");
		}
		else if(theAction=="reset")
		{
			eval("document.forms[0]."+theAction+"()");
		}
		else
		{
			eval(theAction);
		}
	}
}
