	function funDateCheck(datestr,datestr1)
	{	
		 da=new Date(datestr);
		 od=new Date(datestr1);

		 dcdat=document.myForm.DCDate.value;
		 dcdat=ConvertDate(dcdat,dateFormat)
		 temparr2=dcdat.split(".");
		 tempdate2=temparr2[1]+"/"+temparr2[0]+"/"+temparr2[2];
		 dcdat=new Date(tempdate2);

		 invdat=document.myForm.InvoiceDate.value;
		 invdat=ConvertDate(invdat,dateFormat)
		 temparr3=invdat.split(".");
		 tempdate3=temparr3[1]+"/"+temparr3[0]+"/"+temparr3[2];
		 invdat=new Date(tempdate3);

		 shipdat=document.myForm.ShipDate.value;
		 shipdat=ConvertDate(shipdat,dateFormat)
		 temparr1=shipdat.split(".");
		 tempdate1=temparr1[1]+"/"+temparr1[0]+"/"+temparr1[2];
		 shipdat=new Date(tempdate1);

		 expdate=document.myForm.ExpectedArivalTime.value;
		 expdate=ConvertDate(expdate,dateFormat)
		 temparr=expdate.split(".");
		 tempdate=temparr[1]+"/"+temparr[0]+"/"+temparr[2];
		 expdate=new Date(tempdate);

		

		 if(dcdat<od) 
	         {
			alert(refdGtSdt_L)
			return false;
		 }
		 if(invdat<od) 
	         {
			alert(invdGteSdt_L)
			return false;
		 }

		 if(shipdat<od) 
	         {
			alert(sdtGteOdt_L)
			return false;
		 }

		 if(expdate<shipdat) 
	         {
			alert(arrdtGteSdt_L)
			return false;
		 }

		 if(expdate<da)
		 {
			//alert(expdate +"***********"+da);
		 	alert(arrdtGteTdt_L);
		 	return false;
		 }

		//added by nagesh
		/*if(shipdat<dcdat)
		{
			alert(refdLteSdt_L)
			return false;
		}*/
		//Finished
		 return true;

	}
	
	
	// Number Validations
	function verifyField(theField)
	{
		if(isNaN(theField.value))
		{
			alert(plzVldQty_L);
			theField.focus();
			return false
		}
		else if(funTrim(theField.value)=='')
		{
			theField.value="0";
		}
		else if (parseInt(theField.value)< 0)
		{
			alert(plzQtyZero_L);
			theField.focus();
			return false
		}
		return true;
	}
	// Shipment fields Check
	function validateFields(obj)
	{	
		if(funTrim(document.myForm.DeliveryChallan.value) == "")
		{
			alert(plzEnRdcno_L);
			document.myForm.DeliveryChallan.focus();
			return false;
		}
		/*if(funTrim(document.myForm.DCDate.value) == "")
		{
			alert(plzEnRdcdt_L);
			return false;
		}*/
		
		
		if(funTrim(document.myForm.InvoiceNo.value) == "")
		{
			alert(plzEnInvNo_L);
			document.myForm.InvoiceNo.focus();
			return false;
		}
		if(funTrim(document.myForm.InvoiceDate.value) == "")
		{
			alert(plzEnInvdt_L);
			return false;
		}
		
		
		if(funTrim(document.myForm.LR.value) == "")
		{
			alert(plzEnLrno_L);
			document.myForm.LR.focus()
			return false;
		}	
		if(funTrim(document.myForm.ShipDate.value) == "")
		{
			alert(plzShDate_L);
			return false;
		}
		if(funTrim(document.myForm.CarrierName.value) == "")
		{
			alert(plzEnCrrn_L);
			document.myForm.CarrierName.focus()
			return false;
		}
		if(funTrim(document.myForm.ExpectedArivalTime.value) == "")
		{
			alert(plzExparrDt_L);
			return false;
		}
		return true;
	}
	//Calling When Click on Save Button
	
	//Check weather user enters Shipment Details for atleast one line
	function funBatchCheck()
	{
		var len=document.myForm.batches.length;
		var bool=false;
		if(isNaN(len))
		{
			if(document.myForm.batches.value=="")
			{
				alert(plzEnShdet_L);
				return false;
			}
		}
		else
		{
			for(var i=0;i<len;i++)
			{
				if(document.myForm.batches[i].value!="")
				{
					bool=true;
					break;
				}	
			}
			if(bool==false)
			{
				alert(plzEnShOneDet_L)	;
				return false;
			}
		}
		return true;
	}
	// Deletion Option when user Edit before Submit the Shipment Data
	function deleteLine(){
		len = document.forms[0].Chk.length
		if (isNaN(len)){
			if (document.forms[0].Chk.checked){
				if ( confirm (plsActDel_L)){
					document.forms[0].action="ezDeleteShipment.jsp?OpStat=All";document.forms[0].submit();
				}
			}
			else{
				alert (plzShLine_L);
			}
		}
		else{
			var chkLen = 0 ;
			for (i=0 ; i < len ; i++){	
				if (document.forms[0].Chk[i].checked){
					chkLen++;
				}
			}
			if (chkLen == 0){
				alert (plzAtlOneSh_L);	
			}
			else if (chkLen == len){
				if ( confirm (plsActDel_L)){
					document.forms[0].action="ezDeleteShipment.jsp?OpStat=All";document.forms[0].submit();
				}
			}
			else{
				if ( confirm (thisDelBatch_L)){
					document.forms[0].action="ezDeleteShipment.jsp?OpStat=Some";document.forms[0].submit();
				}
			}
				
		}
	}
