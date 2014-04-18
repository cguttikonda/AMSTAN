
function funsubmit()
{
	//document.UserAuth.BusUser.options[0].selected=true;
	document.CopyUser.action="ezCopyUserBySysKey.jsp";
	document.CopyUser.submit();
}


function funsubmit1(area)
{
	if(document.CopyUser.WebSysKey.options[document.CopyUser.WebSysKey.selectedIndex].value=="sel" && document.CopyUser.BusUser.options[document.CopyUser.BusUser.selectedIndex].value=="sel")
	{
		alert("Please Select "+area +" and user");
		return;
	}

	if(document.CopyUser.BusUser.options[document.CopyUser.BusUser.selectedIndex].value=="sel")
	{
		alert("Please select User");
	}
	else
	{
		document.CopyUser.action="ezCopyUserBySysKey.jsp";
		document.CopyUser.submit();
	}
}


function chkCopyUser()
{
	if(document.myForm.NewUser.value == "" || document.myForm.NewUser.value == null)
	{
		alert("Please enter Target User")
		document.myForm.NewUser.focus()
		return false
	}
	else
	{
		document.myForm.NewUser.value = (document.myForm.NewUser.value).toUpperCase()
		document.myForm.submit()
		document.myForm.action="ezConfirmCopyUser.jsp"
		return true
	}
}