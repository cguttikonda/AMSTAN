<%@ include file="../../../Includes/JSPs/Sales/iOpenOrdersDetails.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCheckCartItems.jsp"%>
<%@ include file="../Misc/ezTaxCodesAndDesc.jsp"%>
<%
	String soldToChk = request.getParameter("soldTo");
	ReturnObjFromRetrieve soldToRetObj = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");

	ArrayList soldTo_AL = new ArrayList();
	for(int sl=0;sl<soldToRetObj.getRowCount();sl++)
	{
		String soldToArray = soldToRetObj.getFieldValueString(sl,"EC_ERP_CUST_NO");
		soldTo_AL.add(soldToArray);
	}

	if(!progSOItemHT.containsValue("Free of Charge") && !soldTo_AL.contains(soldToChk))
	{
%>
		<div class="main-container col2-layout middle account-pages">
		<div class="main">
		<div class="col-main1 roundedCorners">
		<div class="page-title">
			<ul class="success-msg"><li><span>You are not authorized to view this order</span></li></ul>
		</div>
		</div> <!-- col-main -->
		</div> <!--main -->
		</div> <!-- main-container col1-layout -->
		<%@ include file="../../../Sales/JSPs/Misc/ezFooter.jsp"%>
<%
		return;
	}
%>
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

<Script src="../../Library/JavaScript/Misc/SubUserAuthCheck.js"></Script>
<Script>
	var subUser;
	var subAuth;
	var canItemIdScrpt ="";
	function checkAuth()
	{
		subUser = '<%=session.getValue("IsSubUser")%>'
		return true;
	}	
	
	function getAttach()
	{
		document.myForm.SalesOrder.value = soNum;
		document.myForm.PurchaseOrder.value = poNum;
		document.myForm.action="../Invoices/ezSOInvoiceList.jsp";
		document.myForm.target = "_blank";
		document.myForm.submit();
	}

	function callFun(type,soNum,poNum)
	{
		document.myForm.SalesOrder.value = soNum;
		document.myForm.PurchaseOrder.value = poNum;
		document.myForm.LineNumber.value = '';
				
		if(type=='INV')
			document.myForm.action="../Invoices/ezSOInvoiceList.jsp";
			
		if(type=='DLV')
			document.myForm.action="../Deliveries/ezSODeliveriesList.jsp";	

		if(type=='PRINT')
			document.myForm.action="../Sales/ezSOPrint.jsp";	
						
		document.myForm.target = "_blank";
		document.myForm.submit();
	}
	
	function callFunInv(type,soNum,poNum)
	{
		document.myForm.SalesOrder.value = soNum;
		document.myForm.PurchaseOrder.value = poNum;
		document.myForm.LineNumber.value = '';

		if(type=='INV')
			document.myForm.action="../Invoices/ezSOInvoiceList.jsp";

		if(type=='DLV')
			document.myForm.action="../Deliveries/ezSODeliveriesList.jsp";	
		if(type=='PRINT')
			document.myForm.action="ezSOPrint.jsp";			
		document.myForm.target = "_blank";
		document.myForm.submit();
	}

	function callFunLineDel(type,soNum,lineNum,poNum)
	{
		document.myForm.SalesOrder.value = soNum;
		document.myForm.PurchaseOrder.value = poNum;
		document.myForm.LineNumber.value = lineNum;

		if(type=='INV')
			document.myForm.action="../Invoices/ezSOInvoiceList.jsp";

		if(type=='DLV')
			document.myForm.action="../Deliveries/ezSODeliveriesList.jsp";	
		if(type=='PRINT')
			document.myForm.action="ezSOPrint.jsp";			
		document.myForm.target = "_blank";
		document.myForm.submit();
	}

	function funQuoteDetails(ordNum,customer)
	{
		document.myForm.salDoc.value = ordNum;
		document.myForm.soldTo.value = customer;
		document.myForm.action="../Quotes/ezJobQuoteDetails.jsp";
		document.myForm.target = "_blank";
		document.myForm.submit();
	}
	function getProductDetails(code)
	{
		document.myForm.prodCode_D.value=code;

		document.myForm.action="../Catalog/ezProductDetails.jsp";
		document.myForm.target="_blank";
		document.myForm.submit();
	}
	function funBack()
	{
		history.go(-1)
	}
	
	function funviewCR(crNo)
	{
		document.myForm.cancellationId.value = crNo;
		document.myForm.canReqType.value = 'P';
		document.myForm.crType.value = 'C';
		Popup.showModal('modal');
		document.myForm.action="../Sales/ezCancReqDetailsMain.jsp";
		document.myForm.submit();
	}
	
	function funviewRR(crNo)
	{
		document.myForm.cancellationId.value = crNo;
		document.myForm.canReqType.value = 'P';
		document.myForm.crType.value = 'RGA';

		Popup.showModal('modal');
		document.myForm.action="../Sales/ezCancReqDetailsMain.jsp";
		document.myForm.submit();
	}
	
	function funReOrder()
	{
		var catType=document.myForm.catTypeE.value;

		if(checkAuth())		
			{
			
				Popup.showModal('modal');
				document.myForm.target="_self";
				document.myForm.action="../ShoppingCart/ezAddCartRepeatOrder.jsp";
				document.myForm.submit();
			}
	}
	function funCancel(canItemId)
	{
		
		if(checkAuth())		
		{
			eval(document.getElementById("CANC_MSG"+canItemId)).style.visibility = 'visible';
			eval(document.getElementById("CANC_BUTTON"+canItemId)).style.visibility = 'hidden';
			(eval("document.myForm.selForCancaellation"+canItemId)).value = 'Y';
		}	
	}
	
	function funRGARequest(canItemId)
	{
		if(checkAuth())		
		{
			eval(document.getElementById("RGA_MSG"+canItemId)).style.visibility = 'visible';
			eval(document.getElementById("RGA"+canItemId)).style.display = 'block';
			eval(document.getElementById("RGA_BUTTON"+canItemId)).style.visibility = 'hidden';
			(eval("document.myForm.selForCancaellation"+canItemId)).value = 'Y';
		}	
	}

	function funCancelSelItems(poNum)
	{
		if(checkAuth())		
		{
		
			document.myForm.PurchaseOrder.value = poNum;

			var itemsLen = document.myForm.poItems.length; 	
			var count = 0;

			if(!isNaN(itemsLen))
			{
				for(var i=0;i<itemsLen;i++)
				{
					poItem = document.myForm.poItems[i].value;
					selForCancaellation = (eval("document.myForm.selForCancaellation"+poItem)).value;


					if(selForCancaellation == 'Y')
						count++;
				}
			}else{
				poItem = document.myForm.poItems.value;
				selForCancaellation = (eval("document.myForm.selForCancaellation"+poItem)).value;


				if(selForCancaellation == 'Y')
					count++;
			}

			if(count==0)
			{
				alert("Please select atleast one item for cancellation.");
				return;
			}
			document.myForm.cancOrRGA.value = "C";
			document.myForm.action="ezSOItemsCancConfirmMain.jsp";
			document.myForm.submit();
		}	
	}

	function funRGASelItems(poNum)
	{
		if(checkAuth())		
		{
			document.myForm.PurchaseOrder.value = poNum;

			var itemsLen = document.myForm.poItems.length; 	
			var count = 0;

			if(!isNaN(itemsLen))
			{
				for(var i=0;i<itemsLen;i++)
				{
					poItem = document.myForm.poItems[i].value;
					selForCancaellation = (eval("document.myForm.selForCancaellation"+poItem)).value;


					if(selForCancaellation == 'Y')
						count++;
				}
			}else{
				poItem = document.myForm.poItems.value;
				selForCancaellation = (eval("document.myForm.selForCancaellation"+poItem)).value;


				if(selForCancaellation == 'Y')
					count++;
			}

			if(count==0)
			{
				alert("Please select atleast one item for RGA Request.");
				return;
			}
			document.myForm.cancOrRGA.value = "RGA";
			document.myForm.action="ezSOItemsCancConfirmMain.jsp";
			document.myForm.submit();
		}	
	}
	
	function funCancelAllItems(poNum)
	{
		if(checkAuth())
		{

			document.myForm.PurchaseOrder.value = poNum;
			document.myForm.CancelAllItems.value = 'Y';

			document.myForm.cancOrRGA = "C";
			document.myForm.action="ezSOItemsCancConfirmMain.jsp";
			document.myForm.submit();
		}	
	}
	
	function funRGAAllItems(poNum)
	{
		if(checkAuth())
		{

			document.myForm.PurchaseOrder.value = poNum;
			document.myForm.CancelAllItems.value = 'Y';

			document.myForm.cancOrRGA = "RGA";	
			document.myForm.action="ezSOItemsCancConfirmMain.jsp";
			document.myForm.submit();
		}	
	}
	
	function funSaveRGAData(ordLine)
	{
		var itemType = document.getElementById("itemType"+ordLine).value;

		if(itemType=='C')
		{
			var chkbox = document.getElementById("itemTypeCnt"+ordLine).value;
			var itemChk = false;
			var matComp = "";
			var qtyComp = "";
			var compRga = "";
			if(isNaN(chkbox))
			{
				if(document.getElementById("matChkComp"+ordLine+"0").checked)
				{
					var matChkVal  = document.getElementById("matChkComp"+ordLine+"0").value;
					var matRga  = document.getElementById("retMatRGA"+matChkVal).value;
					var qtyRga  = document.getElementById("retQtyRGA"+matChkVal).value;
					var actRga  = document.getElementById("retQtyComp"+matChkVal).value;
					var compPrice  	= document.getElementById("retPriceComp"+matChkVal).value;
					var descRga  	= document.getElementById("retDescComp"+matChkVal).value;
					var retMatRga  	= document.getElementById("retMatComp"+matChkVal).value;
					var parentMat  	= document.getElementById("parentMat"+matChkVal).value;

					if(parseFloat(qtyRga)==0)
					{
						alert("Return quantity should not be zero");
						return;
					}
					else if(parseFloat(qtyRga)>parseFloat(actRga))
					{
						alert("Return quantity should not be more than Actual quantity");
						return;
					}
					matComp = matRga+"¥"+compPrice+"¥"+matChkVal;
					qtyComp = qtyRga+"¥"+compPrice+"¥"+matChkVal;
					compRga = matRga+"¥"+qtyRga+"¥"+compPrice+"¥"+descRga+"¥"+retMatRga+"¥"+parentMat+"¥"+matChkVal;
					itemChk = true;
				}
			}
			else
			{
				for(i=0;i<chkbox;i++)
				{
					if(document.getElementById("matChkComp"+ordLine+i).checked)
					{
						var matChkVal  = document.getElementById("matChkComp"+ordLine+i).value;
						var matRga  = document.getElementById("retMatRGA"+matChkVal).value;
						var qtyRga  = document.getElementById("retQtyRGA"+matChkVal).value;
						var actRga  = document.getElementById("retQtyComp"+matChkVal).value;
						var compPrice  	= document.getElementById("retPriceComp"+matChkVal).value;
						var descRga  	= document.getElementById("retDescComp"+matChkVal).value;
						var retMatRga  	= document.getElementById("retMatComp"+matChkVal).value;
						var parentMat  	= document.getElementById("parentMat"+matChkVal).value;

						if(parseFloat(qtyRga)==0)
						{
							alert("Return quantity should not be zero");
							return;
						}
						else if(parseFloat(qtyRga)>parseFloat(actRga))
						{
							alert("Return quantity should not be more than Actual quantity");
							return;
						}

						if(matComp=='')
							matComp = matRga+"¥"+compPrice+"¥"+matChkVal;
						else
							matComp = matComp+"§"+matRga+"¥"+compPrice+"¥"+matChkVal;

						if(qtyComp=='')
							qtyComp = qtyRga+"¥"+compPrice+"¥"+matChkVal;
						else
							qtyComp = qtyComp+"§"+qtyRga+"¥"+compPrice+"¥"+matChkVal;

						if(compRga=='')
							compRga = matRga+"¥"+qtyRga+"¥"+compPrice+"¥"+descRga+"¥"+retMatRga+"¥"+parentMat+"¥"+matChkVal;
						else
							compRga = compRga+"§"+matRga+"¥"+qtyRga+"¥"+compPrice+"¥"+descRga+"¥"+retMatRga+"¥"+parentMat+"¥"+matChkVal;

						itemChk = true;
					}
				}
			}
			if(eval(itemChk))
			{
				document.getElementById("retMatHRGA"+ordLine).value = matComp;
				document.getElementById("retQtyHRGA"+ordLine).value = qtyComp;
				document.getElementById("retRGAComp"+ordLine).value = compRga;
				funRGARequest(ordLine);

				$.fancybox.close();
			}
			else
			{
				alert("Please select atleast one item");
				return;
			}
		}
		else
		{
			var matRga  = document.getElementById("retMatRGA"+ordLine).value;
			var qtyRga  = document.getElementById("retQtyRGA"+ordLine).value;
			var actRga  = document.getElementById("retQty"+ordLine).value;

			if(parseFloat(qtyRga)==0)
			{
				alert("Return quantity should not be zero");
				return;
			}
			else if(parseFloat(qtyRga)>parseFloat(actRga))
			{
				alert("Return quantity should not be more than Actual quantity");
				return;
			}

			document.getElementById("retMatHRGA"+ordLine).value = matRga;
			document.getElementById("retQtyHRGA"+ordLine).value = qtyRga;

			funRGARequest(ordLine);

			$.fancybox.close();
		}
	}
	function funRefreshSort(soNum,poNum,customer)
	{
		document.myForm.SalesOrder.value = soNum;
		document.myForm.PurchaseOrder.value = poNum;
		document.myForm.soldTo.value = customer;
		document.myForm.sort_types = $('#sort_types').val();

		document.myForm.action="ezSalesOrderDetails.jsp";	
		document.myForm.submit();
	}

	var xmlhttpA

	function auditTrail()
	{
		xmlhttpA=GetXmlHttpObjectA();
		var webOrNo = document.myForm.webOrNo.value;

		if(xmlhttpA==null)
		{
			alert ("Your browser does not support Ajax HTTP");
			return;
		}

		var url = "../Misc/ezWFAuditTrailList.jsp";
		url=url+"?webOrNo="+webOrNo;

		xmlhttpA.onreadystatechange=getOutputA;
		xmlhttpA.open("GET",url,true);
		xmlhttpA.send(null);
	}
	function getOutputA()
	{
		if(xmlhttpA.readyState==4)
		{
			document.getElementById("auditId").innerHTML=xmlhttpA.responseText;
		}
	}
	function GetXmlHttpObjectA()
	{
		if(window.XMLHttpRequest)
		{
			return new XMLHttpRequest();
		}
		if(window.ActiveXObject)
		{
			return new ActiveXObject("Microsoft.XMLHTTP");
		}

		return null;
	}
	
</Script>

<!-- jQuery for sorting & pagination STARTS here-->

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes example in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#example_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#example tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#example thead th:first-child { border-left: 1px solid #AAA; }
	#example thead th:last-child { border-right: 1px solid #AAA; }
</style>

<style type="text/css">

