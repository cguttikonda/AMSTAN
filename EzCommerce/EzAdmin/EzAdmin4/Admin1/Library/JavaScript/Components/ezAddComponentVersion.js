function checksubmit()
{
	if(document.myForm.Client.value=="_")
	{
		alert("Please Select Client")
		return false
	}
	else
	if(document.myForm.Component.value=="_")
	{
			alert("Please Select Component")
			return false
	}
	else
	if(document.myForm.Version.value=="_")
	{
				alert("Please Select Version")
				return false
	}
	else
	if(document.myForm.upDate.value=="")
	{
				alert("Please Select Date")
				return false
	}
	else
	return true
}

