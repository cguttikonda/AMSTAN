
	
function checkAll()
{
	var chkObj 	= document.myForm.chk;
	var chkObj1 	= document.myForm.chk1;
	var chkLen	= chkObj1.length;
	var chkValue	= "";
	var count	= 0;

	if(chkObj.checked)
	{
		if(!isNaN(chkLen))
		{
			for(i=0;i<chkLen;i++)
			{
				chkObj1[i].checked = true; 
			}
		}
		else
		{
			chkObj1.checked = true;
		}
	}
	else
	{
		if(!isNaN(chkLen))
		{
			for(i=0;i<chkLen;i++)
			{
				chkObj1[i].checked = false;
			}
		}
		else
		{
			chkObj1.checked = false;
		}
	}
}
