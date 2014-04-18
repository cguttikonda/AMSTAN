function funSubmit()
	{
	if(document.myForm.siteNum.value!="")
		{
		document.myForm.action="ezTransListById.jsp"
		document.myForm.submit();
		}
	else
		{
		alert("please enter the value ");
		document.myForm.siteNum.focus()
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
