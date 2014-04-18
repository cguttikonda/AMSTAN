function funLineValid()
{
	len=document.myForm.Price.length;
	if(isNaN(len))
	{
		if(document.myForm.Price.value=="")
		{
			alert("Please Enter Price of the Material");
			return false;
		}
		else
			return true;
	}
	else
	{
		var bool="false"
		for(var i=0;i<len;i++)
		{
			if(document.myForm.Price[i].value!="")
			{
				var bool="true"
				return true;
			}
		}
		if(bool=="false")
		{
			alert("Please Enter the price for atleast one material");
			return false;
		}
	}
}
function funOpen(n)
{
	values=document.myForm.allconditions.value;
	reQtFlg=document.myForm.reQtFlg.value;
	
	//alert(values);
	
	priceValue = document.myForm.Price.value;
	dialogvalue=window.showModalDialog("../Rfq/ezAllConditions.jsp?PBXXVal="+priceValue+"&reQtFlg="+reQtFlg+"&matNum="+matNum,values,"center=yes;dialogHeight=35;dialogWidth=45;help=no;titlebar=no;status=no;resizable=no")
	if ((dialogvalue=='Canceld~~')||(dialogvalue==null))
	{
	}
	else{
	     if(document.myForm.allconditions['+n+'] == null)
	     {
		document.myForm.allconditions.value=dialogvalue;
	     }	
	     else
	     {
		document.myForm.allconditions['+n+'].value=dialogvalue;
	     }
	}
}


function qtyFun()
{
	qtyFlag = true;
	
			var qtyObj	= document.myForm.updtdQty;
			var qtyVal	= qtyObj.value;
			var qtyLen	= qtyVal.length;

			if(qtyVal.indexOf('.')!=-1)
			{
				if(qtyLen>13)
				{
					alert("Quantity Exceeded")
					qtyFlag = false;
				}
				else
				{
					var substr = qtyVal.substring(qtyVal.indexOf('.')+1,qtyLen);
					if(substr.length>3){
						alert("Quantity value Exceeded")
						qtyFlag = false;
						document.myForm.updtdQty.focus();
					}	
				}				
			}
			else
			{
				if(qtyLen>9)
				{
					alert("Quantity value Exceeded")
					qtyFlag = false;
					document.myForm.updtdQty.focus();
				}

			}
					
	
	return qtyFlag;
}


