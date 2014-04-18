<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Quotation/iBackEndQuoteDetails.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetWebOrderNo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iShippingTypes.jsp" %>
<%@ include file="../../../Includes/JSPs/Quotation/iPaymentTerms.jsp" %>
<%
	
	boolean enterComments = false;
	boolean editPrice = false;
	boolean createSO = false;
	
	if(toAct!=null && "Y".equals(toAct))
		enterComments = true;
		
	String salesAreaCode = (String)session.getValue("SalesAreaCode");
	String sapSoNo = request.getParameter("sapSoNo");
	
	if(sapSoNo==null || "null".equalsIgnoreCase(sapSoNo) || "".equals(sapSoNo)) createSO = true;
	
	/** For Comments **/
	
	String soNum = "";
	String commentNo = ""; 
	int qcsCount = 0;
	ezc.ezparam.ReturnObjFromRetrieve commentsRet = null;

	if(webRetObj!=null && webRetObj.getRowCount()>0)
	{
		soNum = webRetObj.getFieldValueString(0,"WEB_ORNO");
		ezc.ezsalesquote.client.EzSalesQuoteManager ezsalesquotemanager = new ezc.ezsalesquote.client.EzSalesQuoteManager();
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
		ezc.ezsalesquote.params.EziQcfCommentParams qcfParams= new ezc.ezsalesquote.params.EziQcfCommentParams();
		qcfParams.setQcfCode(soNum);
		qcfParams.setQcfType("COMMENTS");
		qcfParams.setQcfExt1("$$");
		mainParams.setLocalStore("Y");
		mainParams.setObject(qcfParams);
		Session.prepareParams(mainParams);
		commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)ezsalesquotemanager.getMaxCommentNo(mainParams);

		if(commentsRet!= null || !"null".equals(commentsRet))
		{
			commentNo = commentsRet.getFieldValueString(0,"COMMENT_NO");
			if(commentNo == "null" || "null".equals(commentNo))
				commentNo = "1";
		}		
		else
			commentNo = "1";
		commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)ezsalesquotemanager.getCommentList(mainParams);

		if(commentsRet != null)
		{
			qcsCount = commentsRet.getRowCount();
		}
	}
	
	/** End Comments **/
	
	/************************Files Attached******************************************/

	String uploadFilePathDir="";

	ResourceBundle site=null;
	try
	{
		uploadFilePathDir = site.getString("UPLOADFILEPATHDIR");
		uploadFilePathDir = uploadFilePathDir.replace('\\','/');
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload Temp Dir "+e);	
	}	
	
	uploadFilePathDir = "j2ee/"+uploadFilePathDir;
	ezc.ezparam.ReturnObjFromRetrieve retUploadDocs = null;
	ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setObjectNo("'"+salesAreaCode+"SQ"+soNum+"'");
	myParams.setObject(uDocsParams);
	Session.prepareParams(myParams);
	try
	{
		retUploadDocs = (ezc.ezparam.ReturnObjFromRetrieve)uploadManager.getUploadedDocs(myParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting Upload docs:"+e);	
	}
	
	int noOfDocs = 0;
	if(retUploadDocs!= null)
	{
		noOfDocs = retUploadDocs.getRowCount();
	}
	
	/************************Files Attached******************************************/

	/************************Quote Details from portal DB****************************/

	ReturnObjFromRetrieve mainRet = null;

	ReturnObjFromRetrieve retHeaderQuote = null;
	ReturnObjFromRetrieve retLines = null;
	ReturnObjFromRetrieve retDeliverySchedules = null;
	ReturnObjFromRetrieve retLineMatId = null;
	ReturnObjFromRetrieve sdHeader = null;

	EzcSalesOrderParams ezcSOParams = new EzcSalesOrderParams();
	ezcSOParams.setLocalStore("Y");
	Session.prepareParams(ezcSOParams);

	EziSalesOrderStatusParams iSOStatusParams = new EziSalesOrderStatusParams();
	EziSalesHeaderParams iSOHeader = new EziSalesHeaderParams();
	EzSalesOrderStructure SOStrut = new EzSalesOrderStructure();

	ezcSOParams.setObject(iSOStatusParams);
	ezcSOParams.setObject(iSOHeader);
	ezcSOParams.setObject(SOStrut);

	iSOHeader.setDocNumber(soNum);
	iSOHeader.setType("");
	iSOHeader.setSoldTo(customer);
	iSOHeader.setSalesArea(salesAreaCode);

	SOStrut.setDeliverySchedules("X");
	SOStrut.setLines("H");   

	try
	{
		EzoSalesOrderStatus soStatus  = (EzoSalesOrderStatus) EzSalesOrderManager.ezSalesOrderStatus(ezcSOParams);

		mainRet = soStatus.getReturn();
		retHeaderQuote		= (ReturnObjFromRetrieve)mainRet.getObject("SALES_HEADER");
		retLines 		= (ReturnObjFromRetrieve)mainRet.getObject("SALES_LINES");
		retDeliverySchedules 	= (ReturnObjFromRetrieve)mainRet.getObject("DELIVERY_LINES");
		retLineMatId         	= (ReturnObjFromRetrieve)mainRet.getObject("ITEM_MATID"); 
		sdHeader 		= (ReturnObjFromRetrieve)retHeaderQuote.getObject("SdHeader");
	}
	catch(Exception e){}
	
	int retLinesCount = 0;
	
	if(retLines!=null)
		retLinesCount = retLines.getRowCount();
	
	//out.println("retHeaderQuote:::::::::::"+retHeaderQuote.toEzcString());
	//out.println("retLines:::::::::::"+retLines.toEzcString());
	//out.println("retDeliverySchedules:::::::::::"+retDeliverySchedules.toEzcString());
	//out.println("retLineMatId:::::::::::"+retLineMatId.toEzcString());
	//out.println("sdHeader:::::::::::"+sdHeader.toEzcString());

	/************************Quote Details from portal DB****************************/
	
	String isSubUser = (String)session.getValue("IsSubUser");
	String suAuth = (String)session.getValue("SuAuth");
%>
<html>
<head>
	<Title>Sales Quote Details-- Powered by EzCommerce Inc</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=95
	var tabHeight="30%"
	var itemCountJS = '<%=retItemsCount%>'

	function verifyField(field,alertMsg)
	{
		if(isNaN(funTrim(field.value)) || funTrim(field.value)=="")
		{
			alert(alertMsg);
			field.value="";
			field.focus();
		}
	}
	function mulTotValPrice(priceObj,indx)
	{
		var len	= document.generalForm.product.length;
		var netValObj = document.generalForm.NetValue;
		var reqQtyObj = document.generalForm.Reqqty;
		var listPriceObj = document.generalForm.ListPrice;
		var totValObj = document.generalForm.TotalValue;
		var totalValue = 0;
		
		if(!isNaN(len))
		{
			eval(netValObj[indx]).value = (parseFloat(eval(reqQtyObj[indx]).value)*parseFloat(priceObj.value)).toFixed(2);

			if(isNaN(netValObj[indx].value))
				eval(netValObj[indx]).value = "";
				
			for(i=0;i<len;i++)
			{
				totalValue += (parseFloat(reqQtyObj[i].value))*(parseFloat(listPriceObj[i].value));
			}
			totValObj.value = totalValue.toFixed(2);
			if(isNaN(totValObj.value)) totValObj.value = "";
		}
		else
		{
			netValObj.value = (parseFloat(reqQtyObj.value)*parseFloat(priceObj.value)).toFixed(2);

			if(isNaN(netValObj.value))
				netValObj.value = "";
			
			totValObj.value = netValObj.value;
			if(isNaN(totValObj.value)) totValObj.value = "";
		}
	}
	function printSQ()
	{
		document.generalForm.action="ezSalesQuotePrint.jsp?salesQuote="+document.generalForm.quoteNo.value+"&soldTo="+document.generalForm.soldTo.value;
		document.generalForm.submit();
	}
	
	function formSubmit(obj,obj2)  
	{
	
		if(obj2!="CRSO")
		{
			if(document.generalForm.reasons.value==""){
				alert("Please enter Comments");
				document.generalForm.reasons.focus();
				return false;
			}
		}

		if(document.generalForm.itemSAPPrice.value!=document.generalForm.ListPrice.value)
		{
			//alert("You cannot create the order as preferred price is changed.");
			//return false;
		}
		
		document.generalForm.status.value=obj2;
		document.generalForm.apStatus.value = obj2;
	
		buttonsSpan=document.getElementById("EzButtonsSpan")
		buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display="none"
			buttonsMsgSpan.style.display="block"
		}
		var y="true"
		var attach="false"

		if(eval(y))
		{	
			var z=document.generalForm.status.value

			if(z=="AP" || z=="AP_CRSO")
			{
				if(document.generalForm.attachs.length>0)
				{
					y=confirm("Do you want to Approve the Quotation?");
				}
				else
				{
					y=confirm("Do you want to Approve the Quotation without Attachments?");
				}
				attach="true"
			}
			if(z=="CRSO")
			{
				y=confirm("Do you want to Create Order?");
			}
			if(z=="REJECTED")
			{
				y=confirm("Do you want to Reject the Quotation?");
			}
			if(eval(attach))
			{
				if(document.generalForm.attachs.length>0)
				{
					document.generalForm.attachflag.value="true";
					var astring="";
					for(var i=0;i<document.generalForm.attachs.length;i++)
					{
						astring=astring+document.generalForm.attachs.options[i].value+",";
					}
					astring	= astring.substring(0,astring.length-1);
					document.generalForm.attachString.value=astring;
				}
			}
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
				buttonsMsgSpan.style.display="none"
			}
		}
	}
	function apCreateOrder(status)
	{
		//alert("This functionality is currently under development.");
		buttonsSpan=document.getElementById("EzButtonsSpan")
		buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display="none"
			buttonsMsgSpan.style.display="block"
		}
		document.generalForm.apStatus.value = status
		document.generalForm.action="ezApproveCreateSOFromQT.jsp"
		document.body.style.cursor="wait"
		document.generalForm.submit();
	}
	function ezBackMain()
	{
		var toAct = document.generalForm.toAct.value;
		var orderStatus = document.generalForm.orderStatus.value;
		var fromDate = document.generalForm.fromDate.value;
		var toDate = document.generalForm.toDate.value;
		
		document.body.style.cursor="wait"
		document.generalForm.action="../Quotation/ezSubmittedQuotesList.jsp?orderStatus="+orderStatus+"&toAct="+toAct+"&FromDate="+fromDate+"&ToDate="+toDate;
		document.generalForm.submit();
	}
	function textCounter(field, countfield, maxlimit)
	{
		if (field.value.length > maxlimit)
		{
			alert("Comments Limit Exceeded : You can enter only "+maxlimit+" in the Comments field");
			field.value = field.value.substring(0, maxlimit);
			return false;
		}
		else
		{
			countfield.value = maxlimit - field.value.length;
		}
		return true
	}
	function ValidateNum(input,evt,checkType)
	{
		var keyCode = evt.which ? evt.which : evt.keyCode;
		//var lisShiftkeypressed = evt.shiftKey;
		var inputValue = input.value
		/*if(lisShiftkeypressed && parseInt(keyCode) != 9) 
		{
			return false ;
		}*/
		if(checkType == 'QUANTITY' || checkType == 'AMOUNT')
		{
			if((parseInt(keyCode)>=48 && parseInt(keyCode)<=57) || keyCode==37/*LFT ARROW*/ || keyCode==39/*RGT ARROW*/ || keyCode==8/*BCKSPC*/ || keyCode==46/*DEL*/ || keyCode==9/*TAB*/ || keyCode==46 /*DOT*/)
			{
				    if(inputValue.indexOf(".") != -1)
				    {
						var inputSub = inputValue.substring(inputValue.indexOf("."))
						var inputSubLength = inputSub.length
						if(inputSubLength <= 2)
						{
							    return true
						}
						else
						{
							    return false;
						}
				    }
				    else
						return true;
			}
		}           
		if(checkType == 'NUMERIC')
		{
			if((parseInt(keyCode)>=48 && parseInt(keyCode)<=57) || keyCode==37/*LFT ARROW*/ || keyCode==39/*RGT ARROW*/ || keyCode==8/*BCKSPC*/ || keyCode==46/*DEL*/ || keyCode==9/*TAB*/)
			{
				    return true;
			}
		}           
		if(checkType == 'ALPHANUMERIC')
		{
			if((parseInt(keyCode)>=48 && parseInt(keyCode)<=57) || keyCode==37/*LFT ARROW*/ || keyCode==39/*RGT ARROW*/ || keyCode==8/*BCKSPC*/ || keyCode==46/*DEL*/ || keyCode==9/*TAB*/ || (parseInt(keyCode)>=65 && parseInt(keyCode)<=90) || (parseInt(keyCode)>=97 && parseInt(keyCode)<=122))
			{
				    return true;
			}
		}           
		if(checkType == 'ALPHABETS')
		{
			if(keyCode==32 /*SPACE*/ || (parseInt(keyCode)>=65 && parseInt(keyCode)<=90) || (parseInt(keyCode)>=97 && parseInt(keyCode)<=122))
			{
				    return true;
			}
		}           
		return false;
	}
	function showAudit()
	{
		var docId = document.generalForm.soNum.value;
	
		var qryString = "ezSalesQuoteAudit.jsp?docId="+docId;
		retVal= window.open(qryString,"SalesQuoteAudit","resizable=no,left=280,top=120,height=400,width=600,status=no,toolbar=no,menubar=no,location=no")
	}
