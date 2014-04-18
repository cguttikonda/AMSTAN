<Html>
<Head>
<Script>
	function callFun(type,soNum,poNum)
	{
		document.myForm.SalesOrder.value = soNum;
		document.myForm.PurchaseOrder.value = poNum;
		
		if(type=='INV')
			document.myForm.action="../Invoices/ezSOInvoiceList.jsp";
			
		if(type=='DLV')
			document.myForm.action="../Deliveries/ezSODeliveriesList.jsp";	

		if(type=='PRINT')
			document.myForm.action="../Sales/ezSOPrint.jsp";	
						
			
		document.myForm.submit();
	}
	
	function callFunInv(type,soNum,poNum)
	{
		document.myForm.SalesOrder.value = soNum;
		document.myForm.PurchaseOrder.value = poNum;

		if(type=='INV')
			document.myForm.action="../Invoices/ezSOInvoiceList.jsp";

		if(type=='DLV')
			document.myForm.action="../Deliveries/ezSODeliveriesList.jsp";	
		if(type=='PRINT')
			document.myForm.action="ezSOPrint.jsp";			

		document.myForm.submit();
	}

	function funQuoteDetails(ordNum,customer)
	{
		document.myForm.salDoc.value = ordNum;
		document.myForm.soldTo.value = customer;
		document.myForm.action="../Quotes/ezJobQuoteDetails.jsp";
		document.myForm.submit();
	}
	function getProductDetails(code)
	{
		document.myForm.prodCode_D.value=code;

		document.myForm.action="../Catalog/ezProductDetails.jsp";
		document.myForm.submit();
	}
	function funBack()
	{
		history.go(-1)
	}
	
	function funReOrder()
	{
		document.myForm.action="../ShoppingCart/ezAddCartRepeatOrder.jsp";
		document.myForm.submit();
	}
	
	function funCancel(canItemId)
	{
		eval(document.getElementById("CANC_MSG"+canItemId)).style.visibility = 'visible';
		eval(document.getElementById("CANC_BUTTON"+canItemId)).style.visibility = 'hidden';
		
		(eval("document.myForm.selForCancaellation"+canItemId)).value = 'Y';
	}
	
	function funCancelSelItems(poNum)
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
		
	
		document.myForm.action="ezSOItemsCancConfirmMain.jsp";
		document.myForm.submit();
	}
	
	function funCancelAllItems(poNum)
	{
		document.myForm.PurchaseOrder.value = poNum;
		document.myForm.CancelAllItems.value = 'Y';


		document.myForm.action="ezSOItemsCancConfirmMain.jsp";
		document.myForm.submit();
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

<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.rowGrouping.js"></script> 
<!-- <script type="text/javascript" src="../../Library/Script/TableTools-2.0.3/js/TableTools.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.0.3/js/ZeroClipboard.js"></script>  -->

<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
 


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
	$(document).ready(function() {
	    oTable = $('#example').dataTable({
	        "fnDrawCallback": function ( oSettings ) {
	            if ( oSettings.aiDisplay.length == 0 )
	            {
	                return;
	            }
	             
	            var nTrs = $('#example tbody tr');
	            var iColspan = nTrs[0].getElementsByTagName('td').length;
	            var sLastGroup = "";
	            for ( var i=0 ; i<nTrs.length ; i++ )
	            {
	                var iDisplayIndex = oSettings._iDisplayStart + i;
	                var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[0];
	                if ( sGroup != sLastGroup )
	                {
	                    var nGroup = document.createElement( 'tr' );
	                    var nCell = document.createElement( 'td' );
	                    nCell.colSpan = iColspan;
	                    nCell.className = "group";
	                    nCell.innerHTML = sGroup;
	                    nGroup.appendChild( nCell );
	                    nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
	                    sLastGroup = sGroup;
	                }
	            }
	        },
	        "aoColumnDefs": [
	            { "bVisible": false, "aTargets": [ 0 ] }
	        ],
	        "aaSortingFixed": [[ 0, 'asc' ]],
	        "aaSorting": [[ 1, 'asc' ]],
	        "sDom": 'lfr<"giveHeight"t>ip'
	    });
} );

	$(document).ready( function() {
		fnFeaturesInit();
		$('#solines').dataTable( {
				"bJQueryUI": true,
				"iDisplayLength": 50
        	} );
	    $(".fancybox").fancybox({closeBtn:true});


	} );
</script>
<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#example").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized});

});

</script>

<!-- jQuery for sorting & pagination ENDS here -->
<!-- fancy box popup instead of original from rb -->

<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>

<!-- end of fancybox -->
</Head>
<body>
<form name="myForm" method = 'POST'>
<input type='hidden' name='SalesOrder' value=''>
<input type='hidden' name='PurchaseOrder' value=''>
<input type='hidden' name='salDoc' value=''>
<input type='hidden' name='soldTo' value=''>
<input type="hidden" name="prodCode_D">
<input type="hidden" name="CancelAllItems" value='N'>





