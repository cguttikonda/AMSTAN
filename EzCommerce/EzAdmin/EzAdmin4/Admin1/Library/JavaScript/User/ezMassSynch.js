function checkAll()
{
	if(document.myForm.prop.value=="")
	{
		alert("Please Enter Property File Name")
		document.myForm.prop.focus()
	}
	else if(document.myForm.from.value=="")
	{
		alert("Please Enter From value")
		document.myForm.from.focus()
	}
	else if(document.myForm.to.value=="")
	{
		alert("Please Enter To Value")
		document.myForm.to.focus()
	}
	else
		return true;
	return false;
}