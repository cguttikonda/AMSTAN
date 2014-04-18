<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners">
<div class="my-account">
<div class="dashboard">
<%!	
	public Vector getSubUserShips(String user_id,ezc.session.EzSession Session)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		//String query="SELECT A.*, B.ECA_NO, B.ECA_NAME, B.ECA_COMPANY_NAME,B.ECA_ERP_UPDATE_FLAG, B.ECA_PHONE, B.ECA_ADDR_2,B.ECA_ADDR_1,B.ECA_CITY,B.ECA_STATE,B.ECA_PIN,B.ECA_COUNTRY,B.ECA_TRANSORT_ZONE,B.ECA_JURISDICTION_CODE,B.ECA_LANG,B.ECA_EMAIL,B.ECA_WEB_ADDR FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE  A.EC_PARTNER_FUNCTION IN ('WE') AND A.EC_PARTNER_NO IN (SELECT DISTINCT(EECD_DEFAULTS_VALUE) FROM EZC_ERP_CUSTOMER_DEFAULTS WHERE EECD_NO IN (SELECT EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+user_id+"' AND EUD_KEY='SOLDTOPARTY' ) AND EECD_DEFAULTS_KEY='SHIPTO' AND EECD_USER_ID='"+user_id+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO AND EC_SYS_KEY='"+sysKey+"' AND EC_BUSINESS_PARTNER='"+bussPart+"'";
		String query="SELECT DISTINCT(EUD_VALUE) SHIPTO FROM EZC_USER_DEFAULTS WHERE  EUD_USER_ID='"+user_id+"' AND EUD_KEY='SHIPTOPARTY' ";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}
		Vector toDelShips = null;
		int retCnt = 0;
		if(retObjMisc!=null){
			retCnt = retObjMisc.getRowCount();
			toDelShips =new Vector();
		}	
		if(retCnt>0)	
		{
			for(int i=0;i<retCnt;i++)	
			{
				toDelShips.add(retObjMisc.getFieldValueString(i,"SHIPTO"));		

			}
		}

		return toDelShips;
	}
	public ReturnObjFromRetrieve getListOfShipTos(String selSol,String userType,String BussPart, String isSubUser, ezc.session.EzSession Session)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		
		miscParams.setIdenKey("MISC_SELECT");
		
		String appendQry = "";
		if("3".equals(userType))
			appendQry = "AND EC_BUSINESS_PARTNER='"+BussPart+"'";
		String query="SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME,ECA_ACCOUNT_GROUP,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO='"+selSol+"' AND EC_PARTNER_FUNCTION='WE' AND EC_NO=ECA_NO ";
	
		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::34566::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			if("Y".equals(isSubUser))
			{
				if(retObjMisc!=null)
				{
					Vector delShips = (Vector)getSubUserShips(Session.getUserId(),Session);
					for(int i=retObjMisc.getRowCount()-1;i>=0;i--)
					{
						String toBeDel = retObjMisc.getFieldValueString(i,"EC_PARTNER_NO");
						String blockCode_A = retObjMisc.getFieldValueString(i,"ECA_EXT1");
						if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
						{
							retObjMisc.deleteRow(i);
						}
						else
						{
							if(!delShips.contains(toBeDel))
								retObjMisc.deleteRow(i);
						}
					}
				}
			}			
			else
			{
				if(retObjMisc!=null)
				{
					for(int i=retObjMisc.getRowCount()-1;i>=0;i--)
					{
						String blockCode_A = retObjMisc.getFieldValueString(i,"ECA_EXT1");
						if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
							retObjMisc.deleteRow(i);
					}
				}
			}
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}
		

		return retObjMisc;
	}	
%>
<%

	ReturnObjFromRetrieve orderList 	= null;
	ezc.ezparam.ReturnObjFromRetrieve ret   = null;
	int cnt= 0;
	
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	EzCurrencyFormat myFormat = new EzCurrencyFormat();
	ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	String soldToQT = request.getParameter("selSoldTo");
	if(soldToQT==null || "null".equals(soldToQT)) soldToQT ="";
 	String shipToQT = request.getParameter("shipTo");
  	if(shipToQT==null || "null".equals(shipToQT)) shipToQT ="";	
	String selSold = request.getParameter("selSoldTo");
	if(selSold=="" || selSold==null || "null".equals(selSold))
	{
		selSold = (String)session.getValue("AgentCode");
		soldToQT = (String)session.getValue("AgentCode");
	}
	String tobeSelected = "";	

	if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_S+"/"+fDate_S+"/"+fyear;
	if(toDate==null || "null".equalsIgnoreCase(toDate)) toDate = cMonth_S+"/"+cDate_S+"/"+cYear;
	ReturnObjFromRetrieve retShips   	 = null;
	if(request.getParameter("selSoldTo")!=null && !"".equals(request.getParameter("selSoldTo")) && !"null".equals(request.getParameter("selSoldTo")))		
		retShips = (ReturnObjFromRetrieve)getListOfShipTos(selSold,(String)session.getValue("UserType"),(String)session.getValue("BussPart"),(String)session.getValue("IsSubUser"),Session);
