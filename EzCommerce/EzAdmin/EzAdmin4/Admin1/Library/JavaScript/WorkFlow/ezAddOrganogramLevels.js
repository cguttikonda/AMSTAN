function funSave()
{
	if(document.myForm.orgCode.selectedIndex==0)
	{
		alert("Please Select Organogram.");
		document.myForm.orgCode.focus();		
	}
	else if(document.myForm.level.selectedIndex==0)
	{
		alert("Please Select Level.");
		document.myForm.level.focus();
	}
	else if(document.myForm.participant.selectedIndex==0)
	{
		alert("Please Select Participant.");
		document.myForm.participant.focus();
	}
	else if(document.myForm.lang.selectedIndex==0)
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
		document.myForm.action = "ezAddSaveOrganogramLevels.jsp"
		document.myForm.submit();
	}
}