.a, .b, .c1, .c2 {border:solid thin #DDD}
.bh {	padding:5px;
	border:1px solid #ddd;
	font-weight:bold;
	white-space:nowrap;}
.a {display:table}
.bh {display:table-header-group}
.b {display:table-row}
.c1, .c2 {display:table-cell}
.bhc1, .bhc2 {display:table-cell;background-color:lightgray}

</style>

<script>
// Javascript originally by Patrick Griffiths and Dan Webb.
// http://htmldog.com/articles/suckerfish/dropdowns/
sfHover = function() {
	var sfEls = document.getElementById("navbar").getElementsByTagName("li");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=" hover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp(" hover\\b"), "");
		}
	}
}
if (window.attachEvent) window.attachEvent("onload", sfHover);
</script>

<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.4/js/TableTools.min.js"></script> 

<!-- jQuery for sorting & pagination ENDS here -->
<!-- fancy box popup instead of original from rb -->

<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
<!-- Drop down menu on Cancel etc -->

<!-- en dof style for new header -->

<style type="text/css">

a {color:#006699; text-decoration:none}
a:hover {color:#ccc; text-decoration:none}
.highlight 
{
	height: 60px;
	width: 100%;
	background: #c0c0c0;
	background: -webkit-linear-gradient(#e9e9e9, #c0c0c0);
	background: -moz-linear-gradient(#e9e9e9, #c0c0c0);
	background: -ms-linear-gradient(#e9e9e9, #c0c0c0);
	background: -o-linear-gradient(#e9e9e9, #c0c0c0);
	background: linear-gradient(#e9e9e9, #c0c0c0);
}
</style>

<form name="myForm" method = 'POST'>

<input type='hidden' name='cancelRGA' value=''>
<input type='hidden' name='SalesOrder' value=''>
<input type='hidden' name='PurchaseOrder' value=''>
<input type='hidden' name='LineNumber' value=''>
<input type='hidden' name='salDoc' value=''>
<input type='hidden' name='soldTo' value=''>
<input type="hidden" name="prodCode_D">
<input type="hidden" name="cancellationId" >
<input type="hidden" name="canReqType" value = 'P'>
<input type="hidden" name="crType" value = 'C'>
<input type="hidden" name="CancelAllItems" value='N'>
<input type="hidden" name="cancOrRGA" value = "C" id="cancOrRGA">
<input type="hidden" name="catTypeE" value="<%=catType_C%>">
<input type="hidden" name="singleList" value="Y">
<input type="hidden" name="webOrNo" value="<%=webOrNo%>">

<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners" style="padding-top:1px" >
<!-- <div class="page-title"> -->
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>

<%
	NumberFormat nf = NumberFormat.getCurrencyInstance(); 
	String fromPage = request.getParameter("fromPage");
	String poValueFromList = request.getParameter("poValue");
	String prot = "http:";
	if (request.getProtocol().indexOf("HTTPS") != -1) 
		 prot = "https:";
	String myServer = request.getServerName();
	String myApp = "AST";
	if (request.getRequestURI().indexOf("ASP") != -1)
		myApp = "ASP";
	
	if (poValueFromList == null) {
		poValueFromList = "";
	}
	if (fromPage!=null){
		if("".equals(fromPage))fromPage="";
	}
	
	poNum = retHeader.getFieldValueString(0,"PO_NO");
	String poDate = ret.getFieldValueString(0,"PO_DATE");
	String soNumber = retHeader.getFieldValueString(0,"DOC_NO");
	String complDlv = retHeader.getFieldValueString(0,"COMPL_DLV");
	String docDate = ret.getFieldValueString(0,"DOC_DATE");
	String reqDate = ret.getFieldValueString(0,"REQ_DATE");
	String dlvCheck = "";

	if(complDlv!=null && "X".equalsIgnoreCase(complDlv)) dlvCheck = "checked=checked";

	String tempsoNumber = "";

	try
	{
		tempsoNumber = (Long.parseLong(soNumber))+"";
	}
	catch(Exception e)
	{
		tempsoNumber = soNumber;
	}

	String partRole="",partToCode="",partToName="",partToName2="",partToStreet="",partToCity="",partnerAddrCode="";
	String partToDist="",partToRegion="",partToCountry="",partToPostCode="",partToTel="",partToFax="",soldTo_Name="";

	String shipToAddress = "";
	String billToAddress = "";

	String soldToCode = "";
	String shipToCode = "";
	String zfCode = "Standard"; // Customer's LTL Partner ID or Generic Partner ID for LTL Shipments
	String zcCode = ""; // Carrier Code for UPS/DHL at American Standard
	String zfAddress = "";
	
	String promoCode = businessDataRetObj.getFieldValueString(0,"CUSTCONGR4");
	
	String tempStr= "";
	String condVal = "0";
	String pricingCondTableFreight = "<table class=\"data-table\" id=\"FREIGHTTABLE"+poNum+"\"><thead><tr id=\"condtablehdrrow\"><th>Sales Order #</th><th>SO Line#</th><th>Condition Type</th><th>Condition Desc.</th><th>Value</th></tr></thead><tbody>";
	String pricingCondTableFreightDiv = "<div class=\"a\">"+"<div class=\"bh\">"+"<div class=\"bhc1\">&nbsp;Product ID&nbsp; </div><div class=\"bhc1\">&nbsp;Type&nbsp;</div><div class=\"bhc1\">&nbsp;Doc Ref. ID&nbsp;</div><div class=\"bhc1\">&nbsp;Charge Description&nbsp;</div><div class=\"bhc1\">&nbsp;Value&nbsp;</div>"+ "</div>";
	
	java.math.BigDecimal freightTotal = new java.math.BigDecimal("0");
	
	ezc.ezcommon.EzLog4j.log("retCond>>>>>>>"+retCond.toEzcString(),"I");
	for(int j=0;j<retCond.getRowCount();j++)
	{
		String condLineNo = retCond.getFieldValueString(j,"ItmNumber");
		String condLineMatno = "";
		
		String condType = retCond.getFieldValueString(j,"CondType");
		String tempSONum = retCond.getFieldValueString(j,"DOC_NO");
		for (int ol=0;ol<slsOrdLineRetObj.getRowCount();ol++){
			if (slsOrdLineRetObj.getFieldValueString(ol,"SALES_DOC").equals(tempSONum) && 
			    slsOrdLineRetObj.getFieldValueString(ol,"SALES_DOC_ITEM").equals(condLineNo)){
			       	condLineMatno = slsOrdLineRetObj.getFieldValueString(ol,"ITEM_NO");
			    	break;
			    	}
		}

		String condDesc = "";

		if(taxCond.get(condType)!=null && !"null".equals(taxCond.get(condType)))
			condDesc = (String)taxCond.get(condType);

			// It is a header condition
			condVal = retCond.getFieldValueString(j,"Condvalue");
			try
			{
				condVal = new java.math.BigDecimal(condVal).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			}
			catch(Exception e){}
			if(condType!=null && !"".equals(condType) && !"null".equals(condType)) 
			{
				if("ZUFM".equals(condType) || "ZHTT".equals(condType) 
				  || "ZFHL".equals(condType) || "ZCRT".equals(condType) 
				  || "ZFRT".equals(condType) || "ZHD0".equals(condType) 
				  || "HD00".equals(condType) || "ZMSC".equals(condType)
				  || "ZPKH".equals(condType) || "ZRES".equals(condType))	
				{
					// it is one of freight conditions. add it to table

					if ("HD00".equals(condType) || "ZCRT".equals(condType))
					condVal = retCond.getFieldValueString(j,"CondValue");
					else	
					condVal = retCond.getFieldValueString(j,"Condvalue");
					if (!condType.equals("ZMSC")){
					if (!condVal.equals("0")) {
						condVal = new java.math.BigDecimal(condVal).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						pricingCondTableFreight = pricingCondTableFreight+"<tr><td>&nbsp;"+tempSONum+"</td><td>&nbsp;"+condLineNo+"</td><td>&nbsp;"+condType+"</td><td >"+condDesc+"</td><td>&nbsp;"+condVal+"</td></tr>";
						pricingCondTableFreightDiv = pricingCondTableFreightDiv+"<div class=\"b\">"+"<div class=\"c1\">&nbsp;"+condLineMatno+"&nbsp;</div><div class=\"c1\">&nbsp;"+"Order"+"&nbsp;</div><div class=\"c1\"&nbsp;>"+tempSONum+"/"+condLineNo+"&nbsp;</div><div class=\"c1\">&nbsp;"+condDesc+"["+condType+"]&nbsp;</div><div class=\"c2\" style=\"text-align:right\">&nbsp;"+nf.format(new Double(condVal))+"&nbsp;</div></div>";

						}
					} else {
					if (!condVal.equals("0") && (retCond.getFieldValueString(j,"Condorigin")!=null && retCond.getFieldValueString(j,"Condorigin").equals("C"))) {
						condVal = new java.math.BigDecimal(condVal).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						pricingCondTableFreight = pricingCondTableFreight+"<tr><td>&nbsp;"+tempSONum+"</td><td>&nbsp;"+condLineNo+"</td><td>&nbsp;"+condType+"</td><td >"+condDesc+"</td><td>&nbsp;"+condVal+"</td></tr>";
						pricingCondTableFreightDiv = pricingCondTableFreightDiv+"<div class=\"b\">"+"<div class=\"c1\">&nbsp;"+condLineMatno+"&nbsp;</div><div class=\"c1\">&nbsp;"+"Order"+"&nbsp;</div><div class=\"c1\"&nbsp;>"+tempSONum+"/"+condLineNo+"&nbsp;</div><div class=\"c1\">&nbsp;"+condDesc+"["+condType+"]&nbsp;</div><div class=\"c2\" style=\"text-align:right\">&nbsp;"+nf.format(new Double(condVal))+"&nbsp;</div></div>";
						try
						{
							freightTotal = freightTotal.add(new java.math.BigDecimal(condVal));
						}
						catch(Exception e){}

						}
					}
				}
			}
	} // end of looping through header condition table to build freight subtotals	
	
	pricingCondTableFreight = pricingCondTableFreight+"</tbody></table>";
	// Now add freight values based on delivery data
	java.math.BigDecimal freightTotalDel = new java.math.BigDecimal("0");
	if (dlvDocHdrRetObj != null){
		String freightDel = "0";
		for ( int dlh=0;dlh<dlvDocHdrRetObj.getRowCount();dlh++){
			freightDel = dlvDocHdrRetObj.getFieldValueString(dlh,"ZZAMT");
			if (freightDel!= null && !freightDel.equals("0") && !freightDel.equals("0.00")){
				freightDel = new java.math.BigDecimal(freightDel).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				freightTotalDel = freightTotalDel.add(new java.math.BigDecimal(freightDel));
				pricingCondTableFreightDiv = pricingCondTableFreightDiv+"<div class=\"b\">"+"<div class=\"c1\">&nbsp;"+""+"&nbsp;</div><div class=\"c1\">&nbsp;"+"Shipment"+"&nbsp;</div><div class=\"c1\"&nbsp;>"+dlvDocHdrRetObj.getFieldValueString("DLV_DOC_NO")+"&nbsp;</div><div class=\"c1\">&nbsp;Freight&nbsp;</div><div class=\"c2\" style=\"text-align:right\">&nbsp;"+nf.format(new Double(freightDel))+"&nbsp;</div></div>";
			}	
		}
	}
	
	
	/*********VALUE_MAP FOR CARRIER LOGO********/
	//Read Value Map

	EzcParams valueMapParamsMisc = new EzcParams(false);
	EziMiscParams valueMapParams = new EziMiscParams();

	ReturnObjFromRetrieve carrierLogoValMapRetObj = null;

	valueMapParams.setIdenKey("MISC_SELECT");

	String queryVM= "SELECT * "+ "FROM EZC_VALUE_MAPPING "+ " WHERE MAP_TYPE='CARRIERLOG'";

	valueMapParams.setQuery(queryVM);

	valueMapParamsMisc.setLocalStore("Y");
	valueMapParamsMisc.setObject(valueMapParams);
	Session.prepareParams(valueMapParamsMisc);	

	try
	{
		carrierLogoValMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(valueMapParamsMisc);
	}
	catch(Exception e){}	


	/*********VALUE_MAP********/
	/*********VALUE_MAP FOR CARRIER NAME********/
	ReturnObjFromRetrieve carrierDescValMapRetObj = null;

	valueMapParams.setIdenKey("MISC_SELECT");

	queryVM= "SELECT * "+ "FROM EZC_VALUE_MAPPING "+ " WHERE MAP_TYPE='CARRIERDESC'";

	valueMapParams.setQuery(queryVM);

	valueMapParamsMisc.setLocalStore("Y");
	valueMapParamsMisc.setObject(valueMapParams);
	Session.prepareParams(valueMapParamsMisc);	

	try
	{
		carrierDescValMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(valueMapParamsMisc);
	}
	catch(Exception e){}	
			

	/*********VALUE_MAP********/
		
	if(retPartners!=null)
	{
		for(int a=0;a<retPartners.getRowCount();a++)
		{
			tempStr = "";
			partRole = retPartners.getFieldValueString(a,"PARTN_ROLE");
			partToCode = retPartners.getFieldValueString(a,"CUSTOMER");
			

			if("AG".equals(partRole) || "WE".equals(partRole) || "ZF".equals(partRole) || "ZC".equals(partRole))
			{
				partnerAddrCode = retPartners.getFieldValueString(a,"ADDRESS");
				
				for(int i=0;i<retAddress.getRowCount();i++)
				{
			
					String tempAddrCode = retAddress.getFieldValueString(i,"ADDRESS");
					
					if(partnerAddrCode.equals(tempAddrCode))
					{
						partToName = retAddress.getFieldValueString(i,"PARTNER_NAME");
						soldTo_Name = retAddress.getFieldValueString(i,"PARTNER_NAME");
						partToName2 = "";//retAddress.getFieldValueString(i,"PARTNER_NAME2");
						partToStreet = retAddress.getFieldValueString(i,"STREET");
						partToCity = retAddress.getFieldValueString(i,"CITY");
						partToDist = retAddress.getFieldValueString(i,"DISTRICT");
						partToRegion = retAddress.getFieldValueString(i,"REGION");
						partToCountry = retAddress.getFieldValueString(i,"COUNTRY");
						partToPostCode = retAddress.getFieldValueString(i,"POSTL_CODE");
						partToTel = retAddress.getFieldValueString(i,"TELEPHONE1");
						partToFax = retAddress.getFieldValueString(i,"FAX_NUMBER");

						if("WE".equals(partRole))
							shipToCode = partToCode;
						if(partToName==null || "null".equals(partToName)) partToName="";
						if(partToName2==null || "null".equals(partToName2)) partToName2="";
						if(partToStreet==null || "null".equals(partToStreet)) partToStreet="";
						if(partToCity==null || "null".equals(partToCity)) partToCity="";
						if(partToDist==null || "null".equals(partToDist)) partToDist="";
						if(partToRegion==null || "null".equals(partToRegion)) partToRegion="";
						if(partToCountry==null || "null".equals(partToCountry)) partToCountry="";
						if(partToPostCode==null || "null".equals(partToPostCode)) partToPostCode="";
						if(partToTel==null || "null".equals(partToTel)) partToTel="";
						if(partToFax==null || "null".equals(partToFax)) partToFax="";

						if(shipToCode!=null && !"null".equals(shipToCode) && !"".equals(shipToCode.trim()))
							tempStr = tempStr + shipToCode +"<br>";
						if(partToName!=null && !"null".equals(partToName) && !"".equals(partToName.trim()))
							tempStr = tempStr + partToName +"<br>";
						if(partToName2!=null && !"null".equals(partToName2) && !"".equals(partToName2.trim()))
							tempStr = tempStr + partToName2 +"<br>";
						if(partToStreet!=null && !"null".equals(partToStreet) && !"".equals(partToStreet.trim()))
							tempStr = tempStr + partToStreet +"<br>";
						if(partToCity!=null && !"null".equals(partToCity) && !"".equals(partToCity.trim()))
							tempStr = tempStr + partToCity +", ";
						if(partToRegion!=null && !"null".equals(partToRegion) && !"".equals(partToRegion.trim()))
							tempStr = tempStr + partToRegion +"&nbsp;";
						if(partToPostCode!=null && !"null".equals(partToPostCode) && !"".equals(partToPostCode.trim()))
							tempStr = tempStr + partToPostCode +" ";
						if(partToCountry!=null && !"null".equals(partToCountry) && !"".equals(partToCountry.trim()))
							tempStr = tempStr + partToCountry +"<br>";
						if(partToTel!=null && !"null".equals(partToTel) && !"".equals(partToTel.trim()))
							tempStr = tempStr +"Tel#:" + partToTel +"<br>";
						if(partToFax!=null && !"null".equals(partToFax) && !"".equals(partToFax.trim()))
							tempStr = tempStr +"Fax#:"+ partToFax +"<br>";
					}		
				}		

				if("AG".equals(partRole))
				{
					soldToCode = partToCode;
					billToAddress  = tempStr;
				}
				else if("WE".equals(partRole))
				{
					shipToCode = partToCode;
					shipToAddress  = tempStr;
				}
				else if("ZC".equals(partRole))
				{
					zcCode = partToCode;
					if(carrierDescValMapRetObj!=null)
					{
						for(int cd=0;cd<carrierDescValMapRetObj.getRowCount();cd++)
						{
							if (carrierDescValMapRetObj.getFieldValueString(cd,"VALUE1").equals(partToCode)){
								zcCode = carrierDescValMapRetObj.getFieldValueString(cd,"VALUE2");
								break;
							}
						}
					}	
				}
				else if("ZF".equals(partRole))
				{
					zfCode = "Customer's LTL Partner";
					zfAddress = tempStr;
				}
			}
		}
	}
	
	Date dateNow = new Date ();
	DateFormat dformat = new SimpleDateFormat("MM/dd/yyyy hh:mm a");
	dformat.setTimeZone(TimeZone.getTimeZone("America/New_York"));
	String printDate = dformat.format(dateNow);
%>
	<br>
	<div class="highlight" style="height:75px" id="orderheader" >
	<div class="printE" style="float:right; display:none;">
	<img src="../../Library/Styles/logorevised.png" height="55px" width="237px">
	</div>
	<div style="width: 700px; float: left">
		<br>&nbsp;<font size="5" color="black"><b>PO STATUS</b></font><br>
		&nbsp;<strong>PO ID:</strong>&nbsp;<%=poNum%><strong> PO DATE:</strong>&nbsp;<%=poDate%> <strong>RECEIPT DATE:</strong>&nbsp;<%=docDate%> <strong>REQUESTED DELIVERY DATE:</strong>&nbsp;<%=reqDate%><br>
		<strong>STATUS:</strong> <%=delivStatus%>&nbsp;<strong>Current Date/Time:</strong> <%=printDate%><br>
	</div>
	
<% 
	String dummyHeader = "<div class='main-container'><div class='main'><div class='col-main1 '><div class='highlight' style='height:75px' id='orderheader' >" + 
	"<div style='width: 475px; float: left'> " + 
		" <br>&nbsp;<font size='5' color='black'><b>PO STATUS</b></font>&nbsp;Printed on "+printDate +" <br> " +
		"&nbsp;<strong>PO ID:</strong>&nbsp; "+poNum+"<strong> PO DATE:</strong>&nbsp;"+poDate+" <strong>RECEIPT DATE:</strong>&nbsp;"+docDate+"<br>"+
	"&nbsp;<strong>STATUS:</strong> "+delivStatus+"<br>	</div></div>";
%>
	<input type="hidden" name="poDate" value='<%=poDate%>'>
	</div>
	<br>
	<div style="padding-left:2px"><p>
		<ul style="list-style-type:square;list-style-position:inside;">
		<li >Please check the order Status periodically for recent updates/activities.</li>
		<li >Cancellation must be received 3 business days prior to expected Ship Date.</li>
		<li >Orders for Custom Products cannot be cancelled.</li>
		<li >Customers cancelling orders for shower doors after 24 hours of entry will be charged a $75 cancellation fee per door panel.</li>
		</ul>
		<br>
		
	</p>
	</div>
<% 
	dummyHeader+= "<br>	<div style='padding-left:2px'><p>"+
	"<ul style='list-style-type:square;list-style-position:inside;'>"+
	"<li >Please check the order Status periodically for recent updates/activities.</li>"+
	"<li >Cancellation must be received 3 business days prior to expected Ship Date.</li>"+
	"<li >Orders for Custom Products cannot be cancelled.</li>"+
	"<li >Customers cancelling orders for shower doors after 24 hours of entry will be charged a $75 cancellation fee per door panel.</li>"+
	"</ul><br></p></div>";

%>
	<div class="col1-set">
	<div class="col-1">
	<div class="info-box">
	<div class="noprint">
	<div id='backToList' >
		<button type="button" title="Back" class="button" onclick="javascript:history.back()"><span class="left-link">Back</span></button>
	</div>

	<div id='Sort Button' style="display: inline-block; ">
		<ul id="navbar" style="width: 100px; display: inline;">
			<li><a href="javascript:void()" style="padding-top:7px;padding-bottom:5px;">Sort &nbsp;&nbsp;<span class="arrow"></span></a>
			<ul>
				<li><a style="cursor:pointer;" id='solinesort'><span>PO Line</span></a></li>
				<li><a style="cursor:pointer;" id='pricegroupsort'><span>Price Group</span></a></li>
			</ul>
			</li>
		</ul>
	</div>

	<div id='Filter Button' style="padding-left:7px;display: inline-block; ">
		<ul id="navbar" style="width: 100px; display: inline;">
			<li><a href="javascript:void()" style="padding-top:7px;padding-bottom:5px;">Item Status&nbsp;&nbsp;<span class="arrow"></span></a>
			<ul>
				<li ><a style="cursor:pointer;" href="#orderheader" id='allines'><span>Show All Lines</span></a></li>
				<li ><a style="cursor:pointer;" href="#orderheader" id='openlines'><span>Open</span></a></li>
				<li ><a style="cursor:pointer;" href="#orderheader" id='partship'><span>Partially Shipped</span></a></li>
				<li ><a style="cursor:pointer;" href="#orderheader" id='shipped'><span>Shipped</span></a></li>
				<li ><a style="cursor:pointer;" href="#orderheader" id='canceled'><span>Cancelled</span></a></li>
				<li ><a style="cursor:pointer;" href="#orderheader" id='CRP'><span>Cancellation Requested</span></a></li>
				<li ><a style="cursor:pointer;" href="#orderheader" id='RGA'><span>RGA Requested</span></a></li>
			</ul>
			</li>
		</ul>
	</div>

	<div id='OtherActions' style="display: inline-block;padding-left:7px; ">
		<ul id="navbar" style="width: 100px; display: inline;">
			<li><a href="javascript:void()" style="padding-top:5px;padding-bottom:5px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'> &nbsp;&nbsp;<span class="arrow"></span></a>
			<ul>
				<li><a style="cursor:pointer;" id='cancelselected' href="javascript:funCancelSelItems('<%=poNum%>')"><span>Cancel Selected</span></a></li>
				<li><a style="cursor:pointer;" id='cancelall' href="javascript:funCancelAllItems('<%=poNum%>')"><span>Cancel Order</span></a></li>
				<li><a style="cursor:pointer;" id='rgaselected' href="javascript:funRGASelItems('<%=poNum%>')"><span>RGA/Return Selected</span></a></li>
				<li><a style="cursor:pointer;" id='re-order' href="javascript:funReOrder()"><span>Replenish Items</span></a></li>
				<li><a style="cursor:pointer;" id='invoices' href="javascript:callFun('INV','<%=salesOrder%>','<%=poNum%>')"><span>Invoice</span></a></li>
				<li><a style="cursor:pointer;" id='asns' href="javascript:callFun('DLV','<%=salesOrder%>','<%=poNum%>')"><span>ASN</span></a></li>

				<li><a style="cursor:pointer;" id='print' href="#orderheader"><span>Print PO</span></a></li>
<%
				if ((attachmentRetObj != null) && (attachmentRetObj.getRowCount() > 0 )) 
				{
%>
					<li><a style="cursor:pointer;" class="fancybox" href="#POATTACHMENTS<%=poNum%>" id='attachments' ><span>Attachments</span></a></li>
<%
				}
				if(!"CU".equals(userRole))
				{
%>
					<li><a style="cursor:pointer;" class="fancybox" href="#auditId" id='Audit' onclick="javascript:auditTrail()"><span>Audit</span></a></li>

<%
				}
%>
			</ul>
			</li>
		</ul>
	</div>
<%
		if ((attachmentRetObj != null) && (attachmentRetObj.getRowCount() > 0 )) 
		{
%>
			<div id="POATTACHMENTS<%=poNum%>" style="width: 400px; display: none; ">
			<h2>Attachments for PO: <%=poNum%></h2>
<%
			for (int acount=0;acount<attachmentRetObj.getRowCount();acount++) 
			{
%>
				<a href="../UploadFiles/ezViewOrSaveFile.jsp?lineNo=<%=acount%>&fileKey_<%=acount%>=<%=attachmentRetObj.getFieldValueString(acount,"FILENAME")%>&fileVal_<%=acount%>=<%=attachmentRetObj.getFieldValueString(acount,"INSTID")%>" target="_blank"><%=attachmentRetObj.getFieldValueString(acount,"FILENAME")%></a>
		<br>
<% 
			}
%>
		</div>
<%
		}
%>

	</div> <!-- no print -->
	</div> <!-- infobox -->
	</div><!-- col1 -->
	</div> <!-- col1set div -->
	<input type="hidden" name="soldToCode" value="<%=customer%>">
	<input type="hidden" name="shipToCode" value="<%=shipToCode%>">
	<input type="hidden" name="shipTo" value="<%=shipTo%>">
	<input type="hidden" name="salesOrder" value='<%=salesOrder%>'>
	<input type="hidden" name="soldTo_Name" value="<%=soldTo_Name%>" >

	<input type="hidden" name="partToName" value="<%=partToName%>" >
	<input type="hidden" name="partToStreet" value="<%=partToStreet%>" >
	<input type="hidden" name="partToCity" value="<%=partToCity%>" >
	<input type="hidden" name="partToRegion" value="<%=partToRegion%>" >
	<input type="hidden" name="partToPostCode" value="<%=partToPostCode%>" >
	<input type="hidden" name="partToCountry" value="<%=partToCountry%>" >
	<input type="hidden" name="partToTel" value="<%=partToTel%>" >	
	
<!-- </div> div page title-->
<div id="auditId" style="width: 900px; height:200px; display: none; "></div>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">shipping Address</h2>
		<p><%=shipToAddress%></p>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Sold To Address</h2>
		<p><%=billToAddress%></p>
	</div>
	</div> <!-- Col 2 of Order Header -->
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Shipping Method </h2>
<% 
		if (dlvCheck.equals("checked=checked")) 
		{
%>
			<p><strong>Deliver Together:</strong>&nbsp;Yes<br>
<%
		}
%>
		<strong>Shipping Mode:</strong>&nbsp;
<%
		if(!("".equals(zcCode)))
		{
			out.println(zcCode); 
		}
		else
		{
			out.println(zfCode);
		}
		if(!("".equals(zcCode.trim())) || !(zfAddress.trim().equals(""))) {
%>
		<br><strong>BILLING DETAILS WITH SHIPPER</strong><br>
		
<%
		}
		if(!("".equals(zcCode)))
		{
			out.println(SOHeaderSCACText);
		}
		else
		{
			out.println(zfAddress);
		}
%>
		<br>
		</p>
	</div>
	</div> <!-- Col 3 of Order Header -->
</div> <!-- End of header Column 3 Set -->
<br>
<div class="col1-set">
<%
	if(!promoCode.equals(""))
	{
%>
		<p><strong>Promo Code Used # </strong><%=promoCode%></p>
<%
	}
%>
</div>
<%
	if (localSODetailsRetObj.getFieldValueString(0,"EON_TYPE") != null && localSODetailsRetObj.getRowCount()>0 && !"".equals(nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"EON_TYPE"))) && !(localSODetailsRetObj.getFieldValueString(0,"EON_TYPE").equals("Q") || localSODetailsRetObj.getFieldValueString(0,"EON_TYPE").equals("A"))) 
	{ 
		// replace this check with order type. Currently EON_TYPE stores reason which is mandatory for FD orders
%>
<div class="col3-set" id="focdata">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">FOC Request Info</h2>
		<p><strong>Purpose:&nbsp;</strong><%=nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"EON_TYPE"))%><br>
		<strong>Reason:&nbsp;</strong><%=nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"EON_QUESTION_TYPE"))+" - "+nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"VALUE2"))%><br>
		<strong>Requestor:&nbsp;</strong><%=nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"EON_CREATED_BY"))%><br>
		<strong>Approver:&nbsp;</strong><%=nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"EON_MODIFIED_BY"))%></p>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">FOC Defect Categorization</h2>
		<p><strong>Category1:&nbsp;</strong><%=nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"ESDH_DEFCAT_L1"))%><br>
		<strong>Category2:&nbsp;</strong><%=nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"ESDH_DEFCAT_L2"))%><br>
		<strong>Category3:&nbsp;</strong><%=nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"ESDH_DEFCAT_L3"))%></p>
	</div>
	</div> <!-- Col 2 of foc header -->
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">FOC Purpose Explanation</h2>
		<textarea id="explanationtext" rows="2" cols="80"><%=nullCheckBlank(localSODetailsRetObj.getFieldValueString(0,"EON_TEXT"))%></textarea>
	</div>
	</div> <!-- col3 of FOC Order -->