%> 

<!-- jQuery for sorting & pagination STARTS here-->

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	

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
				    "sButtonText": "Download CSV",
				    "sFileName": "Order List - *.csv"
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
	//out.println("searchSoldTo:::::"+request.getParameter("searchSoldTo")+":::soldToQT:::"+soldToQT);
	//out.println("soldToQT:::equals:::"+soldToQT.equals(request.getParameter("searchSoldTo")));
	//if(!"null".equals(request.getParameter("searchSoldTo")) && (soldToQT.equals(request.getParameter("searchSoldTo"))))
	{
%>	
		<%@ include file="../../../Includes/JSPs/Sales/iOpenOrdersList.jsp"%>
<%
	}
	/******* This commented is to handle the multiple requests to SAP on selecting soldTo to fetch Ship To codes. ****/
	/*if(orderList==null)
	{
		out.println("From Session::::");
		orderList = (ReturnObjFromRetrieve)session.getValue("ORDERLIST");
		cnt = orderList.getRowCount();
	}	
	if(ret==null)
		ret = (ReturnObjFromRetrieve)session.getValue("DATERET");
	
	//out.println("orderList:::::::::"+orderList.toEzcString());*/
	
	
	/******* This commented is to handle the multiple requests to SAP on selecting soldTo to fetch Ship To codes. ****/	
		
	
	
	String dispHeader = "0 Open Orders";

	if(cnt>0)
		//dispHeader = "<font color=\"#66cc33;\">"+cnt+"</font> Open Orders";
		dispHeader = "Open Orders";	
		
	String disp="display:none";

	if("Y".equals(searchStat) || "Y"==searchStat)
	disp = "";		
%>
<div class="block" style="padding-left:0px;width:100%">
	<div class="block-title" >
		<strong>
			<span><%=dispHeader%></span>
		</strong>
	</div>
</div>
<%
	String forkey 	= (String)session.getValue("formatKey");
	if(forkey==null) forkey="/";

	
%>
<script type="text/javascript">
	function getOrders()
	{
		Popup.showModal('headermodal');
		document.myForm.action="ezSalesOrders.jsp";
		document.myForm.submit();
	}
	function getDetails(SoNum,SoldTo,poValue,shipTo,poNo,poDate)
	{
		Popup.showModal('headermodal');
		document.myForm.salesOrder.value= SoNum;
		document.myForm.soldTo.value	= SoldTo;
		document.myForm.OrdShipTo.value	= shipTo;
		document.myForm.poValue.value	= poValue;
		document.myForm.poNo.value	= poNo;
		document.myForm.poDate.value	= poDate;

		document.myForm.action="ezSalesOrderDetails.jsp";
		document.myForm.submit();
	}
	function openSearch(searchType)
	{
		var selSoldTo='';
		if(searchType=='SHIPTO')
			selSoldTo = document.myForm.selSoldTo.value
		window.open("../Sales/ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo+"&chkBlock=Y&fromPage=Y",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
	}
	function getShipTos()
	{
		Popup.showModal('headermodal');
		document. myForm.submit();
	} 	
</script>
<form name="myForm" method="post">
<input type="hidden" name="searchStat" value="Y">
<input type="hidden" name="all" value="ALL">
<ul class="form-list">
	<li>
	<div id="it">
	<!--<input type="button" class="button" title="Show/Hide" value="Show/Hide"/>-->
	<button type="button" title="Search" class="button btn-update"><span>Show / Hide Search</span></button>
	</div>
	</li>
	<li>
	<div id="display" style="<%=disp%>">
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
 		<ul style="padding-left: 20px;">
 		<li>
 		<div class="input-box" style="width:350px !important;">
 		<select name="selSoldTo" onChange = "getShipTos()" style="width:300px !important;">
<%
		if("CU".equals(userRole))
		{
%>		
 			<option value ="" <%=tobeSelected%> >ALL</option>
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
 					<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%> : <%=soldToCode_A%></option>
 <%				}
 				else
 				{
 %>	
 					<option value="<%=soldToCode_A%>" ><%=soldToName_A%> : <%=soldToCode_A%></option>
 <%
 				}
 			}
 		}
 %>
 		</select>
 		<a href="javascript:openSearch('SOLDTO')"><img height="20px" width="20px" title="Search" src="../../Images/search2.png"></a>
 		</div>
 		</li>
 		</ul>
 		</td>
 		</Tr>
 		
 		<Tr>
		<th width=5%>Ship To Code</th>
 		<td width=15% colspan=4>
 		<ul style="padding-left: 20px;">
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
 		<a href="javascript:openSearch('SHIPTO')"><img height="20px" width="20px" title="Search" src="../../Images/search2.png"></a>
 		</div>
 		</li>
 		</ul>
 		
 		</td> 		
 		</tr>
 		 
 		</thead>
 		</table>
 		<div style="margin-top:8px;float:right;margin-right: -10px;">
 		<!--<input type="submit" class="button" title="Submit" onClick="getOrders()" />-->
 		<button title="Submit" class="button btn-update" onClick="getOrders()" ><span>Search</span></button>
 		</div>
