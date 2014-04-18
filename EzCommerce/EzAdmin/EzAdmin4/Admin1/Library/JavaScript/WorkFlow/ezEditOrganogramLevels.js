function funSave()
{
	if(document.myForm.lang.selectedIndex==0)
	{
		alert("Please Select Language.");
		document.myForm.lang.focus();		
	}
	else if(document.myForm.description.value=="")
	{
		alert("Please Enter Description.");
		document.myForm.description.focus();
	}
	else
	{
		document.myForm.action = "ezEditSaveOrganogramLevels.jsp"
		document.myForm.submit();
	}
}