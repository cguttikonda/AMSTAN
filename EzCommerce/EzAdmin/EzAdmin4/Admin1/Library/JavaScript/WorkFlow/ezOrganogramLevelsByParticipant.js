function funFocus()
{
	if(document.myForm.orgCode!=null)
		document.myForm.orgCode.focus()
}
function funSelect()
{
	if(document.myForm.orgCode.selectedIndex==0)
	{
		alert("Please Select Organogram.");
		document.myForm.orgCode.focus();		
	}
	else
	{
		document.myForm.action = "ezOrganogramLevelsByParticipant.jsp"
		document.myForm.submit();
	}
}