</Script>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/UploadFiles/ezAttachment.js"></Script> 
</head>

<body  scroll=auto>
<form method="post" name="generalForm">

<input type="hidden" name="toAct" 	value="<%=toAct%>">
<input type="hidden" name="orderStatus" value="'<%=orderStatus%>'">
<input type="hidden" name="fromDate" 	value="<%=fromDate%>">
<input type="hidden" name="toDate" 	value="<%=toDate%>">
<input type="hidden" name="quoteNo" 	value="<%=retHeader.getFieldValueString(0,"DOC_NO")%>">
<input type="hidden" name="soNum" 	value="<%=soNum%>">
<input type="hidden" name="qcsCount" 	value="<%=(qcsCount+1)%>">
<input type="hidden" name="createdBy"	value="<%=sdHeader.getFieldValueString(0,"CREATE_USERID")%>">
<input type="hidden" name="status">
<input type="hidden" name="attachflag">
<input type="hidden" name="attachString">
<input type="hidden" name="apStatus">


<%
	String temp = "";	  
	try
	{
		temp=Integer.parseInt(strSalesOrder)+"";
	}
	catch(Exception e)
	{
		temp=strSalesOrder;
	}	
	String display_header = "Sales Quote Details :"+temp;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	String shipToAddress = null;
	String billToAddress = null;

	String soldTo = null;
	String shipTo = null; 

	if(retPartners!=null)
	{
		String partRole="",partner="",name ="",name2="",street="",city="",district="",region="",country="",postl="",tele="",fax="";
		String tempStr= "";

		for(int i=0;i<retPartners.getRowCount();i++)
		{
			tempStr= ""; 
			partRole = retPartners.getFieldValueString(i,"ROLE");

			if("AG".equals(partRole) || "WE".equals(partRole))
			{
				partner = retPartners.getFieldValueString(i,"PARTNER_NO");
				name = retPartners.getFieldValueString(i,"PARTNER_NAME");
				name2 = retPartners.getFieldValueString(i,"PARTNER_NAME2");
				street = retPartners.getFieldValueString(i,"STREET");
				city = retPartners.getFieldValueString(i,"CITY");
				district = retPartners.getFieldValueString(i,"DISTRICT");
				region = retPartners.getFieldValueString(i,"REGION");
				country = retPartners.getFieldValueString(i,"COUNTRY");
				postl = retPartners.getFieldValueString(i,"POSTL_CODE");
				tele = retPartners.getFieldValueString(i,"TELEPHONE1");
				fax = retPartners.getFieldValueString(i,"FAX_NUMBER");
 
			 	if(name!=null && !"null".equals(name) && !"".equals(name.trim()) )
				tempStr = tempStr + name +"<br>";
				if(name2!=null && !"null".equals(name2) && !"".equals(name2.trim()) )
				tempStr = tempStr + name2 +"<br>";
				if(street!=null && !"null".equals(street) && !"".equals(street.trim()) )
				tempStr = tempStr + street +"<br>";
				if(city!=null && !"null".equals(city) && !"".equals(city.trim()) )
				tempStr = tempStr + city +", ";
				//if(district!=null && !"null".equals(district) && !"".equals(district.trim()) ) 
				//tempStr = tempStr + district +"<br>";
				if(region!=null && !"null".equals(region) && !"".equals(region.trim()) )
				tempStr = tempStr + region +"&nbsp;";
				if(postl!=null && !"null".equals(postl) && !"".equals(postl.trim()) )
				tempStr = tempStr + postl +"<br>";
				if(country!=null && !"null".equals(country) && !"".equals(country.trim()) )
				tempStr = tempStr + country +"<br>";

				if(tele!=null && !"null".equals(tele) && !"".equals(tele.trim()) )   
				tempStr = tempStr +"Tel: " + tele +"<br>";

				if(fax!=null && !"null".equals(fax) && !"".equals(fax.trim()) )
				tempStr = tempStr +"Fax: "+ fax +"<br>";			

				if("AG".equals(partRole)){
					soldTo = partner;
					billToAddress  = tempStr;
				}else{
					shipTo = partner;
					shipToAddress  = tempStr;
				}
			}
		}
	}
	if(retHeaderCount>0 && retItemsCount>0)
	{

		String poNo	 = retHeader.getFieldValueString(0,"PO_NO");
		String poDate	 = ret.getFieldValueString(0,"PO_DATE");
		String reqDate	 = ret.getFieldValueString(0,"REQ_DATE");
		String validFrom = ret.getFieldValueString(0,"QT_VALID_F");
		String validTo	 = ret.getFieldValueString(0,"QT_VALID_T");
		String shipCond	 = retHeader.getFieldValueString(0,"SHIP_COND");
		String shipType	 = "";
		
		if(shipCond!=null)
			shipType = (String)ezShippingTypes.get(shipCond);
			
		String selPayTerm = sdHeader.getFieldValueString(0,"PAYMENT_TERMS");
%>

<div align="center" style="visibility:visible;width:100%;">
<Table width='95%' valign='top'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=0 >
	<!--<Tr>
     		<th class="labelcell" align="left" width="12%" >PO No</th>
     		<td width="13%"><%//=poNo%></td>
        	<th class="labelcell" align="left" width="12%" >PO Date</th>
        	<td width="13%"><%//=poDate%></td>
        	<th class="labelcell" align="left" width="12%" >Required Delivery Date</th>
        	<td width="13%"><%//=reqDate%></td>
        	<Th class="labelcell" align="left" width="12%" >Ship Type</Th>
        	<td width="13%"><%//=shipType%></td>
	</Tr>
	<Tr>
        	<th class="labelcell" align="left">Valid From</th>
        	<td ><%//=validFrom%></td>
        	<th class="labelcell" align="left">Valid To</th>
        	<td ><%//=validTo%></td>
        	<Th class="labelcell" align="left" width="25%" colspan=2>Payment Terms</Th>
		<Td nowrap colspan=2>
		<%//=selPayTerm%>--<%//=(String)ezPaymentTerms.get(selPayTerm)%>
		<input type="hidden" name="paymentTerm" value="<%//=selPayTerm%>">
		</Td>
	</Tr>-->
	<Tr>
		<Td width="20%" align="left" valign="top" colspan=2><b>Shipping Address:</b></Td>
		<Td width="30%" align="left" valign="top" colspan=2><%=shipToAddress%></Td>
		<Td width="20%" align="left" valign="top" colspan=2><b>Billing Address:</b></Td> 
		<Td width="30%" align="left" valign="top" colspan=2><%=billToAddress%>
		<input type="hidden" name="soldTo" value="<%=soldTo%>">
		</Td>
	</Tr>
	
	<input type="hidden" name="poDate" value="<%=poDate%>">
	<input type="hidden" name="reqDate" value="<%=reqDate%>">
	<input type="hidden" name="selPayTerm" value="<%=selPayTerm%>">
	<input type="hidden" name="shipType" value="<%=shipCond%>">
	<input type="hidden" name="poNo" value="<%=poNo%>">
</Table>
</div>

<Div >
<Table width="95%"  id="tabHead"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<Tr>
	<th width="10%" valign="top" >Ordered Part#</th>
        <th width="28%" valign="top" nowrap>Description</th>
        <th width="12%" valign="top">Brand</th>
        <th width="10%" valign="top">List Price</th>
	<!--<th width="6%" valign="top">UOM</th>-->
	<th width="10%" valign="top">Quantity</th>
	<th width="10%" valign="top">Price [<%=retHeader.getFieldValueString(0,"CURRENCY")%>]</th>
	<Th width="10%" valign="top">Total Price [<%=retHeader.getFieldValueString(0,"CURRENCY")%>]</Th>
	<Th width="10%" valign="top">Delivery Date</Th>
        <!--<Th width="8%" valign="top">ATP</Th>-->
</Tr>
</Table>
</div>
<!--<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:30%;left:2%'>-->
<Div>
<Table width='95%' id='InnerBox1Tab'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%
	java.math.BigDecimal listPriceBD = null;
	java.math.BigDecimal reqPriceBD = null;

	int count = retItems.getRowCount();
	for(int i=0;i<count;i++)
	{
		String matno			= retItems.getFieldValueString(i,"CUST_MAT");
		String price			= ret1.getFieldValueString(i,"NET_PRICE");
		
		try
		{
			if(price!=null && !"null".equals(price) && "0.00".equals(price.trim()))
			{
				double subtot = Double.parseDouble(retItems.getFieldValueString(i,"VALUE"));
				double subqty = Double.parseDouble(retItems.getFieldValueString(i,"QTY"));
				java.math.BigDecimal obj = new java.math.BigDecimal(subtot/subqty);
				price = obj.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)+"";	
			}
		}
		catch(Exception e){price ="0.00"; }
		
		try{
			matno=String.valueOf(Long.parseLong(matno)); 
		}catch(Exception e){ }
		
		String requireddate = ret1.getFieldValueString(i,"REQUIREDDATE");
		
		if(requireddate == null || "null".equals(requireddate))
			requireddate = "";
		
		if(requireddate.trim().length() >10) requireddate = "";
		
		String lineNo = retItems.getFieldValueString(i,"LINE_NO");
		
		try{
			lineNo=String.valueOf(Long.parseLong(lineNo)); 
		}catch(Exception e){ }

		String brand = "";
		String listPrice = "";
		String reqPrice = "";
		String custMat = "";
		String soLineNo = "";
		
		for(int pc=0;pc<retLinesCount;pc++)
		{
			soLineNo = retLines.getFieldValueString(pc,"SO_LINE_NO");
			
			if(soLineNo!=null && soLineNo.equals(lineNo))
			{
				brand = retLines.getFieldValueString(pc,"INVOICE");	//brand
				//listPrice = retLines.getFieldValueString(pc,"LIST_PRICE");
				listPrice = retLines.getFieldValueString(pc,"SAP_PRICE");
				reqPrice = retLines.getFieldValueString(pc,"DESIRED_PRICE");
				custMat = retLines.getFieldValueString(pc,"CUST_MAT");
			}
		}
		
		try
		{
			listPriceBD = new java.math.BigDecimal(listPrice);
			listPriceBD = listPriceBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
		}
		catch(Exception e)
		{
			listPriceBD = new java.math.BigDecimal("0");
		}

		try
		{
			reqPriceBD = new java.math.BigDecimal(reqPrice);
			reqPriceBD = reqPriceBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
		}
		catch(Exception e)
		{
			reqPriceBD = new java.math.BigDecimal("0");
		}
		String classVar = "tx";
		if(enterComments)
		classVar="InputBox";

		String colTone = "";
		if(i%2==0)
			 colTone = "style='background-color:#EFEFEF'";
%>		
		<Tr align="center">
			
			<Td width="10%" align=left <%=colTone%> nowrap title="<%=retItems.getFieldValueString(i,"ITEM_NO")%>---><%=retItems.getFieldValueString(i,"ITEM_DESC")%>"><%=matno%>&nbsp;
			
			<input type="hidden" name="product" value="<%=retItems.getFieldValueString(i,"ITEM_NO")%>">
			<input type="hidden" name="lineNo" value="<%=retItems.getFieldValueString(i,"LINE_NO")%>">
			<input type="hidden" name="matno" value="<%=retItems.getFieldValueString(i,"ITEM_NO")%>">
			<input type="hidden" name="prodDesc" value="<%=retItems.getFieldValueString(i,"ITEM_DESC")%>">
			<input type="hidden" name="Reqqty" value="<%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%>">
			<input type="hidden" name="uom" value="<%=retItems.getFieldValueString(i,"UOM")%>">
			<input type="hidden" name="custprodCode" value="<%=custMat%>">
			<input type="hidden" name="ItemCat" value="TAN">
			<input type="hidden" name="itemSAPPrice" value="<%=price%>">
			<input type="hidden" name="delDate" value="<%=ret1.getFieldValueString(i,"REQUIREDDATE")%>">
			<input type="hidden" name="soLineNo" value="<%=lineNo%>">
			
			</Td>
			<Td width="28%" align=left <%=colTone%>><%=retItems.getFieldValueString(i,"ITEM_DESC")%>&nbsp;</Td>
			<Td width="12%" <%=colTone%>><%=brand%></Td>
			<Td width="10%" align=right <%=colTone%>><%="$"+listPriceBD%></Td>
			<!--<Td width="6%" align=center <%=colTone%>><%=retItems.getFieldValueString(i,"UOM")%></Td>-->
			<Td width="10%" align=right <%=colTone%>><%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%></Td>
			<input type="hidden" name="requiredPrice" value="<%=reqPriceBD%>"> 	
			<Td width="10%" align=right <%=colTone%>><input type="text" class='<%=classVar%>' size="8" name="ListPrice" value="<%=price.trim()%>"></Td>
			<Td width="10%" align=right <%=colTone%>><%=ret1.getFieldValueString(i,"VALUE")%></Td>
			<Td width="10%" <%=colTone%>><%=ret1.getFieldValueString(i,"REQUIREDDATE")%>&nbsp;</Td>
			<!--<Td width="8%"><%//=%>&nbsp;</Td>-->
		</Tr>
<%
	}
	
	String freightPrice = sdHeader.getFieldValueString(0,"FREIGHT_PRICE");
	String freightIns = sdHeader.getFieldValueString(0,"HEADER_FREIGHT_INS");
	String netValue = retHeader.getFieldValueString(0,"NET_VALUE");
	
	java.math.BigDecimal freightPrice_bd = new java.math.BigDecimal("0.00");
	java.math.BigDecimal freightIns_bd = new java.math.BigDecimal("0.00");
	java.math.BigDecimal netValue_bd = new java.math.BigDecimal("0.00");
	
	if(freightPrice!=null && !"null".equals(freightPrice) && !"".equals(freightPrice))
	{
		try
		{
			freightPrice_bd = new java.math.BigDecimal(freightPrice);
			freightPrice_bd = freightPrice_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
			
			freightIns_bd = new java.math.BigDecimal(freightIns);
			freightIns_bd = freightIns_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
			
			netValue_bd = new java.math.BigDecimal(netValue);
			netValue_bd = netValue_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
			
			netValue_bd = netValue_bd.add(freightIns_bd);
			netValue_bd = netValue_bd.add(freightPrice_bd);
		}
		catch(Exception e)
		{
			freightPrice_bd = new java.math.BigDecimal("0.00");
			freightIns_bd = new java.math.BigDecimal("0.00");
			netValue_bd = new java.math.BigDecimal("0.00");
		}
	}
