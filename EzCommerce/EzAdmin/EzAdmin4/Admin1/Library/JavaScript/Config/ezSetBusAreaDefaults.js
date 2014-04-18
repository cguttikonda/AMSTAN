

function myalert(label)
{
	
	if(document.myForm.SystemKey.selectedIndex != 0)
	{
		document.myForm.action="ezSetBusAreaDefaults.jsp";
		document.myForm.submit();
	}
}

function placeFocus()
{
	var obj = document.myForm.DefaultsValue
	if(obj != null)
	{
		if(obj.length == null)
		{
			document.myForm.DefaultsValue.focus()
		}
		else
		{
			document.myForm.DefaultsValue[0].focus()
		}
	}	
}