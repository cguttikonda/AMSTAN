function vendorList()
{
	
	
	var chkObj 	= document.myForm.purchReq;
	var chkLen	= chkObj.length;
	var chkValue	= "";
	var count	= 0;
	if(!isNaN(chkLen))
	{
		for(i=0;i<chkLen;i++)
		{
			if(chkObj[i].checked)
			{
				count++;
				chkValue = chkValue+chkObj[i].value+"##";		
			}
		}
	}
	else
	{
		if(chkObj.checked)
		{
			count = 1;
			chkValue = chkValue+chkObj.value+"##";
		}
	}
	if(count == 0)
	{
		alert("Please select atleast one Purchase Requisition");
		return;
	}

	var mainToken	= chkValue.split("##");
	
	var tokensLen	= mainToken.length-1;

	var material;
	var plant;
	var delDate;
	var qty	= 0;
	var uom;
	var matDesc;
	var prno;
	var itmno;
	var valtype;
	if(!isNaN(tokensLen))
	{
	
		var childToken	= mainToken[0].split("$$");
		material	= childToken[0];
		plant		= childToken[1];
		qty		= childToken[3];
		delDate		= childToken[2];
		uom		= childToken[4];
		matDesc		= childToken[5];
		prno		= childToken[6];
		itmno		= childToken[7];
		valtype		= childToken[8];
		a=delDate.split(".");
		var mm = parseInt(a[1],10)-1;
		var dlvrDate  = new Date(a[2],mm,a[0]);
		
		
	
		for(j=1;j<tokensLen;j++)
		{
			var childToken	= mainToken[j].split("$$");

			var material1	= childToken[0];
			var plant1	= childToken[1];
			var qty1	= childToken[3];
			var delDate1	= childToken[2];
			
			b=delDate1.split(".");
			var mm1 = parseInt(b[1],10)-1;
			var cmprDate  = new Date(b[2],mm1,b[0]);

			/*if(delDate<delDate1)
			{
				delDate = delDate1; 
			}*/
			
			if(dlvrDate<cmprDate)
			{
				delDate = delDate1; 
			}
			//alert(delDate);

			if(funTrim(material) == funTrim(material1))
			{
				if(funTrim(plant) == funTrim(plant1))
				{
					qty = parseInt(qty)+parseInt(qty1);	
				}
				else
				{
					alert("Please select material with same Plant to get Vendors");
					return;
				}
			}
			else
			{
				alert("Please select same Material to get Vendors");
				return;
			}
		}	
	}
	
	buttonsSpan	  = document.getElementById("EzButtonsSpan")
	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
	if(buttonsSpan!=null)
	{
	     buttonsSpan.style.display		= "none"
	     buttonsMsgSpan.style.display	= "block"
     	}
	document.myForm.purchReq.value		= material+"$$"+plant+"$$"+delDate+"$$"+qty+"$$"+uom+"$$"+matDesc+"$$"+prno;
	document.myForm.purchaseHidden.value	= material+"$$"+plant+"$$"+delDate+"$$"+qty+"$$"+uom+"$$"+matDesc+"$$"+prno+"$$"+itmno+"$$"+valtype;
	//document.myForm.action			= "ezVendorViewList.jsp";
	//document.myForm.submit();
}

function ClosePR(checkauth)
{
	if(!checkRoleAuthorizations("CLOSE_PR"))
	{
		//alert("You are not authorized to close Purchase Requisition");
		//return;
	}
	var chkObj 	= document.myForm.purchReq;
	var chkLen	= chkObj.length;
	var chkValue	= "";
	var count	= 0;

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
		alert("Please select atleast one Purchase Requisition to Close");
		return;
	}

	if(confirm("Are you sure to close PR(s)?"))
	{
	
		url = "ezRemarks.jsp";
		values="";
		dialogvalue=window.showModalDialog(url,values,"center=yes;dialogHeight=18;dialogWidth=25;help=no;titlebar=no;status=no;resizable=no")
		if ((dialogvalue=='Canceld~~')||(dialogvalue==null))
		{
			return;
		}
		else
		{
			document.myForm.reasons.value = dialogvalue;
			buttonsSpan	  = document.getElementById("EzButtonsSpan")
			buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
			if(buttonsSpan!=null)
			{
			     buttonsSpan.style.display		= "none"
			     buttonsMsgSpan.style.display	= "block"
			}
			document.myForm.action	= "ezClosePR.jsp";
			document.myForm.submit();
		}
	
	}	
}
