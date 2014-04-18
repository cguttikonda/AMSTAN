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
	  tabfun(n)
}
function createPO()
{

	if(!checkRoleAuthorizations("ADD_PO"))
	{
		alert("You are not authorized to create Purchase Order");
		return;
	}
	
	
	
	
        appendQuantities();   
     	var len = document.myForm.chk1.length     
     	var Count = 0;
     	var valCount = 0; 
     	var vendType; 
     	if(!isNaN(len))
     	{
     		for(var i=0;i<len;i++)
     		{
    		     if(document.myForm.chk1[i].checked)
     		     {
			   Count++;										     			
			   var str = document.myForm.chk1[i].value
			   
			   //alert(str);
			   var values = str.split("#")
			   if(values[0]=="-" && values[3]=="A")
			   {
				valCount++;		   
			   }
			   else if(values[3]=="S")
			   {
				vendType ="S";	
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
		    var values = str.split("#")		   
		    if(values[0]=="-"  && values[3]=="A")
		    {
		    	valCount++;
		    }
		     else if(values[3]=="S")
		    {
		    	vendType ="S";	
		    }
     		}
     	}
	if(vendType=="S")
	{
		alert("You can not Create PO with Non Approved Vendors");
		return;
	}
     	else if(Count == 0 || valCount > 0)	
     	{
     		alert("Please Select Vendor With Contract To Create PO");
     		return;
     	}
     	else if(Count > 1)	
     	{
     		alert("Please Select Only One Vendor With Contract To Create PO");
     		return;
     	}     
     	
     	var plantObj=document.myForm.plant;
	if(plantObj!=null && plantObj.value=="NA")
	{
		alert("You can't create PO without selecting plant,Please select plant from material search to create PO")
		return false;
	}
     	
     	var vndr = "";
     	var qty = "";
     	var len = document.myForm.chk1.length;
     	if(!(isNaN(len)))
     	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				vndr = document.myForm.chk1[i].value;
				qty =  document.myForm.qtyTxt[i].value;
			}	
		}
     	}
     	else
     	{
     		vndr = document.myForm.chk1.value;
     		qty =  document.myForm.qtyTxt.value;
     	}
     	var chkdStr = vndr.split("#");
   	
   	buttonsSpan	  = document.getElementById("EzButtonsSpan");
	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
	if(buttonsSpan!=null)
	{
	     	buttonsSpan.style.display	= "none"
	        buttonsMsgSpan.style.display	= "block"
     	}
     	
     	var url = "ezPopPoCreate.jsp?vendor="+chkdStr[1]+"&Quantity="+qty;
	dialogvalue=window.showModalDialog(url,window.self,"center=yes;dialogHeight=30;dialogWidth=40;help=no;titlebar=no;status=no;resizable=no")
	
	if(dialogvalue=="SUBMIT")
	{
		document.myForm.action="ezCreatePOByPopUp.jsp";
		document.myForm.submit();
	}
	else
	if(dialogvalue=="Cancel")
	{
		buttonsSpan	  = document.getElementById("EzButtonsSpan");
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display	= "block"
			buttonsMsgSpan.style.display	= "none"
     		}
	}
	else
	{
		buttonsSpan	  = document.getElementById("EzButtonsSpan");
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display	= "block"
			buttonsMsgSpan.style.display	= "none"
		}

     	}
	
     	
/*     	
     	buttonsSpan	  = document.getElementById("EzButtonsSpan")
     	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
     	if(buttonsSpan!=null)
     	{
     	      	buttonsSpan.style.display	= "none"
           	buttonsMsgSpan.style.display	= "block"
     	}
     	document.myForm.action = "ezCreatePO.jsp";
     	document.myForm.submit();
*/     	

}


function checkVendor()
{
	var vendChkObj 		= 	document.myForm.chk1
	var vendChkObjLen	=	vendChkObj.length
	var chkdValue 		= 	""
	var ezAppVendors 	= new Array()
	var ezAppAgents 	= new Array()
	var vndCount 	= 0;
	var agntCount 	= 0;

	if(!isNaN(vendChkObjLen))
	{
		for(i=0;i<vendChkObjLen;i++)
		{
			if(vendChkObj[i].checked)
			{
				chkdValue = (vendChkObj[i].value).split("#")
				if(chkdValue[3] == "A")
				{
					ezAppVendors[vndCount] = chkdValue[1]
					vndCount++
				}
				if(chkdValue[3] == "N")
				{
					ezAppAgents[agntCount] = ((chkdValue[1]).split("$"))[0]
					agntCount++
				}

			}
		}
	}

	vndCount	=	ezAppVendors.length;
	agntCount	=	ezAppAgents.length;

	var checkFlag = false

	for(i=0;i<vndCount;i++)
	{
		for(j=0;j<agntCount;j++)
		{
			if(ezAppVendors[i]	==	ezAppAgents[j])
			{
				alert("Agent for the selected approved vendor "+ezAppVendors[i]+" cannot be selected to create the RFQ")
				checkFlag = true
				break;
			}
		}
	}

	return checkFlag;
}

