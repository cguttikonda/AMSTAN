var optVal=0
var fileName="";

function funOpt(opt,fName)
{
	optVal=opt
	fileName=fName
}
function goForSubmit(formName)
{
	if(optVal==1)
	{
		formName.action=fileName
		return true
	}
	else
		if(optVal==2)
		{
			/*if(chkEdit(formName))
			{
				formName.action=fileName	
				return true
			}
			else
				return false*/
		formName.action=fileName
		return true;		
		}
		else
			if(optVal==3)
			{
				if(chkDel(formName))
				{
					formName.action=fileName
					return true
				}
				else
					return false
		}
		else
			if(optVal==4)
			{
				if(chkForStep(formName))
				{
					formName.action=fileName
					return true
				}
				else
					return false
		}
	}

function chkForStep(myForm)
{
             
		parForm=document.myForm
		chkLength=parForm.chk1.length
		if(!(isNaN(chkLength)))
		{
	
      		count=0;
			for(i=0;i<chkLength;i++)
			{
				if(parForm.chk1[i].checked)
				count=count+1
			}
			if(count !=1)
			{
				alert("Please check Only one checkbox which you want to view Steps")
				return false;
			}

	   	 }
	    	else
	   	{
			if(!(parForm.chk1.checked))
			{
			alert("Please check Only one checkbox which you want to view Steps")
			return false;
			}
	  	}
	
	return true;
}
