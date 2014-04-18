<%
String displayOrder = request.getParameter("displayOrder");
%>
 <%@ include file="../../../Includes/JSPs/Search/iListSalesOrders.jsp"%>
 <div class="main-container col2-left-layout middle account-pages">
 <div class="hly-perftop"></div>
 <div class="main">
 <div class="col-main roundedCorners">
 <div class="my-account">
 <div class="dashboard">
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "";

		return ret;
	}
	
%>
 <%
 
 	String fromDate = request.getParameter("fromDate");
 	String toDate = request.getParameter("toDate");
 	ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
 	String soldToQT = request.getParameter("selSoldTo");
 	if(soldToQT!=null && !"".equals(soldToQT)) soldToQT = soldToQT.split("##")[0];
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
 <script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
 
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
 	
 	String dispHeader = "No Orders in Review/Negotiation";
 
 	if((("INPROCESS".equals(negotiateType) || "NEGOTIATED".equals(negotiateType))) && "N".equals(displayOrder))
 		dispHeader = "<span style=\"color:#50B4B6;\">"+retobjCnt+"</span> Orders in ASB Queue";
 	if((("INPROCESS".equals(negotiateType) || "NEGOTIATED".equals(negotiateType))) && "Y".equals(displayOrder))
 		dispHeader = "<span style=\"color:#50B4B6;\">"+retobjCnt+"</span> Display Orders in Queue"; 		
	else if("ACCEPTED".equals(negotiateType))
 		dispHeader = "<span style=\"color:#50B4B6;\">"+retobjCnt+"</span> Orders in Customer Queue"; 	
 	else if("REJECTED".equals(negotiateType))
 		dispHeader = "<span style=\"color:#50B4B6;\">"+retobjCnt+"</span> Rejected Orders";
 	else if("CLOSED".equals(negotiateType))
 		dispHeader = "<span style=\"color:#50B4B6;\">"+retobjCnt+"</span> Closed Orders";

 	/*else if(retobjCnt==0 && "REJECTED".equals(negotiateType))	
 		dispHeader = "No Rejected Orders";
	else if(retobjCnt==0 && "ACCEPTED".equals(negotiateType))	
 		dispHeader = "No Accepted Orders"; */		
 	//out.println(retobjCnt);	
 		
 		
 	String disp="display:none";
 	//HashMap soldToHash = (HashMap)session.getValue("SOLDTONAMES");
 	String soldToName = "";
 
 	if("Y".equals(searchStat) || "Y"==searchStat)
 		disp = "";
 	if(request.getParameter("selSoldTo")!=null && !"".equals(request.getParameter("selSoldTo")) && !"null".equals(request.getParameter("selSoldTo")) && "Y".equals(searchStat))
 	{
 		soldToName = "&nbsp;for&nbsp;";
 		String tempVal = request.getParameter("selSoldTo");
 		tempVal = tempVal.split("##")[1];
 		//out.println("tempVal::::::"+tempVal);
 		//soldToName = soldToName+(String)soldToHash.get(request.getParameter("selSoldTo"));
 		soldToName = soldToName+tempVal;
 		
 	}
 	String selSold = request.getParameter("selSoldTo");
	if(selSold=="" || selSold==null || "null".equals(selSold))
	{
		selSold = (String)session.getValue("AgentCode");
		soldToQT = (String)session.getValue("AgentCode");
	}	

	if(request.getParameter("selSoldTo")!=null && !"".equals(request.getParameter("selSoldTo")) && !"null".equals(request.getParameter("selSoldTo")))		
		retShips = (ReturnObjFromRetrieve)getListOfShipTos(selSold.split("##")[0],(String)session.getValue("UserType"),(String)session.getValue("BussPart"),(String)session.getValue("IsSubUser"),Session);
	//out.println(retShips.toEzcString());	
