function checkCond()
{
	var count=0;
	var len = document.myForm.chk1.length;
	if(!isNaN(len))
	{
		for(var i = 0; i < len; i++)
		{
			  if(document.myForm.chk1[i].checked)
			       count = count + 1;
		}
	}
	else
	{
		if(document.myForm.chk1.checked)
		   count = count + 1;
	}
	if(count<1)
		 return false;
	else 
		 return true ;

}
function funStat(chkstat)
{
	var len = document.myForm.chk1.length;
	var actionStat='',chkStat=chkstat;
	var count=0;
	var ponum ='';
	var chkcount=0;
	if(!isNaN(len))
	{
		for(var i = 0; i < len; i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				chkcount=chkcount+1;
				actionStat= document.myForm.actionStatus[i].value;
				ponum= document.myForm.poNo[i].value;
				//alert("actionStat"+actionStat);
				if(actionStat==chkStat || actionStat=='')
					  return ponum;
				else  
					  count=count+1;	  

			}

		}
		
	}
	else
	{
		if(document.myForm.chk1.checked)
		{
			chkcount=chkcount+1;
			actionStat= document.myForm.actionStatus.value;
			ponum= document.myForm.poNo.value;
			//alert("actionStat"+actionStat+ponum);
			if(actionStat==chkStat || actionStat=='')
				 return ponum;
			else  
	  			count=count+1;	
		}
		
	}
	if(count==chkcount)
	 	return 'ponum';
	
}

function checkVal1(statCond)
{
	var len = document.myForm.chk1.length;
	var actionStat='';
	var ponum ='';
	var count=0;
	var chkcount=0;
	     	
	if(!checkCond())
	{
		if(statCond=='SUBMITTED')
		alert('Please Select atleast one PO NO to Submit');
		else if(statCond=='RELEASED' || statCond=='ALL')
		alert(selBlockedPo_L);
		return;
        }
        else
	{
		
		if(statCond=='ALL')
		{
			document.myForm.action="ezReleasePurchaseOrder.jsp";
			document.myForm.submit();
			return;
		}
		
		
		
		
		if(statCond=='SUBMITTED')
			var cond = funStat('RELEASED')
		else if(statCond=='RELEASED')
			var cond = funStat('SUBMITTED')
		
		if(cond=='ponum')
		{
			if(statCond=='SUBMITTED')
				document.myForm.action="ezSubmitPurchaseOrder.jsp";
			else if(statCond=='RELEASED')
				document.myForm.action="ezReleasePurchaseOrder.jsp";
			//alert(document.myForm);	
			document.myForm.submit();
		}
		else
		{	
			if(statCond=='SUBMITTED')
			alert('PO '+cond+' have no authorizations to Submit');	
			else if(statCond=='RELEASED')
			alert('PO '+cond+' have no authorizations to Release');
		}

	}

}