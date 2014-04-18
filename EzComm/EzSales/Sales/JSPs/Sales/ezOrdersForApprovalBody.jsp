<%
String displayOrder = request.getParameter("displayOrder");
%>
 <%@ include file="../../../Includes/JSPs/Search/iListSalesOrders.jsp"%>
 <%@ include file="../../../Includes/JSPs/Misc/iMethods.jsp"%>
 <div class="main-container col2-left-layout middle account-pages">
 <div class="hly-perftop"></div>
 <div class="main">
 <div class="col-main roundedCorners">
 <div class="my-account">
 <div class="dashboard">
 <%
 
 	String fromDate = request.getParameter("fromDate");
 	String toDate = request.getParameter("toDate");
 	
 	//out.println("apprSel:::::"+apprSel+":::reqSel:::"+reqSel);
 	String soldToQT = request.getParameter("selSoldTo");
 	if(soldToQT==null || "null".equals(soldToQT)) soldToQT ="";		
 
 	if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_S+"/"+fDate_S+"/"+fyear;
 	if(toDate==null || "null".equalsIgnoreCase(toDate)) toDate = cMonth_S+"/"+cDate_S+"/"+cYear;
 	int retobjCnt = 0;
 	if(retobj!=null && retobj.getRowCount()>0)
 		 retobjCnt = retobj.getRowCount();
 	
 %> 
 
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
 
 <script src="http://code.jquery.com/jquery-latest.js"></script>
 <script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
 <script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
 <script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min_new.js"></script> 
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
 
 	$(document).ready( function() {
 		fnFeaturesInit();
 		$('#example').dataTable( {
 			"bJQueryUI": true,
 			"sPaginationType": "full_numbers",
 			"bStateSave":true,
 			"aaSorting": [[ 6, "desc" ]],
			"aoColumnDefs": [ 
			{ "bVisible": false, "aTargets": [ 6 ] }
				],	
 			"sDom": '<"H"Tfr>t<"F"ip>',
 			"oTableTools": {
 				"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
 				"aButtons": [
 				{
 				    "sExtends":    "csv",
 				    "sButtonText": "Download CSV"
 				}
 				]
 			}

 		} );
 
 
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
 <link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
 <%
 	String searchStat = request.getParameter("searchStat");
 	String BussPart =  (String)session.getValue("BussPart");
 	String shipToQT = request.getParameter("shipTo");
  	if(shipToQT==null || "null".equals(shipToQT)) shipToQT ="";
 	ReturnObjFromRetrieve retShips = null;
 	
 	String dispHeader = "No Orders for Approval";
 	
 	if("ALL".equals(negotiateType))
 		dispHeader = "No Aprroved/Rejected Orders";
 	else if("FOCAPPROVED".equals(negotiateType))	
 		dispHeader = "No Approved Orders";
 	else if("FOCREJECTED".equals(negotiateType))	
 		dispHeader = "No Rejected Orders"; 			
 	if(retobjCnt>0 && "FORAPPROVAL".equals(negotiateType))
 		dispHeader = "Orders for Approval";
 	else if(retobjCnt>0 && "ALL".equals(negotiateType))	
		dispHeader = "Approved/Rejected Orders";
 	else if(retobjCnt>0 && "FOCAPPROVED".equals(negotiateType))	
		dispHeader = "Approved Orders";		
 	else if(retobjCnt>0 && "FOCREJECTED".equals(negotiateType))	
		dispHeader = "Rejected Orders";				
		
 	String disp="display:none";
 
 	if("Y".equals(searchStat) || "Y"==searchStat)
 	disp = "";
 	String selSold = request.getParameter("selSoldTo");
	if(selSold=="" || selSold==null || "null".equals(selSold))
	{
		selSold  = (String)session.getValue("AgentCode");
		soldToQT = (String)session.getValue("AgentCode");
	}	
		
 	retShips   = (ReturnObjFromRetrieve)getListOfShipTos("FD",(String)session.getValue("UserType"),BussPart,(String)session.getValue("IsSubUser"),Session); 	
 %>
 <div class="block" style="padding-left: 0px; width:100%;">
  	<div class="block-title">
  	<strong>
  		<span><%=dispHeader%></span>
 	 </strong>
 	 </div>
  </div>
 
 <script type="text/javascript">
 	function getOrders()
 	{
 		Popup.showModal('headermodal');
 		
 		document.myForm.action="ezOrdersForApproval.jsp?negotiateType="+document.myForm.negotiateType.value+"&ORDERTYPE=A";
 		document.myForm.submit();
 	}
 	function getDetails(SoNum,SoldTo,focStat,shipTo,docDate,sysKey,multiSOs)
 	{
 		Popup.showModal('headermodal');
 		document.myForm.webOrNo.value=SoNum;
 		document.myForm.soldTo.value=SoldTo;
 		document.myForm.salesOrder.value=SoNum;
 		document.myForm.OrdShipTo.value=shipTo;
 		document.myForm.poDate.value=docDate;
 		document.myForm.sysKey.value=sysKey;
 		
 		if(focStat=="FOCAPPROVED" || focStat=="FOCACCEPTED")
 		{
 			if(multiSOs == "MULTI_SO")
 				document.myForm.action="ezGetMultiSOCodes.jsp";
 			else
 				document.myForm.action="ezSalesOrderDetails.jsp";
 		}	
 		else	
 			document.myForm.action="ezApprovalOrderDetails.jsp";
 		document.myForm.submit();
 	}
	function getShipTos()
	{
		Popup.showModal('headermodal');
		document.myForm.submit();

	} 
	function openSearch(searchType)
	{
		var selSoldTo='';
		if(searchType=='SHIPTO')
			selSoldTo = document.myForm.selSoldTo.value
		window.open("../Sales/ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo+"&chkBlock=Y&fromPage=Y&ordType=FD",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
	}
	 
 </script>
 <form name="myForm" method="post">
 <input type="hidden" name="searchStat" value="Y">
 <div>
 	<!--<table class="data-table">
 	<thead>
 	<tr>
 	<th width=20%>From Date</th>
 	<td width=20%><input type="text" size="12" id="fromDate" name="fromDate" value="<%=fromDate%>" readonly /><%=getDateImage("fromDate")%></td>
 	<th width=20%>To Date</th>
 	<td width=20%><input type="text" size="12" id="toDate" name="toDate" value="<%=toDate%>" readonly /><%=getDateImage("toDate")%></td>
 	<td width=20%><input type="submit" class="button" title="Submit" onClick="getOrders()" /></td>
 	</tr>
 	</thead>
 	</table>-->
 	
 </div>
 <ul class="form-list">
 
 	<li>
 	<div id="it"><button type="button" title="Search" class="button btn-update"><span>Show / Hide Search</span></button></div>
 	</li>
 
 	<li>
 	<div id="display" style="<%=disp%>" >
 		<table class="data-table">
 		<thead>
 		
 		<tr>
 		<th width=5%>Document Date</th>
 		<th width=5% align=center>From</th>
 		<td width=15%><input type="text" size="12" id="fromDate" name="fromDate" value="<%=fromDate%>" readonly /><%=getDateImage("fromDate")%></td>
 		<th width=5% align=center>To</th>
 		<td width=15%><input type="text" size="12" id="toDate" name="toDate" value="<%=toDate%>" readonly /><%=getDateImage("toDate")%></td>
 
 		</tr>
 
 		
 		<tr>
 		<th width=5%>FD Expense A/c </th>
 		<td width=15% colspan=4>
 		<ul>
 		<li>
 		<div class="input-box" style="width: 350px !important;">
 		<select name="selSoldTo" style="width: 300px !important;" >
 		<option value=''>ALL </option>
 <%
		
		//ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
		EzcParams mainParams_FD= new EzcParams(false);
		EziMiscParams miscParams_FD = new EziMiscParams(); 		
		ReturnObjFromRetrieve retsoldto_A_SesGet = null;
		miscParams_FD.setIdenKey("MISC_SELECT");
		miscParams_FD.setQuery("SELECT DISTINCT(EC_PARTNER_NO),EC_ERP_CUST_NO,ECA_NAME,ECA_ACCOUNT_GROUP,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_PARTNER_FUNCTION='AG' AND EC_NO=ECA_NO AND EC_SYS_KEY IN ('999701','999702','999704')");

		mainParams_FD.setLocalStore("Y");
		mainParams_FD.setObject(miscParams_FD);
		Session.prepareParams(mainParams_FD);	

		try
		{		
			retsoldto_A_SesGet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_FD);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}		
 		if(retsoldto_A_SesGet!=null)
 		{
 			retsoldto_A_SesGet.sort(new String[]{"ECA_NAME"},true);
 			for(int i=0;i<retsoldto_A_SesGet.getRowCount();i++)
 			{
				String blockCode_A  = retsoldto_A_SesGet.getFieldValueString(i,"ECA_EXT1");
				if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

				if(!"BL".equalsIgnoreCase(blockCode_A))
				{
				String soldToCode_A 	= retsoldto_A_SesGet.getFieldValueString(i,"EC_ERP_CUST_NO");
 				String soldToName_A 	= retsoldto_A_SesGet.getFieldValueString(i,"ECA_NAME");
 
 				String selected_A = "selected";
 
 				if(soldToQT.equals(soldToCode_A))
 				{
 %>				
 					<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%> (<%=soldToCode_A%>)</option>
 <%				}
 				else
 				{
 %>	
 					<option value="<%=soldToCode_A%>" ><%=soldToName_A%> (<%=soldToCode_A%>)</option>
 <%
 				}
 				}
 			}
 		}
 %>
 		</select>
 		<a href="javascript:openSearch('SOLDTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
 		</div>
 		</li>
 		</ul>
 		</tr>
 		<!--<Tr>
		<th width=5%>Ship To Code</th>
 		<td width=15% colspan=4>
 		<ul>
 		<li>
 		<div class="input-box" style="width: 350px !important;">
 		<select name="shipTo" style="width: 300px !important;" >
 		<option value = "A">ALL </option> -->
 <%
 		/*ArrayList byPassShips = new ArrayList();
 		if(retShips!=null)
 		{
 			retShips.sort(new String[]{"ECA_COMPANY_NAME"},true);
 			for(int i=0;i<retShips.getRowCount();i++)
 			{
 				String shipToCode_A 	= retShips.getFieldValueString(i,"EC_PARTNER_NO");
 				String shipToName_A 	= retShips.getFieldValueString(i,"ECA_COMPANY_NAME");
				
				if(byPassShips.contains(shipToCode_A))
					continue;
				else
					byPassShips.add(shipToCode_A); 				
 
 				String selected_A = "selected";
 
 				if(shipToQT.equals(shipToCode_A))
 				{*/
 %>				
 					<!--<option value="<%//=shipToCode_A%>" <%//=selected_A%>><%//=shipToName_A%> (<%//=shipToCode_A%>)</option>-->
 <%				/*}
 				else
 				{*/
 %>	
 					<!--<option value="<%//=shipToCode_A%>" ><%//=shipToName_A%> (<%//=shipToCode_A%>)</option>-->
 <%
 				/*}
 			}
 		}*/
 %>
 		<!--</select>
 		<a href="javascript:openSearch('SHIPTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
 		</div>
 		</li>
 		</ul>
 		
 		</td>
 		</tr>-->
 		<input type="hidden" name="shipTo" value="A">
		<tr>
			<th align=center>Requestor</th>
			<td colspan=4>
				<input type="radio" name="reqSel" value="AL">&nbsp;&nbsp;ALL&nbsp;&nbsp;
				<input type="radio" name="reqSel" value="MYS" >&nbsp;&nbsp;Myself
			</td>	
		</tr>
<%
		if(userAuth_R.containsKey("FOC_APPR")) 
		{
%>		
			<tr>
				<th  align=center>Approver</th>
				<td colspan=4>
					<input type="radio" name="appSel" value="AL">&nbsp;&nbsp;ALL&nbsp;&nbsp;
					<input type="radio" name="appSel" value="MYS" >&nbsp;&nbsp;Myself
				</td>	
			</tr> 		
<%
		}
%>		
 		</thead>
 		</table>
<%
		if(!"FORAPPROVAL".equalsIgnoreCase(negotiateType))
		{
%>		
			<table class="data-table">
			<thead>
			<tr>
			<th width=7.5% align=center>Status</th>
			<td width=32%>
			<ul>
			<li>
			<div class="input-box" style="width:230px !important;">
			<select name="negotiateType" style="width: 300px !important;">
<%
			String allSel = "";
			String appSel = "";
			String rejSel = "";

			if("ALL".equals(negotiateType)) allSel = "selected";
			else if("FOCAPPROVED".equals(negotiateType)) appSel = "selected";
			else if("FOCREJECTED".equals(negotiateType)) rejSel = "selected";
%>
				<option value="ALL" <%=allSel%>>All</option>
				<option value="FOCAPPROVED" <%=appSel%>>Approved</option>
				<option value="FOCREJECTED" <%=rejSel%>>Rejected</option>
			</select>
			</div>
			</li>
			</ul>
			</td>
			</tr>


			</thead>
			</table>
<%
		}
%>		
			
		<div style="margin-top:8px;float:right;margin-right: -10px;">
			<!--<input type="submit" class="button" title="Submit" onClick="getOrders()" />-->
			<button title="Submit" class="button btn-update" onClick="getOrders()" ><span>Search</span></button>
		</div>  		
 		
 		
 	</div>
 	</li>
 </ul>
 
 
 
 <%
 	Hashtable poSalesOrdersHT = new Hashtable();
 	Hashtable poValueHT = new Hashtable();
 	Vector poVector = new Vector();
	Hashtable poSysKeyHT = new Hashtable();

	Hashtable multiBackOrdHT = new Hashtable();
 
 	if(retobjCnt>0)
 	{
		long start = System.currentTimeMillis();
		String webOrdNo = "";

 		for(int i=0;i<retobjCnt;i++)
 		{
 			String soNumber = retobj.getFieldValueString(i,"WEB_ORNO");
 			String sapSO = retobj.getFieldValueString(i,"BACKEND_ORNO");

			if(sapSO!=null && "Multi Orders".equalsIgnoreCase(sapSO.trim()))
			{
				if("".equals(webOrdNo))
					webOrdNo = soNumber;
				else
					webOrdNo = webOrdNo+"','"+soNumber;
			}
		}
		if(!"".equals(webOrdNo))
		{
			//multiBackOrdHT = (Hashtable)getBackOrdNum(webOrdNo,Session);
		}
		//out.print("retobj::::"+retobj.toEzcString());
 		for(int i=0;i<retobjCnt;i++)
 		{
 			String shipToCode	= retobj.getFieldValueString(i,"SHIP_TO_CODE");

 			if(!"0999999999".equals(shipToCode))
 				continue;

 			String poNumber 	= retobj.getFieldValueString(i,"PO_NO");
 			String soNumber 	= retobj.getFieldValueString(i,"WEB_ORNO");
 			String soNetValue  	= retobj.getFieldValueString(i,"NET_VALUE");
 			String sapSO	  	= retobj.getFieldValueString(i,"BACKEND_ORNO");
 			String focStat  	= retobj.getFieldValueString(i,"EON_STATUS");
 			String soSyskey		= retobj.getFieldValueString(i,"SYSKEY");

			//if(sapSO!=null && "Multi Orders".equalsIgnoreCase(sapSO.trim()))
			//	sapSO = (String)multiBackOrdHT.get(soNumber);

 			if(poVector.contains(soNumber))
 			{
 				if("FOCAPPROVED".equals(focStat) || "FOCACCEPTED".equals(focStat))
 				{
 					if(!poSalesOrdersHT.contains(sapSO))
 						poSalesOrdersHT.put(poNumber,(String)poSalesOrdersHT.get(poNumber)+"ÿ"+sapSO);
 				}
 				else
 				{
 					if(!poSalesOrdersHT.contains(soNumber))
	 					poSalesOrdersHT.put(poNumber,(String)poSalesOrdersHT.get(poNumber)+"ÿ"+soNumber);
 				}
 
 			}else{
 				if("FOCAPPROVED".equals(focStat) || "FOCACCEPTED".equals(focStat))
 				{
 					poVector.addElement(sapSO);
 					poSalesOrdersHT.put(poNumber,sapSO);
 				}	
 				else	
 				{
 					poVector.addElement(soNumber);
 					poSalesOrdersHT.put(poNumber,soNumber);
 				}
 				poSysKeyHT.put(poNumber,soSyskey);
 				//poValueHT.put(poNumber,soNetValue);
 			}
 		}
		long finish = System.currentTimeMillis();
		//out.println("Time taken to execute for loop in ezOrdersForApprovalBody.jsp>>>"+(finish-start)/1000+" secs");
 	}	
 		
 		//out.println("::::::::::::::::::poSalesOrdersHT:::::::::"+poSalesOrdersHT);
 		//out.println("::::::::::::::::::poValueHT:::::::::"+poValueHT);
 %>		
 <div class="col1-set">
 <div class="info-box"><br>
 
 <input type="hidden" name="webOrNo">
 <input type="hidden" name="salesOrder">
 <input type="hidden" name="soldTo">
 <input type="hidden" name="OrdShipTo">
 <input type="hidden" name="poDate">
 <input type="hidden" name="sysKey">
 <input type="hidden" name="negotiateType_A" value="<%=negotiateType%>">
<!-- <table class="display" id="example"> -->
<table class="data-table" id="example">
<thead>
<tr>
	<th style="width:20%;" rowspan=2>PO Id</th>
	<th width=20% align=center rowspan=2>
		PO Date [POD]<br>
		Req. Date [RqD]
	</th>
	<!--<th width=20% >Posted Date</th>-->
	<!--<th width=20%  >Amount [USD]</th>-->
	<th style="width:30%;" align=center colspan=2>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Customer/Account
	</th>
	<th style="width=30%;" align=center colspan=2>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Users
	</th>
	<tr>
		<!--<Th width="10%" align="center">PO Date</Th>
		<Th width="10%" align="center">Request Date</Th>-->

		<Th width="15%" align="center">Expense Acc</Th>
		<Th width="15%" align="center">Ship To </Th>

		<Th width="15%" align="center">Requestor<br>Approver</Th>
		<Th width="15%" align="center">Status</Th>
	</tr>
</tr>
</thead>
<tbody>
<%
 		
 	poVector = new Vector();
 	//out.println(retobj.toEzcString());
  	for(int i=0;i<retobjCnt;i++)
 	{
		String shipToCode	= retobj.getFieldValueString(i,"SHIP_TO_CODE");

		if(!"0999999999".equals(shipToCode))
			continue;

 		String tempsoNumber = "";
 		String soNumber	  = retobj.getFieldValueString(i,"WEB_ORNO");
 		String netValue	  = retobj.getFieldValueString(i,"NET_VALUE");
 		String soCust 	  = retobj.getFieldValueString(i,"SOLD_TO_CODE");
 		String DocDate 	  = retobj.getFieldValueString(i,"RES1");
 		String DocStatus  = retobj.getFieldValueString(i,"STATUS");
 		
 		String soldToCode = retobj.getFieldValueString(i,"SOLD_TO_CODE");
 		String soldToName = retobj.getFieldValueString(i,"SOTO_ADDR1");
 		String shipTo 	  = retobj.getFieldValueString(i,"SHIP_TO_CODE");
 		String shipToName = retobj.getFieldValueString(i,"SHTO_ADDR1"); 		
 		String approverId = retobj.getFieldValueString(i,"EON_INDEX_NO"); 
 		String requesterId= retobj.getFieldValueString(i,"EON_CREATED_BY"); 
 		String focStat	  = retobj.getFieldValueString(i,"EON_STATUS");
 		
 		
 		
 		
 		String pono = retobj.getFieldValueString(i,"PO_NO");
 		if("NEW".equals(DocStatus))DocStatus="Saved";
 
 		if(poVector.contains(pono))
 			continue;
 		else
 			poVector.addElement(pono);	
 
 
 		StringTokenizer st1 = new StringTokenizer(DocDate,"/");
 		String[] docsplit   = new String[3];
 		int h=0;
 		while(st1.hasMoreTokens())
 		{
 			docsplit[h]=st1.nextToken();
 			h++;
 		}			
 		java.util.Date dDate = new java.util.Date(Integer.parseInt(docsplit[2])-1900,Integer.parseInt(docsplit[0])-1,Integer.parseInt(docsplit[1]));
 		DocDate = formatDate.getStringFromDate(dDate,"/",formatDate.MMDDYYYY);
 		try
 		{
 			tempsoNumber = (Long.parseLong(soNumber))+"";
 		}
 		catch(Exception e)
 		{	
 			tempsoNumber = soNumber;
 		}
 
 		if((DocDate==null)||(DocDate=="null")||(DocDate.trim().length() == 0)) DocDate ="N/A";
 		if((netValue==null)||(netValue=="null")||(netValue.trim().length() == 0)) netValue ="N/A";
 
 		/*String poValueBD="0";
 		poValueBD = (String)poValueHT.get(pono);
 
 		try
 		{
 			poValueBD = new java.math.BigDecimal(poValueBD).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 		}
 		catch(Exception e){
 			poValueBD = (String)poValueHT.get(pono);
 		}*/

 		String orderStat = "";

 		if("FORAPPROVAL".equals(focStat)) orderStat = "Pending for Approval";
 		else if("FOCAPPROVED".equals(focStat) || "FOCACCEPTED".equals(focStat)) orderStat = "Approved";
 		else if("FOCREJECTED".equals(focStat)) orderStat = "Rejected";
 %>
 		<tr>
 <%
 		if(retobj.getFieldValueString(i,"BACKEND_ORNO")!=null && "Multi Orders".equalsIgnoreCase(retobj.getFieldValueString(i,"BACKEND_ORNO").trim()))
 		{
 %>
 		
			<td width=20%><a href="javascript:getDetails('<%=soNumber%>','<%=soCust%>','<%=focStat%>','<%=shipTo%>','<%=DocDate%>','<%=poSysKeyHT.get(pono.trim())%>','MULTI_SO')"><%=pono%></a></td>
<%
		}
		else
		{
%>
			<td width=20%><a href="javascript:getDetails('<%=poSalesOrdersHT.get(pono.trim())%>','<%=soCust%>','<%=focStat%>','<%=shipTo%>','<%=DocDate%>','<%=poSysKeyHT.get(pono.trim())%>','')"><%=pono%></a></td>
<%
		}
%>

			<td width=20%>
				<strong>POD:</strong><%=DocDate%><br>
				<strong>RqD:</strong><%=DocDate%>
			</td>
			<!--<td width=10%><%=DocDate%></td>-->
			<!--<td width=20%><%=DocDate%></td>-->
			

			<td width=15%><%=soldToName+"<br>["+soldToCode+"]"%></td>
			<td width=15%><%=shipToName+"<br>["+shipTo+"]"%></td>

			<td width=15%><strong>R:</strong><%=requesterId.toUpperCase()%><br><strong>A:</strong><%=approverId.toUpperCase()%></td>
			<td width=15%>&nbsp;<%=orderStat%></td>
			<td><%=tempsoNumber%></td>
 		</tr>
 <%
 	}
 %>
 	</tbody>
 	</table>
 </div>
 </div>
 <script>
 $("#it").click(function () {
 
 $("#display").toggle( "slow" );
 });
<%
	if(request.getParameter("selSoldTo")==null || "".equals(request.getParameter("selSoldTo")) || "null".equals(request.getParameter("selSoldTo")))		
	{
%>
		document.myForm.selSoldTo.value=""
<%
	}
%> 
var appsel ="<%=apprSel%>"
var reqsel ="<%=reqSel%>"
<%
	if(userAuth_R.containsKey("FOC_APPR")) 
	{
%>
		if(appsel=='AL')
			document.myForm.appSel[0].checked=true
		else
			document.myForm.appSel[1].checked=true
<%
	}
%>
if(reqsel=='AL')
	document.myForm.reqSel[0].checked=true
else
	document.myForm.reqSel[1].checked=true	

 </script>
 </form>
 
 </div>
 </div>
 </div>
<%@ include file="ezMyOrdersMenuLink.jsp"%>

 </div>
</div>