function createRFQ()
{

	if(!checkRoleAuthorizations("ADD_RFQ"))
	{
		alert("You are not authorized to create Request For Quotation");
		return;
	}        
	
	
					
					
        appendQuantities();
    	var reqDate = document.myForm.reqDate.value;
     	var len = document.myForm.chk1.length
     	var Count = 0;
     	var valCount = 0; 
     	var agrmntCount = 0;
     	var soldTos = "";

	if(!isNaN(len))
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				var str = document.myForm.chk1[i].value
				var values = str.split("#")		   
				if(values[0]=="AGR")
				{
					document.myForm.chk1[i].value = values[0]+"#"+values[1]+"#"+document.myForm.qtyTxt[i].value+"#"+"A";
					//alert(document.myForm.chk1[i].value);
					agrmntCount++;		   
				}
				else
				{
					valCount++;		   
				}

				if(Count == 0)
					soldTos = values[0]
				else	
					soldTos += ","+values[0]
				Count++;	
			}
		}	
	}
	else
	{
		if(document.myForm.chk1.checked)
		{

			var str = document.myForm.chk1.value     	    
			var values = str.split("#")		   
			if(values[0]=="AGR")
			{
				document.myForm.chk1.value = values[0]+"#"+document.myForm.qtyTxt.value+"#"+values[2]+"#"+"A";
				agrmntCount++;		   
			}
			else
			{
				valCount++;		   
			}
			soldTos = values[0]
			Count++;
		}
	}
	

	if(Count == 0)	
	{
		alert("Please Select Atleast One Vendor To Create RFQ");
		return;
	}

	
	if(agrmntCount > 0)
	{
		//alert("Please Select Only Vendors Without Contract To Create RFQ");
		
		if(!confirm("Contract already exists for selected vendor(s).Do you want to create RFQ for selected vendor(s)?"))
		return;
	}
	

	if(checkVendor())
		return;
	
	var entryWindow;
	buttonsSpan	  = document.getElementById("EzButtonsSpan");
	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
	if(buttonsSpan!=null)
	{
		buttonsSpan.style.display	= "none"
		buttonsMsgSpan.style.display	= "block"
     	}
     	arguments = document.myForm.qtnEndDate.value;
     	material  = document.myForm.material.value;
	entryWindow = window.showModalDialog("ezEnterEndDate.jsp?reqDate="+reqDate+"&material="+material+"&soldTos="+soldTos,arguments,"center=yes;dialogHeight=21;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")
	
      	if((entryWindow!="Cancel") && (entryWindow!=null))
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
     	  	document.myForm.delivDate.value=entryWindowValues[3];
		document.myForm.action="ezCreateRFQ.jsp";
		document.myForm.submit();
     	}
     	else
     	{
     		buttonsSpan	  = document.getElementById("EzButtonsSpan");
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display	= "block"
			buttonsMsgSpan.style.display	= "none"
     		}
     	
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
					if(chkdArgs[0] == "AGR")
						document.myForm.chk1[i].value = "AGR#"+chkdArgs[1]+"#"+chkdArgs[2]+"#"+document.myForm.qtyTxt[i].value+"#"+chkdArgs[3]
					else
						document.myForm.chk1[i].value = "-#"+chkdArgs[1]+"#"+document.myForm.qtyTxt[i].value+"#"+chkdArgs[3]
				}
			}
		}
		else
		{
			if(document.myForm.chk1.checked)
			{
				var chkdValue = document.myForm.chk1.value
				var chkdArgs = chkdValue.split('#')
				if(chkdArgs[0] == "AGR")
					document.myForm.chk1.value = "AGR#"+chkdArgs[1]+"#"+chkdArgs[2]+"#"+document.myForm.qtyTxt.value+"#"+chkdArgs[3]
				else	
					document.myForm.chk1.value = "-#"+chkdArgs[1]+"#"+document.myForm.qtyTxt.value+"#"+chkdArgs[3]
			}	
		}
	}
}
function funShowVndrDetails(syskey,soldto)
{
		var retValue = window.showModalDialog("ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
}