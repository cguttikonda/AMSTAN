<%@ page import ="ezc.ezparam.*,ezc.ezsap.*" %>
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

	public Vector getSubUserShips(String user_id,ezc.session.EzSession Session)
	{
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
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
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	
	if (rType == null){
		rType = "'RC'";
	}
	else{
	 if (rType.equals("PCR"))
		rType = "'RC'";
	  if (rType.equals("RCR"))
		rType = "'RC'";
	  if (rType.equals("ACR"))
		rType = "'C','RC'";
	  if (rType.equals("RGA"))
		rType = "'RGA'";
	}

	if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_S+"/"+fDate_S+"/"+fyear;
	if(toDate==null || "null".equalsIgnoreCase(toDate)) toDate = cMonth_S+"/"+cDate_S+"/"+cYear;
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
		"aaSorting": [[ 0, "desc" ]],
		"sPaginationType": "full_numbers",
		"iDisplayLength": 100,
<% 
		if (rType.equals("'RGA'"))
			if ("'R','CA'".equals(canReqType)) 
			{
%>
				 "aoColumnDefs": [
					{ "bVisible": true, "aTargets": [ 6 ] }, //Request Type,ExpirationDate Column hidden, status column visible
					{ "bVisible": false, "aTargets": [ 5,7 ] }
				]
<%
			} else { 
				if ("'A'".equals(canReqType)) 
				{
%>
					"aoColumnDefs": [
						{ "bVisible": false, "aTargets": [ 5,6 ] }, //Request Type Column and status column hidden
						{ "bVisible": true, "aTargets": [ 7 ] } //Expiration Date Column visible
					]
<%
				} else { 
%>
					"aoColumnDefs": [
						{ "bVisible": false, "aTargets": [ 5,6,7 ] } //Request Type Column and status and expiration date column hidden
					 ]
<%
				} 
			} 
			if (!rType.equals("'RGA'")) 
			{
%>
				"aoColumnDefs": [
					{ "bVisible": false, "aTargets": [ 4,5,6 ] } //Request Type and Status hidden for CRs. Col Nr is different
				]
<%
			}
%>
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
	String soldToQT = request.getParameter("selSoldTo");
 	if(soldToQT==null || "null".equals(soldToQT)) soldToQT ="";
 	String shipToQT = request.getParameter("shipTo");
 	if(shipToQT==null || "null".equals(shipToQT)) shipToQT ="";
	String disp="display:none";
	String searchStat = request.getParameter("searchStat");
 	if("Y".equals(searchStat) || "Y"==searchStat)
 		disp = "";  	
	String selSold = request.getParameter("selSoldTo");
	if(selSold=="" || selSold==null || "null".equals(selSold))
	{
		selSold = (String)session.getValue("AgentCode");
		soldToQT = (String)session.getValue("AgentCode");
	} 	
		
	String custCode = "";
	String shipCode = "";
	String dateCode = "";
	
	if("CU".equals(userRole))
	{
		String SoldTos_A ="";
		if(request.getParameter("selSoldTo")!=null && !"null".equals(request.getParameter("selSoldTo")) && !"".equals(request.getParameter("selSoldTo")))
			SoldTos_A=request.getParameter("selSoldTo");	
		else
		{
			String allSoldTos = (String)session.getValue("SOLDTO_SUPER");
			String[] stoken=allSoldTos.split("¥");
			if(stoken.length>1)
			{
				for(int i=0;i<stoken.length;i++)
				{
					if(i==0)
						SoldTos_A=stoken[i];	
					else
						SoldTos_A=SoldTos_A+"','"+stoken[i];
				}

			}
			else
				SoldTos_A=(String)session.getValue("AgentCode");
		}
						
		custCode = " AND ESCH_SOLD_TO IN ('"+SoldTos_A+"')";	
			
	}	
	else
	{
		String fromPage_W = request.getParameter("fromPage");
		if(fromPage_W==null || "null".equalsIgnoreCase(fromPage_W) || "".equals(fromPage_W))
			fromPage_W = "NOCHK";

		if(request.getParameter("selSoldTo")!=null && !"null".equals(request.getParameter("selSoldTo")) && "NOCHK".equals(fromPage_W))
			custCode = " AND ESCH_SOLD_TO IN ('"+request.getParameter("selSoldTo")+"')";	
	}
	if(!"".equals(shipToQT) && !"A".equals(shipToQT))
	{
		shipCode = " AND ESCH_SHIP_TO IN ('"+shipToQT+"')";	
	}
	if(fromDate!=null && toDate!=null && !"null".equals(fromDate) && !"null".equals(toDate) && "Y".equals(searchStat))	
	{
		dateCode  = " AND ESCH_CREATED_ON BETWEEN  convert(DATETIME,'"+fromDate+"',110)  and  convert(DATETIME,'"+toDate+"',110)";
	
	}
		
	String poNumber = request.getParameter("poNumber");
	ReturnObjFromRetrieve retCancelReqObj = null;
	ezc.ezparam.EzcParams reqMainParams = new ezc.ezparam.EzcParams(false);
	EziMiscParams reqMiscParams = new EziMiscParams();
	reqMiscParams.setIdenKey("MISC_SELECT");
	String query="SELECT (SELECT DISTINCT ESCI_BACK_END_ORDER + ' ' as [text()] FROM EZC_SO_CANCEL_ITEMS WHERE ESCI_ID = ESCH_ID FOR XML PATH('')) RGAID, ESCH_ID,ESCH_PO_NUM,ESCH_SO_NUM,(SELECT TOP 1 ECA_NAME FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND EC_ERP_CUST_NO=ESCH_SOLD_TO)SOLDTO_NAME, ESCH_SOLD_TO,ESCH_SHIP_TO,ESCH_SHIP_TO_NAME,ESCH_SYSKEY,(SELECT TOP 1 EU_FIRST_NAME+EU_LAST_NAME FROM EZC_USERS WHERE EU_ID=ESCH_CREATED_BY)ESCH_CREATED_BY,ESCH_CREATED_BY USER_ID,ESCH_CREATED_ON,ESCH_MODIFIED_BY,ESCH_MODIFIED_ON,ESCH_STATUS,ESCH_TYPE,ESCH_EXT1,ESCH_EXT2,ESCH_EXT3,ESCH_EXPIRE_ON FROM EZC_SO_CANCEL_HEADER WHERE ESCH_STATUS IN ("+canReqType+") AND ESCH_TYPE IN ("+rType+")"+custCode + shipCode + dateCode;
	reqMiscParams.setQuery(query);
	reqMainParams.setLocalStore("Y");
	reqMainParams.setObject(reqMiscParams);
	Session.prepareParams(reqMainParams);	
	try{	
		retCancelReqObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(reqMainParams);
	}
	catch(Exception e)
	{}
	
	int retCancelReqObjCnt =0;
	
	if(retCancelReqObj!=null)
		retCancelReqObjCnt = retCancelReqObj.getRowCount();

	String dispHeader = "No Cancellation Request in ASB Queue";

	if (rType.equals("'RGA'")) dispHeader = "No RGA in ASB Queue";

	if("'A'".equals(canReqType))
		if (!rType.equals("'RGA'"))
			dispHeader = "No Approved Cancellation Requests";
		else
			dispHeader = "No RGA in Customer Queue";
			
	if("'R','CA'".equals(canReqType))
		if (!rType.equals("'RGA'"))
			dispHeader = "No Rejected Cancellation Requests";
		else
			dispHeader = "No Closed RGA";

	if(retCancelReqObjCnt>0)
	{
		if (!rType.equals("'RGA'"))
			dispHeader = "Cancellation Requests in ASB Queue";
		else 	
			dispHeader = "RGA in ASB Queue";
		
		if("'A'".equals(canReqType))
			if (!rType.equals("'RGA'"))
				dispHeader = "Approved Cancellation Requests";
			else 
				dispHeader = "RGA in Customer's Queue";
			
		if("'R','CA'".equals(canReqType))
			if (!rType.equals("'RGA'"))
				dispHeader = "Rejected Cancellation Requests";
			else
				dispHeader = "Closed RGA";
	}
	
	ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	ReturnObjFromRetrieve retShips = null;
	if(request.getParameter("selSoldTo")!=null && !"".equals(request.getParameter("selSoldTo")) && !"null".equals(request.getParameter("selSoldTo")))		
		retShips = (ReturnObjFromRetrieve)getListOfShipTos(selSold,(String)session.getValue("UserType"),(String)session.getValue("BussPart"),(String)session.getValue("IsSubUser"),Session);	
%>
 <div class="block" style="padding-left: 0px; width:100%;">
 	<div class="block-title">
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
		
		//document.myForm.action="ezCancellationRequestsMain.jsp?rType="+document.myForm.getOrdStat.value;
		document.myForm.submit();
	}
	function getDetails(cancId,requestor,reqdate,poNo,crType)
	{
		document.myForm.cancellationId.value=cancId;
		document.myForm.requestor.value=requestor;
		document.myForm.reqdate.value=reqdate;
		document.myForm.PONO.value=poNo;
		document.myForm.crType.value=crType;

		document.myForm.action="ezCancReqDetailsMain.jsp";
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
		window.open("../Sales/ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo+"&chkBlock=Y&fromPage=Y",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
	}	
</script>
<form name="myForm" method="post">

<div class="col1-set">
<div class="info-box"><br>

<input type="hidden" name="cancellationId">
<input type="hidden" name="canReqType" value=<%=canReqType%>>
<input type="hidden" name="requestor">
<input type="hidden" name="reqdate">
<input type="hidden" name="PONO">
<input type="hidden" name="crType">
<input type="hidden" name="searchStat" value="Y">
<input type="hidden" name="rType" value="<%=request.getParameter("rType")%>">
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
 		<div style="margin-top:8px;float:right;margin-right: -10px;">
 		<button title="Submit" class="button btn-update" onClick="getOrders()" ><span>Search</span></button>
 		</div>
 	</div>
 	</li>
 </ul>

<%
	if(retCancelReqObjCnt>0)
	{
	
	
%>

	<!-- <table class="display" id="example"> -->
	<table class="data-table" id="example">
	<thead>
	<tr>
<%
	if (!rType.equals("'RGA'"))
	{
%>
		<th width=10%>Id</th>
		<th width=15%>PO Id.</th>
		<th width=30%>Customer</th>
		<th width=30%>Requested By<br>Requested On</th>
		<th width=5%>Request Type</th>
		<th width=5%>Status</th>
<%
	} else 
	{
%>
		<th width=10%>Req.<br>Id</th>
		<th width=15%>RGA Id</th>
		<th width=15%>PO Id</th>
		<th width=30%>Customer</th>
		<th width=30%>Requested By<br>Requested On</th>
		<th width=5%>Request Type</th>
		<th width=5%>Status</th>
		<th width=10%>Expire On</th>
<%
	}
%>
	</tr>
	</thead>
	<tbody>
<%!
	public static Date getZeroTimeDate(Date fecha) {
	Date res = fecha;
	Calendar calendar = Calendar.getInstance();

	calendar.setTime( fecha );
	calendar.set(Calendar.HOUR_OF_DAY, 0);
	calendar.set(Calendar.MINUTE, 0);
	calendar.set(Calendar.SECOND, 0);
	calendar.set(Calendar.MILLISECOND, 0);

	res = calendar.getTime();

	return res;
}

%>
<%
		Date dts	= null;
		String rgaID	= "";
		String docNums	= "";
		long DAY_IN_MS	= 1000 * 60 * 60 * 24;
		Date rgaExpDate = null;
		Date dateNow	= new Date ();
		
		for(int i=0;i<retCancelReqObjCnt;i++)
		{
			
		
%>
			<tr>
<%
			if (!rType.equals("'RGA'"))
			{
%>
				<td width=10%><%=retCancelReqObj.getFieldValueString(i,"ESCH_ID")%></td>
				<td width=15%><a href="javascript:getDetails('<%=retCancelReqObj.getFieldValueString(i,"ESCH_ID")%>','<%=retCancelReqObj.getFieldValueString(i,"USER_ID")%>','<%=formatDate.getStringFromDate((java.util.Date)retCancelReqObj.getFieldValue(i,"ESCH_CREATED_ON"),"/",formatDate.MMDDYYYY)%>','<%=retCancelReqObj.getFieldValueString(i,"ESCH_PO_NUM")%>','<%=retCancelReqObj.getFieldValueString(i,"ESCH_TYPE")%>')"><%=retCancelReqObj.getFieldValueString(i,"ESCH_PO_NUM")%></a></td>
<%
			} else 
			{
%>
				<td width=10%><a href="javascript:getDetails('<%=retCancelReqObj.getFieldValueString(i,"ESCH_ID")%>','<%=retCancelReqObj.getFieldValueString(i,"USER_ID")%>','<%=formatDate.getStringFromDate((java.util.Date)retCancelReqObj.getFieldValue(i,"ESCH_CREATED_ON"),"/",formatDate.MMDDYYYY)%>','<%=retCancelReqObj.getFieldValueString(i,"ESCH_PO_NUM")%>','<%=retCancelReqObj.getFieldValueString(i,"ESCH_TYPE")%>')"><%=retCancelReqObj.getFieldValueString(i,"ESCH_ID")%></a></td>
				<td><%=retCancelReqObj.getFieldValueString(i,"RGAID")%></td>
				<td width=15%><%=retCancelReqObj.getFieldValueString(i,"ESCH_PO_NUM")%></td>
<%
			}
			if (rType.equals("'RGA'"))
			{
%>
				<td width=30%><%=nullCheck(retCancelReqObj.getFieldValueString(i,"ESCH_SHIP_TO_NAME"))+"  ["+nullCheck(retCancelReqObj.getFieldValueString(i,"ESCH_SHIP_TO"))+"]"%></td>
<%
			} else 
			{
%>
				<td width=30%><%=nullCheck(retCancelReqObj.getFieldValueString(i,"SOLDTO_NAME"))+"  ["+nullCheck(retCancelReqObj.getFieldValueString(i,"ESCH_SOLD_TO"))+"]"%></td>
<%
			}
%>
				<td width=30%><%=nullCheck(retCancelReqObj.getFieldValueString(i,"ESCH_CREATED_BY")) +"  ["+retCancelReqObj.getFieldValueString(i,"USER_ID")+"]"%><br>
				<%=formatDate.getStringFromDate((java.util.Date)retCancelReqObj.getFieldValue(i,"ESCH_CREATED_ON"),"/",formatDate.MMDDYYYY)%></td>
<%
			if (retCancelReqObj.getFieldValueString(i,"ESCH_TYPE").trim().equals("RGA")) 
			{
%>
				<td width=5%>RGA</td>
<% 
			} else 
			{
%>
				<td width=5%>Cancellation</td>
<%
			}
%>
				<td width=5%><%=getStatusDesc(retCancelReqObj.getFieldValueString(i,"ESCH_STATUS"))%></td>
				<td width=5%><%=nullCheckBlank(formatDate.getStringFromDate((java.util.Date)retCancelReqObj.getFieldValue(i,"ESCH_EXPIRE_ON"),"/",formatDate.MMDDYYYY))%></td>
<%
			rgaID	= retCancelReqObj.getFieldValueString(i,"ESCH_ID");
			dts	= (java.util.Date)retCancelReqObj.getFieldValue(i,"ESCH_EXPIRE_ON");
			dateNow		= getZeroTimeDate(dateNow);			
			if(dts!= null)
				rgaExpDate	= new Date(dts.getTime() + (7 * DAY_IN_MS));
%>		
			</tr>
<%
			//if(rgaExpDate.compareTo(dateNow)== -1 || rgaExpDate.compareTo(dateNow)== 0)
		}
%>
	</tbody>
	</table>

<%
	}
%>

</div>
</div>
 
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
<%!
	public String getStatusDesc(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
		else {
		if (ret.equals("CA"))
			ret = "Accepted";
		if (ret.equals("R"))
			ret = "Rejected";
		}

		return ret;
	}
	public String nullCheckBlank(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "01/01/1900";
		return ret;
	}
%>