function funSubmit()
{
	if(document.myForm.obj.value!="")
	{
		document.myForm.action="ezTransListByObject.jsp"
		document.myForm.submit();
	}
	else
	{
		alert("please enter the value ");
		document.myForm.obj.focus();
		return false;
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
		return false;
}