%>
</Table>
</Div>
<Div style="align:center;width:100%;position:absolute;overflow:auto">
	<Table align=right  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="95%">
	<Tr>
		<Td width=60% class=blankcell>&nbsp;</Td>
		<Td width=28% class=blankcell>
			<Table align=right width=100% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<Tr>
				<Th width="66%" align=right>Freight</Th>
				<Td width="34%" align=right>&nbsp;<input type="text" name="freightVal" class="tx" size="10" readonly value="<%=freightPrice_bd%>" style="text-align:right"></Td>
			</Tr>
			<Tr>
				<Th width="66%" align=right>Freight Insurance</Th>
				<Td width="34%" align=right>&nbsp;<input type="text" name="freightIns" class="tx" size="10" readonly value="<%=freightIns_bd%>" style="text-align:right"></Td>
			</Tr>
			<Tr>
				<Th width="66%" align=right>Total</Th>
				<Td width="34%" align=right>&nbsp;<input type="text" class="tx" size="10" name="TotalValue" value="<%=myFormat.getCurrencyString(netValue_bd)%>" style="text-align:right" readonly></Td>
			</Tr>
			</Table>
		</Td>
		<Td width=12% class=blankcell>&nbsp;</Td>
	</Tr>
	</Table>
</div>
<BR><BR><BR><BR>
<div style="align:center;width:100%;position:absolute;overflow:auto">
<%
	if(qcsCount > 0)
	{
%>	
		<Br>
		<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th align="left" colspan=3>Comments</Th>	        
		</Tr>			
<%
		String displayStr ="";
		for(int i=0;i<qcsCount;i++)
		{
			if(i == 0)
			{
%>	
				<Tr><Th width=10%>User</Th><Th width=20%>Date</Th><Th width=70%>Comments</Th></Tr>
<%
			}
				displayStr = commentsRet.getFieldValueString(i,"QCF_COMMENTS");
%>				<Tr>
					<Td width=10% ><%=commentsRet.getFieldValueString(i,"QCF_USER")%></Td>
					<Td width=20% ><%=java.text.DateFormat.getDateTimeInstance(java.text.DateFormat.MEDIUM, java.text.DateFormat.SHORT).format((java.util.Date)commentsRet.getFieldValue(i,"QCF_DATE"))%></Td>
					<Td width=70% title='<%=displayStr%>'><%=displayStr%></TD>
				</Tr>
<%
		}
%>
		</Table>
<%
	}
	
	//The below is used in delete uploded file page for disabling delete option.
	String workFlowStatus = "APPROVED"; 

	if(enterComments)
	{
%>
        <!--  //** comments begin **// --> 

	<BR>	
	<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
		<Th align=left ><B><Font color=white>Enter your comments here</Font></B></Th>
	</Tr>
	<Tr>	
		<Td class='blankcell' width='100%'>
			<textarea style='width:100%' rows=3 name=reasons onKeyDown="textCounter(document.generalForm.reasons,document.generalForm.remLen,2000);" onKeyUp="textCounter(document.generalForm.reasons,document.generalForm.remLen,2000);"></textarea>
			<input type=hidden name=remLen value="2000">
		</Td>
	</Tr>
	</Table>
	
	<!--  //** comments end **// -->
<%
	}
