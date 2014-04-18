function formEvents()
{
    if(document.myForm.chk1!=null)
    {
    	var len = document.myForm.chk1.length
	var count=0;
	if(!isNaN(len))
	{
	   for(var i=0;i<len;i++)
	   {
	   	if(document.myForm.chk1[i].checked)
		{
			count++;
		}
	   }
	}
	else
	{
	   	if(document.myForm.chk1.checked)
		{
			count++;
		}
	}

	if(count==0)
	{
		alert("Select atleast one Purchase Order to block")
	}else{
		document.myForm.action="ezBlockPurchaseOrder.jsp";
    		document.myForm.submit();
	}
    }
    else
    {
    	alert("There are no Purchase Orders to be blocked")
    }
}

function funLinkOpen(fileName,PurchaseOrder,NetAmount,Currency,orderType)
{
	hideButton();
	document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType;
}

function funLinkNew(fileName,PurchaseOrder,NetAmount,Currency,orderType,sysKey,soldTo)
{
	hideButton();
	document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType+"&sysKey="+sysKey+"&soldTo="+soldTo
}


function showTotal()
{
	obj = document.getElementById("InnerBox1Tab")
	obj1 = document.getElementById("InnerBox1Div")
	obj2 = document.getElementById("showTot")

	if(obj!=null && obj1!=null && obj2!=null)
	{
		if(!showTotalDiv)
		{
			if(obj1.offsetHeight < obj.offsetHeight)
			{
				obj2.style.top=obj1.offsetHeight+70
			}else{
				obj2.style.top=obj.offsetHeight+70
			}
			obj2.style.visibility = "visible"
		}
	}
}