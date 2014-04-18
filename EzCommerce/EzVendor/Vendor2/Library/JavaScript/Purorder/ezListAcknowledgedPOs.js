
function funShowReason(arguments)
{
	 newWindow = window.showModalDialog("ezShowRejectedPOReasons.jsp",arguments,"center=yes;dialogHeight=20;dialogleft=200;dialogTop=200;dialogWidth=25;help=no;titlebar=no;status=no;resizable=no")
}

function selectAll()
{
	var len=document.myForm.chk1.length;

	if(document.myForm.chk1.disabled!=true)
	{
		if(document.myForm.select.checked)
		{
			document.myForm.chk1.checked=true
		}
		else
		{
			document.myForm.chk1.checked=false
		}
	}

	for(i=0;i<len;i++)
	{
		if(document.myForm.select.checked)
		{
			if(document.myForm.chk1[i].disabled!=true)
			{
				document.myForm.chk1[i].checked=true
			}
		}
		else
		{
			document.myForm.chk1[i].checked=false
		}
	}
}

function checkVal(stat)
{
	if(!checkRoleAuthorizations("SEND_REMINDER"))
	{
		alert("You are not authorized to send reminder to vendor");
		return;
	}
	
   	var count=0;
	var len = document.myForm.chk1.length;

	if(!isNaN(len))
	{
		for(var i = 0; i < len; i++)
		{
		   if(document.myForm.chk1[i].checked)
		   {
		      count = count + 1;
		   }
		}
	}
	else
	{
		if(document.myForm.chk1.checked)
		{
		   count = count + 1;
		}

	}

	if(count<1)
        	{
		    if(stat=='NA')
		    {					
			alert(selPO_L);
		    }	
		    else
		    {
			alert("Select atleast one PO No to Release");
		    }	
        	}
	else
        	{
          		if(stat=='NA')
		    {				
	   		document.getElementById("back").style.visibility="hidden"
			document.getElementById("msgDiv").style.visibility="visible"
	   		document.myForm.action="ezSendReminders.jsp";
		    }else{
		   	//document.myForm.action="ezReleasePurchaseOrder.jsp";
		    }	
		    document.myForm.submit();	 
	}
}
