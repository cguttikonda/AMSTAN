function funFocus()
{
	if(document.myForm.orgCode!=null)
		document.myForm.orgCode.focus()
}
function funSave()
{
	if(document.myForm.orgCode.selectedIndex==0)
	{
		alert("Please Select Organogram.");
		document.myForm.orgCode.focus();		
	}
	else if(document.myForm.participant.value=="")
	{
		alert("Please Enter Participant.");
		document.myForm.participant.focus();
	}
	else
	{
		document.myForm.action = "ezNextOrganogramLevelsByParticipant.jsp"
		document.myForm.submit();
	}
}