</li>
</ul>
<%
	/*ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();	
	if(shipToQT!=null && !"".equals(shipToQT) && !"A".equals(shipToQT))
		mySearch.search(orderList,"ShipTo",request.getParameter("shipTo"));*/
		
	Hashtable poSalesOrdersHT = new Hashtable();
	Hashtable poValueHT = new Hashtable();
	Vector poVector = new Vector();
//out.println(orderList.toEzcString());
	if(cnt>0)
	{
		for(int i=0;i<cnt;i++)
		{
			if(shipToQT!="" && !"".equals(shipToQT) && !"A".equals(shipToQT))
			{
				String shipTo = orderList.getFieldValueString(i,"ShipTo");
				if(!(shipToQT.equals(shipTo)))
					continue;	
			}			
			
			String poNumber 	= orderList.getFieldValueString(i,"PurchNo");
			String soNumber 	= orderList.getFieldValueString(i,"SdDoc");
			String soNetValue  	= orderList.getFieldValueString(i,"NetValHd");
			String shipTo		= orderList.getFieldValueString(i,"ShipTo");
			String docType		= orderList.getFieldValueString(i,"DocType");
			String docDate 		= ret.getFieldValueString(i,"ValidFrom");//DocDate
									
			if("L2".equals(docType) || "ZRET".equals(docType) || "G2".equals(docType))
				continue;
			StringTokenizer st1 = new StringTokenizer(docDate,"/");
			String[] docsplit = new String[3];
			int h=0;
			while(st1.hasMoreTokens())
			{
				docsplit[h]=st1.nextToken();
				h++;
			}			
			//out.println("+++ 0 - Tokenized the Date"+DocDate);
			java.util.Date dDate = new java.util.Date(Integer.parseInt(docsplit[2])-1900,Integer.parseInt(docsplit[0])-1,Integer.parseInt(docsplit[1]));
			String chkKey = poNumber+shipTo+dDate.getTime();
			//out.println("chkKey::::::::::::"+chkKey);			
		
			if(poVector.contains(chkKey))
			{
				try{
					poValueHT.put(poNumber+dDate.getTime(),Double.parseDouble((String)poValueHT.get(poNumber+dDate.getTime()))+Double.parseDouble(soNetValue)+"");
				}catch(Exception e){
				}	


				poSalesOrdersHT.put(poNumber+dDate.getTime(),(String)poSalesOrdersHT.get(poNumber+dDate.getTime())+"ÿ"+soNumber);

			}else{
				poVector.addElement(chkKey);
				poSalesOrdersHT.put(poNumber+dDate.getTime(),soNumber);
				poValueHT.put(poNumber+dDate.getTime(),soNetValue);
			}
		}
		
		//out.println("::::::::::::::::::poSalesOrdersHT:::::::::"+poSalesOrdersHT);
		//out.println("::::::::::::::::::poValueHT:::::::::"+poValueHT);
		
%>
<div class="col1-set">
<div class="info-box"><br>

<input type="hidden" name="salesOrder">
<input type="hidden" name="soldTo">
<input type="hidden" name="OrdShipTo">
<input type="hidden" name="poValue">
<input type="hidden" name="poNo">
<input type="hidden" name="poDate">
<input type="hidden" name="searchSoldTo" value="<%=request.getParameter("searchSoldTo")%>">

	<!-- <table class="display" id="example"> -->
	<table class="data-table" id="example" style="width:680px">
	<thead>
	<tr>
	<th width=20%>PO Id</th>
	<th width=20%>PO Date</th>
	<th width=20%>Order Posted Date</th>
	<th width=20%>Amount [USD]</th>
	<th width=10%>Status</th>
	<th width=20%>Customer</th>
	<th width=20%>CreatedBy</th>
	</tr>
	</thead>
	<tbody>
<%
		Hashtable dStatusHT = new Hashtable();

		dStatusHT.put(" ","Not relevant");
		dStatusHT.put("A","Open");
		dStatusHT.put("B","Open");
		dStatusHT.put("C","Closed");
		
		poVector = new Vector();
				
		for(int i=0;i<cnt;i++)
		{
			String shipTo	= orderList.getFieldValueString(i,"ShipTo");
			if(shipToQT!="" && !"".equals(shipToQT) && !"A".equals(shipToQT))
				if(!(shipToQT.equals(shipTo)))
					continue;	
			String docType = orderList.getFieldValueString(i,"DocType");
			if("L2".equals(docType) || "ZRET".equals(docType) || "G2".equals(docType))
				continue;

			String poHyperLink="";
			String tempsoNumber = "";
			String DocDate 		= ret.getFieldValueString(i,"ValidFrom");//DocDate
			StringTokenizer st1 = new StringTokenizer(DocDate,"/");
			
			String[] docsplit = new String[3];
			int h=0;
			while(st1.hasMoreTokens())
			{
				docsplit[h]=st1.nextToken();
				h++;
			}
			java.util.Date dDate = new java.util.Date(Integer.parseInt(docsplit[2])-1900,Integer.parseInt(docsplit[0])-1,Integer.parseInt(docsplit[1]));
			//DocDate = formatDate.getStringFromDate(dDate,forkey,formatDate.MMDDYYYY);
			DocDate = ret.getFieldValueString(i,"DocDate");
											
			String soNumber	= orderList.getFieldValueString(i,"SdDoc");
			String netValue	= orderList.getFieldValueString(i,"NetValHd");
			String soCust 	= orderList.getFieldValueString(i,"SoldTo");
			
			String DocStatus = orderList.getFieldValueString(i,"EzDocStatus");
			if("".equals(DocStatus))DocStatus = orderList.getFieldValueString(i,"DocStatus");
			String pono = orderList.getFieldValueString(i,"PurchNo");
			String createdBy = orderList.getFieldValueString(i,"EzCreatedBy");
			if(createdBy==null || "".equals(createdBy) || "null".equals(createdBy)) createdBy = "";
			String delivStatus = (String)dStatusHT.get(DocStatus);
			
			if(poVector.contains(pono+shipTo+dDate.getTime()))
				continue;
			else
				poVector.addElement(pono+shipTo+dDate.getTime());			
			
			
			String podate=ret.getFieldValueString(i,"ValidFrom");
			try
			{
				tempsoNumber = (Long.parseLong(soNumber))+"";
			}
			catch(Exception e)
			{	
				tempsoNumber = soNumber;
			}

			if((DocDate==null)||(DocDate=="null")||(DocDate.trim().length() == 0)) DocDate ="N/A";
			if((podate==null)||(podate=="null")||(podate.trim().length() == 0)) podate ="N/A";
			if((netValue==null)||(netValue=="null")||(netValue.trim().length() == 0)) netValue ="N/A";
			
			String poValueBD="0";
			poValueBD = (String)poValueHT.get(pono+dDate.getTime());
			
			try
			{
				poValueBD = new java.math.BigDecimal(poValueBD).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			}
			catch(Exception e){
				poValueBD = (String)poValueHT.get(pono+dDate.getTime());
			}
			if("".equals(pono.trim()))
			{
				poHyperLink = "<a href=javascript:getDetails('"+poSalesOrdersHT.get(pono+dDate.getTime())+"','"+soCust+"','"+poValueBD+"','"+pono+"','"+podate+"')>";
				//out.println("Boolean:::::::"+"".equals(pono.trim())+"pono:::::::"+pono+"INDEX::::::::"+i+"poHyperLink:::"+poHyperLink);	
			}
			String soNo = orderList.getFieldValueString(i,"SdDoc");
				
%>
			<tr>
			<td width=20%><a href="javascript:getDetails('<%=poSalesOrdersHT.get(pono+dDate.getTime())%>','<%=soCust%>','<%=poValueBD%>','<%=shipTo%>','<%=pono%>','<%=podate%>')"><%=pono%></a></td>
			<td width=20%><%=podate%></td>
			<td width=20%><%=DocDate%></td>
			<td width=20%><%=myFormat.getCurrencyString(poValueBD)%></td>
			<td width=10%><%=delivStatus%></td>
			<td width=20%><%=soCust%></td>
			<td width=20%><%=createdBy%></td>
			
			</tr>
<%
		}
%>
	</tbody>
	</table>
</div>
</div>

<%
	}
%>
</form>
</div>
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
<%@ include file="ezMyOrdersMenuLink.jsp"%>

</div>
</div>
<%
	/*if(!"null".equals(request.getParameter("searchSoldTo")) && (soldToQT.equals(request.getParameter("searchSoldTo"))))
	{
		session.putValue("ORDERLIST",orderList);
		session.putValue("DATERET",ret);
	}*/
	
%>	