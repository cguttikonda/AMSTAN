<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners">
<div class="my-account">
<div class="dashboard">
<%@ page import="java.util.*,java.text.ParseException,java.text.SimpleDateFormat,java.text.DateFormat" %>
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
		String query="SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME,ECA_ACCOUNT_GROUP FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO='"+selSol+"' AND EC_PARTNER_FUNCTION='WE' AND EC_NO=ECA_NO ";
	
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
						if(!delShips.contains(toBeDel))
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
<script type="text/javascript">
	function getOrders()
	{
		Popup.showModal('headermodal');
		document.myForm.action="ezExpiringJobQuotes.jsp";
		document.myForm.submit();
	}
	function getJobDetails(salesDoc,soldToCode,docStatus)
	{
		Popup.showModal('headermodal');
		document.myForm.salDoc.value=salesDoc;
		document.myForm.soldTo.value=soldToCode;
		document.myForm.docStat.value=docStatus;
		document.myForm.fromPage.value='ezExpiringJobQuotes.jsp';
		

		document.myForm.action="ezJobQuoteDetails.jsp";
		document.myForm.submit();
	}
	function getShipTos()
	{

		document. myForm.submit();

	} 	
	function openSearch(searchType)
	{
		var selSoldTo='';
		if(searchType=='SHIPTO')
			selSoldTo = document.myForm.selSoldTo.value
		window.open("../Sales/ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo+"&chkBlock=Y&fromPage=Y",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
	}	
</script>

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

	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	String BussPart =  (String)session.getValue("BussPart");
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
	String disp="display:none";
	String searchStat = request.getParameter("searchStat");
 	if("Y".equals(searchStat) || "Y"==searchStat)
 		disp = "";	

	if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_S+"/"+fDate_S+"/"+fyear;
	if(toDate==null || "null".equalsIgnoreCase(toDate)) toDate = cMonth_S+"/"+cDate_S+"/"+cYear;
	String noDays = request.getParameter("noDays");
	int expiringIn = 60;
	if(noDays!=null && !"null".equalsIgnoreCase(noDays) && !"".equals(noDays))
	{	try{
			expiringIn = Integer.parseInt(noDays);
		}	
		catch(Exception e){ expiringIn = 60;}
	}	
		

	//ReturnObjFromRetrieve retObjExpSQ 	 = (ReturnObjFromRetrieve)session.getValue("retObjExSQSes");
	
	/*********** SAP CALL TO BRING EXPING QUOTES Start *****/
	client1=null;
	function = null;

	site_SW = (String)session.getValue("Site");
	skey_SW = "999";

	SalQCnt=0;



	String colSQ_Expiring[]={"SALESDOC","ITEMNO","MATERIAL","MATDESC","VALIDFROM","VALIDTO","REQQTY","NETPRICE","NETVALUE","DOCDATE","SOLDTO","SOLDTONAME","SHIPTO","SHIPTONAME","POJOBNAME","DOCSTATUS"};
	ReturnObjFromRetrieve retObjExpSQ = new ReturnObjFromRetrieve(colSQ_Expiring);
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();

	try
	{
		function= EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_LIST",site_SW+"~"+skey_SW);
		JCO.ParameterList sapProc = function.getImportParameterList();
		JCO.Table salesTable = function.getTableParameterList().getTable("SALES_ORDERS");



		sapProc.setValue(soldToQT,"CUSTOMER_NUMBER");
		sapProc.setValue("2","TRANSACTION_GROUP");
		sapProc.setValue("O","WITHOPENCLOSEDESTATUS");

		//valid from
		Date sqDateFrom = new Date();


		String strDateTo="12/31/9999";

		Calendar cal = Calendar.getInstance();																								
		cal.add(Calendar.DATE, expiringIn);								
		Date ExsDateTo = cal.getTime();
		//out.println("expiringIn::::"+expiringIn);
		//out.println(ExsDateTo);

		DateFormat formatter;
		Date sqDateToo = new Date();
		formatter = new SimpleDateFormat("MM/dd/yyyy");
		sqDateToo = (Date)formatter.parse(strDateTo); 


		salesTable.appendRow();
		salesTable.setValue(sqDateFrom,"VALID_FROM");
		salesTable.setValue(ExsDateTo,"VALID_TO");

		if("CU".equals(userRole) && "".equals(request.getParameter("selSoldTo")))
		{
			JCO.Table custSelectionTable = function.getTableParameterList().getTable("CUSTOMER_SELECTION");
			String allSoldTos = (String)session.getValue("SOLDTO_SUPER");
			if(allSoldTos.indexOf("¥")!=-1)
			{
				java.util.StringTokenizer allsoldTo = new java.util.StringTokenizer(allSoldTos,"¥");
				while(allsoldTo.hasMoreTokens())
				{
					String soldToStr = allsoldTo.nextToken()+"";
					custSelectionTable.appendRow();
					custSelectionTable.setValue(soldToStr, "CUSTOMER");
					ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+soldToStr,"D");
				}
			}
			else
			{
				custSelectionTable.appendRow();
				custSelectionTable.setValue(allSoldTos, "CUSTOMER");
			}
		}

		try
		{
			client1 = EzSAPHandler.getSAPConnection(site_SW+"~"+skey_SW);
			client1.execute(function);
		}
		catch(Exception ec)
		{
			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
		}

		JCO.Table headerTable 	= function.getTableParameterList().getTable("SALES_ORDERS");


		//out.println("headerTable:::"+headerTable);

		if(headerTable!=null)
		{

			if (headerTable.getNumRows() > 0)
			{
				do
				{

					String sdDoc  	= (String)headerTable.getValue("SD_DOC");
					Date validFrom	= (Date)headerTable.getValue("VALID_FROM");
					Date validTo  	= (Date)headerTable.getValue("VALID_TO");
					Date sqDateTo 	= new Date();


					int dateComp = validTo.compareTo(sqDateTo);																

					if(dateComp<0) 
					  continue;								  								

					int dateCompTo = validTo.compareTo(ExsDateTo);


					if(dateCompTo>0)
					  continue;	

					retObjExpSQ.setFieldValue("VALIDFROM",validFrom);
					retObjExpSQ.setFieldValue("VALIDTO",validTo);


					 retObjExpSQ.setFieldValue("SALESDOC",headerTable.getValue("SD_DOC"));
					 //retObjSQ.setFieldValue("ITEMNO",headerTable.getValue("ITM_NUMBER"));
					 //retObjSQ.setFieldValue("MATERIAL",headerTable.getValue("MATERIAL"));
					 //retObjSQ.setFieldValue("MATDESC",headerTable.getValue("SHORT_TEXT"));
					 //retObjSQ.setFieldValue("REQQTY",headerTable.getValue("REQ_QTY"));
					 //retObjSQ.setFieldValue("NETPRICE",headerTable.getValue("NET_PRICE"));
					 retObjExpSQ.setFieldValue("NETVALUE",headerTable.getValue("NET_VAL_HD"));
					 retObjExpSQ.setFieldValue("DOCDATE",headerTable.getValue("DOC_DATE"));
					 retObjExpSQ.setFieldValue("SOLDTO",headerTable.getValue("SOLD_TO"));
					 retObjExpSQ.setFieldValue("SOLDTONAME",headerTable.getValue("NAME"));
					 retObjExpSQ.setFieldValue("SHIPTO",headerTable.getValue("SHIP_TO"));
					 retObjExpSQ.setFieldValue("SHIPTONAME",headerTable.getValue("SHIP_TO_NAME"));								 
					 retObjExpSQ.setFieldValue("POJOBNAME",headerTable.getValue("PURCH_NO"));
					 retObjExpSQ.setFieldValue("DOCSTATUS",headerTable.getValue("DOC_STATUS"));
					 retObjExpSQ.addRow();
				}
				while(headerTable.nextRow());
			}

		}
		//out.println("headerTable:::"+retObjExpSQ.toEzcString());
	}
	catch(Exception e)
	{
		out.println("EXCEPTION>>>>>>"+e);
	}
	finally
	{
		if (client1!=null)
		{
			JCO.releaseClient(client1);
			client1 = null;
			function=null;
		}
	}
	/*********** SAP CALL TO BRING EXPING QUOTES End ********/
	
	if(shipToQT!=null && !"".equals(shipToQT) && !"A".equals(shipToQT))
		mySearch.search(retObjExpSQ,"SHIPTO",request.getParameter("shipTo"));
	
	ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	//ReturnObjFromRetrieve retShips   	 = (ReturnObjFromRetrieve)getListOfShipTos(selSold,(String)session.getValue("UserType"),BussPart,(String)session.getValue("IsSubUser"),Session);

	int cntSQ =0;
	if(retObjExpSQ!=null &&  retObjExpSQ.getRowCount()>0)	
		cntSQ =  retObjExpSQ.getRowCount();				
	//out.println("cntSQ::::::::::"+cntSQ);	
		
	String dispHeader = "Expiring Job Quotes";
