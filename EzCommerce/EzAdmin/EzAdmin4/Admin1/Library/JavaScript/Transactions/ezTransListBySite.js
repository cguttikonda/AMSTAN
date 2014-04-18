function funSubmit()
{
	if(document.myForm.siteNum.value!="")
	{
		document.myForm.action="ezTransListBySite.jsp"
		document.myForm.submit();
	}
	else
	{
		alert("Please Enter The Site Number");
		document.myForm.siteNum.focus();
		return false
	}
}



function funClear()
{
	if(chkEdit(document.myForm))
	{
		document.myForm.action="ezDeleteTrans.jsp"
		document.myForm.submit();
	}
	else
		return false
}