%>	
	<BR>
	<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
<%
	if(enterComments)
	{
		workFlowStatus = "";
%>
	<Th align="left" width=60%>
		<Table width=100%><Tr><Th align=left>
		<a href="JavaScript:funAttach()" title="Click Here To Attach A File"><Font color="white"><B>Attach PO</B></Font></a>
		</Th><Th align=right>
		<a href="JavaScript:funRemove()" title="Click Here To Remove Attached File"><Font color="white"><B>Remove</B></Font></a>
		</Th></Tr></Table>
	</Th>
<%
	}
	if(noOfDocs>0)
	{			
%>
	<Th align="center" >
		View Attached Files
	</Th>
<%
	}
%>
	</Tr>
	<Tr>
<%
	if(enterComments)
	{
%>
	<Td align="center" width=60% class='blankcell' >
		<select name="attachs" style="width:100%" size=5 ondblclick="funOpenFile()">
		</select>
	</Td>
<%
	}
	if(noOfDocs>0)
	{			
%>
	<Td borderColorDark=#ffffff width=40% align="center" class="blankcell">
		<iframe src="../UploadFiles/ezAttachments.jsp?docNum=<%=soNum%>&docType=SQ&workFlowStatus=<%=workFlowStatus%>" frameborder=1 width=100% scrolling=auto scrolling=yes height="75"></iframe>
	</Td>
<%
	}
