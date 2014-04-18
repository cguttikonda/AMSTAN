	function addGroup()
	{
		document.location.href="ezAddMailGroup.jsp"
	}
	var option=0
	function setOpt(opt)
	{
		option=opt
	}
	function checkField()
	{

		if(option==1)
		{

			if(chkEdit(document.myForm))
			{

				document.myForm.action="ezEditMailGroup.jsp"
				return true
			}
		}
		else if(option==2)
		{
			if(chkDel(document.myForm))
			{
				document.myForm.action="ezDeleteMailGroups.jsp"
				return true
			}
		}
		return false
	}
