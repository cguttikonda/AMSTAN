function searchVendor(vCode,vName)
	{
		//if(document.myForm.VendorCode.value == "")
		//{
		//	alert("Please enter vendor code or enter '*' for complete list");
		//	return;
		//}	
		//if(document.myForm.VendorName.value == "")
		//{
		//	alert("Please enter vendor name or enter '*' for complete list");
		//	return;
		//}
		
		var vCode = document.myForm.VendorCode.value
		var vName = document.myForm.VendorName.value
		
		if(document.myForm.chk2 != null)
		{
			var chkdLength = document.myForm.chk2.length
			var chkVendors;
			var chkdCount = 0

			if(!isNaN(chkdLength))
			{
				for(i=0;i<chkdLength;i++)
				{
						if(chkdLength == 0)
							chkVendors = document.myForm.chk2[i].value
						else
							chkVendors += "¥"+document.myForm.chk2[i].value
				}		
			}
			else
			{
				chkVendors = document.myForm.chk2.value
			}
		}	
		
		
		
		window.showModalDialog("ezSAPVendorList.jsp?VendorCode="+vCode+"&VendorName="+vName+"&ChkdVendors="+chkVendors,window.self,'center:yes;dialogWidth:40;dialogHeight:30;status:no;minimize:no;close:no;')
	}

	 
	 
function createPO()
{
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
		   if(values[0]=="V")
		   {
			valCount++;		   
		   }
		   if(values[0]=="A")
		   {
			inValCount++;		   
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
	    if(values[0]=="V")
	    {
		valCount++;		   
	    }
	    if(values[0]=="A")
	    {
		inValCount++;		   
	    }
     	}
     }

     if(Count < 2 )	
     {
     	alert("Please Select Atleast Two Vendors To Create RFQ");
     	//return;
     }
     else if(valCount == 0)	
     {
         alert("Please Select A Vendor Not An Agreement To Create RFQ");
         return;
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
     	  document.myForm.qtnEndDate.value=entryWindow
          document.myForm.action = "ezCreateRFQ.jsp";
	  document.myForm.submit();
     }
}	