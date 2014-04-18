function selectMat()
{
	
	var errCount ='<%=errObjCount%>'
	var y=false;

	var chkObj 	= document.myForm.chk1;
	var chkLen	= chkObj.length;
	var chkValue	= "";
	var count	= 0;
        
        var sel         = document.myForm.catalog;
        
        if(sel.value=="sel")
        {
		alert("Please select Vendor Catalog");
		return;
        }
        
	if(!isNaN(chkLen))
	{
		for(i=0;i<chkLen;i++)
		{
			if(chkObj[i].checked)
			{
				count++;				
			}
		}
	}
	else
	{
		if(chkObj.checked)
		{
			count = 1;
		}
	}

	if(count == 0)
	{
		alert("Please select atleast one product to save");
		return;
	}
	
	
	buttonsSpan	  = document.getElementById("EzButtonsSpan")
	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
	if(buttonsSpan!=null)
	{
	     buttonsSpan.style.display		= "none"
	     buttonsMsgSpan.style.display	= "block"
	}

        if(errCount>0)
        {
	   
	   y=confirm("Some of the errors in the uploaded file.Do you want to continue with remaing data.")
	}
	else 
	   y=true;
	
        if(eval(y))
	{
		document.myForm.action = "ezSaveProductByStatus.jsp";
		document.myForm.submit();
	}
}
	
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
