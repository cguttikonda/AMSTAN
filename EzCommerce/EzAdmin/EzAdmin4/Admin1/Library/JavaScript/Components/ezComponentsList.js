var option=0
function checkAll()
{
	chkObj = document.myForm.chk1;
	var len1=chkObj.length
	if(document.myForm.chkAll.checked)
	{

		if(isNaN(len1))
		{
			chkObj.checked=true
		}
		else
		{
			for(i=0;i<chkObj.length;i++)
			chkObj[i].checked = true
		}
	}
	if(!(document.myForm.chkAll.checked))
	{
		if(isNaN(len1))
		{
			chkObj.checked=false
		}
		else
		{
			for(i=0;i<chkObj.length;i++)
			chkObj[i].checked = false
		}
	}
}

function fun(opt)
{

	option=opt
	go()
}
function go()
{

	if(option==1)
	{
  			document.myForm.action="ezAddComponent.jsp"
			document.myForm.submit()
			return true
	}
	else
	if(option==2)
	{
		if(chkEdit(document.myForm))
		{
			document.myForm.action="ezEditComponent.jsp"
			document.myForm.submit()
			return true
		}
		else
			return false
	}
	else
	if(option==3)
	{
		if(chkDel(document.myForm))
		{
			document.myForm.action="ezDeleteComponent.jsp"
			document.myForm.submit()
			return true
		}
		else
			return false
	}
	if(option==4)
	{

			if(chkEdit(document.myForm))
			{
				document.myForm.action="ezAddComponentVersionHistory.jsp"
				document.myForm.submit()
				return true
			}
			else
			return false

	}

}