<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-mainwide">
<div class="page-title">
<%@ include file="../Misc/ezTaxCodesAndDesc.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iOpenOrdersDetails.jsp"%>
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
<%
	//out.println(retHeader.toEzcString());
	String fromPage = request.getParameter("fromPage");
	
	if (fromPage!=null){
	if("".equals(fromPage))fromPage="";
	}
	
	String poNum = retHeader.getFieldValueString(0,"PO_NO");
	String poDate = ret.getFieldValueString(0,"PO_DATE");
	String soNumber = retHeader.getFieldValueString(0,"DOC_NO");
	String complDlv = retHeader.getFieldValueString(0,"COMPL_DLV");
	String docDate = ret.getFieldValueString(0,"DOC_DATE");
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
	String partToDist="",partToRegion="",partToCountry="",partToPostCode="",partToTel="",partToFax="";

	String shipToAddress = "";
	String billToAddress = "";

	String soldToCode = "";
	String shipToCode = "";
	String zfCode = "Standard"; // Customer's LTL Partner ID or Generic Partner ID for LTL Shipments
	String zcCode = ""; // Carrier Code for UPS/DHL at American Standard
	String zfAddress = "NA";
	
	String promoCode = businessDataRetObj.getFieldValueString(0,"CUSTCONGR4");
	String tempStr= "";
	
	if(retPartners!=null)
	{
		for(int a=0;a<retPartners.getRowCount();a++)
		{
			tempStr = "";
			partRole = retPartners.getFieldValueString(a,"PARTN_ROLE");
			partToCode = retPartners.getFieldValueString(a,"CUSTOMER");
			//out.println(retPartners.toEzcString());

			if("AG".equals(partRole) || "WE".equals(partRole) || "ZF".equals(partRole) || "ZC".equals(partRole))
			{
			
				partnerAddrCode = retPartners.getFieldValueString(a,"ADDRESS");
				
				for(int i=0;i<retPartners.getRowCount();i++)
				{
			
					String tempAddrCode = retAddress.getFieldValueString(i,"ADDRESS");
					
					if(partnerAddrCode.equals(tempAddrCode))
					{
						if ( !("ZC".equals(partRole)) )
						partToCode = retAddress.getFieldValueString(i,"PARTNER_NO");
						
						
						partToName = retAddress.getFieldValueString(i,"PARTNER_NAME");
						partToName2 = "";//retAddress.getFieldValueString(i,"PARTNER_NAME2");
						partToStreet = retAddress.getFieldValueString(i,"STREET");
						partToCity = retAddress.getFieldValueString(i,"CITY");
						partToDist = retAddress.getFieldValueString(i,"DISTRICT");
						partToRegion = retAddress.getFieldValueString(i,"REGION");
						partToCountry = retAddress.getFieldValueString(i,"COUNTRY");
						partToPostCode = retAddress.getFieldValueString(i,"POSTL_CODE");
						partToTel = retAddress.getFieldValueString(i,"TELEPHONE1");
						partToFax = retAddress.getFieldValueString(i,"FAX_NUMBER");

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

						if(partToName!=null && !"null".equals(partToName) && !"".equals(partToName.trim()))
							tempStr = tempStr + partToName +"<br>";
						if(partToName2!=null && !"null".equals(partToName2) && !"".equals(partToName2.trim()))
							tempStr = tempStr + partToName2 +"<br>";
						if(partToStreet!=null && !"null".equals(partToStreet) && !"".equals(partToStreet.trim()))
							tempStr = tempStr + partToStreet +"<br>";
						if(partToCity!=null && !"null".equals(partToCity) && !"".equals(partToCity.trim()))
							tempStr = tempStr + partToCity +", ";
						//if(partToDist!=null && !"null".equals(partToDist) && !"".equals(partToDist.trim()))
							//tempStr = tempStr + partToDist +"<br>";
						if(partToRegion!=null && !"null".equals(partToRegion) && !"".equals(partToRegion.trim()))
							tempStr = tempStr + partToRegion +"&nbsp;";
						if(partToPostCode!=null && !"null".equals(partToPostCode) && !"".equals(partToPostCode.trim()))
							tempStr = tempStr + partToPostCode +"<br>";
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
					if ("UP1A".equals(partToCode)){
						zcCode = "UPS Next Day Air Early A.M.";
					} else if ("UP1B".equals(partToCode)){
						zcCode = "UPS Next Day Air ";
					} else if ("UP1C".equals(partToCode)){
						zcCode = "UPS Next Day Air Saver";
					} else if ("UP2B".equals(partToCode)){
						zcCode = "UPS 2nd Day Air A.M";
					} else if ("UP2C".equals(partToCode)){
						zcCode = "UPS 2nd Day Air";
					} else if ("UP3C".equals(partToCode)){
						zcCode = "UPS 3 Day Select";
					} else if ("UPGC".equals(partToCode)){
						zcCode = "UPS Ground";
					} else if ("UIUC".equals(partToCode)){
						zcCode = "UPS Express Critical";
					} else if ("UIPA".equals(partToCode)){
						zcCode = "UPS Worldwide Express Plus";
					} else if ("UIPB".equals(partToCode)){
						zcCode = "UPS Worldwide Express";
					} else if ("UIPC".equals(partToCode)){
						zcCode = "UPS Worldwide Saver";
					} else if ("UIEC".equals(partToCode)){
						zcCode = "UPS Worldwide Expedited";
					} else if ("UIGC".equals(partToCode)){
						zcCode = "UPS Worldwide Standard";
					} else if ("FE1A".equals(partToCode)){
						zcCode = "Fedex First Overnight";
					} else if ("FE1B".equals(partToCode)){
						zcCode = "Fedex Priority Overnight";
					} else if ("FE1C".equals(partToCode)){
						zcCode = "Fedex Standard Overnight";
					} else if ("FE2B".equals(partToCode)){
						zcCode = "Fedex 2 Day A.M.";
					} else if ("FE2C".equals(partToCode)){
						zcCode = "Fedex 2-Day";
					} else if ("FE3C".equals(partToCode)){
						zcCode = "Fedex Express Saver";
					} else if ("FEGC".equals(partToCode)){
						zcCode = "Fedex Ground";
					} else if ("FEHC".equals(partToCode)){
						zcCode = "Fedex Home Delivery";
					} else if ("FIUC".equals(partToCode)){
						zcCode = "Fedex International Next Flight";
					} else if ("FIPC".equals(partToCode)){
						zcCode = "Fedex International Priority";
					} else if ("FIEC".equals(partToCode)){
						zcCode = "Fedex International Economy";
					} else if ("FIGC".equals(partToCode)){
						zcCode = "Fedex International Ground";
					} 
					
					//out.println(" +++++++++++++++++ HELLO THERE "+partToCode);
					
				}
				else if("ZF".equals(partRole))
				{
					//zfCode = partToCode;
					zfCode = "Customer's LTL Partner";
					zfAddress = tempStr;
									
				}
			}
		}
	}
%>
	<h2>PO #: <%=poNum%> Status: <%=delivStatus%></h2>
	<h3>PO Date <%=poDate%>, Accepted by American Standard on <%=docDate%></h3>
	<div id="noprint">
	<a href="javascript:funBack()"><span>Back to List</span></a>
	&nbsp;&nbsp;&nbsp;<a href="javascript:window.print()"><span>Print PDF</span></a>
	&nbsp;&nbsp;&nbsp;<a href="javascript:funReOrder()"><span>Re-Order</span></a>
	<!-- &nbsp;&nbsp;&nbsp;<a href="javascript:void(0)"><span>Download XML</span></a>
	&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)"><span>Download Excel</span></a>
	&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)"><span>Email Order</span></a> -->
	&nbsp;&nbsp;&nbsp;<a href="javascript:funCancelAllItems('<%=poNum%>')"><span>Cancel Order</span></a>
	&nbsp;&nbsp;&nbsp;<a href="javascript:callFun('INV','<%=salesOrder%>','<%=poNum%>')"><span>View Invoices</span></a>
	&nbsp;&nbsp;&nbsp;<a href="javascript:callFun('DLV','<%=salesOrder%>','<%=poNum%>')"><span>View Deliveries</span></a>
	&nbsp;&nbsp;&nbsp;<a href="javascript:funCancelSelItems('<%=poNum%>')"><span>Cancel Selected Items</span></a>
	</div>
	<input type="hidden" name="soldToCode" value="<%=customer%>">
	<input type="hidden" name="salesOrder" value='<%=salesOrder%>'>