%>
<div class="block" style="padding-left:0px;width:100%">
<div class="block-title">
	<strong><span><%=dispHeader%></span></strong>
</div>
</div>
<form name="myForm" method="post">

<input type="hidden" name="salDoc">
<input type="hidden" name="soldTo">
<input type="hidden" name="docStat">
<input type="hidden" name="fromPage" value="">
<input type="hidden" name="searchStat" value="Y">

 	<ul class="form-list">
 	
 	<li>
 	<div id="it">
 	<!--<input type="button" class="button" title="Search Criteria" value="Search Criteria"/>-->
 	<button type="button" title="Search" class="button btn-update"><span>Show / Hide Search</span></button>
 	</div>
 	</li>
 
 	<li>
 	<div id="display" style="<%=disp%>" >
 	
 	<table class="data-table">
 		<thead>
 		
 		<!--<tr>
 		<th width=5%>Document Date</th>
 		<th width=5% align=center>From</th>
 		<td width=15%><input type="text" size="12" id="fromDate" name="fromDate" value="<%=fromDate%>" readonly /><%=getDateImage("fromDate")%></td>
 		<th width=5% align=center>To</th>
 		<td width=15%><input type="text" size="12" id="toDate" name="toDate" value="<%=toDate%>" readonly /><%=getDateImage("toDate")%></td>
 
 		</tr>-->
 
 		
 		<tr>
 		<th width=5%>Sold To Code</th>
 		<td width=15% colspan=4>
 		<ul style="padding-left: 20px;">
 		<li>
 		<div class="input-box" style="width:350px !important;">
 		<select name="selSoldTo" style="width:300px !important;"><!--onChange = "getShipTos()" -->
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
 					<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%></option>
 <%				}
 				else
 				{
 %>	
 					<option value="<%=soldToCode_A%>" ><%=soldToName_A%></option>
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
 		
 		<!--<Tr>
		<th width=5%>Ship To Code</th>
 		<td width=15% colspan=4>
 		<ul style="padding-left: 20px;">
 		<li>
 		<div class="input-box" style="width:350px !important;">
 		<select name="shipTo"  style="width:300px !important;">
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
 					<!--<option value="<%//=shipToCode_A%>" <%//=selected_A%>><%//=shipToName_A%></option>-->
 <%				/*}
 				else
 				{*/
 %>	
 					<!--<option value="<%//=shipToCode_A%>" ><%//=shipToName_A%></option>-->
 <%
 				/*}
 			}
 		}*/
 %>
 		<!--</select>
 		<a href="javascript:openSearch('SHIPTO')"><img height="20px" width="20px" title="Search" src="../../Images/search2.png"></a>
 		</div>
 		</li>
 		</ul>
 		
 		</td> 		
 		</tr>-->
 		<Tr>
 		<th width=10%>Expiring in (Enter the No. of days)</th>
		<td width=20% style="padding-left: 23px;"><input type="text" size="12" name="noDays" value="<%=expiringIn%>" /></td>
 		</Tr
 
 		</thead>
 		</table>
 		<div style="margin-top:8px;float:right;margin-right: -10px;">
 		<!--<input type="submit" class="button" title="Submit" onClick="getOrders()" />-->
 		<button title="Submit" class="button btn-update" onClick="getOrders()" ><span>Search</span></button>
 		</div>
 	</div>
 	</li>
 </ul>
 

<div class="col1-set">
<div class="info-box"><br>							

	<table class="data-table" id="example" >				
	<thead>																		
	
	<tr>
	
	<th width=25%>Job Name</th>
	<th width=10%>QuoteNo.<br>Quote Date</th>
	<th width=15%>Validity</th>
	<th width=44%>Job Ship-to Account </th>
	<th width=16%>NetValue[USD]</th>
	
	</tr>
	</thead>
	<tbody>
<%
				
		if(cntSQ>0)
		{
			for(int i=0;i<cntSQ;i++)									      
			{												      

				String salesDoc    = retObjExpSQ.getFieldValueString(i,"SALESDOC");			      
				//String itemNo    = retObjExpSQ.getFieldValueString(i,"ITEMNO");			      
				//String matCode   = retObjExpSQ.getFieldValueString(i,"MATERIAL");			      
				//String matDesc   = retObjExpSQ.getFieldValueString(i,"MATDESC"); 			      
				Date validFrom 	   = (Date)retObjExpSQ.getFieldValue(i,"VALIDFROM");
				Date validTo 	   = (Date)retObjExpSQ.getFieldValue(i,"VALIDTO");
				//String reqQty    = retObjExpSQ.getFieldValueString(i,"REQQTY");
				//String netPrice  = retObjExpSQ.getFieldValueString(i,"NETPRICE");
				String netValue    = retObjExpSQ.getFieldValueString(i,"NETVALUE");
				Date docDate 	   = (Date)retObjExpSQ.getFieldValue(i,"DOCDATE");
				String soldToCode  = retObjExpSQ.getFieldValueString(i,"SOLDTO");
				String soldToName  = retObjExpSQ.getFieldValueString(i,"SOLDTONAME");
				String shipToCode  = retObjExpSQ.getFieldValueString(i,"SHIPTO");
				String shipToName  = retObjExpSQ.getFieldValueString(i,"SHIPTONAME");						
				String poJobName   = retObjExpSQ.getFieldValueString(i,"POJOBNAME");
				String docStatus   = "X";//retObjExpSQ.getFieldValueString(i,"DOCSTATUS");


				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
				String valFromStr = formatter.format(validFrom);
				String valToStr = formatter.format(validTo);
				String docDateStr = formatter.format(docDate);

				String tempSalesDoc="",tempSoldToCode="",tempShipToCode="";

				try
				{
					tempSalesDoc = (Long.parseLong(salesDoc))+"";
				}
				catch(Exception e)
				{	
					tempSalesDoc = salesDoc;
				}

				try
				{
					tempSoldToCode = (Long.parseLong(soldToCode))+"";
					tempShipToCode = (Long.parseLong(shipToCode))+"";
				}
				catch(Exception e)
				{	
					tempSoldToCode = soldToCode;
					tempShipToCode = shipToCode;
				}

%>
				<tr>
				<td width=25%><a href="javascript:getJobDetails('<%=salesDoc%>','<%=soldToCode%>','<%=docStatus%>')"><%=poJobName%></a></td>
				<td width=18%><%=tempSalesDoc%><br><%=docDateStr%></td>
				<td width=15%><%=valFromStr%><%=" to "%><%=valToStr%></td>
				<td width=19%><%=tempShipToCode%><br><%=shipToName%></td>
				<td width=16%><%=netValue%></td>
				</tr>
<%
			}
		}
		else if(cntSQ==0 && "Y".equals(searchStat))
		{
%>
			 <div class="block" style="padding-left:0px; width:100%;">
				<div class="block-title">
					<strong>
						<span>NO results for the search criteria</span>
					</strong>
				</div>
			</div>	
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
function funClickLink(actionPage,statusval){
	Popup.showModal('headermodal');
	document.lMenuForm.status.value = statusval
	document.lMenuForm.action = actionPage;
	document.lMenuForm.submit();
}
</script>

</form>

</div>
</div>
</div>

<div class="col-left sidebar roundedCorners">
<form id="lMenuForm" name="lMenuForm" >
<input type="hidden" name="status" value="" id="status">

	<div class="block block-account">
		<div class="block-title">
			<strong><span>View Quotes</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<li><a href="javascript:funClickLink('../Quotes/ezJobQuotes.jsp','O')">Open</a></li>
			<li><a href="javascript:funClickLink('../Quotes/ezJobQuotes.jsp','C')">Closed</a></li>
			<li><a href="javascript:funClickLink('../Quotes/ezExpiredJobQuotes.jsp','E')">Expired Quotes</a></li>
			<li class="current"><strong>Expiring Soon</strong></li>
			</ul>
		</div>
	</div>
</form>
</div>
</div>
</div>