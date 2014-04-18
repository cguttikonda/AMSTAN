<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Sales/iEditSaveOrder.jsp"%>
<%@ include file="../../../Includes/JSPs/Discounts/igetDiscountCreatedBy.jsp" %>
<%@ include file="../../../Includes/JSPs/Discounts/igetConfigDiscount.jsp" %>
<%@ include file="ezReadCatDefaults.jsp"%>
<html>
<head>
	<Title>Sales Order Details -- Powered by EzCommerce Inc</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/ezVerifyField.js"></Script>

<Script>
	var tabHeadWidth=95
	var tabHeight="30%"
	
	function applyPromoCode()
	{
		var chkPromoCode = document.generalForm.promoCode.value;
		
		var y = true;
		
		if(eval(y))
		{
			try
			{
				req = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch(e)
			{
				try
				{
					req = new ActiveXObject("Microsoft.XMLHTTP");
				}
				catch(oc)
				{
					req = null;
				} 
			}  

			if(!req&&typeof XMLHttpRequest!="undefined")
			{
				req = new XMLHttpRequest();
			}
			//alert(req)

			var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Sales/ezAjaxCheckPromoCode.jsp?promoCode="+chkPromoCode;

			//alert(url)

			if(req!=null)
			{
				req.onreadystatechange = Process;
				req.open("GET", url, true);
				req.send(null);
			}
		}
	}
	function Process() 
	{
		if(req.readyState == 4)
		{
			var resText = req.responseText;	 	        	
						
			if(req.status == 200)
			{
				var resultText	= resText.split("#");
				
				var validCode 	= resultText[0];
				var promoType 	= resultText[1];
				var manfId 	= resultText[2];
				var itemCat 	= resultText[3];
				var applyDisc 	= resultText[4];

				if(validCode.indexOf("VALIDPROMOCODE")!=-1)
				{
					//alert(validCode)
					//alert(promoType)
					//alert(manfId)
					//alert(itemCat)
					//alert(applyDisc)
					
					chkToApply(promoType,manfId,itemCat,applyDisc)

					//alert("Entered is Valid Promotional Code");
				}
				else
				{
					alert("Entered is Not Valid Promotional Code");
				}
			}
			else
			{
				if(req.status == 500)	 
				alert("Error");
			}
		}
	}
	function chkToApply(promoType,mfrCode,itemCat,applyDisc)
	{
		var len = document.generalForm.product.length;
		var pCode = document.generalForm.promoCode.value;;
		
		var mfrPartObj = document.generalForm.itemMfrPart;
		var mfrCodeObj = document.generalForm.itemMfrCode;
		var itemCatObj = document.generalForm.vendCatalog;
		var hideFinalPriceObj = document.generalForm.itemOrgPrice;
		var finalPriceObj = document.generalForm.finalPrice;
		
		var desiredQtyObj = document.generalForm.desiredQty;
		var finalPriceValObj = document.generalForm.finalPriceVal;
		var grandTotalValObj = document.generalForm.grandTotalVal;
		var itemPromoCodeObj = document.generalForm.itemPromoCode;
		
		var apply = false;
		var fPrice = 0;
		var fPriceVal = 0;
		var gTotal = 0;
		var fTotVal = 0;
		
		var fVal = document.generalForm.freightVal.value;
		var fIns = document.generalForm.freightIns.value;
		
		if(funTrim(fVal)!='TBD' && funTrim(fIns)!='TBD')
			fTotVal = (parseFloat(fVal)+parseFloat(fIns)).toFixed(2); 
		
		if(isNaN(len))
		{
			if(((mfrCode=='All' && itemCat=='All') || (mfrCode==funTrim(eval(mfrCodeObj).value) && itemCat=='All') || (mfrCode==funTrim(eval(mfrCodeObj).value) && itemCat==funTrim(eval(itemCatObj).value))))
			{
				fPrice = ((parseFloat(eval(hideFinalPriceObj).value))-((parseFloat(eval(hideFinalPriceObj).value)*parseFloat(applyDisc))/parseFloat(100))).toFixed(2);
				eval(finalPriceObj).value = fPrice;
				fPriceVal = (parseFloat(eval(desiredQtyObj).value)*parseFloat(fPrice)).toFixed(2);
				eval(finalPriceValObj).value = fPriceVal;
				eval(grandTotalValObj).value = (parseFloat(fPriceVal)+parseFloat(fTotVal)).toFixed(2);
				eval(itemPromoCodeObj).value = pCode;
				apply = true;
			}
			if(promoType=='MFRPN' && mfrCode==funTrim(eval(mfrPartObj).value))
			{
				eval(finalPriceObj).value = applyDisc;
				fPriceVal = (parseFloat(eval(desiredQtyObj).value)*parseFloat(applyDisc)).toFixed(2);
				eval(finalPriceValObj).value = fPriceVal;
				eval(grandTotalValObj).value = (parseFloat(fPriceVal)+parseFloat(fTotVal)).toFixed(2);
				eval(itemPromoCodeObj).value = pCode;
				apply = true;
			}
		}
		else
		{
			for(i=0;i<len;i++)
			{
				if(((mfrCode=='All' && itemCat=='All') || (mfrCode==funTrim(eval("mfrCodeObj["+i+"]").value) && itemCat=='All') || (mfrCode==funTrim(eval("mfrCodeObj["+i+"]").value) && itemCat==funTrim(eval("itemCatObj["+i+"]").value))))
				{
					fPrice = ((parseFloat(eval("hideFinalPriceObj["+i+"]").value))-((parseFloat(eval("hideFinalPriceObj["+i+"]").value)*parseFloat(applyDisc))/parseFloat(100))).toFixed(2);
					eval("finalPriceObj["+i+"]").value = fPrice;
					fPriceVal = (parseFloat(eval("desiredQtyObj["+i+"]").value)*parseFloat(fPrice)).toFixed(2);
					eval("finalPriceValObj["+i+"]").value = fPriceVal;
					eval("itemPromoCodeObj["+i+"]").value = pCode;
					apply = true;
				}
				if(promoType=='MFRPN' && mfrCode==funTrim(eval("mfrPartObj["+i+"]").value))
				{
					eval("finalPriceObj["+i+"]").value = applyDisc;
					fPriceVal = (parseFloat(eval("desiredQtyObj["+i+"]").value)*parseFloat(applyDisc)).toFixed(2);
					eval("finalPriceValObj["+i+"]").value = fPriceVal;
					eval("itemPromoCodeObj["+i+"]").value = pCode;
					apply = true;
				}
				gTotal = (parseFloat(gTotal)+parseFloat(eval("finalPriceValObj["+i+"]").value)).toFixed(2);
			}
			eval(grandTotalValObj).value = (parseFloat(gTotal)+parseFloat(fTotVal)).toFixed(2);
		}
		if(apply)
		{
			ApplySpan=document.getElementById("applySpan")
			RemoveSpan=document.getElementById("removeSpan")
			if(ApplySpan!=null)
			{
				ApplySpan.style.display="none"
				RemoveSpan.style.display="block"
			}
			document.generalForm.hidePromoCode.value=pCode;
			
			alert("Promotional code applied successfully");
		}
		else
			alert("Entered promotional code cannot be applied to these product(s)");
	}
	function removePromoCode()
	{
		var len = document.generalForm.product.length;
		
		var finalPriceObj = document.generalForm.finalPrice;
		var finalPriceValObj = document.generalForm.finalPriceVal;
		var grandTotalValObj = document.generalForm.grandTotalVal;
		
		var hideFinalPriceObj = document.generalForm.hideFinalPrice;		
		var hideFinalPriceValObj = document.generalForm.hideFinalPriceVal;
		var hideGrandTotalValObj = document.generalForm.hideGrandTotalVal;
		var itemPromoCodeObj = document.generalForm.itemPromoCode;
		
		var remove = false;
		
		var fVal = document.generalForm.freightVal.value;
		var fIns = document.generalForm.freightIns.value;
		
		var fTotVal = 0;
		
		if(funTrim(fVal)!='TBD' && funTrim(fIns)!='TBD')
			fTotVal = (parseFloat(fVal)+parseFloat(fIns)).toFixed(2);
		
		if(isNaN(len))
		{
			eval(finalPriceObj).value=eval(hideFinalPriceObj).value;
			eval(finalPriceValObj).value=eval(hideFinalPriceValObj).value;
			eval(itemPromoCodeObj).value="";
			remove = true;
		}
		else
		{
			for(i=0;i<len;i++)
			{
				eval("finalPriceObj["+i+"]").value=eval("hideFinalPriceObj["+i+"]").value;
				eval("finalPriceValObj["+i+"]").value=eval("hideFinalPriceValObj["+i+"]").value;
				eval("itemPromoCodeObj["+i+"]").value="";
				remove = true;
			}
		}
		if(remove)
		{
			eval(grandTotalValObj).value=(parseFloat(eval(hideGrandTotalValObj).value)+parseFloat(fTotVal)).toFixed(2);
		
			ApplySpan=document.getElementById("applySpan")
			RemoveSpan=document.getElementById("removeSpan")
			if(RemoveSpan!=null)
			{
				ApplySpan.style.display="block"
				RemoveSpan.style.display="none"
			}
			document.generalForm.hidePromoCode.value="";
		
			alert("Promotional code removed successfully");
		}
	}
	function calFreight()
	{
		var servType = document.generalForm.fServType.value;
		var countryCode = document.generalForm.shipToCountry.value;
		var zipCode = document.generalForm.shipToZipcode.value;
		var weight = document.generalForm.weight.value;
		var packType = document.generalForm.packType.value;
		var noFreight = document.generalForm.noFreight.value;
		
		if(funTrim(noFreight)=="TBD")
		{
			document.generalForm.freightVal.value = "TBD";
			document.generalForm.freightIns.value = "TBD";
		}
		else
		{
 			if(funTrim(servType)!="SP" && funTrim(servType)!="")
 			{
				try
				{
					reqFM = new ActiveXObject("Msxml2.XMLHTTP");
				}
				catch(e)
				{
					try
					{
						reqFM = new ActiveXObject("Microsoft.XMLHTTP");
					}
					catch(oc)
					{
						reqFM = null;
					}
				}

				if(!reqFM&&typeof XMLHttpRequest!="undefined")
				{
					reqFM = new XMLHttpRequest();
				}
				//alert(reqFM)

				var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Sales/ezAjaxFreightType.jsp?servType="+servType+"&countryCode="+countryCode+"&zipCode="+zipCode+"&weight="+weight+"&packType="+packType;

				//alert(url)

				if(reqFM!=null)
				{
					reqFM.onreadystatechange = ProcessFreight;
					reqFM.open("GET", url, true);
					reqFM.send(null);
				}
			}
			else
			{
				document.generalForm.freightVal.value = "TBD";
				document.generalForm.freightIns.value = "TBD";
			}
		}
	}
	function ProcessFreight() 
	{
		if(reqFM.readyState == 4)
		{
			var resText = reqFM.responseText;	 	        	
						
			if(reqFM.status == 200)
			{
				var resultText	= resText.split("#");
				
				var fType = resultText[0];
				var fPrice = resultText[1];

				if(fType.indexOf("FRIEGHT")!=-1)
				{
					calFreightIns();
					
					document.generalForm.freightVal.value = parseFloat(fPrice).toFixed(2);
					
					var fIns = document.generalForm.freightIns.value;
					var fTotVal = (parseFloat(fPrice)+parseFloat(fIns)).toFixed(2);

					var grandTotalValObj = document.generalForm.grandTotalVal;
					eval(grandTotalValObj).value = (parseFloat(fTotVal)+parseFloat(eval("grandTotalValObj").value)).toFixed(2);
				}
				else
				{
					document.generalForm.freightVal.value = "TBD";
					document.generalForm.freightIns.value = "TBD";
				}
			}
		}
	}
	function calFreightIns()
	{
		var len = document.generalForm.product.length;
		
		var freightInsObj = document.generalForm.freightIns;
		var itemWeightObj = document.generalForm.itemWeight;
		var finalPriceValObj = document.generalForm.finalPriceVal;
		var frInsValObj = document.generalForm.frInsVal;
		var fIns = 0;
		var flag = false;
		
		if(isNaN(len))
		{
			if(eval(itemWeightObj).value!="0")
			{
				fIns = (parseFloat(eval("finalPriceValObj").value)*parseFloat(eval("frInsValObj").value)).toFixed(2);
				eval(freightInsObj).value = fIns;
			}
		}
		else
		{
			for(i=0;i<len;i++)
			{
				if(eval("itemWeightObj["+i+"]").value!="0")
				{
					fIns = (parseFloat(fIns)+(parseFloat(eval("finalPriceValObj["+i+"]").value)));
					flag = true;
				}
			}
			
			if(eval(flag))
			{
				fIns = (parseFloat(fIns)*parseFloat(eval("frInsValObj").value)).toFixed(2);
				eval(freightInsObj).value = fIns;
			}
		}
	}
	var total = "<%=retLinesCount%>";
	function openNewWindow(obj,i)
	{
		if(!(obj.substring(0,14)=='ezDatesDisplay'))
			eval("document.generalForm.changeFlag_"+i+".value=false")
		if(total==1)
			totQty = document.generalForm.desiredQty.value
		else
			totQty = document.generalForm.desiredQty[i].value
			
		var statusOrder = document.generalForm.statusOrder.value
		
		obj = obj + "&status="+statusOrder+"&totQty="+totQty
		newWindow = window.open(obj,"multi","resizable=no,left=250,top=90,height=450,width=400,status=no,toolbar=no,menubar=no,location=no")
	}
	function formSubmit(obj,obj2)
	{
		document.generalForm.status.value=obj2;
		

		var flag = true;
		
		var pCode = document.generalForm.hidePromoCode.value;
		var len	= document.generalForm.product.length;
		var docStatus = "<%=orderStatus%>"

		
		if(pCode!='NOCODE' && pCode=='')
		{
			alert("Promotional Code is not applied to the order. Please click on Apply");
			flag = false;
		}

		if(flag)
		{
			
			
			var y="true"
			var z=document.generalForm.status.value

			if(z=="TRANSFERED")
			{
				if(isNaN(len))
				{
					if(document.generalForm.finalPrice.value!=document.generalForm.itemListPrice.value && docStatus=="'NEW'")
					{
						alert("You cannot Submit the order as price is changed");
						return false;
					}
				}
				else
				{
					for(i=0;i<len;i++)
					{
						if(document.generalForm.finalPrice[i].value!=document.generalForm.itemListPrice[i].value && docStatus=="'NEW'")
						{
							alert("You cannot Submit the order as price is changed for product(s)");
							return false;
						}	
					}
				}
				
				y=confirm("Do you want to Submit the Order?")
			}
			if(z=="NEGOTIATED")
			{
				var count=0;

				if(isNaN(len))
				{
					if(document.generalForm.itemSAPPrice.value!=document.generalForm.itemListPrice.value)
						count=count+1;
				}
				else
				{
					for(i=0;i<len;i++)
					{  
						if(document.generalForm.itemSAPPrice[i].value!=document.generalForm.itemListPrice[i].value)
							count=count+1;
					}
				}
				
				if(count==0 && (document.generalForm.freightValHid.value==document.generalForm.freightVal.value))
				{
					alert("Price on at-least one line item must be changed to set it on Review");
					y=false;
				}
				else
				{
					y=confirm("Do you want to Review the Order?")
				}
			}

			buttonsSpan=document.getElementById("EzButtonsSpan")
			buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
			buttonsSpanRem=document.getElementById("EzButtonsRemarksSpan")
			buttonsMsgSpanRem=document.getElementById("EzButtonsRemarksMsgSpan")

			if(buttonsSpan!=null)
			{
				buttonsSpan.style.display="none"
				buttonsSpanRem.style.display="none"
				buttonsMsgSpan.style.display="block"
				buttonsMsgSpanRem.style.display="block"
			}
   

			if(eval(y))
			{			
				document.body.style.cursor="wait";
				document.generalForm.target="_self";
				document.generalForm.action=obj;
				document.generalForm.submit();
			}
			else
			{
				if(buttonsSpan!=null)
				{
					buttonsSpan.style.display="block"
					buttonsSpanRem.style.display="block"
					buttonsMsgSpan.style.display="none"
					buttonsMsgSpanRem.style.display="none"
				}
			}
			
		}
	}
	function showTabN(tabToShow)
	{
		obj1=document.getElementById("div1")
		obj3=document.getElementById("theads")
		obj5=document.getElementById("div5")
		obj6=document.getElementById("div6")
		obj7=document.getElementById("buttonDiv")
		obj8=document.getElementById("showTot");
		obj9=document.getElementById("InnerBox1Tab");
		if(tabToShow=="1")
		{
			obj1.style.visibility="visible";
			obj3.style.visibility="visible";
			obj5.style.visibility="visible";
			obj6.style.visibility="hidden";
			obj7.style.visibility="hidden";
			obj8.style.visibility="visible";
			obj9.style.visibility="visible";
		}
		else if(tabToShow=="2")
		{
			obj1.style.visibility="hidden";
			obj3.style.visibility="hidden";
			obj5.style.visibility="hidden";
			obj6.style.visibility="visible";
			obj7.style.visibility="visible";
			obj8.style.visibility="hidden";
			obj9.style.visibility="hidden";
		}
	}
	function ezListPage(obj)
	{
		document.generalForm.orderStatus.value="'"+obj+"'"
		document.generalForm.action="ezSavedOrdersList.jsp"		
		document.generalForm.submit()
	}
	function ezMailToManager()
	{
		newWindow = window.open("ezComposeMail.jsp?soNum=<%=soNum%>","ComposeMsg","resizable=no,left=250,top=90,height=450,width=600,status=no,toolbar=no,menubar=no,location=no")
	}
</Script>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/UploadFiles/ezAttachment.js"></Script> 
</head>
<body scroll=auto>
<form method="post" name="generalForm">
<input type="hidden" name="frInsVal" 	value="<%=frInsVal%>">
<input type="hidden" name="statusOrder" value="<%=(sdHeader.getFieldValueString(0,"STATUS")).trim()%>">
<input type="hidden" name="orderStatus" value='<%=request.getParameter("ordType")%>'>
<input type="hidden" name="status">
<input type="hidden" name="soNum" 	value="<%=soNum%>">
<%
	Double grandTotal =new Double("0");
	String colTone = "class='tx'";

	String display_header = "Web Order Details : "+soNum;
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	
	String isSubUser = (String)session.getValue("IsSubUser");
	String suAuth = (String)session.getValue("SuAuth");
	String UserRole	= (String)session.getValue("UserRole");
	
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos((String)session.getValue("AgentCode"));
	ReturnObjFromRetrieve  listBillTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos((String)session.getValue("AgentCode"));

	String billTPZone	  = listBillTos_ent.getFieldValueString(0,"ECA_TRANSORT_ZONE");
	String billJurCode	  = listBillTos_ent.getFieldValueString(0,"ECA_JURISDICTION_CODE");
	if(billTPZone!=null)
	billTPZone = billTPZone.trim();

	if(billJurCode!=null)
	billJurCode = billJurCode.trim();


	Vector types = new Vector();
	Vector names = new Vector();
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	names.addElement("PURCH_DATE");
	names.addElement("REQ_DATE");
	names.addElement("ORDER_DATE");
	
	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);
	
	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(sdHeader);
	
	Vector types1= new Vector();
	Vector names1= new Vector();
	types1.addElement("date");
	names1.addElement("REQ_DATE");

	EzGlobal.setColTypes(types1);
	EzGlobal.setColNames(names1);
	
	ezc.ezparam.ReturnObjFromRetrieve ret1 = EzGlobal.getGlobal(retLines);
	
	String poNo 	 = sdHeader.getFieldValueString(0,"PO_NO");
	String createdBy = sdHeader.getFieldValueString(0,"CREATE_USERID");
	String poDate	 = ret.getFieldValueString(0,"PURCH_DATE");
	String reqDate 	 = ret.getFieldValueString(0,"REQ_DATE");
	
	
	
	String formatkey = (String)session.getValue("formatKey");
	FormatDate fD = new FormatDate();

	java.util.Date statusDate = (java.util.Date)sdHeader.getFieldValue(0,"STATUS_DATE");
	
	String spShipIns	= sdHeader.getFieldValueString(0,"TEXT3");
	String freightType	= sdHeader.getFieldValueString(0,"FREIGHT");
	String Currency		= sdHeader.getFieldValueString(0,"DOC_CURRENCY");
	String promoCode	= sdHeader.getFieldValueString(0,"HEADER_PROMO_CODE");

	//Sold to Address
	
	String soldTo		= sdSoldTo.getFieldValueString(0,"SOLD_TO_CODE");
	String soldName		= sdSoldTo.getFieldValueString(0,"SOTO_NAME");
	String soldStreet	= sdSoldTo.getFieldValueString(0,"SOTO_ADDR1");
	String soldCity		= sdSoldTo.getFieldValueString(0,"SOTO_ADDR2");
	String soldState	= sdSoldTo.getFieldValueString(0,"SOTO_STATE");
	String soldCountry	= sdSoldTo.getFieldValueString(0,"SOTO_COUNTRY");
	String soldZip		= sdSoldTo.getFieldValueString(0,"SOTO_ZIPCODE");
	
	//Ship to Address
	
	String shipTo		= sdShipTo.getFieldValueString(0,"SHIP_TO_CODE");
	String shipName		= sdShipTo.getFieldValueString(0,"SHTO_NAME");
	String shipStreet	= sdShipTo.getFieldValueString(0,"SHTO_ADDR1");
	String shipCity		= sdShipTo.getFieldValueString(0,"SHTO_ADDR2");
	String shipState	= sdShipTo.getFieldValueString(0,"SHTO_STATE");
	String shipCountry	= sdShipTo.getFieldValueString(0,"SHTO_COUNTRY");
	String shipZip		= sdShipTo.getFieldValueString(0,"SHTO_ZIPCODE");
	
	//Contact details

	String conDetails 	= sdHeader.getFieldValueString(0,"TEXT1");
	String remarks	 	= sdHeader.getFieldValueString(0,"TEXT2");
	
	String shAttn	= "";
	String shPhone1	= "";
	String shPhone2	= "";
	String shFax	= "";
	
	try
	{
		StringTokenizer conDetails_ST = new StringTokenizer(conDetails,"¥");
		
		shAttn 	 = conDetails_ST.nextToken();
		shPhone1 = conDetails_ST.nextToken();
		shPhone2 = conDetails_ST.nextToken();
		shFax	 = conDetails_ST.nextToken();
	}
	catch(Exception e){}
	
	if("N/A".equals(shAttn)) shAttn = "";
	if("N/A".equals(shPhone1)) shPhone1 = "";
	if("N/A".equals(shPhone2)) shPhone2 = "";
	if("N/A".equals(shFax)) shFax = "";
	
	String freightTypeDisp = "";
	
	if(freightType!=null && "SP".equals(freightType))
	{
		freightTypeDisp = "Third Party Billing";
	}
	else if(freightType!=null && !"".equals(freightType))
	{
		freightTypeDisp = (String)freightServHash.get(freightType);
	}
	
	if(sdHeaderCount>0 && retLinesCount>0)
	{ 
%>
	<div id="div1" align="center" style="visibility:visible;width:100%">
	<Table width='95%' valign='top'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=0 >
		<Tr>
			<th class="labelcell" align="left" width="14%" >PO No</th>
			<td width="20%"><%=poNo%>
			<input type="hidden" name="poNo" value="<%=poNo%>"></td>
			<input type="hidden" name="createdBy" value="<%=createdBy%>"></td>
			<th class="labelcell" align="left" width="14%" colSpan=2>PO Date</th>
			<td width="20%"><%=poDate%>
			<input type="hidden" name="poDate" value="<%=poDate%>"></td>
			<th class="labelcell" align="left" width="17%" colSpan=2>Required Delivery Date</th>
			<td width="15%"><%=reqDate%>
			<input type="hidden" name="requiredDate" value="<%=reqDate%>"></td>
		</Tr>
		<Tr>
			<th class="labelcell"  align="left" colspan = 4 >
			Sold To Address
			</th>
			<Th class="labelcell"  align="left" colspan = 4 cellPadding=3 cellSpacing=0 >
			Ship To Address
			</Th>
		</Tr>
		<Tr>
			<Td align=right>Company:</Td>
			<td colspan=2><%=soldName%>
			<input type="hidden" name="soldTo" value="<%=soldTo%>"></Td>
			<input type="hidden" name="soldToName" value="<%=soldName%>"></Td>
			<Td align=right>Company:</Td>
			<Td colspan=2><%=shipName%>
			<input type="hidden" name="shipTo" value="<%=shipTo%>"></Td>
			<input type="hidden" name="shipToName" value="<%=shipName%>"></Td>
			<Td align=right>Attn.:</Td>
			<Td ><%=shAttn%>
			<input type="hidden" name="shAttn" value="<%=shAttn%>"></Td>
		</Tr>
		<Tr>
			<Td align=right>Street:</Td>
			<td colspan=2><%=soldStreet%>
			<input type="hidden" name="soldToAddress1" value="<%=soldStreet%>"></Td>
			<Td align=right>Street:</Td>
			<Td colspan=2><%=shipStreet%>
			<input type="hidden" name="streetName" value="<%=shipStreet%>"></Td>
			<Td align=right>Tel# 1:</Td>
			<Td ><%=shPhone1%>
			<input type="hidden" name="telNumber" value="<%=shPhone1%>"></Td>
		</Tr>
		<Tr>
			<Td align=right>City:</Td>
			<td colspan=2><%=soldCity%>
			<input type="hidden" name="soldToAddress2" value="<%=soldCity%>"></Td>
			<Td align=right>City:</Td>
			<Td colspan=2><%=shipCity%>
			<input type="hidden" name="shipToAddress2" value="<%=shipCity%>"></Td>
			<Td align=right>Tel# 2:</Td>
			<Td ><%=shPhone2%>
			<input type="hidden" name="mobileNumber" value="<%=shPhone2%>"></Td>
		</Tr>
		<Tr>
			<Td align=right>State:</Td>
			<td colspan=2><%=soldState%>
			<input type="hidden" name="soldToState" value="<%=soldState%>"></Td>
			<Td align=right>State:</Td>
			<Td colspan=2><%=shipState%>
			<input type="hidden" name="shipToState" value="<%=shipState%>"></Td>
			<Td align=right>Fax #:</Td>
			<Td ><%=shFax%>
			<input type="hidden" name="faxNumber" value="<%=shFax%>"></Td>
		</Tr>
		<Tr>
			<Td align=right>Country:</Td>
			<td colspan=2><%=soldCountry%>
			<input type="hidden" name="soldToCountry" value="<%=soldCountry%>"></Td>
			<Td align=right>Country:</Td>
			<Td colspan=2><%=shipCountry.trim()%>
			<input type="hidden" name="shipToCountry" value="<%=shipCountry%>"></Td>
			<Td align=right>Freight Type:</Td>
			<Td><%=freightTypeDisp%>
			<input type="hidden" name="fServType" value="<%=freightType%>"></Td>
		</Tr>
		<Tr>
			<Td align=right>Postal Code:</Td>
			<td colspan=2><%=soldZip%>
			<input type="hidden" name="soldToZipcode" value="<%=soldZip%>">
			<input type="hidden" name="billTPZone" value="<%=billTPZone%>">
			<input type="hidden" name="billJurCode" value="<%=billJurCode%>">
			</Td>
			<Td align=right>Postal Code:</Td>
			<Td colspan=4><%=shipZip%>
			<input type="hidden" name="shipToZipcode" value="<%=shipZip%>"></Td>
		</Tr>
<%
		//if(freightType!=null && "SP".equals(freightType))
		//{
%>
		<!--<Tr>
			<Th colspan=8 style="text-align:left;width:100%">Special Shipping Instructions (for Freight Type - Special Only)</Th>
		</Tr>
		<Tr>
			<Td colspan=8 width="100%">
			<textarea name="specialShIns" style="width:100%" rows="3" cols="*" readonly><%//=spShipIns%></textarea>
			</Td>
		</Tr>-->
<%
		//}
%>
	</Table>
	</div>
	<Div id='theads'>
	<Table width="95%"  id="tabHead"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
				
		<th width="10%" valign="top" nowrap>Product</th> 
		<th width="22%" valign="top" nowrap>Description</th>
		<th width="10%" valign="top" >Brand</th>
		<th width="10%" valign="top" >List Price</th>
		<th width="10%" valign="top">Discount Price [<%=Currency%>]</th>
		<th width="7%" valign="top">Quantity</th>
		<th width="10%" valign="top">Anticipated Price [<%=Currency%>]</th>
		<Th width="10%" valign="top">Total Price [<%=Currency%>]</Th>
		<Th width="11%" valign="top">Delivery Schedules</Th>
		
	</Tr>
	</Table>
	</div>
	<Table width='95%' id='InnerBox1Tab'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%
		java.math.BigDecimal totWeight = new java.math.BigDecimal("0");

		String noFreight = "";

    		for(int i=0;i<retLinesCount;i++)
    		{ 
			String prodCode     = retLines.getFieldValueString(i,"PROD_CODE");
			String custprodCode = retLines.getFieldValueString(i,"CUST_MAT");
			String prodDesc     = retLines.getFieldValueString(i,"PROD_DESC");
			String prodUom      = retLines.getFieldValueString(i,"UOM");
			String prodQty      = retLines.getFieldValueString(i,"COMMITED_QTY");
			String ItemCat      = retLines.getFieldValueString(i,"ITEM_CATEGORY");
			String itemWeight   = retLines.getFieldValueString(i,"ITEM_WEIGHT");
			String itemBrand    = retLines.getFieldValueString(i,"INVOICE");
			String cnetProd	    = retLines.getFieldValueString(i,"NOTES");
			String prodCat	    = retLines.getFieldValueString(i,"VENDOR_CATALOG");
			String manfId	    = retLines.getFieldValueString(i,"INCOTERMS2");
			String ProdLine	    = retLines.getFieldValueString(i,"SO_LINE_NO");
			String foc	    = retLines.getFieldValueString(i,"FOC");
			String itemDiscCode = retLines.getFieldValueString(i,"DISC_CODE");  
			String commiPrice   = retLines.getFieldValueString(i,"COMMIT_PRICE");
			String plant   	    = retLines.getFieldValueString(i,"PLANT");
			String desPrice	    = retLines.getFieldValueString(i,"DESIRED_PRICE");
			
			if(plant==null || "null".equals(plant.trim())) plant = "";
			
			String delReqDate   = ret1.getFieldValueString(i,"REQ_DATE");
			
			if(prodUom!=null)prodUom=prodUom.trim();
			
			String itemOrgPrice = "0";
			String atpMatId = prodCat+cnetProd;
 			
 			String listPrFrmHash = (String)cnetPriceHash.get(custprodCode);
 			
 			if(listPrFrmHash!=null)
 				itemOrgPrice = listPrFrmHash;
 				
        		String a = "";
        		
        		try
        		{
        			a=Integer.parseInt(prodCode)+"-->"+prodDesc;
        		}
        		catch(Exception e)
        		{
        			a=prodCode +"--->"+prodDesc;
        		}
        		
        		try
        		{
        		   	prodQty=prodQty.substring(0,prodQty.indexOf('.'));
           		}
           		catch(Exception e){}
           		
           		if((Double.parseDouble(itemWeight))==0)
           		{
           			noFreight = "TBD";	//if weight is zero for atleast one item then freight must be TBD
           		}
           		
           		java.math.BigDecimal itemWeight_bd = null;
           		
			try
			{
				itemWeight_bd = new java.math.BigDecimal(itemWeight);
				
				itemWeight_bd = itemWeight_bd.multiply(new java.math.BigDecimal(prodQty));
				totWeight = totWeight.add(itemWeight_bd);
			}
			catch(Exception e){}
			
			String discPer = "";
			String discCode = "";
			String agentCode = (String)session.getValue("AgentCode");
			if(applyDisc_C)
			{
				try
				{
					String returnValue = getConfigDiscount(Session,manfId,prodCat,agentCode,discCreated_C);

					discPer = returnValue.split("¥")[0];
					discCode = returnValue.split("¥")[1];       
				}
				catch(Exception e){}
			}
			
			String listPriceVal = itemOrgPrice;
			String commiPriceVal = commiPrice;
			
			java.math.BigDecimal listPrice_bd = null;
			java.math.BigDecimal discount_bd = null;
			java.math.BigDecimal commiPrice_bd = null;
			
			
 			try
 			{
 				listPrice_bd = new java.math.BigDecimal(itemOrgPrice);
 				listPrice_bd = listPrice_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
 				listPriceVal = listPrice_bd+"";
 			}
 			catch(Exception e)
 			{
				listPrice_bd = new java.math.BigDecimal("0");
				listPrice_bd = listPrice_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
				listPriceVal = listPrice_bd+"";
 			}
 			
 			try
			{
				commiPrice_bd = new java.math.BigDecimal(commiPrice);
				commiPrice_bd = commiPrice_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
				commiPriceVal = commiPrice_bd+"";
			}
			catch(Exception e)
			{
				commiPriceVal = commiPrice;
			}
 			
			//String discPriceVal = listPriceVal;
			String discPriceVal = desPrice;

			if(discPer!=null && !"".equals(discPer) && !(new java.math.BigDecimal("0.00")).equals(listPrice_bd))
			{
				try
				{
					discount_bd = new java.math.BigDecimal(discPer);
					discount_bd = (listPrice_bd.multiply(discount_bd)).divide(new java.math.BigDecimal("100"),2,java.math.BigDecimal.ROUND_HALF_UP);
					listPrice_bd = listPrice_bd.subtract(discount_bd);
					discPriceVal = listPrice_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)+"";
				}
				catch(Exception e){}
			}

			java.math.BigDecimal bUprice 	= new java.math.BigDecimal(discPriceVal);
			java.math.BigDecimal bQty 	= new java.math.BigDecimal(prodQty.toString());
			java.math.BigDecimal bPrice 	= null;
			
			bUprice 	= bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
			bPrice 		= bQty.multiply(bUprice);
			grandTotal	= new Double(grandTotal.doubleValue()+bPrice.doubleValue());

			String priceCurr = bUprice+"";
			String valueCurr = bPrice.setScale(2,java.math.BigDecimal.ROUND_UP)+"";
			
			String tPNo= "";
			
			try
			{
				tPNo = Integer.parseInt(custprodCode)+"";
			}
			catch(Exception e)
			{ 
				tPNo = custprodCode;
			}
			
			int chkcount = 0;
			String reqDelDate = "";
			String reqDelQty = "";
			
			for(int k=0;k<retDeliverySchedules.getRowCount();k++)
			{
				String delProdLine = retDeliverySchedules.getFieldValueString(k,"EZDS_ITM_NUMBER");
				
				if(ProdLine.equals(delProdLine))
				{
					String reqDelShdDate = retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_DATE");
					String reqDelShdQty = retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_QTY");
					try
					{
						reqDelShdQty = (new java.math.BigDecimal(reqDelShdQty.trim())).setScale(0,java.math.BigDecimal.ROUND_UP).toString();
					}
					catch(Exception e)
					{
						log4j.log("exception occured while parsing>>>>"+e,"E");
					}
					if(chkcount==0)
					{
						reqDelDate = reqDelShdDate;
						reqDelQty = reqDelShdQty;
					}
					else
					{
						reqDelDate = reqDelDate+"@@"+reqDelShdDate;
						reqDelQty = reqDelQty+"@@"+reqDelShdQty;
					}

					if(!("0").equals(retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_QTY")))
						chkcount++;
				}
			}

			String DatesDisplay="";
			
			if(chkcount >=2)
			{
				DatesDisplay	= "<a href=\"JavaScript:openNewWindow('ezDatesDisplay.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+prodQty+"&itemNo="+ProdLine+"','"+i+"')\">Multiple</a>";
			}
			else
			{
				DatesDisplay	= "<a href=\"JavaScript:openNewWindow('ezDatesDisplay.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+prodQty+"&itemNo="+ProdLine+"','"+i+"')\"><Div id=editDateDisplay_"+i+">"+delReqDate+"</div></a>";
			}

			String tdColor="";
			String classVal = "tx";
			
			if(i%2==0)
			{
				colTone = "class='tx1'";
				classVal = "tx1";
				tdColor="style='background-color:#EFEFEF'";
			}
			
			if(NegotiateFlag)
				classVal="InputBox";
			
			String tdColorNeg = tdColor;
			
			if(!commiPriceVal.equals(priceCurr)) tdColorNeg = "style='background-color:#F77272'";
			
			String catDefaultsStr = "";
			String orderType= "OR";

			if(catDefaultsHt.get(prodCat)!=null) catDefaultsStr = (String)catDefaultsHt.get(prodCat);

			StringTokenizer st1 = new StringTokenizer(catDefaultsStr,"¤");
			if(st1!=null)
			{
				while(st1.hasMoreTokens())
				{
					String defaultsStr = st1.nextToken();
					String defaultsArr[] = defaultsStr.split("-");
					if(plant.equals(defaultsArr[1]))
					{
						orderType = defaultsArr[0];
						break;
					}  
				}	
			}
%>
		<Tr>
			<Td width="10%" align="left" title="<%=a%>" <%=tdColor%>><%=tPNo%></Td> 
			<Td width="22%" align="left" title="<%=a%>" <%=tdColor%>>
			<input type="text" name="prodDesc" size="32" <%=colTone%>  readonly value="<%=prodDesc%>">

			<input type="hidden" name="orderType" value="<%=orderType%>">
			<input type="hidden" name="plant" value="<%=plant%>">
			<input type="hidden" name="product" value="<%=prodCode%>">
			<input type="hidden" name="custprodCode" value="<%=custprodCode%>">
			<input type="hidden" name="pack" value="<%=prodUom%>">
			<input type="hidden" name="ItemCat" value="<%=ItemCat%>">
			<input type="hidden" name="vendCatalog" value="<%=prodCat%>">
			<input type="hidden" name="desiredQty" value="<%=prodQty%>">
			<input type="hidden" name="itemOrgPrice" value="<%=itemOrgPrice%>">
			<input type="hidden" name="itemPromoCode" value="">
			<input type="hidden" name="changeFlag_<%=i%>" value="true">
			<input type="hidden" name="itemWeight" value="<%=itemWeight%>">
			<input type="hidden" name="itemMfrPart" value="<%=custprodCode%>">  
			<input type="hidden" name="itemMfrCode" value="<%=manfId%>">
			<input type="hidden" name="itemMatId" value="<%=atpMatId%>">
			<input type="hidden" name="itemMfrNr" value="<%=itemBrand%>">
			<input type="hidden" name="itemEanUPC" value="">
			<input type="hidden" name="lineNo" value="<%=ProdLine%>">
			<input type="hidden" name="focVal" value="<%=foc%>">
			<input type="hidden" name="desiredDate" value="<%=delReqDate%>">
			<input type="hidden" name="itemCnetProd" value="<%=cnetProd%>">
			<input type="hidden" name="itemDiscCode" value="<%=itemDiscCode%>">
			<input type="hidden" name="itemSAPPrice" value="<%=commiPriceVal%>">
			</Td>
			<Td width="10%" align="center" <%=tdColor%>>&nbsp;<%=itemBrand%></Td>
			<Td width="10%" align="right" <%=tdColor%>>&nbsp;<%="$"+listPriceVal%></Td>
			<Td width="10%" align="right" <%=tdColor%>>
			<input type="text" name="finalPrice" <%=colTone%> size="8" readonly value="<%=priceCurr%>" style="text-align:right">
			<input type="hidden" name="hideFinalPrice" value="<%=priceCurr%>">
			</Td>
			<Td width="7%" align="right" <%=tdColor%>><%=prodQty%></Td> 
			<Td width="10%" align="right" <%=tdColorNeg%>>
				<input type="text" class="<%=classVal%>" size="8" name="itemListPrice" value="<%=commiPriceVal%>" style="text-align:right" onBlur="verifyField(this,'Please enter valid price');">
			</Td>
			
			<Td width="10%" align="right" <%=tdColor%>>
			<input type="text" name="finalPriceVal" <%=colTone%> size="8" readonly value="<%=valueCurr%>" style="text-align:right">
			<input type="hidden" name="hideFinalPriceVal" value="<%=valueCurr%>">
			</Td>
			<Td width="11%" align="center" <%=tdColor%>>
			<input type="hidden" name="del_sch_date" value="<%=reqDelDate%>">
			<input type="hidden" name="del_sch_qty" value="<%=reqDelQty%>">
<%
			if(chkcount>=2)
			{
%>
				<%=DatesDisplay%>
<%			
			}
			else
			{
%>
				<%=delReqDate%>
<%
			}
%>
			</Td>
		</Tr>
<%  
				colTone = "class='tx'";
		}
	
	String packType = "PACK";

	try
	{
		int pt = totWeight.compareTo(new java.math.BigDecimal("0.5"));

		if(pt==-1 || pt==0)
			packType = "ENV";
	}
	catch(Exception ex){}

	java.math.BigDecimal grandTotal_bd = new java.math.BigDecimal(grandTotal.toString());
	grandTotal_bd = grandTotal_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);

	String freightTone = "tx";

	if(!"CU".equals(UserRole.toUpperCase()) && NegotiateFlag)
		freightTone = "InputBox";

	String freightVal_D = sdHeader.getFieldValueString(0,"FREIGHT_PRICE");
	String freightInsVal_D = sdHeader.getFieldValueString(0,"HEADER_FREIGHT_INS");

	String tdColorFgt = "";
	
	if("CU".equals(UserRole.toUpperCase())) tdColorFgt = "style='background-color:#F77272'";
%>
	</Table>
	<input type="hidden" name="total" 	value="<%=retLinesCount%>">
	<input type="hidden" name="docCurrency" value="<%=Currency%>">
	<input type="hidden" name="statusDate" 	value="<%=fD.getStringFromDate(statusDate,formatkey,FormatDate.MMDDYYYY)%>">
	<input type="hidden" name="orderDate"	value="<%=ret.getFieldValueString(0,"ORDER_DATE")%>">
	<Div id="showTot" style="visibility:visible">
		<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="98%">
		<Tr>
			<Td width=63% class=blankcell>&nbsp;</Td>
			<Td width=26% class=blankcell>


			<Table align=center width=100% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<Tr>
				<Th width="58%" align=right>Freight</Th>
				<Td width="42%" align=right <%=tdColorFgt%>>&nbsp;<input type="text" name="freightVal" class="<%=freightTone%>" size="10" value="<%=freightVal_D%>" style="text-align:right" onBlur="verifyField(this,'Please enter valid price');">
				<input type="hidden" name="freightValHid" value="<%=freightVal_D%>"></Td>
			</Tr>
			<Tr>
				<Th width="58%" align=right>Freight Insurance</Th>
				<Td width="42%" align=right>&nbsp;TBD<input type="hidden" name="freightIns" <%=colTone%> size="10" readonly value="0.00" style="text-align:right"></Td>
			</Tr>
			<Tr>
				<Th width="58%" align=right>Taxes</Th>
				<Td width="42%" align=right>&nbsp;<input type="text" name="taxes" <%=colTone%> size="10" readonly value="TBD" style="text-align:right">
				<input type="hidden" name="noFreight" value="<%=noFreight%>">
				</Td>
			</Tr>
			<Tr>
				<Th width="58%" align=right>Total</Th>
				<Td width="42%" align=right>&nbsp;<input type="text" name="grandTotalVal" <%=colTone%> size="10" readonly value="<%=grandTotal_bd.toString()%>" style="text-align:right">
				<input type="hidden" name="hideGrandTotalVal" value="<%=grandTotal_bd.toString()%>">
				<input type="hidden" name="weight" value="<%=(totWeight.setScale(0,java.math.BigDecimal.ROUND_HALF_UP)).toString()%>">
				<input type="hidden" name="packType" value="<%=packType%>">
				</Td>
			</Tr>
			</Table>
			</td>
			<Td width=11% class=blankcell></td>
		</Tr>
		</Table>
	</div>
	<div id="div5" align="center" style="overflow:auto;visibility:visible;position:absolute;width:100%">
<%
	if(promoCode!=null && !"null".equals(promoCode.trim()) && !"".equals(promoCode.trim()) && !"NOCODE".equals(promoCode.trim()))
	{
%>	
	<Table align=center width=95% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
		<Th width=18%>Promotional Code<br>(click on Apply)</Th>
		<Td width=12%><input type="text" class="InputBox" size="20" name="promoCode" maxlength="20" value="<%=promoCode%>" readonly>
		<input type="hidden" name="hidePromoCode" value="">
		</Td>
		<Td width=10%>
		<span id="applySpan">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Apply");
		buttonMethod.add("applyPromoCode()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</span>
		<span id="removeSpan" style="display:none">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Remove");
		buttonMethod.add("removePromoCode()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>		
		</span>
		</Td>
		<Td width=60% class=blankcell>&nbsp;</Td>
	</Tr>
	</Table>
<%
	}
	else
	{
%>
		<input type="hidden" name="hidePromoCode" value="NOCODE">
<%
	}
%>
	<BR>
	<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr>
<%
		if(noOfDocs>0)
		{
			String workFlowStatus = "APPROVED"; 
%>
			<Th align="center" >
				View Attached Files
			</Th>
		</Tr>
		<Tr>
			<Td borderColorDark=#ffffff width=40% align="center" class="blankcell">
				<iframe src="../UploadFiles/ezAttachments.jsp?docNum=<%=soNum%>&docType=SO&workFlowStatus=<%=workFlowStatus%>" frameborder=1 width=100% scrolling=auto scrolling=yes height="75"></iframe>
			</Td>
<%
		}
%>
		</Tr>
	</Table>
	<Script>
		//calFreight();
	</Script>
	<Table align=center>
	<Tr>
		<Td align="center" class="blankcell"><font color="blue">Taxes extra as applicable</font></Td>
	</Tr>
	<Tr>
		<Td  class="blankcell" align="center">
		<span id="EzButtonsSpan">
<%	
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		//if("CU".equals(UserRole.toUpperCase())) 
		if(NegotiateFlag)
		{
			if("Y".equals(isSubUser))
			{
				if("VEDIT".equals(suAuth))
				{
					buttonName.add("Submit Order");
					buttonMethod.add("formSubmit(\"ezEditSubmitOrder.jsp\",\"TRANSFERED\")");
					
					buttonName.add("Review Together");
					buttonMethod.add("formSubmit(\"ezEditSubmitOrder.jsp\",\"NEGOTIATED\")");
				}
			}
			else
			{
				buttonName.add("Submit Order");
				buttonMethod.add("formSubmit(\"ezEditSubmitOrder.jsp\",\"TRANSFERED\")");
				
				if("CU".equals(UserRole.toUpperCase()))
					buttonName.add("Review Together");
				else
					buttonName.add("Send Back to Customer");
				
				buttonMethod.add("formSubmit(\"ezEditSubmitOrder.jsp\",\"NEGOTIATED\")");

				buttonName.add("Email to Manager");
				buttonMethod.add("ezMailToManager()");
			}
		} 

		buttonName.add("Remarks");
		buttonMethod.add("showTabN(\"2\")");

		buttonName.add("Back");
		if("'NEW'".equals(orderStatus))
		buttonMethod.add("ezListPage(\"NEW\")");
		else
		buttonMethod.add("ezListPage(\"NEGOTIATED\")");

		out.println(getButtonStr(buttonName,buttonMethod));
%>	
		</span>
		<span id="EzButtonsMsgSpan" style="display:none">
		<Table align=center>
		<Tr>
			<Td class="labelcell">Your request is being processed. Please wait</Td>
		</Tr>
		</Table>
		</span> 
		</Td> 
	</Tr>
	</Table>
	</div>
	<div id="div6" style="overflow:auto;visibility:hidden;position:absolute;left:2%;top:16%;height:70%;width:98%">
	<Table align=center  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="60%">
	<Tr>
		<th>Remarks</th>
	</Tr>
	<Tr>
		<Td>
			<textarea cols="90" rows="10" style="overflow:auto;border:0" name="generalNotes1" class=txarea><%=remarks%></textarea>
		</Td>
	</Tr>
	</Table>
	</Div>

	<Div id="buttonDiv"  style="visibility:hidden;position:absolute;top:91%;width:100%">
	<Table align="center" width="70%">
	<Tr>
		<Td class="blankcell" align="center"><nobr>
		<span id="EzButtonsRemarksSpan">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Back");
		buttonMethod.add("showTabN(\"1\")");

		out.println(getButtonStr(buttonName,buttonMethod));
%>		
		</span>	
		<span id="EzButtonsRemarksMsgSpan" style="display:none">
		<Table align=center>
		<Tr>
			<Td class="labelcell">Your request is being processed. Please wait</Td>
		</Tr>
		</Table>
		</span>
	</nobr>
	</Td>
	</Tr>
	</Table>
<%
	}
%>
</form>
</body>
<Div id="MenuSol"></Div>
</html>