%>
 <div class="block" style="padding-left: 0px; width:100%;">
 	<div class="block-title">
 	<strong>
 		<span><%=dispHeader+soldToName%></span>
	 </strong>
	 </div>
 </div>
 
 <script type="text/javascript">
	function getOrders()
 	{
 		Popup.showModal('headermodal');
 		document. myForm.action="ezNegotiatedOrders.jsp?ORDERTYPE=N";
 		document. myForm.submit();
 	}
 	function getDetails(SoNum,SoldTo,SysKey)
 	{
 		Popup.showModal('headermodal');
 		document. myForm.webOrNo.value=SoNum;
 		document. myForm.soldTo.value=SoldTo;
 		document. myForm.sysKey.value=SysKey;
 
 		document. myForm.action="ezNegotiateOrderDetails.jsp";
 		document. myForm.submit();
 	}
	function getShipTos()
	{
		Popup.showModal('headermodal');
		document. myForm.submit();
	}
	function openSearch(searchType)
	{
		var selSoldTo='';
		if(searchType=='SHIPTO')
		{
			selSoldTo = document.myForm.selSoldTo.value
			selSoldTo = selSoldTo.split('##')[0]
		}	
		window.open("../Sales/ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo+"&chkBlock=Y&fromPage=Y",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
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
 	<div id="it">
 	<button type="button" title="Search" class="button btn-update"><span>Show / Hide Search</span></button>
 	</div>
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
 		<th width=5%>Sold To Code</th>
 		<td width=15% colspan=4>
 		<ul>
 		<li>
 		<div class="input-box" style="width:350px !important;">
 		<select name="selSoldTo" onChange = "getShipTos()" style="width:300px !important;">
<%
		if("CU".equals(userRole))
		{
%>		
			<option value =""  >ALL</option>
 			
 <%
		}
 		if(retsoldto_A_SesGet!=null)
 		{
 			retsoldto_A_SesGet.sort(new String[]{"ECA_NAME"},true);
 			for(int i=0;i<retsoldto_A_SesGet.getRowCount();i++)
 			{
 				String soldToCode_A 	= retsoldto_A_SesGet.getFieldValueString(i,"EC_ERP_CUST_NO");
 				String soldToName_A 	= retsoldto_A_SesGet.getFieldValueString(i,"ECA_NAME");

 				String selected_A = "selected";
 
 				if(soldToQT.equals(soldToCode_A) )
 				{
 %>				
 					<option value="<%=soldToCode_A%>##<%=soldToName_A%>" <%=selected_A%>><%=soldToName_A%> : <%=soldToCode_A%></option>
 <%				}
 				else
 				{
 %>	
 					<option value="<%=soldToCode_A%>##<%=soldToName_A%>" ><%=soldToName_A%> : <%=soldToCode_A%></option>
 <%
 				}
 			}
 		}
 %>
 		</select>
 		<a href="javascript:openSearch('SOLDTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
 		</div>
 		</li>
 		</ul>
 		</td>
 		</Tr>
 		
 		<Tr>
		<th width=5%>Ship To Code</th>
 		<td width=15% colspan=4>
 		<ul>
 		<li>
 		<div class="input-box" style="width:350px !important;">
 		<select name="shipTo"  style="width:300px !important;">
 		<option value = "A">ALL </option> 
 <%
 		ArrayList byPassShips = new ArrayList();
 		if(retShips!=null)
 		{
 			retShips.sort(new String[]{"EC_PARTNER_NO"},true);
 			for(int i=0;i<retShips.getRowCount();i++)
 			{
 				String shipToCode_A 	= retShips.getFieldValueString(i,"EC_PARTNER_NO");
 				String shipToName_A 	= retShips.getFieldValueString(i,"ECA_COMPANY_NAME");
				
				if(byPassShips.contains(shipToCode_A))
					continue;
				else
					byPassShips.add(shipToCode_A); 				
 
 				String tempShip 	= retShips.getFieldValueString(i,"ECA_ACCOUNT_GROUP");
				if("CPDA".equalsIgnoreCase(tempShip)) shipToName_A = "Drop Ship";

				String selected_A = "selected";
 
 				if(shipToQT.equals(shipToCode_A))
 				{
 %>				
 					<option value="<%=shipToCode_A%>" <%=selected_A%>><%=shipToName_A%> : <%=shipToCode_A%></option>
 <%				}
 				else
 				{
 %>	
 					<option value="<%=shipToCode_A%>" ><%=shipToName_A%> : <%=shipToCode_A%></option>
 <%
 				}
 			}
 		}
 %>
 		</select>
 		<a href="javascript:openSearch('SHIPTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
 		</div>
 		</li>
 		</ul>
 		
 		</td> 		
 		</tr>
 
 		</thead>
 		</table>
 		<div align=right style=" text-align: right; float: right; margin-top: 8px; margin-right: -10px; ">
 		<button type="button" title="Submit" class="button btn-update" onClick="getOrders()"><span>Search</span></button>
 		<!--<input type="submit" class="button" title="Submit" onClick="getOrders()" />-->
 		</div>
 	</div>
 	</li>
 </ul>
 
 
 
 <%
 	Hashtable poSalesOrdersHT = new Hashtable();
 	Hashtable poValueHT = new Hashtable();
 	Hashtable poSysKeyHT = new Hashtable();
 	Vector poVector = new Vector();
 	
 
 	if(retobjCnt>0)
 	{
 		//out.println(retobj.toEzcString());
 		for(int i=0;i<retobjCnt;i++)
 		{
 			String poNumber 	= retobj.getFieldValueString(i,"PO_NO");
 			String soNumber 	= retobj.getFieldValueString(i,"WEB_ORNO");
 			String soNetValue  	= retobj.getFieldValueString(i,"NET_VALUE");
 			String soShipTo		= retobj.getFieldValueString(i,"SHIP_TO_CODE");
 			String soSysKey		= retobj.getFieldValueString(i,"SYSKEY");
 			Date chkDate 		= (Date)retobj.getFieldValue(i,"DOCDATE");
 			
 			String chkKey = poNumber+soShipTo+chkDate.getTime();
 			
 			if(poVector.contains(chkKey))
 			{
 				try{
 					poValueHT.put(poNumber,Double.parseDouble((String)poValueHT.get(chkKey))+Double.parseDouble(soNetValue)+"");
 				}catch(Exception e){
 				}	
 
 
 				poSalesOrdersHT.put(poNumber,(String)poSalesOrdersHT.get(chkKey)+"#"+soNumber);
 				poSysKeyHT.put(poNumber,(String)poSysKeyHT.get(chkKey)+"#"+soSysKey);
 
 			}else{
 				poVector.addElement(chkKey);
 				poSalesOrdersHT.put(chkKey,soNumber);
 				poValueHT.put(chkKey,soNetValue);
 				poSysKeyHT.put(chkKey,soSysKey);
 			}
 		}
 	}	
 		
 		//out.println("::::::::::::::::::poSalesOrdersHT:::::::::"+poSalesOrdersHT);
 		//out.println("::::::::::::::::::poValueHT:::::::::"+poValueHT);
 %>		
 <div class="col1-set">
 <div class="info-box"><br>
 
 <input type="hidden" name="webOrNo">
 <input type="hidden" name="soldTo">
 <input type="hidden" name="selectedSoldTo">
 <input type="hidden" name="sysKey">
 <input type="hidden" name="fromNeg" value ="Y">
 <input type="hidden" name="negotiateType" value="<%=negotiateType%>">
 <input type="hidden" name="displayOrder" value="<%=displayOrder%>">
  	<!-- <table class="display" id="example"> -->
 	<table class="data-table" id="example">
 	<thead>
 	<tr>
 	<th width=20%>PO Id</th>
 	<th width=20%>PO Date</th>
 	<th width=20%>Posted Date</th>
 	<th width=20%>Amount [USD]</th>
 	<th width=20%>Customer</th>
 	</tr>
 	</thead>
 	<tbody>
 <%
 		
 	poVector = new Vector();
  	for(int i=0;i<retobjCnt;i++)
 	{
 		String tempsoNumber = "";
 		String poNumber = retobj.getFieldValueString(i,"PO_NO");
 		String soNumber	= retobj.getFieldValueString(i,"WEB_ORNO");
 		String netValue	= retobj.getFieldValueString(i,"NET_VALUE");
 		String soCust 	= retobj.getFieldValueString(i,"SOLD_TO_CODE");
		String soShipTo	= retobj.getFieldValueString(i,"SHIP_TO_CODE");
		Date chkDate 	= (Date)retobj.getFieldValue(i,"DOCDATE"); 		
		String chkKey   = poNumber+soShipTo+chkDate.getTime();
		
 		String DocDate 	= retobj.getFieldValueString(i,"RES1");
 		String pono = retobj.getFieldValueString(i,"PO_NO");
 		
 
 		if(poVector.contains(chkKey))
 			continue;
 		else
 			poVector.addElement(chkKey);	
 
 		//out.println("poVector::::::"+poVector);
 
 		/*StringTokenizer st1 = new StringTokenizer(DocDate,"/");
 		String[] docsplit = new String[3];
 		int h=0;
 		while(st1.hasMoreTokens())
 		{
 			docsplit[h]=st1.nextToken();
 			h++;
 		}			
 		java.util.Date dDate = new java.util.Date(Integer.parseInt(docsplit[2])-1900,Integer.parseInt(docsplit[0])-1,Integer.parseInt(docsplit[1]));
 		DocDate = formatDate.getStringFromDate(dDate,"/",formatDate.MMDDYYYY);*/
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
 
 		String poValueBD="0";
 		poValueBD = (String)poValueHT.get(chkKey);
 
 		try
 		{
 			poValueBD = new java.math.BigDecimal(poValueBD).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 		}
 		catch(Exception e){
 			poValueBD = (String)poValueHT.get(chkKey);
 		}
 %>
 		<tr>
 		<td width=20%><a href="javascript:getDetails('<%=poSalesOrdersHT.get(chkKey)%>','<%=soCust%>','<%=poSysKeyHT.get(chkKey)%>')"><%=pono%></a></td>
 		<td width=20%><%=DocDate%></td>
 		<td width=20%><%=DocDate%></td>
 		<td width=20%><%=poValueBD%></td>
 		<td width=20%><%=soCust%></td>
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
 document.getElementById("");
 $("#display").toggle( "slow" );
 });
<%
	if((request.getParameter("selSoldTo")==null || "".equals(request.getParameter("selSoldTo")) || "null".equals(request.getParameter("selSoldTo"))) && "CU".equals(userRole))		
	{
%>
		document.myForm.selSoldTo.value=""
<%
	}
%> 
 </script>
 </form>
 
 </div>
 </div>
 </div>
<%@ include file="ezMyOrdersMenuLink.jsp"%>

 </div>
</div>