</div> <!-- foc order -->	
<% 
	} // end if if check for finding FD Orders
%>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px"></h2>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px"></h2>
	</div>
	</div>
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px"></h2>
	</div>
	</div>
</div>	

<Table width="100%" border=0>
<Tr>
<% 
	if (!SOHeaderText.trim().equals("")) 
	{
%>
		<Td><label for="headertext"><strong>General Notes</strong></label></Td>
<% 
	}
	if (!SOHeaderShipText.trim().equals("")) 
	{ 
%>
		<Td><label for="shipInst"><strong>Order Shipping Instructions</strong></label></Td>
<% 
	}
%>
</Tr>
<Tr>
	<Td>
<% 
	if (!SOHeaderText.trim().equals("")) 
	{
%>
		<textarea id="headertext" rows="2" cols="80"><%=SOHeaderText%></textarea>
<% 
	}
%>
		<!-- <p><strong>External Header Text : </strong><%=SOHeaderText%></p> -->
	</Td>
	<Td>
<% 
	if (!SOHeaderShipText.trim().equals("")) 
	{ 
%>
		<textarea id="headertext" rows="2" cols="80"><%=SOHeaderShipText%></textarea>
<% 
	}
%>
	</Td>
</Tr>
</Table>
<br>

<% 
	if ((attachmentRetObj != null) && (attachmentRetObj.getRowCount() > 0 )) 
	{
%>
		<div id="POATTACHMENTS<%=poNum%>" style="width: 400px; display: none; ">
		<h2>Attachments for PO: <%=poNum%></h2>
<% 
		for (int acount=0;acount<attachmentRetObj.getRowCount();acount++) 
		{ 
%>
			<a href="../UploadFiles/ezViewOrSaveFile.jsp?lineNo=<%=acount%>&fileKey_<%=acount%>=<%=attachmentRetObj.getFieldValueString(acount,"FILENAME")%>&fileVal_<%=acount%>=<%=attachmentRetObj.getFieldValueString(acount,"INSTID")%>" target="_blank"><%=attachmentRetObj.getFieldValueString(acount,"FILENAME")%></a>
			<br>
<% 
		} 
%>
	</div>
<%	 
	} 
