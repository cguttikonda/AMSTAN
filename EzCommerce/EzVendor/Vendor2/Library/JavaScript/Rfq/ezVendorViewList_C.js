
function showDiv(n)
{
         for(var i=1;i<=3;i++)
	 {
		if(i==n)
		{
			document.getElementById("tab"+i).style.visibility="visible"
			document.getElementById("tab"+i+"color").style.color="#000000"
		}
		else
		{
			document.getElementById("tab"+i).style.visibility="hidden"
			document.getElementById("tab"+i+"color").style.color="#ffffff"
		}
	 }
	 if(n == 2)
	 {
		var tabObj = document.getElementById("VendorTab")
		var rowItems = tabObj.getElementsByTagName("tr");
		var rowCountValue = rowItems.length;	  
		if(rowCountValue > 0)
		{
			document.getElementById("VendorHeaderDiv").style.visibility='visible'
		}
		else
		{
			document.getElementById("VendorHeaderDiv").style.visibility='hidden'
		}
	  }
	  else
	  	document.getElementById("VendorHeaderDiv").style.visibility='hidden'
	  	
	  if(n == 3)
	  {
	  	var AgentsDivObj = document.getElementById("AgentsTab");
	  	if(AgentsDivObj!= null)
	  	{
			var tabObj = document.getElementById("AgentsTab")
			var rowItems = tabObj.getElementsByTagName("tr");
			var rowCountValue = rowItems.length;	  
			if(rowCountValue > 0)
			{
				document.getElementById("AgentsHeaderDiv").style.visibility='visible'
			}
			else
			{
				document.getElementById("AgentsHeaderDiv").style.visibility='hidden'
			}
		}	
	  }
	  else
	  {
	  	var agentsHeadDivObj = document.getElementById("AgentsHeaderDiv");
	  	if(agentsHeadDivObj!= null)
	  		document.getElementById("AgentsHeaderDiv").style.visibility='hidden'	
	  }		  	
	  tabfun(n)
}
	 
function createPO()
{
        //appendQuantities();   
     	var len = document.myForm.chk1.length     
     	var Count = 0;
     	var valCount = 0; 
     	if(!isNaN(len))
     	{
     		for(var i=0;i<len;i++)
     		{
    		     if(document.myForm.chk1[i].checked)
     		     {
			   Count++;										     			
			   var str = document.myForm.chk1[i].value
			   var values = str.split("##")		   
			   if(values[0]=="A")
			   {
				valCount++;		   
			   }
     		     }
     		}	
     	}
     	else
     	{
     		if(document.myForm.chk1.checked)
     		{
     		    Count++;	
     		    var str = document.myForm.chk1.value
		    var values = str.split("##")		   
		    if(values[0]=="A")
		    {
			valCount++;		   
		    }
     		}
     	}
     	if(Count == 0 )	
     	{
     		alert("Please Select An Agreement To Create PO");
     		return;
     	}
     	else if(Count > 1)	
     	{
     		alert("Please Select Only One Agreement To Create PO");
     		return;
     	}     
     	else if(valCount == 0)	
     	{
     	    	alert("Please Select An Agreement Not A Vendor To Create PO");
     	    	return;
     	}
     	buttonsSpan	  = document.getElementById("EzButtonsSpan")
     	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
     	if(buttonsSpan!=null)
     	{
     	      	buttonsSpan.style.display	= "none"
           	buttonsMsgSpan.style.display	= "block"
     	}
     	document.myForm.action = "ezCreatePO.jsp";
     	document.myForm.submit();
}

function createRFQ()
{
        //appendQuantities();
     	var reqDate = document.myForm.reqDate.value;
     	var len = document.myForm.chk1.length
     	var Count = 0;
     	var valCount = 0; 
     	var inValCount = 0;
     	if(!isNaN(len))
     	{
     		for(var i=0;i<len;i++)
     		{
    			if(document.myForm.chk1[i].checked)
     			{
			   	Count++;										     			
			   	var str = document.myForm.chk1[i].value
			   	var values = str.split("##")		   
		   		if(values[0]=="A")
		   		{
					inValCount++;		   
		   		}
		   		else
		   		{
					valCount++;		   
		   		}
	     		}
     		}	
     	}
     	else
     	{
     		if(document.myForm.chk1.checked)
     		{
     		    	Count++;	
     		    	var str = document.myForm.chk1.value     	    
	    		var values = str.split("##")		   

	    		if(values[0]=="A")
	    		{
				inValCount++;		   
	    		}
	    		else
	    		{
	    			valCount++;		   
	    		}
     		}
     	}
	if(valCount == 0)	
     	{
     		 alert("Please Select A Vendor Not An Agreement To Create RFQ");
     	    	 return;
     	}
     	else if(Count < 2 )	
     	{
     		alert("Please Select Atleast Two Vendors To Create RFQ");
     		//return;
     	}
     	else if(inValCount > 0)	
     	{
     		alert("Please Select Only Vendors To Create RFQ");
         	return;
     	}     
        arguments = document.myForm.qtnEndDate.value;
     	entryWindow = window.showModalDialog("ezEnterEndDate.jsp?reqDate="+reqDate,arguments,"center=yes;dialogHeight=20;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")
     	if(entryWindow!=null)
     	{
                buttonsSpan	  = document.getElementById("EzButtonsSpan")
     	     	buttonsMsgSpan  = document.getElementById("EzButtonsMsgSpan")
          	if(buttonsSpan!=null)
          	{
          	    	buttonsSpan.style.display	= "none"
          	   	buttonsMsgSpan.style.display	= "block"
     	  	}
     	  	var entryWindowValues = entryWindow.split('##');
     	  	document.myForm.qtnEndDate.value=entryWindowValues[0];
     	  	document.myForm.commentText.value=entryWindowValues[1];
     	  	document.myForm.collNo.value=entryWindowValues[2];
     	 	
     	  	document.myForm.action = "ezCreateRFQ.jsp";
	  	document.myForm.submit();
     	}	
}	 