</div>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title">shipping Address</h2>
		<p><%=shipToAddress%></p>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title">Sold To Address</h2>
		<p><%=billToAddress%></p>
	</div>
	</div> <!-- Col 2 of Order Header -->
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title">Shipping Method </h2>
		<p><input type="checkbox" name="shipcomplete" value="yes" <%=dlvCheck%> disabled="disabled"> Ship Complete(if possible)</input> <br>
		Shipping Mode  : 
<%
		if(!("".equals(zcCode)))
		{
			out.println(zcCode); 
		}
		else
		{
			out.println(zfCode);
		}
%>
		<br><strong>BILLING DETAILS WITH SHIPPER</strong><br>
<%
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
<div class="col1-set">
<%
	if(!promoCode.equals(""))
	{
%>
		<p><strong>Promo Code Used # </strong><%=promoCode%></p>
<%
	}
%>
<label for="attachments">Attachments</label>
<iframe src="../UploadFiles/ezAttachmentsFromSap.jsp?salesOrder=<%=salesOrder%>" frameborder=yes width=100% scrolling=auto scrolling=yes height="50" style="border-style: solid; border-color: #333;   border-width: 2px; background: #FFF;"></iframe>

<label for="headertext">External Header Text</label>
<textarea id="headertext" rows="2" cols="80"><%=SOHeaderText%></textarea>
<!-- <p><strong>External Header Text : </strong><%=SOHeaderText%></p> -->
<div class="info-box">

	<table class="data-table" width="100%">
	<tr>
		<td border="0"><h2 >Items Ordered </h2></td>
		<td class="printNo" border="0">
		View :	<select id="sort types" value="1">
			<option value="1">By Points Group</option>
			<option value="2">By Order Type</option>
			<option value="3">By PO and Line</option>
			<option value="4">As Entered</option>
			</select>
		</td>
	<tr>
	
	</table>

	<table class="data-table" id="solines">
	<thead>
	<tr>
	<!-- <th width="10%">Pricegrp</th> -->
	<!-- <th width="10%">&nbsp;</th> -->
	<th width="10%">Our Order/Ln#<br>Your PO Ln#</th>
	<th width="22%">Product Information</th>
	<th width="7%">Program/<br>Reference</th>
	<th width="5%">Mult. %</th>
	<th width="5%">Price<br>[USD]</th>
	<th width="5%">Ord.<br>Qty. </th>
	<th width="5%">Conf.Qty.<br>Date </th>
	<th width="7%">Ship Qty/ <br>Dates</th>
	<th width="7%">SubTotal</th>
	<th width="5%">Track Goods/ <br>Print Invoices</th>
	<th width="10%">Cancel/<br>Dispute</th>
	</tr>
	</thead>
	<tbody>