%>

<% 
	dummyHeader+= "<div class='col3-set'><div class='col-1'>"+
	"<div class='info-box'>	<h2 class='sub-title' style='padding-top:10px'>shipping Address</h2>"+
	"<p>"+shipToAddress+"</p>"+
	"</div>"+
	"</div>"+
	"<div class='col-2'>"+
	"<div class='info-box'>"+
	"<h2 class='sub-title' style='padding-top:10px'>Sold To Address</h2>"+
	"<p>"+billToAddress+"</p>"+
	"</div>"+
	"</div> "+
	"<div class='col-3'>"+
	"<div class='info-box'>"+
	"<h2 class='sub-title' style='padding-top:10px'>Shipping Method </h2>";
	if (dlvCheck.equals("checked=checked")) { 
		dummyHeader+="<p><strong>Deliver Together:</strong>&nbsp;Yes<br>";
	}
	dummyHeader+="<strong>Shipping Mode:</strong>&nbsp;";
	if(!("".equals(zcCode)))
	{
		dummyHeader+=zcCode; 
	}
	else
	{
		dummyHeader+=zfCode;
	}
	if(!("".equals(zcCode.trim())) || !(zfAddress.trim().equals(""))) {
	dummyHeader+="<br><strong>BILLING DETAILS WITH SHIPPER</strong><br>";
	}
	if(!("".equals(zcCode)))
	{
		dummyHeader+=SOHeaderSCACText;
	}
	else
	{
		dummyHeader+=zfAddress;
	}
	dummyHeader+="<br></p></div></div> <!-- Col 3 of Order Header --></div> <!-- End of header Column 3 Set -->";
	dummyHeader+="<div class='col3-set'>"+
		"<div class='col-1'>"+
		"<div class='info-box'>"+
		"<h2 class='sub-title' style='padding-top:10px'></h2>"+
		"</div>	</div><div class='col-2'>"+
		"<div class='info-box'>"+
		"<h2 class='sub-title' style='padding-top:10px'></h2>"+
		"</div>	</div>	<div class='col-3'>"+
		"<div class='info-box'>"+
		"<h2 class='sub-title' style='padding-top:10px'></h2>"+
		"</div>	</div></div>	";
        dummyHeader+="</div></div></div>";
%>
<div >
	
	<table class="data-table" id="solines" style="width:100% !important;">
	<thead>
	<tr>
		<th width="10%">&nbsp;</th>
		<th width="10%">Image<br>Brand</th>
		<th width="22%">Product Information</th>
		<th width="7%">PO Program</th>
		<th width="5%">Net Price[NP]<br>Multiplier[MULT]<br>List Price[LP]</th>
		<th width="5%">Order Qty[OQ]<br>Confirm Qty[CQ]<br>Exp Delv Date[EDelDt]</th>
		<th width="7%">Ship Qty[SQ]<br>Ship Dates[SDt]</th>
		<th width="7%">SubTotal</th>
		<th width="5%">Actions</th>
		<th width="1%" id='custmat35'></th>
		<th width="1%" id='SONum'></th>
		<th width="1%" id='POLine'></th>
		<th width="1%" id='custmat35pts'></th>
	</tr>
	</thead>
	<tbody>
