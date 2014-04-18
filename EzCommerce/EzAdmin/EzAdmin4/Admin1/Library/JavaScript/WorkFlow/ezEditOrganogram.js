function funUpdate()
{
	if(document.myForm.syskey.selectedIndex==0)
	{
		alert("Please Select Business Area.");
		document.myForm.syskey.focus();		
	}
	else if(document.myForm.lang.selectedIndex==0)
	{
		alert("Please Select Lanuguage.");	
		document.myForm.lang.focus();
	}
	else if(document.myForm.template.selectedIndex==0)
	{
		alert("Please Select Template.");
		document.myForm.template.focus();
	}
	else if(document.myForm.description.value == "")
	{
		alert("Please Enter Description.")
		document.myForm.description.focus();
	}
	else
	{
		document.myForm.action = "ezEditSaveOrganogram.jsp"
		document.myForm.submit();
	}
}