<%
	java.math.BigDecimal totTax = new java.math.BigDecimal("0");
	int count = retItems.getRowCount();
	
	/* out.println(retItems.toEzcString());
	out.println(retCond.toEzcString());
	out.println(retLineText.toEzcString());   
	out.println(retLineText.toEzcString());
*/

	//out.println(itemShippedQtys);
	
	java.math.BigDecimal totalItemsValue = new java.math.BigDecimal("0");
	java.math.BigDecimal freightTotal = new java.math.BigDecimal("0");
	java.math.BigDecimal grandTotal = new java.math.BigDecimal("0");

	Vector plantsVect = new Vector();
	
	plantsVect.addElement("128");
	plantsVect.addElement("01");
	plantsVect.addElement("521");


	for(int i=0;i<count;i++)
	{
		boolean dlvCreated = false;
		boolean pgiCreated = false;
		boolean poCreated  = false;
	
		String salesDocNo 	= retItems.getFieldValueString(i,"DOC_NO");
		String lineNo 		= retItems.getFieldValueString(i,"LINE_NO");
		String itemDesc		= retItems.getFieldValueString(i,"ITEM_DESC");
		String matno		= retItems.getFieldValueString(i,"ITEM_NO");
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
		
		String cust_mat35 = slsOrdLineRetObj.getFieldValueString(i,"CUST_MAT35");
		String volume = slsOrdLineRetObj.getFieldValueString(i,"VOLUME");
		
		
		String salesHdrData	= (String)soHeaderDataHT.get(salesDocNo);
		
		String salesHdrDataArr[]= salesHdrData.split("#"); 
		
		
		/**
		try{
			itemValue	= (new  java.math.BigDecimal(itemValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
			
			totalItemsValue	= totalItemsValue.add(new  java.math.BigDecimal(itemValue));
			
			
		}catch(Exception e){}	
		*/
		String salesQuoteRef = " ",jobQuoteOrdId = "";
		
	
		if(refSalesQuotations.get(salesDocNo+""+lineNo)!=null)
		{
			salesQuoteRef = "JobQuote# "+(String)refSalesQuotations.get(salesDocNo+""+lineNo);
			
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
					programType = "Direct Ship";
		}
		if ( salesHdrDataArr[0].equalsIgnoreCase("ZIDS")) {
			programType = "Intercompany Direct Ship";
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
			
		if(poNumSOItemHT.contains(salesDocNo+""+lineNo))		
			poCreated = true;
			
		String shippedDates = "",shippedDatesHTML = "";
		
		if(itemDeliveryDates.get(salesDocNo+""+lineNo)!=null)	
		{
			pgiCreated = true;
			shippedDatesHTML = "<table class=\"data-table\"><thead><tr><th>Date</th><th>Quantity</th></tr></thead><tbody>";
			shippedDates = (String)itemDeliveryDates.get(salesDocNo+""+lineNo);
			
			String shippedDtArr[] = shippedDates.split("#");
			
			for(int s=0;s<shippedDtArr.length;s++)
				shippedDatesHTML = shippedDatesHTML+"<tr><td>&nbsp;"+(shippedDates.split("#")[s]).split("!!")[0]+"</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+(shippedDates.split("#")[s]).split("!!")[1]+"</td></tr>";
			
			if(shippedDtArr.length>1)
				shippedDates = "Multiple";	 
			else		
				shippedDates = (shippedDates.split("#")[0]).split("!!")[0]; 
				
				
			shippedDatesHTML = shippedDatesHTML+"</tbody></table>"; 	
		}
		
		//out.println(":::shippedDatesHTML:::"+shippedDatesHTML);
		
		String strikeTextStartTag = "", strikeTextEndTag = "";
		if(!"".equals(rejReason))
		{
			strikeTextStartTag = "<strike>";
			strikeTextEndTag = "<strike>";
			
		}	

		String lineItemText = (String)retLineTextHT.get(salesDocNo+""+lineNo);
				
		if(lineItemText==null || "null".equals(lineItemText))
			lineItemText = "";


		String condVal = "0";
		String listPrice = "0";
		String price_N = "0";
		String price_NJ = "0";
		String stdMultiplier = "0";
		String freight = "0";
		//java.math.BigDecimal freightTotal = new java.math.BigDecimal("0");
		
		String pricingCondTable = "<table class=\"data-table\"><thead><tr><th>Condition Type</th><th>Condition Desc.</th><th>Value</th></tr></thead><tbody>";

		for(int j=0;j<retCond.getRowCount();j++)
		{
			String condLineNo = retCond.getFieldValueString(j,"ItmNumber");
			String condType = retCond.getFieldValueString(j,"CondType");
			String tempSONum = retCond.getFieldValueString(j,"DOC_NO");
			
			String condDesc = "";
			
			if(taxCond.get(condType)!=null && !"null".equals(taxCond.get(condType)))
				condDesc = (String)taxCond.get(condType);
			
			

			if(salesDocNo.equals(tempSONum) && lineNo.equals(condLineNo))
			{
				condVal = retCond.getFieldValueString(j,"Condvalue");

				try
				{
					condVal = new java.math.BigDecimal(condVal).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
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
					}
					catch(Exception e){}
				}
				if("ZJOB".equals(condType))
				{
					price_NJ = retCond.getFieldValueString(j,"Condvalue");

					try
					{
						price_NJ = new java.math.BigDecimal(price_NJ).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}
					catch(Exception e){}
				}
				if("PN00".equals(condType))
				{
					price_N = retCond.getFieldValueString(j,"Condvalue");

					try
					{
						price_N = new java.math.BigDecimal(price_N).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}
					catch(Exception e){}
				}
				if("ZUSM".equals(condType))
				{
					stdMultiplier = retCond.getFieldValueString(j,"Condvalue");

					try
					{
						stdMultiplier = new java.math.BigDecimal(stdMultiplier).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}
					catch(Exception e){}
				}
				if("ZUFM".equals(condType) || "ZHTT".equals(condType) || "ZFHL".equals(condType) || "ZCRT".equals(condType) || "ZFRT".equals(condType) || "ZHD0".equals(condType) || "HD00".equals(condType))
					{
						if ("HD00".equals(condType))
							freight = retCond.getFieldValueString(j,"CondValue");
						else	
							freight = retCond.getFieldValueString(j,"Condvalue");
						//out.println(freight);
						
					try
					{
						freight = new java.math.BigDecimal(freight).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						
						if("".equals(rejReason))
							freightTotal = freightTotal.add(new java.math.BigDecimal(freight));
					}
					
					catch(Exception e){}
				}
				
				if ("ZJOB".equals(condType) || "PN00".equals(condType)){
					if ("PN00".equals(condType)){
						itemValue	= (new  java.math.BigDecimal(price_N).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
					} else {
						itemValue	= (new  java.math.BigDecimal(price_NJ).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
					}	
					java.math.BigDecimal itemQty1 = (new  java.math.BigDecimal(retItems.getFieldValueString(i,"QTY")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
					java.math.BigDecimal itemValueBD = new java.math.BigDecimal(itemValue);
					itemValueBD = itemValueBD.multiply(itemQty1);			
					itemValue = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					
				}
				
				
			} // end of for condition table loop
		} // end of for item row loop

		if("0".equals(stdMultiplier)) stdMultiplier = "N/A";

		pricingCondTable = pricingCondTable+"</tbody></table>"; 
		//out.println(pricingCondTable);
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

		if("".equals(rejReason))
			totalItemsValue	= totalItemsValue.add(new  java.math.BigDecimal(itemValue));
		//out.println(" +++ COND TYPE ="+condType+"+++++ totalItemsValue++->"+totalItemsValue.toString());

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
				//double subtot = Double.parseDouble(retItems.getFieldValueString(i,"VALUE"));
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
	
	<tr>
		
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
		
		<!-- *********************For Repeat Order -- Ends ******************************* -->
		
		
		<!-- <td width=5% align="center"><%=cust_mat35%><%=volume%></td> -->
				
		<td width=10% align="center"><%=strikeTextStartTag%><%=tempSalesDocNumber%>/<%=tempLineNo%><br>Your PO Line# <%=poItemNo%><%=strikeTextEndTag%><br>
		<div class="ITEMTEXT<%=tempSalesDocNumber+""+tempLineNo%>">
		<% if (!("".equals(lineItemText))) { %>
		<a class="fancybox" href="#ITEMTEXT<%=tempSalesDocNumber+""+tempLineNo%>"><span>Line Text</span></a>
		<% } else { ; }%>
		</div>
		<div id="ITEMTEXT<%=tempSalesDocNumber+""+tempLineNo%>" style="width: 400px; display: none; ">
		<h2>Item Text for <%=salesDocNo%>/<%=tempLineNo%></h2>
		<br>
		<table class="data-table">
		<tr>
		<th><%=lineItemText%></th>
		</tr>
		</table>
<!--
		<div class="know-close-button"><a href="ezSalesOrderDetails.jsp" name = "mbitem" id="mbitem">[ x ] Close</a></div> -->
		</div>
<!--		<script type="text/javascript">
			var viewport = document.viewport.getDimensions();
			$$('.ITEMTEXT<%=tempSalesDocNumber+""+tempLineNo%> a').invoke('observe', 'click' ,function(){
			Dialog.info($('ITEMTEXT<%=tempSalesDocNumber+""+tempLineNo%>').innerHTML, { className: "magento know", width:620, height:300, zIndex: 99999, recenterAuto:false, autoresize:false, top:160, left: viewport.width/2 - 230, onShow:function(){
			$$('.overlay_magento.know', '.know-close-button a').invoke('observe','click',function(){
			Dialog.closeInfo()
			});
			} });
			});
		</script>
-->		
<%
		if(!"CU".equals(userRole))
		{
			String tempDocType = salesHdrDataArr[0];

			if("TA".equals(tempDocType)) tempDocType = "OR";
			else if("KL".equals(tempDocType)) tempDocType = "FD";
%>		
			Doc Type  <%=tempDocType%><br>
			Sales Org.  <%=salesHdrDataArr[1]%><br>
			Division  <%=salesHdrDataArr[2]%><br>
			Dist Chnl  <%=salesHdrDataArr[3]%>
<%
		}
%>		
		</td>
		<td width=30%><%=strikeTextStartTag%><a href="javascript:getProductDetails('<%=matno%>')" title="<%=itemDesc%>"><%=itemDesc%>&nbsp;</a><br><strong>Your SKU#</strong><%=custMat%><br><strong>UPC#</strong><%=eanUPC%><br><strong>Product#</strong><%=matno%><br><strong>List Price:</strong>$ <%=listPrice%><%=strikeTextEndTag%></td>
		<% if (jobQuoteOrdId.equals("")) { %>
		<td width=7%><%=strikeTextStartTag%><strong></strong><%=programType%><%=strikeTextEndTag%></td>
		<% } else { %>
		<td width=7%><%=strikeTextStartTag%><strong></strong><a href="javascript:funQuoteDetails('<%=jobQuoteOrdId%>','<%=customer%>')"><%=salesQuoteRef%></a><%=strikeTextEndTag%></td>
		<% }; %>
		<td width=7% align="right"><%=strikeTextStartTag%><%=stdMultiplier%><%=strikeTextEndTag%></td>
		<td width=7% align="right">
		<div class="PRICE<%=tempSalesDocNumber+""+tempLineNo%>">
		<% if (jobQuoteOrdId.equals("")) { %>
		<a class = "fancybox" href="#PRICE<%=tempSalesDocNumber+""+tempLineNo%>"><span><%=price_N%></span></a>
		<% } else { %>
		<a class="fancybox" href="#PRICE<%=tempSalesDocNumber+""+tempLineNo%>"><span><%=price_NJ%></span></a>
		<% }; %>
		</div>
		<div id="PRICE<%=tempSalesDocNumber+""+tempLineNo%>" style="width:400px; display:none">
		<h2>Pricing Details for Order <%=tempSalesDocNumber%>, Line&nbsp;<%=tempLineNo%></h2>
		<h2>Product <%=itemDesc%></h2>
		<br>
		<%=pricingCondTable%>

		</div>

		
		
		
		</td>
		<td width=8% align="right"><%=strikeTextStartTag%><%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%><%=strikeTextEndTag%></td>
		<td width=5% align="right"><%=strikeTextStartTag%><%=eliminateDecimals(confQty)%><br><%=confDate%><%=strikeTextEndTag%></td>
		<td width=8% align="right"><%=strikeTextStartTag%><%=eliminateDecimals(shippedQty)%><%=strikeTextEndTag%>
		
		
		<div class="SHIPDATES<%=tempSalesDocNumber+""+tempLineNo%>">
		<a class="fancybox" href="#SHIPDATES<%=tempSalesDocNumber+""+tempLineNo%>"><span><%=shippedDates%></span></a>
		</div>
		<div id="SHIPDATES<%=tempSalesDocNumber+""+tempLineNo%>" style="width:400px; display:none">
		<h2>DATES</h2>
		<br>
		<%=shippedDatesHTML%>
		</div>
		
		</td>
		
		<td width=10% align="right"><%=strikeTextStartTag%><%=itemValue%><%=strikeTextEndTag%></td>
<%
		if("".equals(rejReason))
		{
		
		String trackURL = "", trackLogo="";
		String shipper = (String) soLineShippingPartners.get(salesDocNo+""+lineNo);
		trackingNumber = (String) soLineTrackingNumbers.get(salesDocNo+""+lineNo);
		dlvBolNumber = (String) soLineBolNumbers.get(salesDocNo+""+lineNo);
		if (shipper!= null) {
		if (shipper.startsWith("FE") || shipper.startsWith("FI") || shipper.startsWith("FDX")){
			trackURL = "http://www.fedex.com/Tracking?action=track&tracknumbers="+trackingNumber;
			trackLogo = "..\\..\\Images\\fedex.jpg";
		}
		if (shipper.startsWith("UP")){
			trackURL = "http://wwwapps.ups.com/etracking/tracking.cgi?tracknum="+trackingNumber;
			trackLogo = "..\\..\\Images\\ups.jpg";
		}
		if (shipper.startsWith("AMSA")){
			trackURL = "http://amstan.com/Tools/ameritrax/ShipStat.asp?txtHgt=500&txtWdt=500&radio3=2&text1="+trackingNumber;
			trackLogo = "..\\..\\Images\\amstan.jpg";
		}
		}
		//out.println(trackURL+"++++"+trackLogo);
%>		
		<td width=10% align="right">
		&nbsp;BOL# :
		<%if ((dlvBolNumber != null) && (!"".equals(dlvBolNumber))) { %>
		<%=dlvBolNumber%> 
		
		<% } else { %>
		N/A<br>
		<!--<a href="javascript:callFunInv('PRORD','<%=salesDocNo%>','<%=poNum%>')"><img src="..\..\Images\printorder.png" ></a>-->
		<a target="_blank" href="javascript:callFunInv('PRINT','<%=salesDocNo%>','<%=poNum%>')" ><img src="..\..\Images\printorder.png" ></a>
		
		<% ; }%>
		<br>
		
<% if (	trackingNumber != null && 
	!trackingNumber.equals("")) { %>	
		<div class="TRACKING<%=salesDocNo+""+lineNo%>">
		<a class="fancybox" href="#TRACKING<%=salesDocNo+""+lineNo%>">
			<img src="<%=trackLogo%>" width="60" height="30" alt="<%=trackingNumber%>">
		</a>
		<!-- <a class="fancybox" href="#TRACKING<%=salesDocNo+""+lineNo%>"><span>Line Text</span></a> -->
		</div>
		<div id="TRACKING<%=salesDocNo+""+lineNo%>" style="display:none">
		<h2>Tracking Information for SO #<%=salesDocNo%></h2>
		<br>
		<table><tr><th>
		<iframe
		   src="<%=trackURL%>"
		   width="600"
		   height="450"
		   marginwidth="0"
		   marginheight="0"
		   frameborder="no"
		   scrolling="yes"
		   style="border-style: solid; border-color: #333;   border-width: 2px; background: #FFF;">
		</iframe>
		</th></tr></table>
		<div class="know-close-button"><a href="ezSalesOrderDetails.jsp#">[ x ] Close</a></div>
		</div>
		<script type="text/javascript">
			var viewport = document.viewport.getDimensions();
			$$('.TRACKING<%=salesDocNo+""+lineNo%> a').invoke('observe', 'click' ,function(){
			Dialog.info($('TRACKING<%=salesDocNo+""+lineNo%>').innerHTML, { className: "magento know", width:620, height:600, zIndex: 99999, recenterAuto:false, autoresize:false, top:160, left: viewport.width/2 - 230, 
			onShow:function(){
			$$('.overlay_magento.know', '.know-close-button a').invoke('observe','click',function(){
			Dialog.closeInfo()
			});
			} });
			});
		</script>
		<br><a href="javascript:callFunInv('INV','<%=salesDocNo%>','<%=poNum%>')"><img src="..\..\Images\invoice.png" ></a>
		&nbsp;<a href="javascript:callFunInv('DLV','<%=salesDocNo%>','<%=poNum%>')"><img src="..\..\Images\printbol.png" ></a>
		<br><a href="javascript:callFunInv('PRINT','<%=salesDocNo%>','<%=poNum%>')"><img src="..\..\Images\printorder.png" ></a>
<% }; %>
		</td>
		<td width=5%>
			<p id='CANC_MSG<%=salesDocNo+""+lineNo%>' style='visibility:hidden'> <Font color='RED'><b>Selected For Cancellation</b></Font></p>
			<p id='CANC_MSG<%=salesDocNo+""+lineNo%>' style='visibility:hidden'> <Font color='RED'><b>Selected For Cancellation</b></Font></p>
<%
			String cancelType= "";
			
			//if(i==1 || i==3)
			//	dlvCreated = true;
		
			if(dlvCreated && pgiCreated)
			{
				cancelType = "RGA";
%>
				<input id='CANC_BUTTON<%=salesDocNo+""+lineNo%>' type="button" value="REQ. RGA" onClick="#"/>
<%
			}
			else if(dlvCreated && !pgiCreated)
			{
				cancelType = "RC";
%>
				<input id='CANC_BUTTON<%=salesDocNo+""+lineNo%>' type="button" value="REQ. CANCEL" onClick="funCancel('<%=salesDocNo+""+lineNo%>')"/>
<%
			}
			else if(!dlvCreated && !pgiCreated && poCreated)
			{
				cancelType = "RC";
%>
				<input id='CANC_BUTTON<%=salesDocNo+""+lineNo%>' type="button" value="REQ. CANCEL" onClick="funCancel('<%=salesDocNo+""+lineNo%>')"/>
<%
			}	
			else if(!plantsVect.contains(itemPlant))  // Plant 128, 01 and 521
			{
				if(!"ZCUS".equals(salesHdrDataArr[0]) || ("ZCUS".equals(salesHdrDataArr[0]) && Integer.parseInt((String)SO_DAYS_HT.get(salesDocNo)) <= 24))
				{
					cancelType = "C";
%>
					<input id='CANC_BUTTON<%=salesDocNo+""+lineNo%>' type="button" value="CANCEL" onClick="funCancel('<%=salesDocNo+""+lineNo%>')"/>
<%
				}
				else if("ZCUS".equals(salesHdrDataArr[0]) && Integer.parseInt((String)SO_DAYS_HT.get(salesDocNo)) > 24)
				{
					cancelType = "RC";
%>
					<input id='CANC_BUTTON<%=salesDocNo+""+lineNo%>' type="button" value="REQ. CANCEL" onClick="funCancel('<%=salesDocNo+""+lineNo%>')"/>
<%
				}
			}
			else if(plantsVect.contains(itemPlant) && !dlvCreated && !pgiCreated)
			{
				cancelType = "C";
%>
				<input id='CANC_BUTTON<%=salesDocNo+""+lineNo%>' type="button" value="CANCEL" onClick="funCancel('<%=salesDocNo+""+lineNo%>')"/>
<%
			}
			
			//cancelType = "RC";
%>

		<input type='hidden' name='cancelType<%=salesDocNo+""+lineNo%>' value='<%=cancelType%>'>
		<input type='hidden' name='selForCancaellation<%=salesDocNo+""+lineNo%>' value='N'>
		</td>
		
<%
		}else{
%>
		<td width=10% align="right">Rejected/Cancelled</Td>
		<input type='hidden' name='selForCancaellation<%=salesDocNo+""+lineNo%>' value='C'>
		<td width=10% align="right">&nbsp;</td>
<%
		}
%>
		
		
	</tr>
<%
	}
%>
	</tbody>
	<tfoot>
			<tr>
				<td colspan="9" align="right"><h3>&nbsp;Order Sub Total</h3></td>
				<td align="right"><%=totalItemsValue%></td>
			</tr>
			<tr>
				<td colspan="9" align="right"><h3>&nbsp;Shipping and Handling</h3></td>
				<td align="right"><%=freightTotal%></td>
			</tr>
			<% grandTotal = grandTotal.add(totalItemsValue);
			   grandTotal = grandTotal.add(freightTotal);
			 %>  
			<tr>
				<td colspan="9" align="right"><h3>&nbsp;Grand Total</h3></td>
				<td align="right"><%=grandTotal%></td>
			</tr>
	</tfoot>
	</table>
	<div id="noprint">
		<a href="javascript:funBack()"><span>Back to List</span></a>
		&nbsp;&nbsp;&nbsp;<a href="javascript:window.print()"><span>Print PDF</span></a>
		&nbsp;&nbsp;&nbsp;<a href="javascript:funReOrder()"><span>Re-Order</span></a>
		<!--&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)"><span>Download XML</span></a>
		&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)"><span>Download Excel</span></a>
		&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)"><span>Email Order</span></a> -->
		&nbsp;&nbsp;&nbsp;<a href="javascript:funCancelAllItems('<%=poNum%>')"><span>Cancel Order</span></a>
		&nbsp;&nbsp;&nbsp;<a href="javascript:callFun('INV','<%=salesOrder%>','<%=poNum%>')"><span>View Invoices</span></a>
		&nbsp;&nbsp;&nbsp;<a href="javascript:callFun('DLV','<%=salesOrder%>','<%=poNum%>')"><span>View Deliveries</span></a>
		&nbsp;&nbsp;&nbsp;<a href="javascript:funCancelSelItems('<%=poNum%>')"><span>Cancel Selected Items</span></a>

	</div>
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</Form>

</Body>