<%
	java.math.BigDecimal totTax = new java.math.BigDecimal("0");
	int count = retItems.getRowCount();
	

	java.math.BigDecimal totalItemsValue = new java.math.BigDecimal("0");
	java.math.BigDecimal grandTotal = new java.math.BigDecimal("0");

	Vector plantsVect = new Vector();
	
	/* there could be 128 orders type OR, and should not be canceled as they are type of custom items */
	
	plantsVect.addElement("128");
	plantsVect.addElement("127"); // reflects Safety Tubs
	/* in Test session it was noted that 01 and 521 orders are OR with PR/PO in place ..so those rules apply */
	
	retItems.sort(new String[]{"DOC_NO","LINE_NO"},true);
	slsOrdLineRetObj.sort(new String[]{"SALES_DOC","SALES_DOC_ITEM"},true);

	java.util.HashMap catalogHM = new java.util.HashMap();

	if(slsOrdLineRetObj!=null)
	{
		for(int i=0;i<slsOrdLineRetObj.getRowCount();i++)
		{
			String catalog_S = slsOrdLineRetObj.getFieldValueString(i,"CUST_MAT35");
			String volume_S = slsOrdLineRetObj.getFieldValueString(i,"VOLUME");
			String matno	= slsOrdLineRetObj.getFieldValueString(i,"ITEM_NO");
			String rejReason = retItems.getFieldValueString(i,"REJREASON");

			if(("PTSAM".equals(matno) || "PTSCH".equals(matno) || "PIECES".equals(matno)))
				continue;

			if("Repair Parts".equals(catalog_S) || "DXV Chinaware".equals(catalog_S) || "DXV Faucets".equals(catalog_S) ||
			   "DXV Furniture".equals(catalog_S) || "DXV Tubs".equals(catalog_S) || 
			   "DXV Sinks (Non-CW)".equals(catalog_S) || "DXV Repair Parts".equals(catalog_S))
			{
				String salesDoc_S = slsOrdLineRetObj.getFieldValueString(i,"SALES_DOC");
				String salesDocItem_S = slsOrdLineRetObj.getFieldValueString(i,"SALES_DOC_ITEM");

				for(int j=0;j<slsOrdLineRetObj.getRowCount();j++)
				{
					String salesDoc_B = slsOrdLineRetObj.getFieldValueString(j,"SALES_DOC");
					String parentItem_B = slsOrdLineRetObj.getFieldValueString(j,"PARENT_ITEM");

					if(salesDoc_S.equals(salesDoc_B) && salesDocItem_S.equals(parentItem_B))
					{
						String netValue_B = slsOrdLineRetObj.getFieldValueString(j,"NET_VALUE");
						volume_S = (new java.math.BigDecimal(volume_S)).add(new java.math.BigDecimal(netValue_B)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}
				}
			}

			if(!catalogHM.containsKey(catalog_S))
			{
				catalogHM.put(catalog_S,volume_S);
			}
			else if("".equals(rejReason))
			{
				String volume_H = (String)catalogHM.get(catalog_S);
				volume_H = new java.math.BigDecimal(volume_S).add(new java.math.BigDecimal(volume_H)).toString();
				catalogHM.put(catalog_S,volume_H);
			}
		}
	}

	Map sortedMap = new TreeMap(catalogHM);

	Set catCol = sortedMap.entrySet();
	Iterator catColIte = catCol.iterator();

	while(catColIte.hasNext())
	{
		Map.Entry catColData = (Map.Entry)catColIte.next();

		String cat_HM = (String)catColData.getKey();
		int ent = 0;

		for(int i=0;i<count;i++)
		{
			String matno		= retItems.getFieldValueString(i,"ITEM_NO");
			String cust_mat35 	= slsOrdLineRetObj.getFieldValueString(i,"CUST_MAT35");

			if(!cat_HM.equals(cust_mat35))
				continue;

			if(("CU".equals(userRole)) && ("PTSAM".equals(matno) || "PTSCH".equals(matno) || "PIECES".equals(matno)))
				continue;

			boolean dlvCreated = false;
			boolean pgiCreated = false;
			boolean poCreated  = false;
			boolean dlvExists = false; // this will be used to check if Request for Cancellation or Cancel Directly
			boolean retReqCreated = false;
			boolean cancReqCreated = false;

			String salesDocNo 	= retItems.getFieldValueString(i,"DOC_NO");
			String lineNo 		= retItems.getFieldValueString(i,"LINE_NO");
			String itemDesc		= retItems.getFieldValueString(i,"ITEM_DESC");

			if(itemDesc!=null && !"null".equals(itemDesc) && !"".equals(itemDesc))
				itemDesc = itemDesc.replaceAll("'","`")   ;

			String custMat          = retItems.getFieldValueString(i,"CUST_MAT");
			String price		= ret1.getFieldValueString(i,"NET_PRICE");

			String itemPlant	= ret1.getFieldValueString(i,"PLANT");

			String zztext           = retItems.getFieldValueString(i,"ZZTEXT");
			String itTax            = retItems.getFieldValueString(i,"TAX");
			String requireddate 	= ret1.getFieldValueString(i,"REQUIREDDATE");
			String rejReason 	= retItems.getFieldValueString(i,"REJREASON");
			String poItemNo 	= retItems.getFieldValueString(i,"PO_ITM_NO");
			String eanUPC	 	= retItems.getFieldValueString(i,"EAN_UPC");

			String orderedQty 	= retItems.getFieldValueString(i,"QTY");
			String itemValue 	= retItems.getFieldValueString(i,"VALUE");
			String itemValueNew 	= retItems.getFieldValueString(i,"VALUE");
			itemValueNew = (new  java.math.BigDecimal(itemValueNew).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();


			String volume = slsOrdLineRetObj.getFieldValueString(i,"VOLUME");
			String parentItem = slsOrdLineRetObj.getFieldValueString(i,"PARENT_ITEM");
			String childComponents = "";
			String delimitedChildComponents = "";
			String childComponentsLineNos = "";
			String parentItemComp = "";
			String itemDescComp = "";
			String matnoComp = "";
			String salesDocNoComp = "";
			String lineNoComp = "";
			String itemQtyComp = "";
			String shippedQtyComp = "0";
			String rejReasonComp = "";

			java.util.Hashtable priceCompHT = new java.util.Hashtable();	//List prices of kit components

			// Find all children and make a table. See if we can do it conditionally based on item category
			for(int itemc=0;itemc<count;itemc++){
				parentItemComp = "";
				itemDescComp = "";
				matnoComp = "";
				salesDocNoComp = "";
				lineNoComp = "";
				parentItemComp =         slsOrdLineRetObj.getFieldValueString(itemc,"PARENT_ITEM");//slsOrdLineRetObj
				itemDescComp                 = retItems.getFieldValueString(itemc,"ITEM_DESC");
				matnoComp                       = retItems.getFieldValueString(itemc,"ITEM_NO");
				salesDocNoComp            = retItems.getFieldValueString(itemc,"DOC_NO");
				lineNoComp                       = retItems.getFieldValueString(itemc,"LINE_NO");
				itemQtyComp = retItems.getFieldValueString(itemc,"QTY");
				rejReasonComp 	= retItems.getFieldValueString(itemc,"REJREASON");

				if (parentItemComp.equals(lineNo) && salesDocNo.equals(salesDocNoComp) )
				{
					if(itemShippedQtys.get(salesDocNoComp+""+lineNoComp)!=null && itemDeliveryDates.get(salesDocNoComp+""+lineNoComp)!=null)
						shippedQtyComp = (String)itemShippedQtys.get(salesDocNoComp+""+lineNoComp);

					// Components Parent Item # matches the current Line #, and sales order nr is same
					// This component belongs to current line

					String strikeTextStartTagComp = "", strikeTextEndTagComp = "";
					if(!"".equals(rejReasonComp))
					{
						strikeTextStartTagComp = "<strike>";
						strikeTextEndTagComp = "<strike>";
					}

					childComponents+= strikeTextStartTagComp + "" +
					matnoComp 
					+ " " 
					+ itemDescComp
					+ strikeTextEndTagComp
					+ "&nbsp;<br/>";

					if("".equals(rejReasonComp))
					{
						delimitedChildComponents+= ""+ matnoComp + ":" + itemQtyComp + ":" + lineNoComp + ":" + itemDescComp + ":" + shippedQtyComp + "#";
						childComponentsLineNos+=lineNoComp+":"+itemQtyComp+";";
					}
				}
			 }

			String salesHdrData	= (String)soHeaderDataHT.get(salesDocNo);

			String salesHdrDataArr[]= salesHdrData.split("#"); 

			String salesQuoteRef = " ",jobQuoteOrdId = "";

			if(refSalesQuotations.get(salesDocNo+""+lineNo)!=null)
			{
				salesQuoteRef = "JobQuote:&nbsp; "+(String)refSalesQuotations.get(salesDocNo+""+lineNo);

				jobQuoteOrdId = (String)refSalesQuotations.get(salesDocNo+""+lineNo);

				jobQuoteOrdId = jobQuoteOrdId.split("/")[0];
			}	

			String programType = "";
			if ( salesHdrDataArr[0].equalsIgnoreCase("ZDPO") || salesHdrDataArr[0].equalsIgnoreCase("ZIDP")) {
				programType = "Display/VIP";
			}
			if ( salesHdrDataArr[0].equalsIgnoreCase("Z1")) {
				programType = "Quick Ship/Rush";
			}
			if ( salesHdrDataArr[0].equalsIgnoreCase("TA")) {
				programType = "Standard";
			}
			if ( salesHdrDataArr[0].equalsIgnoreCase("ZDSH")) {
				programType = "Standard";
			}
			if ( salesHdrDataArr[0].equalsIgnoreCase("ZIDS")) {
				programType = "Standard";
			}
			if ( salesHdrDataArr[0].equalsIgnoreCase("FD") || salesHdrDataArr[0].equalsIgnoreCase("KL")) {
				programType = "Free of Charge";
			}
			if ( salesHdrDataArr[0].equalsIgnoreCase("ZLTL")) {
				programType = "Replacement";
			}

			String shippedQty = "0";
			String confQty = "0" , confDate="";
			if(itemShippedQtys.get(salesDocNo+""+lineNo)!=null && itemDeliveryDates.get(salesDocNo+""+lineNo)!=null)
				shippedQty = (String)itemShippedQtys.get(salesDocNo+""+lineNo);

			if(itemConfirmedQtyHT.get(salesDocNo+""+lineNo)!=null){
				confQty = (String)itemConfirmedQtyHT.get(salesDocNo+""+lineNo);
				confDate = (String)itemConfirmedDatesHT.get(salesDocNo+""+lineNo);
			}	

			if(shippedItemsVect.contains(salesDocNo+""+lineNo))	
				dlvCreated = true;

			if (dlvNumSOItemHT.containsKey(salesDocNo+""+lineNo))
				dlvExists = true;

			if(poNumSOItemHT.containsKey(salesDocNo+""+lineNo))		
				poCreated = true;

			if(cancReqSOItemHT.containsKey(salesDocNo+""+lineNo))		
				cancReqCreated = true;


			if(retReqSOItemHT.containsKey(salesDocNo+""+lineNo))		
				retReqCreated = true;

			String shippedDates = "",shippedDatesHTML = "";
			String confirmDates = "", confirmDatesHTML = "";
			boolean multipleInvoices = false;
			if(itemDeliveryDates.get(salesDocNo+""+lineNo)!=null)	
			{
				pgiCreated = true;
				shippedDatesHTML = "<table class=\"data-table\"><thead><tr><th>Date</th><th>Quantity</th></tr></thead><tbody>";
				shippedDates = (String)itemDeliveryDates.get(salesDocNo+""+lineNo);

				String shippedDtArr[] = shippedDates.split("#");

				for(int s=0;s<shippedDtArr.length;s++)
					shippedDatesHTML = shippedDatesHTML+"<tr><td>&nbsp;"+(shippedDates.split("#")[s]).split("!!")[0]+"</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+eliminateDecimals((shippedDates.split("#")[s]).split("!!")[1])+"</td></tr>";

				if(shippedDtArr.length>1){
					shippedDates = "Multiple";	 
					multipleInvoices = true;
				}	
				else{		
					shippedDates = (shippedDates.split("#")[0]).split("!!")[0]; 

				}

				shippedDatesHTML = shippedDatesHTML+"</tbody></table>"; 	
			}

			// NEW LOGIC FOR CONFIRM DATE MULTIPLE BASED ON SCHEDULES

			if(itemConfirmedDatesHT.get(salesDocNo+""+lineNo)!=null)	
			{

				confirmDatesHTML = "<table class=\"data-table\"><thead><tr><th>Date</th><th>Quantity</th></tr></thead><tbody>";
				confirmDates = (String)itemConfirmedDatesHT.get(salesDocNo+""+lineNo);

				String confirmedDtArr[] = confirmDates.split("#");

				for(int zz=0;zz<confirmedDtArr.length;zz++)
					confirmDatesHTML = confirmDatesHTML+"<tr><td>&nbsp;"+(confirmDates.split("#")[zz]).split("!!")[0]+"</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+eliminateDecimals((confirmDates.split("#")[zz]).split("!!")[1])+"</td></tr>";

				if(confirmedDtArr.length>1)
					confirmDates = "Multiple";	 
				else		
					confirmDates = (confirmDates.split("#")[0]).split("!!")[0]; 

				confirmDatesHTML = confirmDatesHTML+"</tbody></table>"; 	
			}

			String strikeTextStartTag = "", strikeTextEndTag = "";
			if(!"".equals(rejReason))
			{
				strikeTextStartTag = "<strike>";
				strikeTextEndTag = "<strike>";
			}	

			String lineItemText = (String)retLineTextHT.get(salesDocNo+""+lineNo);
			String lineCancItemText = (String)retLineCancTextHT.get(salesDocNo+""+lineNo);

			if(lineItemText==null || "null".equals(lineItemText))
				lineItemText = "";

			if(lineCancItemText==null || "null".equals(lineCancItemText))
				lineCancItemText = "";

			String brand = "";
			String listPrice = "0";
			String listPriceOurDB = "0";
			String price_N = "0";
			String price_NJ = "0";
			String itemNet = "0.00";
			String stdMultiplier = "0";
			String freight = "0";
			String price_K = "0"; // KUMU in case of items with Components.. PN00 and ZPN0 is empty in these cases

			String pricingCondTable = "<table class=\"data-table\" id=\"PRICETABLE"+salesDocNo+"-"+lineNo+"\"><thead><tr id=\"condtablehdrrow\"><th>Condition Type</th><th>Condition Desc.</th><th>Value</th></tr></thead><tbody>";

			for(int j=0;j<retCond.getRowCount();j++)
			{
				String condLineNo = retCond.getFieldValueString(j,"ItmNumber");
				String condType = retCond.getFieldValueString(j,"CondType");
				String tempSONum = retCond.getFieldValueString(j,"DOC_NO");
				String condInActive = retCond.getFieldValueString(j,"Condisacti");

				String condDesc = "";

				if(taxCond.get(condType)!=null && !"null".equals(taxCond.get(condType)))
					condDesc = (String)taxCond.get(condType);

				if(salesDocNo.equals(tempSONum) && lineNo.equals(condLineNo) && "".equals(condInActive))
				{
					condVal = retCond.getFieldValueString(j,"Condvalue");

					try
					{
						condVal = new java.math.BigDecimal(condVal).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						ezc.ezcommon.EzLog4j.log("condVal>>>>>>>"+condVal,"I");
					}
					catch(Exception e){}


					if(condType!=null && !"".equals(condType) && !"null".equals(condType))
						pricingCondTable = pricingCondTable+"<tr><td>&nbsp;"+condType+"</td><td >"+condDesc+"</td><td>&nbsp;"+condVal+"</td></tr>";

					if("ZUPR".equals(condType))
					{
						listPrice = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							listPrice = new java.math.BigDecimal(listPrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							ezc.ezcommon.EzLog4j.log("listPrice>>>>>>>"+listPrice,"I");
						}
						catch(Exception e){}
					}
					if("ZJOB".equals(condType))
					{
						price_NJ = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							price_NJ = new java.math.BigDecimal(price_NJ).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							ezc.ezcommon.EzLog4j.log("price_NJ>>>>>>>"+price_NJ,"I");
						}
						catch(Exception e){}
					}
					if("PN00".equals(condType))
					{
						price_N = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							price_N = new java.math.BigDecimal(price_N).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							ezc.ezcommon.EzLog4j.log("price_N>>>>>>>"+price_N,"I");
						}
						catch(Exception e){}
					}
					if("KUMU".equals(condType))
					{
						price_K = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							price_K = new java.math.BigDecimal(price_K).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							ezc.ezcommon.EzLog4j.log("price_K>>>>>>>"+price_K,"I");
						}
						catch(Exception e){}
					}

					if("ZUSM".equals(condType) || "ZPML".equals(condType) || "ZSTD".equals(condType) || "ZUVP".equals(condType) || "Z706".equals(condType) || "ZMPM".equals(condType) || "ZMUL".equals(condType))
					{
						stdMultiplier = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							stdMultiplier = new java.math.BigDecimal(stdMultiplier).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}
					}
					if("ZUFM".equals(condType) || "ZHTT".equals(condType) 
					|| "ZFHL".equals(condType) || "ZCRT".equals(condType) 
					|| "ZFRT".equals(condType) || "ZHD0".equals(condType) 
					|| "HD00".equals(condType) || "ZPKH".equals(condType) 
					|| "ZRES".equals(condType))
					{
						if ("HD00".equals(condType) || "ZCRT".equals(condType))
							freight = retCond.getFieldValueString(j,"CondValue");
						else	
							freight = retCond.getFieldValueString(j,"Condvalue");															
						try
						{
							freight = new java.math.BigDecimal(freight).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							if("".equals(rejReason))
								freightTotal = freightTotal.add(new java.math.BigDecimal(freight));
						}
						catch(Exception e){}
					}

					if (("ZJOB".equals(condType) || "PN00".equals(condType)) && "".equals(condInActive))
					{ 
						if ("PN00".equals(condType)){
							itemValue	= (new  java.math.BigDecimal(price_N).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
							ezc.ezcommon.EzLog4j.log("itemValue>>>>>>>"+itemValue,"I");
						} else {
							itemValue	= (new  java.math.BigDecimal(price_NJ).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
							ezc.ezcommon.EzLog4j.log("itemValue>>>>>>>"+itemValue,"I");
						}
						// Handling Combo Item 
						if (!childComponentsLineNos.trim().equals("")) {
							itemValue = "0";
							// Current item is parent item. Get the condition values of children
							 String[] tempCompLineArray;
							 tempCompLineArray = childComponentsLineNos.split(";");

							for(int tmpl =0; tmpl < tempCompLineArray.length ; tmpl++)
							{
								// for EACH component line get the PN00 value by looping at condition table
								for(int crec=0;crec<retCond.getRowCount();crec++)
								{
									String condLineNo1 = retCond.getFieldValueString(crec,"ItmNumber");
									String condType1 = retCond.getFieldValueString(crec,"CondType");
									String tempSONum1 = retCond.getFieldValueString(crec,"DOC_NO");
									String condInActive1 = retCond.getFieldValueString(crec,"Condisacti");
									String condDesc1 = "";
									String condVal1 = "";

									if (((!"".equals(jobQuoteOrdId) && "ZJOB".equals(condType1)) || ("".equals(jobQuoteOrdId) && "PN00".equals(condType1))) && "".equals(condInActive1)){
										String itemPrice	= (new  java.math.BigDecimal(retCond.getFieldValueString(crec,"Condvalue")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
										priceCompHT.put(condLineNo1,itemPrice);
									}

									if(taxCond.get(condType1)!=null && !"null".equals(taxCond.get(condType1)))
									{
										condDesc1 = (String)taxCond.get(condType1);
									}
									ezc.ezcommon.EzLog4j.log("condVal1--above if >>>>>>>"+condVal1,"I");

									if(salesDocNo.equals(tempSONum1) && tempCompLineArray[tmpl].substring(0,6).equals(condLineNo1) 
									   && (("".equals(jobQuoteOrdId) && condType1.equals("PN00")) || (!"".equals(jobQuoteOrdId) && condType1.equals("ZJOB")) || condType1.equals("ZUSM") || condType1.equals("ZMPL"))
									   && "".equals(condInActive1))
									{
										// we found a matching/appropriate Net Value condition
										condVal1 = retCond.getFieldValueString(crec,"Condvalue");
									try
									{
										// set scale to 2, and then add this condition value to existing itemValue

										condVal1 = new java.math.BigDecimal(condVal1).setScale(3,java.math.BigDecimal.ROUND_HALF_UP).toString();
										ezc.ezcommon.EzLog4j.log("condVal1--in Try >>>>>>>"+condVal1,"I");

										java.math.BigDecimal condVal1BD = (new  java.math.BigDecimal(condVal1).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
										ezc.ezcommon.EzLog4j.log("condVal1BD--in Try >>>>>>>"+condVal1BD,"I");


										if (((!"".equals(jobQuoteOrdId) && condType1.equals("ZJOB")) || ("".equals(jobQuoteOrdId) && "PN00".equals(condType1))) && "".equals(condInActive1)) {

										// If component qty is a multiple of item qty, multiply condVal1 accordingly
										if (! retItems.getFieldValueString(i,"QTY").equals(tempCompLineArray[tmpl].substring(8)) ) {
											java.math.BigDecimal itemQtyBD = (new  java.math.BigDecimal(retItems.getFieldValueString(i,"QTY")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
											java.math.BigDecimal itemQtyCompBD = (new  java.math.BigDecimal(tempCompLineArray[tmpl].substring(7)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
											java.math.BigDecimal qtyMultipleBD = itemQtyCompBD.divide(itemQtyBD,3);
											condVal1BD = condVal1BD.multiply(qtyMultipleBD);			
											ezc.ezcommon.EzLog4j.log("condVal1BD--in if >>>>>>>"+condVal1BD,"I");
										}	
										// convert current itemValue to BD and then add condVal1BD to it
										ezc.ezcommon.EzLog4j.log("condVal1BD-- above  itemValueBD>>>>>>>"+condVal1BD,"I");

										java.math.BigDecimal itemValueBD = new java.math.BigDecimal(itemValue);
										itemValueBD = itemValueBD.add(condVal1BD);	

										ezc.ezcommon.EzLog4j.log("condVal1BD-- Below  itemValueBD>>>>>>>"+condVal1BD,"I");

										// set to two digits after Decimal for US
										itemValue = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
										ezc.ezcommon.EzLog4j.log("itemValue-- Final>>>>>>>"+itemValue,"I");

										} else {
											stdMultiplier = condVal1;
										}
									}
									catch(Exception e){}
									} // end of salesDocNo.equals(tempSONum1) && tempCompLineArray[tmpl].equals(condLineNo1)
								} // end of crec loop

							} // end of tmpl loop i.e for each component

						} // if it HAS a child component

						// SAP returned itemValue is ignored as per Sam's email on 7/27
						// Calculate Item Value to be displyed on UI as line sub total and to be added to UI subtotal at order level

						java.math.BigDecimal itemQty1 = (new  java.math.BigDecimal(retItems.getFieldValueString(i,"QTY")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
						java.math.BigDecimal itemValueBD = new java.math.BigDecimal(itemValue);
						itemNet = itemValue;
						itemValueBD = itemValueBD.multiply(itemQty1);			
						itemValue = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					} // end of if condition for ZJOB, PN00 and KUMU
				} // end of for condition table loop
			} // end of for item row loop

			if("0".equals(stdMultiplier)) {
				stdMultiplier = "" ;
			} else {
				java.math.BigDecimal centumBD = new java.math.BigDecimal(100);
				stdMultiplier = new java.math.BigDecimal(stdMultiplier).divide(centumBD,3,java.math.BigDecimal.ROUND_FLOOR).toString();
			};

			pricingCondTable = pricingCondTable+"</tbody></table>"; 
			String tempLineNo = "",tempSalesDocNumber = "";

			try
			{
				tempLineNo = (Long.parseLong(lineNo))+"";
			}
			catch(Exception e)
			{
				tempLineNo = lineNo;
			}

			try
			{
				tempSalesDocNumber = (Long.parseLong(salesDocNo))+"";
			}
			catch(Exception e)
			{
				tempSalesDocNumber = salesDocNo;
			}

			if("".equals(rejReason) && parentItem.equals("000000")) 
				// add the itemValue to total if line is NOT rejected AND if it is parent line
				// itemValue gets the KUMU condition for Parent Lines. This is specific to AS
				// In some cases $ value of parent may be applicable. Should change this code for client scenario
				totalItemsValue	= totalItemsValue.add(new  java.math.BigDecimal(itemValue));

			if(zztext == null || "null".equals(zztext))
				zztext = "";
			else
				zztext = zztext.trim();

			if(custMat == null || "null".equals(custMat)) custMat = "";

			try
			{
				totTax = totTax.add(new java.math.BigDecimal(itTax));
			}
			catch(Exception e){}

			try
			{
				if(price!=null && !"null".equals(price) && "0.00".equals(price.trim()))
				{
					double subtot = Double.parseDouble(itemValue);
					double subqty = Double.parseDouble(retItems.getFieldValueString(i,"QTY"));
					java.math.BigDecimal obj = new java.math.BigDecimal(subtot/subqty);
					price = obj.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)+"";;	
				}
			}
			catch(Exception e){price ="0.00"; }

			try
			{
				matno=String.valueOf(Long.parseLong(matno)); 
			}
			catch(Exception e){} 

			if(requireddate == null || "null".equals(requireddate) || requireddate.trim().length() >10) requireddate = "";
			totTax = totTax.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
%>
	<!-- ADD THE LINE ONLY IF IT IS A PARENT ITEM -->
		
<% 
			if ((parentItem!= null) && (parentItem.equalsIgnoreCase("000000"))) 
			{
				String pntspcs = "Pieces";
				if(cat_HM.equals(cust_mat35))// && ent==0)
				{
					pntspcs = "Pieces";
					ent++;
					if("Enamel Steel".equals(cust_mat35) || 
					   "Acrylux".equals(cust_mat35)      || 
					   "Chinaware".equals(cust_mat35)    || 
					   "Americast & Acrylics (Excludes Acrylux)".equals(cust_mat35) ||
					   "Marble".equals(cust_mat35)) 
						pntspcs="Points";

					if("Repair Parts".equals(cust_mat35) || "DXV Chinaware".equals(cust_mat35) || "DXV Faucets".equals(cust_mat35) ||
					   "DXV Furniture".equals(cust_mat35) || "DXV Tubs".equals(cust_mat35) || 
					   "DXV Sinks (Non-CW)".equals(cust_mat35) || "DXV Repair Parts".equals(cust_mat35))
						pntspcs="$";
			}
%>
			<tr style="background-color:white" id="linedatarow">

				<!-- *********************For Repeat Order --Starts ******************************* -->

				<input type='hidden' name='poItems' value='<%=salesDocNo+""+lineNo%>'>
				<input type='hidden' name='prodCode<%=salesDocNo+""+lineNo%>' value='<%=matno%>'>

				<input type='hidden' name='prodDesc<%=salesDocNo+""+lineNo%>' value='<%=itemDesc%>'>
				<input type='hidden' name='listPrice<%=salesDocNo+""+lineNo%>' value='<%=listPrice%>'>
				<input type='hidden' name='eanUpc<%=salesDocNo+""+lineNo%>' value='<%=eanUPC%>'>
				<input type='hidden' name='quantity<%=salesDocNo+""+lineNo%>' value='<%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%>'>

				<input type='hidden' name='salesOrderItems<%=salesDocNo+""+lineNo%>' value='<%=salesDocNo+"#"+lineNo%>'>

				<input type='hidden' name='orderType<%=salesDocNo+""+lineNo%>' value='<%=salesHdrDataArr[0]%>'>
				<input type='hidden' name='salesOrg<%=salesDocNo+""+lineNo%>' value='<%=salesHdrDataArr[1]%>'>
				<input type='hidden' name='division<%=salesDocNo+""+lineNo%>' value='<%=salesHdrDataArr[2]%>'>
				<input type='hidden' name='distChannel<%=salesDocNo+""+lineNo%>' value='<%=salesHdrDataArr[3]%>'>
				<input type='hidden' name='childComponents<%=salesDocNo+""+lineNo%>' id='childComponents<%=salesDocNo+""+lineNo%>' value='<%=childComponents%>'>

				<input type="hidden" name="retQty<%=salesDocNo+""+lineNo%>" id="retQty<%=salesDocNo+""+lineNo%>" value=<%=eliminateDecimals(shippedQty)%>></input>
				<input type="hidden" name="retMat<%=salesDocNo+""+lineNo%>" id="retMat<%=salesDocNo+""+lineNo%>" value=<%=matno%>></input>
				<input type="hidden" name="retMatNP<%=salesDocNo+""+lineNo%>" id="retMatNP<%=salesDocNo+""+lineNo%>" value=<%=itemNet%>></input>
				<input type="hidden" name="retInvNo<%=salesDocNo+""+lineNo%>" id="retInvNo<%=salesDocNo+""+lineNo%>" value=<%=findInvoiceNr(salesDocNo+""+lineNo,dlvNumSOItemHT,invNumSOItemHT,multipleInvoices)%>></input>

				<!-- *********************For Repeat Order -- Ends ******************************* -->

				<td width=10% align="center" id="socell"><div style="display:none" id="solineinfo"><%=strikeTextStartTag%><%=tempSalesDocNumber%>/<%=tempLineNo%><%="\n"%><%=strikeTextEndTag%></div><br>
		
<%
				String mainSTD="",mainLarge="",mainThumb="",dchstatus="";
				String showImages = (String)session.getValue("SHOWIMAGES");

				//Image and Brand of product

				EzcParams prodParamsMiscDWN = new EzcParams(false);
				EziMiscParams prodParamsDWN = new EziMiscParams();

				ReturnObjFromRetrieve prodDetailsRetObjDWN = null;

				prodParamsDWN.setIdenKey("MISC_SELECT");
				String queryDWN = "";

				queryDWN = "SELECT EZP_CURR_PRICE, EZP_BRAND,EZP_ATTR2,EZP_ATTR1,EZP_STATUS FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE = '"+matno+"'";

				prodParamsDWN.setQuery(queryDWN);

				prodParamsMiscDWN.setLocalStore("Y");
				prodParamsMiscDWN.setObject(prodParamsDWN);
				Session.prepareParams(prodParamsMiscDWN);	

				try
				{
					prodDetailsRetObjDWN = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscDWN);
				}
				catch(Exception e){}	

				int indSTD = 0, indLarge = 0,indThumb = 0;

				if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
				{
					listPriceOurDB = prodDetailsRetObjDWN.getFieldValueString(0,"EZP_CURR_PRICE");	
					brand = prodDetailsRetObjDWN.getFieldValueString(0,"EZP_BRAND");	
					mainSTD   = nullCheckBlank(prodDetailsRetObjDWN.getFieldValueString(0,"EZP_ATTR2"));
					dchstatus = nullCheckBlank(prodDetailsRetObjDWN.getFieldValueString(0,"EZP_STATUS"));			
				}

				if("Y".equals(showImages))
				{
%>		
					<img  src="<%=mainSTD%>" width="100" height"160"  alt="" />
<%
				}
%>		
				<p align="center"><%=brand%></p>
				<input type='hidden' name='prodtnurl<%=salesDocNo+""+lineNo%>' value='<%=mainSTD%>'>
				<input type='hidden' name='prodbrand<%=salesDocNo+""+lineNo%>' value='<%=brand%>'>

				</td>
				<td width=40%>

				<%=strikeTextStartTag%><%=itemDesc%>
				<br><strong>Product:&nbsp;</strong><a href="javascript:getProductDetails('<%=matno%>')" title="<%=itemDesc%>"><%=matno%>&nbsp;</a>
				<br><strong>UPC:&nbsp;</strong><%=eanUPC%><br>

				<%=strikeTextEndTag%>
				<div id=<%=salesDocNo+""+lineNo%> style='display: none'><%=parentItem%></div>
				<%=strikeTextStartTag%><strong>Ref:&nbsp;</strong><%=tempSalesDocNumber%>/<%=tempLineNo%><br>
				<div class="ITEMTEXT<%=tempSalesDocNumber+""+tempLineNo%>">
<% 
				if (!("".equals(lineItemText))) 
				{
%>
					<a class="fancybox" href="#ITEMTEXT<%=tempSalesDocNumber+""+tempLineNo%>"><span>Line Text</span></a>
<% 
				} else { ; }
%>
				</div>
				<div id="ITEMTEXT<%=tempSalesDocNumber+""+tempLineNo%>" style="width: 500px; display: none; ">
				<h2>Item Text for <%=salesDocNo%>/<%=tempLineNo%></h2>
				<br>
				<table class="data-table">
				<tr>
				<td><%=lineItemText%></td>
				</tr>
				</table>
				</div>

		<!-- Info for INTERNAL USER -->
<%
				if(!"CU".equals(userRole))
				{
					String tempDocType = salesHdrDataArr[0];

					if("TA".equals(tempDocType)) tempDocType = "OR";
					else if("KL".equals(tempDocType)) tempDocType = "FD";
%>		
					<strong>Doc Info </strong> <%=tempDocType%>/<%=salesHdrDataArr[1]%>/<%=salesHdrDataArr[3]%>/<%=salesHdrDataArr[2]%>/<%=retItems.getFieldValueString(i,"PLANT")%>
<% 
				}
				if (!custMat.equals("") && !custMat.equals("N/A")) 
				{
%>
					<br><strong>My SKU:&nbsp;</strong><%=custMat%>
<% 
				}
				if(!poItemNo.equals("") && !poItemNo.equals("N/A")) 
				{
%>
					<br><%=strikeTextStartTag%><strong>My PO Line:&nbsp;</strong><%=poItemNo%><%=strikeTextEndTag%>
<%
				}
%>
				</td>
<%
				boolean cancQsFaucetItem = true;

				if (jobQuoteOrdId.equals("")) 
				{ 
					if (salesHdrDataArr[0].equals("ZDPO") || salesHdrDataArr[0].equals("ZIDP")) {
						if (stdMultiplier.equals("0.100") || stdMultiplier.equals("0.250") || stdMultiplier.equals("0.10") || stdMultiplier.equals("0.25")){
							programType = "Display";
						}
						if (stdMultiplier.equals("0.350") || stdMultiplier.equals("0.35")){
							programType = "VIP";
						}
					}
					if (progSOItemHT!=null && progSOItemHT.containsKey(salesDocNo+""+lineNo)){
						programType = (String) progSOItemHT.get(salesDocNo+""+lineNo);
					}
					if(retHeader.getFieldValueString(0,"SHIP_COND")!=null && "ZQ".equals(retHeader.getFieldValueString(0,"SHIP_COND")))	//"Quick Ship Faucet".equals(programType)
					{
						programType = "Quick Ship";
						cancQsFaucetItem = false;
				}
%>
				<td width=7%><%=strikeTextStartTag%><strong></strong><%=programType%><%=strikeTextEndTag%></td>
<%
				} else 
				{
%>
					<td width=7%><%=strikeTextStartTag%><strong></strong><a href="javascript:funQuoteDetails('<%=jobQuoteOrdId%>','<%=customer%>')"><%=salesQuoteRef%></a><%=strikeTextEndTag%></td>
<%
				}; 
%>
				<td width=7% align="right">
				<div class="PRICE<%=tempSalesDocNumber+""+tempLineNo%>">
<%
				if(!"CU".equals(userRole))
				{
%>	
					<strong>NP:</strong><a class = "fancybox" href="#PRICE<%=tempSalesDocNumber+""+tempLineNo%>"><span>$<%=checkAuth(itemNet,"VIEW_PRICES",userAuth_R)%></span></a>
<%
				} else 
				{ 
%>
					<span><strong>NP:&nbsp;</strong>$<%=checkAuth(itemNet,"VIEW_PRICES",userAuth_R)%></span>
<% 
				}
%>	
				</div>
				<%=strikeTextStartTag%><strong>MULT:&nbsp;</strong><%=checkAuth(stdMultiplier,"VIEW_PRICES",userAuth_R)%><%=strikeTextEndTag%><br>
				<%=strikeTextStartTag%><strong>LP:&nbsp;</strong>$<%=new java.math.BigDecimal(listPriceOurDB).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString()%>
				<%=strikeTextEndTag%>

				<div id="PRICE<%=tempSalesDocNumber+""+tempLineNo%>" style="width:400px; display:none">
				<h2>Pricing Details for Order <%=tempSalesDocNumber%>, Line&nbsp;<%=tempLineNo%></h2>
				<h2>Product <%=itemDesc%></h2>
				<br>
				<%=checkAuth(pricingCondTable,"VIEW_PRICES",userAuth_R)%>
				</div>
				</td>

				<td width=8% align="right"><%=strikeTextStartTag%><strong>OQ:&nbsp;</strong><%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%><%=strikeTextEndTag%><br>
				<%=strikeTextStartTag%><strong>CQ:&nbsp;</strong><%=eliminateDecimals(confQty)%><br>
				<strong>EDelDt:&nbsp;</strong>
				<a class="fancybox" href="#CONFDATES<%=tempSalesDocNumber+""+tempLineNo%>"><span><%=confirmDates%></span></a>
				<%=strikeTextEndTag%>
				<div id="CONFDATES<%=tempSalesDocNumber+""+tempLineNo%>" style="width:400px; display:none">
				<h2> Expected Delivery Date(s)<br> Product:&nbsp;<%=matno%></h2>
				<br>
				<%=confirmDatesHTML%>
				<br>
				<h3 style="font-color:red">*These are expected Delivery Dates.  Actual delivery dates may vary</h3>
				</div>
				</td>

				<td width=8% align="right"><strong>SQ:&nbsp;</strong><%=strikeTextStartTag%><%=eliminateDecimals(shippedQty)%><%=strikeTextEndTag%>
				<div class="SHIPDATES<%=tempSalesDocNumber+""+tempLineNo%>">
				<strong>SDt:&nbsp;</strong><a class="fancybox" href="#SHIPDATES<%=tempSalesDocNumber+""+tempLineNo%>"><span><%=shippedDates%></span></a>
				</div>
				<div id="SHIPDATES<%=tempSalesDocNumber+""+tempLineNo%>" style="width:400px; display:none">
				<h2>ACTUAL SHIP DATES <br>Product:&nbsp;<%=matno%></h2>
				<br>
				<%=shippedDatesHTML%>
				<br>
				</div>
				</td>
<%
				Double iV = new Double(itemValue);
%>
				<td width=10% align="right"><%=strikeTextStartTag%><%=checkAuth(nf.format(iV),"VIEW_PRICES",userAuth_R)%><%=strikeTextEndTag%></td>
<%
				if("".equals(rejReason))
				{
					String trackURL = "", trackLogo="",carrDesc="";
					String shipper = (String) soLineShippingPartners.get(salesDocNo+""+lineNo);
					trackingNumber = (String) soLineTrackingNumbers.get(salesDocNo+""+lineNo);
					dlvBolNumber = (String) soLineBolNumbers.get(salesDocNo+""+lineNo);

					if (shipper!= null) 
					{
						carrDesc =  shipper;
						if(carrierLogoValMapRetObj!=null)
						{
							for(int a=0;a<carrierLogoValMapRetObj.getRowCount();a++)
							{
								if (carrierLogoValMapRetObj.getFieldValueString(a,"VALUE1").equals(shipper)){
									trackLogo = carrierLogoValMapRetObj.getFieldValueString(a,"VALUE2");
									break;
								}
							}
						}	
						if(carrierDescValMapRetObj!=null)
						{
							for(int a=0;a<carrierDescValMapRetObj.getRowCount();a++)
							{
								if (carrierDescValMapRetObj.getFieldValueString(a,"VALUE1").equals(shipper)){
									carrDesc = carrierDescValMapRetObj.getFieldValueString(a,"VALUE2");
									break;
								}
							}
						}	
					}
%>		
				<td width=10% align="right">
					<input type="hidden" name="retQtyHRGA<%=salesDocNo+""+lineNo%>" id="retQtyHRGA<%=salesDocNo+""+lineNo%>" value=""></input>
					<input type="hidden" name="retMatHRGA<%=salesDocNo+""+lineNo%>" id="retMatHRGA<%=salesDocNo+""+lineNo%>" value=""></input>
					<input type="hidden" name="retRGAComp<%=salesDocNo+""+lineNo%>" id="retRGAComp<%=salesDocNo+""+lineNo%>" value=""></input>

				<div id='RGA<%=salesDocNo+""+lineNo%>' style="display:none">
					<h3> CONFIRM RETURN DETAILS FOR <%=itemDesc%></h3>
<% 
				if (!childComponentsLineNos.trim().equals("")) 
				{
%>
					<p> This Item is sold as Individual Components. Please specific return Quantity for each Component separately. </p>
<%
				}
%>
				<table class="data-table">
				<tr>
<%
				if (!childComponentsLineNos.trim().equals("")) 
				{
%>
					<th>&nbsp;</th>
<%
				}
%>
				<th>Ordered Material</th>
				<th>Returned Material</th>
				<th>Net Price[USD]</th>
				<th>Order Qty</th>
				<th>Ship Qty</th>
				<th>Return Qty</th></tr>
<%
				String itemType = "P";
				int itemTypeCnt = 1;
				if (!childComponentsLineNos.trim().equals("")) 
				{ 
					String[] compLines = delimitedChildComponents.split("#");
					itemType = "C";
					itemTypeCnt = compLines.length;

					for (int ccL=0;ccL<compLines.length;ccL++) 
					{
						String[] compLinesQtySplit = compLines[ccL].split(":");

						String itemLineNo = compLinesQtySplit[2];
						itemNet = (String)priceCompHT.get(itemLineNo);
						String itemCompDesc = compLinesQtySplit[3];
						itemCompDesc = itemCompDesc.replaceAll("\"","``");
%>
						<tr>
						<td><input type="checkbox" name="matChkComp<%=salesDocNo+""+lineNo+""+ccL%>" id="matChkComp<%=salesDocNo+""+lineNo+""+ccL%>" value="<%=salesDocNo+""+itemLineNo%>" checked></input></td>
						<td><%=compLinesQtySplit[0]%></td>
						<td><input type="text" name="retMatRGA<%=salesDocNo+""+itemLineNo%>" id="retMatRGA<%=salesDocNo+""+itemLineNo%>" value=<%=compLinesQtySplit[0]%>></input></td>
						<td>$<%=checkAuth(itemNet,"VIEW_PRICES",userAuth_R)%><br>Invoice:<%=findInvoiceNr(salesDocNo+""+itemLineNo,dlvNumSOItemHT,invNumSOItemHT,multipleInvoices)%></td>
						<td><%=eliminateDecimals(compLinesQtySplit[1])%></td>
						<td><%=eliminateDecimals(compLinesQtySplit[4])%></td>
						<td><input type="text" name="retQtyRGA<%=salesDocNo+""+itemLineNo%>" id="retQtyRGA<%=salesDocNo+""+itemLineNo%>" value=<%=eliminateDecimals(compLinesQtySplit[4])%>></input>
						<input type="hidden" name="retQtyComp<%=salesDocNo+""+itemLineNo%>" id="retQtyComp<%=salesDocNo+""+itemLineNo%>" value=<%=eliminateDecimals(compLinesQtySplit[4])%>></input>
						<input type="hidden" name="retPriceComp<%=salesDocNo+""+itemLineNo%>" id="retPriceComp<%=salesDocNo+""+itemLineNo%>" value=<%=itemNet%>></input>
						<input type="hidden" name="retDescComp<%=salesDocNo+""+itemLineNo%>" id="retDescComp<%=salesDocNo+""+itemLineNo%>" value="<%=itemCompDesc%>"></input>
						<input type="hidden" name="retMatComp<%=salesDocNo+""+itemLineNo%>" id="retMatComp<%=salesDocNo+""+itemLineNo%>" value="<%=compLinesQtySplit[0]%>"></input>
						<input type="hidden" name="parentMat<%=salesDocNo+""+itemLineNo%>" id="parentMat<%=salesDocNo+""+itemLineNo%>" value="<%=matno%>"></input></td>
						</tr>
<%
				}; 
				} else 
				{
%>
					<tr>
					<td><%=matno%></td>
					<td><input type="text" id="retMatRGA<%=salesDocNo+""+lineNo%>" name="retMatRGA<%=salesDocNo+""+lineNo%>" value=<%=matno%>></input></td>
					<td>$<%=checkAuth(itemNet,"VIEW_PRICES",userAuth_R)%><br>Invoice:<%=findInvoiceNr(salesDocNo+""+lineNo,dlvNumSOItemHT,invNumSOItemHT,multipleInvoices)%></td>
					<td><%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%></td>
					<td><%=eliminateDecimals(shippedQty)%></td>
					<td><input type="text" id="retQtyRGA<%=salesDocNo+""+lineNo%>" name="retQtyRGA<%=salesDocNo+""+lineNo%>" value=<%=eliminateDecimals(shippedQty)%>></input></td>
					</tr>
<%
				}
%>
				</table>
				<br>
				<input type="hidden" name="itemType<%=salesDocNo+""+lineNo%>" id="itemType<%=salesDocNo+""+lineNo%>" value="<%=itemType%>">
				<input type="hidden" name="itemTypeCnt<%=salesDocNo+""+lineNo%>" id="itemTypeCnt<%=salesDocNo+""+lineNo%>" value="<%=itemTypeCnt%>">
				<div id="divAction" style="display:block;float:left">
				<button type="button" title="SaveClose" class="button" onclick="javascript:funSaveRGAData('<%=salesDocNo+""+lineNo%>')">Save and Close</button>		
				</div>
			</div>

			<br>
			<div class="noprint">
			<ul id="navbar">
				<li><a href="javascript:void()')"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'><span class="arrow"></span></a>
				<ul>
<%
				if (((dlvBolNumber != null) && (!"".equals(dlvBolNumber))) || ((trackingNumber != null) && (!"".equals(trackingNumber)))) 
				{ 
					String trUrl = prot+"//"+myServer+"/"+myApp+"/EzComm/EzSales/Sales/JSPs/Sales/ezTrackPackage.jsp?trackingNumber="+trackingNumber+"&shippingPartner="+shipper+"&dlvBolNumber="+dlvBolNumber+"&salesDocNo="+salesDocNo+"&lineNo="+lineNo+"&PurchaseOrder="+poNum+"&CarrierDesc="+carrDesc.replaceAll("&"," ");
					String encodedurl = "";
					URL url = new URL(trUrl); 
					try
					{
						encodedurl = URLEncoder.encode(url.toString(),"UTF-8"); 
					}catch(Exception e){out.println(e);}
					try
					{
						if("".equals(carrDesc))
							carrDesc = "TRACK";
						else
							carrDesc = carrDesc.substring(0, java.lang.Math.min(carrDesc.length(), 12));
					}
					catch(Exception e){carrDesc = "TRACK";}
%>
				<li>
					<a id="getMultiTrack" class="fancyframe" href='<%=trUrl%>'><span><%=carrDesc.substring(0, java.lang.Math.min(carrDesc.length(), 12))%></span></a>
				</li>
<%
				}
				if (!eliminateDecimals(shippedQty).equals("0")) 
				{
%>
					<li><a href="javascript:callFunLineDel('DLV','<%=salesDocNo%>','<%=lineNo%>','<%=poNum%>')">ASN</a></li>
					<li><a href="javascript:callFunInv('INV','<%=salesDocNo%>','<%=poNum%>')">Invoice</a></li>
<% 
				}
				String cancelType= "";
				if (cancReqCreated) 
				{
					String crNo = (String)cancReqSOItemHT.get(salesDocNo+""+lineNo);	
					crNo = crNo.substring(0,crNo.indexOf("/"));
%>			
					<li id='VIEW_CRBUTTON<%=salesDocNo+""+lineNo%>'><a href="javascript:funviewCR('<%=crNo%>')">View Canc. Request</a></li>
<%				}
				else if (retReqCreated) 
				{
					String rrNo = (String)retReqSOItemHT.get(salesDocNo+""+lineNo);	
					rrNo = rrNo.substring(0,rrNo.indexOf("/"));
%>
					<li id='VIEW_RRBUTTON<%=salesDocNo+""+lineNo%>'><a href="javascript:funviewRR('<%=rrNo%>')">View Return Request</a></li>
<%
				} 
				else if(dlvCreated && pgiCreated && !retReqCreated)
				{
					cancelType = "RGA";
%>
					<li id='RGA_BUTTON<%=salesDocNo+""+lineNo%>'>
						<a class="fancyboxRGA" href="#RGA<%=salesDocNo+""+lineNo%>" >Request RGA</a><!--onClick="javascript:funRGARequest('<%=salesDocNo+""+lineNo%>')"-->
					</li>
<%
				}
				else if(dlvExists && !cancReqCreated && cancQsFaucetItem)
				{
					cancelType = "RC";
%>
					<li id='CANC_BUTTON<%=salesDocNo+""+lineNo%>'><a href="javascript:funCancel('<%=salesDocNo+""+lineNo%>')">Request Cancel</a></li>
<%
				}
				else if(!dlvExists && !pgiCreated && !cancReqCreated && poCreated && cancQsFaucetItem)
				{
					cancelType = "RC";
%>
					<li id='CANC_BUTTON<%=salesDocNo+""+lineNo%>'><a href="javascript:funCancel('<%=salesDocNo+""+lineNo%>')">Request Cancel</a></li>
<%
				} 
				else if("ZCUS".equals(salesHdrDataArr[0].trim()) && cancQsFaucetItem)
				{
					cancelType = "RC";
%>
					<li id='CANC_BUTTON<%=salesDocNo+""+lineNo%>'><a href="javascript:funCancel('<%=salesDocNo+""+lineNo%>')">Request Cancel</a></li>
<%
				}
				else if(plantsVect.contains(retItems.getFieldValueString(i,"PLANT")) && !dlvCreated && !pgiCreated && !cancReqCreated && cancQsFaucetItem)
				{
					cancelType = "RC";
%>
					<li id='CANC_BUTTON<%=salesDocNo+""+lineNo%>'><a href="javascript:funCancel('<%=salesDocNo+""+lineNo%>')">Request Cancel</a></li>
<%
				} else 
				{
					if(cancQsFaucetItem)
					{
						cancelType = "C";
%> 
						<li id='CANC_BUTTON<%=salesDocNo+""+lineNo%>'><a href="javascript:funCancel('<%=salesDocNo+""+lineNo%>')">Cancel</a></li>
<%
					}
				}	
%>
				<input type='hidden' name='cancelType<%=salesDocNo+""+lineNo%>' value='<%=cancelType%>'>
				<input type='hidden' name='selForCancaellation<%=salesDocNo+""+lineNo%>' value='N'>
			</ul> <!-- end of Action Nav Menu Options area-->
			</li>
		</ul> <!-- end of Action Nav Menu -->
		</div> <!-- no print for Actions Menu -->
<%
			if (cancReqCreated) 
			{
%>
				<div id='CancReqExists' ><font color='RED'>Cancellation Requested </font></div>
				<div id='CRP<%=salesDocNo+""+lineNo%>' style='visibility:hidden'>CRP</div>
<%
			}
			if (retReqCreated) 
			{
%>
				<div id='RetReqExists' ><font color='RED'>RGA Requested </font></div>
<%
			}
			if (eliminateDecimals(retItems.getFieldValueString(i,"QTY")).equals(eliminateDecimals(shippedQty))) 
			{
%>
				<div id='lineStatus' style='visibility:hidden'><font color='RED'>Shipped </font></div>
<% 
			} 
			else 
			{ 
				if (!eliminateDecimals(shippedQty).equals("0")) 
				{
%>
					<div id='lineStatus' style='visibility:hidden'><font color='RED'>Partial </font></div>
<%
				}
			}
			if (eliminateDecimals(shippedQty).equals("0")) 
			{
%>
				<div id='lineStatus' style='visibility:hidden'><font color='RED'>Open</font></div>
<%
			}
%>
			<div id='CANC_MSG<%=salesDocNo+""+lineNo%>' style='visibility:hidden'> <Font color='RED'><b>Selected for Cancellation (Step 1 of 2)</b></Font></div>
			<div id='RGA_MSG<%=salesDocNo+""+lineNo%>' style='visibility:hidden'> <a href = "#RGA<%=salesDocNo+""+lineNo%>" class='fancybox'><Font color='RED'><b>Selected for RGA <br>(Step 1 of 2)</b></Font></a></div>
			</td>
<%
			}
			else
			{
%>
				<input type='hidden' name='selForCancaellation<%=salesDocNo+""+lineNo%>' value='C'>
				<td width=10% align="right">Cancelled
				<div class="ITEMCANCTEXT<%=tempSalesDocNumber+""+tempLineNo%>">
<%
				if (!("".equals(lineCancItemText))) 
				{
%>
					<a class="fancybox" href="#ITEMCANCTEXT<%=tempSalesDocNumber+""+tempLineNo%>"><span>Cancellation Info</span></a>
<%
				} else{ ; }
%>
				</div>
				<div id="ITEMCANCTEXT<%=tempSalesDocNumber+""+tempLineNo%>" style="width: 500px; display: none; ">
				<h2>Cancellation Info for <%=salesDocNo%>/<%=tempLineNo%></h2>
				<br>
				<table class="data-table">
				<tr>
				<td><%=lineCancItemText%></td>
				</tr>
				</table>
				</div>
				</td>
<%
			}
%>
			<td width="1%"><%=cust_mat35%></td>
			<td width="1%"><%=salesDocNo%></td>
			<td width="1%"><%=poItemNo%></td>
<%
			if (pntspcs.equals("$")) 
			{
%>
				<td id="pointsgroup" ><%=cust_mat35%>:<%=pntspcs%><%=(String)catalogHM.get(cust_mat35)%></td>
<% 		
			}
			else { 
%>
				<td id="pointsgroup" ><%=cust_mat35%>:<%=(String)catalogHM.get(cust_mat35)%>&nbsp;<%=pntspcs%></td>
<% 
			}
%>
		</tr>
<% 
			} //END OF if  parentItem condition 
		}
	}
%>
	</tbody>
	<tfoot>
			<tr>
				<td colspan="7" align="right"><h3>&nbsp;Order Sub Total</h3></td>
<%
				Double tiV = new Double(totalItemsValue.doubleValue());
%>
				<td align="right" colspan="3"><%=checkAuth(nf.format(tiV),"VIEW_PRICES",userAuth_R)%></td>
			</tr>
			<tr>
<% 	
				// Now add Freight from Deliveries to freightTotal
			       freightTotal = freightTotal.add(freightTotalDel); 
%>
				<td colspan="7" align="right"><h3>&nbsp;Shipping and Handling&nbsp;(&nbsp;Additional Shipping Charges may be added at the time of Shipment&nbsp;)</h3></td>
<%
				if (freightTotal.toString().equals("0.00")) 
				{
%>
					<td align="right" colspan="3">$<%=checkAuth(freightTotal.toString(),"VIEW_PRICES",userAuth_R)%></td>
<%
				} else 
				{
%>
					<td align="right" colspan="3"><a class = "fancybox" href="#FREIGHT">$<%=checkAuth(freightTotal.toString(),"VIEW_PRICES",userAuth_R)%></a></td>
<% 
					pricingCondTableFreightDiv = pricingCondTableFreightDiv+"<div class=\"b\">"+"<div class=\"c1\">&nbsp;&nbsp;</div>"+"<div class=\"c1\">&nbsp;&nbsp;</div>"+"<div class=\"c1\">&nbsp;<strong>Freight Total</strong>&nbsp;</div>"+"<div class=\"c1\">&nbsp;-&nbsp;</div>"+"<div class=\"c1\" style=\"text-align:right\">&nbsp;<strong>$"+freightTotal+"&nbsp;</strong></div></div>";
					pricingCondTableFreightDiv = pricingCondTableFreightDiv+"</div>";
					if (!delivStatus.equals("CLOSED"))
						pricingCondTableFreightDiv+="<br>Additional Freight will be added during time of shipment."; 
%>
					<div id="FREIGHT" style="width:500px; display:none">
					<h2>Freight Details for PO <%=poNum%></h2>
					<br>
					<%=pricingCondTableFreightDiv%>
					</div>
<%
				}
%>
			</tr>
<%
				grandTotal = grandTotal.add(totalItemsValue);
				grandTotal = grandTotal.add(freightTotal);
%>  
			<tr>
				<td colspan="7" align="right"><h3>&nbsp;Grand Total</h3></td>
				<% Double gT = new Double(grandTotal.doubleValue()); %>
				<td align="right" colspan="3"><%=checkAuth(nf.format(gT),"VIEW_PRICES",userAuth_R)%></td> <!-- was poValueFromList -->
				<input type="hidden" name='tGTotVal' value='<%=grandTotal%>'>
			</tr>
	</tfoot>
	</table>
	<br>
	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
<% 	
	log4j.log("To pull SO Details END of ezOpenOrderDetails>>>"+salesOrder,"F");
	long finish_D0 = System.currentTimeMillis();
	log4j.log("To pull SO Details TOTAL ELAPSED TIME>>>"+(finish_D0-start_D0)/1000,"F");
%>
</Form>
<div id="ajaxAllTrack" style="width:1000px;height:500px;display:none;overflow-x: hidden">
<div align=center  style="padding-top:100px;">
		<ul>
			<li>&nbsp;</li>
			<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
			<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
		</ul>
	</div>

</div>

<script>
var xmlhttpTrack

function loadAllTrack(url)
{

	 xmlhttpTrack=GetXmlHttpObjectTrack();

	 if (xmlhttpTrack==null)
	 {
	   //alert ("Your browser does not support Ajax HTTP");
	   $( "#dialog-notsup" ).dialog('open');
	   return;
	  }
	   			
 	 document.getElementById("getMultiTrack").href="#ajaxAllTrack";
	 document.getElementById("getMultiTrack").class = "fancybox";
	
		var inittext = "<div align=center  style=\"padding-top:100px;\"> " +
				"<ul>" +
				"<li></li>" +
				"<li><img src=\"../../Library/images/loading.gif\" width=\"100\" height=\"100\" alt=\"\"></li>"+
				"<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>"+
				"</ul></div>";
		document.getElementById("ajaxAllTrack").innerHTML=inittext;
	
       xmlhttpTrack.onreadystatechange=getOutputTrack;
       xmlhttpTrack.open("GET",url,true);
       xmlhttpTrack.send(null);

}

function getOutputTrack()
{

  if (xmlhttpTrack.readyState==4)
  {
	
  	document.getElementById("ajaxAllTrack").innerHTML=xmlhttpTrack.responseText;
  }
}

function GetXmlHttpObjectTrack()
{
    if (window.XMLHttpRequest)
    {
       return new XMLHttpRequest();
    }
    if (window.ActiveXObject)
    {
      return new ActiveXObject("Microsoft.XMLHTTP");
    }
 return null;
}


</script>
<script type="text/javascript">
	function fnFeaturesInit ()
	{
		/* Not particularly modular this - but does nicely :-) */
		$('ul.limit_length>li').each( function(i) {
			if ( i > 10 ) {
				this.style.display = 'none';
			}
		} );

		$('ul.limit_length').append( '<li class="css_link">Show more<\/li>' );
		$('ul.limit_length li.css_link').click( function () {
			$('ul.limit_length li').each( function(i) {
				if ( i > 5 ) {
					this.style.display = 'list-item';
				}
			} );
			$('ul.limit_length li.css_link').css( 'display', 'none' );
		} );
	}
	
/* Formating function for row details */
function fnFormatDetails ( oTable, nTr , detailLines )
{
    var aData = oTable.fnGetData( nTr ); // get the row 
    var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
    var soNum = aData[1].substring(aData[1].indexOf('>')+1,aData[1].indexOf('/')); //SONum is in a hidden div tag, so take content after div tag
    var soLine = aData[1].substring(aData[1].indexOf('/')+1,aData[1].indexOf('\n'));
    var str = '' + soNum;
    while (str.length < 10) {
            str = '0' + str;
    }
    soNum = str;
    var str2 = '' + soLine;
    while (str2.length < 6) {
            str2 = '0' + str2;
    }
    soLine = str2;
    var ccompName = 'childComponents'+soNum+soLine+'';
    if ($(document.getElementById(ccompName)).val()!=""){
    
    
    sOut += '<tr><td>This Item is Shipped as following Components:</td><td>'+$(document.getElementById(ccompName)).val()+'</td></tr>';
    sOut += '</table>';
    } else {
    sOut += '<tr><td>No Components for this item</td>'+'</tr>';
    sOut += '</table>';
    }
    return sOut;
}



	$(document).ready( function() {
            
	    fnFeaturesInit();
		 /*
		  * Insert a 'details' column to the table
		  */
	    var nCloneTh = document.createElement( 'th' );
	    var nCloneTd = document.createElement( 'td' );
	    var nCloneTd2 = document.createElement( 'td' );
	    
	    nCloneTd.innerHTML = '<img src="../../Library/images/details_open.png" id="openimg" name="openimg">';
	    
	    var nCloneTdEmpty = document.createElement( 'td' );
	    nCloneTdEmpty.innerHTML = '<p></p>';
	
	   
	    $('#solines tbody tr').each( function () {
	    	var vCol0 = $(this).find('#solineinfo:first').text();
	    	
	    	if (vCol0 !="") {
	    	var soNum = vCol0.substring(0,vCol0.indexOf('/'));
		var soLine = vCol0.substring(vCol0.indexOf('/')+1,vCol0.indexOf('\n'));

		if (soNum != "") {
		var str = '' + soNum;
		while (str.length < 10) {
		    str = '0' + str;
		} 
		}// soNum blank check
		soNum = str;
		if (soLine != "") {
		var str2 = '' + soLine;
		while (str2.length < 6) {
		     str2 = '0' + str2;
		}
		soLine = str2;
		} // soLine blank check
		var ccompName = 'childComponents'+soNum+soLine+'';
		
		if ($(document.getElementById(ccompName)).val()!=""){
			this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
		} else {
			this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
		};
		
		} // end vCol0
		else
		{
			var vPointsGroup = $(this).find('#pointsgroup').text();	
			if (vPointsGroup != ""){
				this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
			}
		}// end else vCol0
	    } );

	    $(".fancybox").fancybox({closeBtn:true});
	    $(".fancyboxRGA").fancybox(
	    	{ closeBtn:true,
	          beforeLoad : function() {
			return true;
			}
	    });
	    $('.fancyframe').fancybox({
	     type:'iframe',
	      closeBtn:true,
	      autoSize:false,
	      width:510,
	      height:390,
	      scrolling:'No'
	      });


	    var oTable = $('#solines').dataTable( {
	    
	     "fnDrawCallback": function ( oSettings ) {
		if ( oSettings.aiDisplay.length == 0 )
		{
		    return;
		}
		
		var nTrs = $('#solines tbody tr#linedatarow');
		var iColspan = nTrs[0].getElementsByTagName('td').length;
		var sLastGroup = "";
		for ( var i=0 ; i<nTrs.length ; i++ )
		{
		    var iDisplayIndex = oSettings._iDisplayStart + i;
		    var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[9];
		    var sGroupPoint = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[12];
		    // THIS CODE ASSUMES THAT 9th Column carries the custmat35 which is hidden info.
		    // Also column 12 has the value of points
		    if ( sGroup != sLastGroup )
		    {
			var nGroup = document.createElement( 'tr' );
			var nCell = document.createElement( 'td' );
			nCell.colSpan = iColspan;
			nCell.className = "group";
			nCell.innerHTML = sGroupPoint;
			nGroup.appendChild( nCell );
			nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
			sLastGroup = sGroup;
		    }
		}
		
        	}, // end of fnDrawCallback
	    	"bJQueryUI": true,
		"bSort" : true,
		"iDisplayLength": 200,
		"bPaginate":false,
		"bProcessing":true,
		"oLanguage": { "sSearch": "Search Product Information Column" } ,
		"aoColumnDefs": [ 
		      { "bVisible": false, "aTargets": [ 9 ,10,11,12] },
		      { "bSortable": false, "aTargets": [ 0,1,2,3,4,5,6,7,8,9 ] },
		      { "bSearchable":false,"aTargets":[ 0,1,3,4,5,6,7,9 ]}
                    ],
	    	"sDom": '<"H"Tfr>t<"F"ip>',
		"oTableTools": {
			"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.4/swf/copy_csv_xls_pdf.swf",
			"sInfo":"Use Browser Print and press Esc. When done",
			"aButtons": [
					{
					    "sExtends":    "print",
					    "sButtonText": "",
					    "mColumns": [0,1,2],
					    "sMessage": "<%//=dummyHeader%>",
					}
			]
		}

                  
	    });
	    oTable.fnSortListener( document.getElementById('solinesort'), 11 );
	    oTable.fnSortListener( document.getElementById('pricegroupsort'), 12 );
	    $('#print').click(function (event) {
	    	window.print();
	   });
	    $('#allines').click(function (event) {
	    	
	    	$(this).css("color","#6C3");
	    	$('#canceled').css("color","white");
	    	$('#openlines').css("color","white");
	    	$('#partship').css("color","white");
	    	$('#CRP').css("color","white");
	    	$('#RGA').css("color","white");
	    	$('#shipped').css("color","white");
	    	oTable.fnFilter("",8,false);
	    });
	    $('#canceled').click(function (event) {
	    	$(this).css("color","#6C3");
	    	$('#allines').css("color","white");
	    	$('#openlines').css("color","white");
	    	$('#partship').css("color","white");
	    	$('#CRP').css("color","white");
	    	$('#RGA').css("color","white");
	    	$('#shipped').css("color","white");
    		oTable.fnFilter('Cancelled',8,false);
	    });
	    $('#openlines').click(function (event) {
	    	$(this).css("color","#6C3");
	    	$('#allines').css("color","white");
	    	$('#canceled').css("color","white");
	    	$('#partship').css("color","white");
	    	$('#CRP').css("color","white");
	    	$('#RGA').css("color","white");
	    	$('#shipped').css("color","white");
      	    	oTable.fnFilter('Open',8,false);
	    });
	    $('#partship').click(function (event) {
	    	$(this).css("color","#6C3");
	    	$('#allines').css("color","white");
	    	$('#canceled').css("color","white");
	    	$('#openlines').css("color","white");
	    	$('#CRP').css("color","white");
	    	$('#RGA').css("color","white");
	    	$('#shipped').css("color","white");
	    	oTable.fnFilter('Partial',8,false);
	    });
	    $('#shipped').click(function (event) {
	    	$(this).css("color","#6C3");
	    	$('#allines').css("color","white");
	    	$('#canceled').css("color","white");
	    	$('#openlines').css("color","white");
	    	$('#partship').css("color","white");
	    	$('#CRP').css("color","white");
	    	$('#RGA').css("color","white");
        	 oTable.fnFilter('Shipped',8,false);
	    });
	    $('#CRP').click(function (event) {
	    	$(this).css("color","#6C3");
	    	$('#allines').css("color","white");
	    	$('#canceled').css("color","white");
	    	$('#openlines').css("color","white");
	    	$('#partship').css("color","white");
	    	$('#shipped').css("color","white");
	    	$('#RGA').css("color","white");
	    	oTable.fnFilter("CRP",8,false);
	    });
	    $('#RGA').click(function (event) {
	    	$(this).css("color","#6C3");
	    	$('#allines').css("color","white");
	    	$('#canceled').css("color","white");
	    	$('#openlines').css("color","white");
	    	$('#partship').css("color","white");
	    	$('#CRP').css("color","white");
	    	$('#shipped').css("color","white");
	    	oTable.fnFilter("RGA Requested",8,false);
	    });
	
	 /* Add event listener for opening and closing details
	     * Note that the indicator for showing which row is open is not controlled by DataTables,
	     * rather it is done here
	     */
	    $('#openimg').live('click', function () {
	        var nTr = $(this).parents('tr')[0];
	        if ( oTable.fnIsOpen(nTr) )
	        {
	            /* This row is already open - close it */
	            this.src = "../../Library/images/details_open.png";
	            
	            oTable.fnClose( nTr );
	        }
	        else
	        {
	            /* Open this row */
	            this.src = "../../Library/images/details_close.png";
	            
	            oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr, 'hello123'), 'details' );
	        }
    	      } );
    	      
		Popup.hide('modal');

	} );
</script>
	
<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};
});
</script>

<script>
  $(document).ready(function(){
    $("#solines_filter").addClass("noprint");
  });
</script>
<%
	String OrdPrint = request.getParameter("OrdPrint");
	if(OrdPrint!=null && "Y".equals(OrdPrint))
	{
%>
		<script>print();</script>
<%
	}
%>
<%!
	public String findInvoiceNr(String str,Hashtable dlvNumSOItemHT,Hashtable invNumSOItemHT,boolean multipleInvoices)
	{
		String invNo = "No Invoice yet";
		if (dlvNumSOItemHT.containsKey(str)){
			String dlvNoString = (String) dlvNumSOItemHT.get(str);
			String[] dlvSplit = dlvNoString.split("/");
			if (invNumSOItemHT.containsKey(dlvSplit[0]+""+dlvSplit[1])) {
				invNo = (String) invNumSOItemHT.get(dlvSplit[0]+""+dlvSplit[1]);
				if (multipleInvoices && invNo != null){
					String[] invNoSplit = invNo.split("/");
					invNo = invNoSplit[0]+"*/"+invNoSplit[1]; 
				}
			}
		}
		return invNo;
	}	
	public String checkAuth(String str,String authKey,ezc.record.util.EzOrderedDictionary userAuth_R)
	{
		String authMess = str;
		if(!userAuth_R.containsKey(authKey)){
			authMess = "Not Authorized";
		}
		return authMess;
	}
	public String noImageCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret) || "N/A".equals(ret))
			ret = "../../Images/noimage.gif";
		return ret;
	}
%>