function appendQuantities()
{
	if(document.myForm.chk1 != null)
	{
		var approvedVendorLength = document.myForm.chk1.length
		if(!isNaN(approvedVendorLength))
		{
			for(i=0;i<approvedVendorLength;i++)
			{
				if(document.myForm.chk1[i].checked)
				{
					var chkdValue = document.myForm.chk1[i].value
					var chkdArgs = chkdValue.split('#')
					if(chkdArgs[0] != null)
						document.myForm.chk1[i].value = chkdArgs[0]+"#"+document.myForm.venTxt[i].value+"#A"
					else
						document.myForm.chk1[i].value = document.myForm.chk1[i].value+"#"+document.myForm.venTxt[i].value+"#A"
				}
			}
		}
		else
		{
			if(document.myForm.chk1.checked)
			{
				var chkdValue = document.myForm.chk1.value
				var chkdArgs = chkdValue.split('#')
				if(chkdArgs[0] != null)
					document.myForm.chk1.value = chkdArgs[0]+"#"+document.myForm.venTxt.value+"#A"
				else
					document.myForm.chk1.value = document.myForm.chk1.value+"#"+document.myForm.venTxt.value+"#A"
			}	
		}
	}
	
	if(document.myForm.chk2 != null)
	{
		var sapVendorLength = document.myForm.chk2.length
		if(!isNaN(sapVendorLength))
		{
			for(i=0;i<sapVendorLength;i++)
			{
				if(document.myForm.chk2[i].checked)
				{
					var chkdValue = document.myForm.chk2[i].value
					var chkdArgs = chkdValue.split('#')
					if(chkdArgs[0] != null)
						document.myForm.chk2[i].value = chkdArgs[0]+"#"+document.myForm.qtyVal1[i].value+"S"	
					else
						document.myForm.chk2[i].value = document.myForm.chk2[i].value+"#"+document.myForm.qtyVal1[i].value+"#S"
				}
			}
			
		}
		else
		{
		
			if(document.myForm.chk2.checked)
			{
				var chkdValue = document.myForm.chk2.value
				var chkdArgs = chkdValue.split('#')
				if(chkdArgs[0] != null)
				document.myForm.chk2.value = chkdArgs[0]+"#"+document.myForm.qtyVal1.value+"#S"
				else
				document.myForm.chk2.value = document.myForm.chk2.value+"#"+document.myForm.qtyVal1.value+"#S"
			}	
		}
	}
	
	
	if(document.myForm.chk3 != null)
	{
		var agentsLength = document.myForm.chk3.length
		if(!isNaN(agentsLength))
		{
			for(i=0;i<sapVendorLength;i++)
			{
				if(document.myForm.chk3[i].checked)
				{
					var chkdValue = document.myForm.chk3[i].value
					var chkdArgs = chkdValue.split('#')
					if(chkdArgs[0] != null)
						document.myForm.chk3[i].value = chkdArgs[0]+"#"+document.myForm.agntVal1[i].value+"#N"	
					else
						document.myForm.chk3[i].value = document.myForm.chk3[i].value+"#"+document.myForm.agntVal1[i].value+"#N"
				}
			}

		}
		else
		{

			if(document.myForm.chk3.checked)
			{
				var chkdValue = document.myForm.chk3.value
				var chkdArgs = chkdValue.split('#')
				if(chkdArgs[0] != null)
				document.myForm.chk3.value = chkdArgs[0]+"#"+document.myForm.agntVal1.value+"#N"
				else
				document.myForm.chk3.value = document.myForm.chk3.value+"#"+document.myForm.agntVal1.value+"#N"
			}	
		}
	}
	
}