%>	
	</Tr>
	</Table>
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

		if(enterComments)
		{
			if("CU".equals((String)session.getValue("UserRole")))
			{
			
				if("Y".equals(isSubUser))
				{
					if("VEDIT".equals(suAuth))
					{
						buttonName.add("Approve and Create Order");
						buttonMethod.add("formSubmit(\"ezApproveCreateSOFromQT.jsp\",\"AP_CRSO\")");

						//buttonName.add("Reject");
						buttonName.add("Negotiate");
						buttonMethod.add("formSubmit(\"ezRejectQuote.jsp\",\"REJECTED\")");
					}
				}
				else
				{
					buttonName.add("Approve and Create Order");
					buttonMethod.add("formSubmit(\"ezApproveCreateSOFromQT.jsp\",\"AP_CRSO\")");

					//buttonName.add("Reject");
					buttonName.add("Negotiate");
					buttonMethod.add("formSubmit(\"ezRejectQuote.jsp\",\"REJECTED\")");
				}
				//buttonName.add("Approve Quotation");
				//buttonMethod.add("formSubmit(\"ezApproveCreateSOFromQT.jsp\",\"AP\")");

			}
		}
		if("CU".equals((String)session.getValue("UserRole")) && "APPROVED".equals(orderStatus) && createSO)
		{
			if(!("Y".equals(isSubUser) && "VONLY".equals(suAuth)))
			{
				//buttonName.add("Create Order");
				//buttonMethod.add("formSubmit(\"ezApproveCreateSOFromQT.jsp\",\"CRSO\")");
			}
		}
		
		buttonName.add("Print");
		buttonMethod.add("printSQ()");	

		buttonName.add("Back");
		buttonMethod.add("ezBackMain()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>	</span>
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
</Div>

<%
	}
	else
	{
		String noDataStatement = "No items present for selected sales quote";
%>

<%@ include file="../Misc/ezDisplayNoData.jsp"%>

<div align=center id="bacKButtonDiv" style="visibility:visible;position:absolute;top:85%;width:100%;">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Back");
		buttonMethod.add("ezBackMain()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<%
	}
%>
</form>
</body>
<Div id="MenuSol"></Div>
</html>
<%!
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>