function SubmitQuote()
{
	//alert(document.myForm.allconditions.value);
	
	//alert(document.myForm.allconditions.value);
	if(!qtyFun())
		return;
	var rfqEndDateObj=document.myForm.EndDate;
	var reQuoteObj =document.myForm.reQtFlg;
	
	//if(reQuoteObj!=null && (funTrim(reQuoteObj.value)!="Y")){
		
		if(rfqEndDateObj!=null){
			
			var td = new Date();
			var expDate = rfqEndDateObj.value;
			selDate = expDate.split(".");
			var a1 = parseInt(selDate[1],10)-1;
			sd = new Date(selDate[2],a1,selDate[0]);
			var dd=td.getDate();
			var mm=td.getMonth();
			var yy=td.getYear();
			td  = new Date(yy,mm,dd);
			
			if(td > sd)
			{
				alert("You can't quote the RFQ which is expired.");
				return;
			}
			
		}
	//}
	
	if (funTrim(document.myForm.QtnRef.value)=="")
	{
		alert("Please enter Qtn. Ref. No");
		document.myForm.QtnRef.focus();
		return false;
	}
	 
	if(document.myForm.QtnDate.value!="")
	{
		sDate = document.myForm.QtnDate.value;
		selDate = sDate.split(".");
		var sd = new Date();
		var td = new Date();
		var a1 = parseInt(selDate[1],10)-1;
	
		sd = new Date(selDate[2],a1,selDate[0]);
		var dd=td.getDate();
		var mm=td.getMonth();
		var yy=td.getYear();
		
		td  = new Date(yy,mm,dd);

		if(sd>td)
		{
			alert("Quotation Date should be less than or equal to today's date");
			document.myForm.QtnDate.focus();
			return;
		}
	}	 
	 
	 
	if(document.myForm.priceValExpDate.value=="")
	{
		alert("Please Select Quatation Exp. Date  From Calendar");
		document.myForm.priceValExpDate.focus();
		return;
	}
	else
	{
		sDate = document.myForm.priceValExpDate.value;
		selDate = sDate.split(".");
		var sd = new Date();
		var td = new Date();
		var a1 = parseInt(selDate[1],10)-1;
	
		sd = new Date(selDate[2],a1,selDate[0]);
		var dd=td.getDate();
		var mm=td.getMonth();
		var yy=td.getYear();
		
		td  = new Date(yy,mm,dd);

		if(sd<=td)
		{
			alert("Quotation Exp. Date should be greater than today's date");
			document.myForm.priceValExpDate.focus();
			return;
		}
	}
	
	if(funTrim(document.myForm.txtMatDesc.value)=="")
	{
		alert("Please Enter Material Description.");
		document.myForm.txtMatDesc.focus();
		return;
	}
	
	var qtyVal  = parseFloat(document.myForm.updtdQty.value);
	if(isNaN(qtyVal))
	{
		alert("Please enter valid quantity");
		document.myForm.updtdQty.focus();
		return;
	}else{
		if(qtyVal<=0){
			alert("Quantity should be grater than zero");
			document.myForm.updtdQty.focus();
			return;
		}
	}
	
	
	var val = parseFloat(document.myForm.Price.value);
	
	
	if(isNaN(val))
	{
		alert("Please enter valid price");
		document.myForm.Price.focus();
		return;
	}else{
		if(val<=0){
			alert("Price should be grater than zero");
			document.myForm.Price.focus();
			return;
		}
	}
	
	var curType = document.myForm.Curr.value
	if(curType == "JPY")
	{
		if(val.indexOf(".") != -1)		
		{
			alert("Decimals were not allowed in case of Japanese Currency");
			document.myForm.Price.focus();
			return;
		}
	}
	
	
	/* if (document.myForm.valType.value=="")
	 {
		alert("Please Select Valuation Type.");
		document.myForm.valType.focus()
		return;
	  }
	
	
	
	 if (document.myForm.taxCode.value=="")
	 {
		alert("Please Tax Code.");
		document.myForm.taxCode.focus()
		return;
	  }
	  */
	
	 if (document.myForm.PaymentTerms.value==""){
		alert("Please Select Payment terms from the List.");
		document.myForm.PaymentTerms.focus()
		return false;
	}else if (document.myForm.IncoTerms.value==""){
		alert("Please Select Inco Terms from the List.");
		document.myForm.IncoTerms.focus()
		return false;
	}else if (document.myForm.IncoTermsDesc.value==""){
		var args = (document.myForm.IncoTerms.value).split("¥")
		alert("Please Enter Incoterm "+args[0]+" with details of location");
		document.myForm.IncoTermsDesc.focus()
		return false;
	}else if (!funLineValid()){
		return false
	}
	if(document.myForm.Remarks.value!="")
	{
		var remStr = document.myForm.Remarks.value;
		if(remStr.length>500)
		{
			alert("Remarks should not be more than 500 characters");
			document.myForm.Remarks.focus();
			return;
		}
		/*if(remStr.indexOf("'")!=-1)
		{
			alert("Single quote(') characters are not allowed in Remarks");
			document.myForm.Remarks.focus();
			return;
		}*/
		
		
	}
	
	document.myForm.allconditionsinrequote.value = "PBXX*"+document.myForm.Price.value+"*NA*NA*NA";
	if(document.myForm.allconditions.value=="")
	{
		document.myForm.allconditions.value = "PBXX*"+document.myForm.Price.value+"*NA*NA*NA";
	}
	else
	{
		document.myForm.allconditions.value += "#PBXX*"+document.myForm.Price.value+"*NA*NA*NA";
	}

		//alert(document.myForm.allconditions.value);
		
	buttonsSpan	  = document.getElementById("EzButtonsSpan")
	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
	if(buttonsSpan!=null)
	{
	     buttonsSpan.style.display		= "none"
	     buttonsMsgSpan.style.display	= "block"
	buttonsSpan.style.visibility		= "hidden"
	     buttonsMsgSpan.style.visibility	= "visible"	     
     	}	

	if("3"!='<%userType%>')
		document.myForm.quantity.value = document.myForm.updtdQty.value; 
	
	document.forms[0].action="ezQuotationSave.jsp";
	document.forms[0].submit();
}
function goBack()
{
	document.forms[0].action = "ezViewRFQDetails.jsp"
	document.forms[0].submit();
}
