<%
	long start1 = System.currentTimeMillis();
%>
<%@ include file= "../../../Includes/JSPs/Search/iGetSearchDetailsSAP.jsp"%>
<%
	long finish1 = System.currentTimeMillis();
	ezc.ezcommon.EzLog4j.log("Time taken to execute iGetSearchDetailsSAP.jsp in ezQuickSearchDetails.jsp>>>"+(finish1-start1)/1000+" secs","F");
%>
<div class="main-container col1-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main1 roundedCorners" style="margin-bottom:50px">
<div class="my-account" style="overflow:hidden">
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
	String orderinforadio = request.getParameter("orderinforadio");
	String ordStatus      = request.getParameter("ordStat");
	String loginUserId    = Session.getUserId();	
	EzCurrencyFormat myFormat = new EzCurrencyFormat();
	
	//out.println("retHeader::::"+retHeader.toEzcString()+":::ordStat:::::"+ordStat);
	//out.println(":::ordStatus:::::"+ordStatus);

%>
<head>
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
<script src="//code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
<Script src="../../Library/Script/popup.js"></Script> 

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
			"aaSorting": [[ 2, "desc" ]],
 			"aoColumnDefs": [
      				{ "bSortable": true, "aTargets": [ 2 ] }			
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

<!-- jQuery for sorting & pagination ENDS here -->

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
<script>
var ordSel = '<%=orderinforadio%>'
var ordtype = '<%=ordStatus%>'
function funBack()
{
	Popup.showModal('modal1');
<%
	if("null".equals(refOrdNo) || "".equals(refOrdNo) || refOrdNo==null )
	{
%>	
		document.myForm.action='ezQuickSearchMain.jsp'
<%
	}else
	{
%>
		document.myForm.soldTo.value="<%=soldToCode%>";
		document.myForm.webOrNo.value="<%=refOrdNo%>";
		document.myForm.action='../Sales/ezEditSaveSalesOrderDetails.jsp'
<%
	}
%>	
	document.myForm.submit()
}
function getDetails(SoNum,SoldTo,Status,cancelId,sysKey)
{
	document.myForm.salesOrder.value=SoNum;
	document.myForm.webOrNo.value=SoNum;
	document.myForm.soldTo.value=SoldTo;
	document.myForm.fromPage.value="Y";
	document.myForm.stat.value=Status;
	document.myForm.negotiateType.value=Status
	document.myForm.cancellationId.value=cancelId
	document.myForm.sysKey.value=sysKey
	//alert(Status)
	//alert(ordSel)
	//alert(ordtype)
	cType = "C";
	if(ordSel=='Returns')
	{
		//Status=ordtype; 
		//document.myForm.canReqType.value=ordtype
		document.myForm.canReqType.value=Status
		cType = "RGA"
	}	
	//alert(Status)
	Popup.showModal('modal1');
	if(Status=='NEW')
		document.myForm.action="../Sales/ezEditSaveSalesOrderDetails.jsp";	
	else if(Status=='NEGOTIATED' || Status=='ACCEPTED' || Status=='INPROCESS' || Status=='APPROVED')
		document.myForm.action="../Sales/ezNegotiateOrderDetails.jsp";	
	else if(Status=='P')	
		document.myForm.action="../Sales/ezCancReqDetailsMain.jsp?crType="+cType;	
	else if(Status=='R' || Status=='CA' )	
		document.myForm.action="../Sales/ezCancReqDetailsMain.jsp?crType="+cType;			
	else if(Status=='A' &&  ordSel=='Returns')		
		document.myForm.action="../Sales/ezCancReqDetailsMain.jsp?crType="+cType;
	else if(Status=='SUBMITTED' )		
		document.myForm.action="../Sales/ezApprovalOrderDetails.jsp";	
	else	
		document.myForm.action="../Sales/ezSalesOrderDetails.jsp";
		
		
	document.myForm.submit();
}
</script>
</head>
<form name="myForm" method="post">
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<input type="hidden" name="salesOrder">
<input type="hidden" name="soldTo">
<input type="hidden" name="fromPage">
<input type="hidden" name="webOrNo">
<input type="hidden" name="stat">
<input type="hidden" name="cancellationId">
<input type="hidden" name="sysKey">
<input type="hidden" name="canReqType">
<input type="hidden" name="negotiateType">
<input type="hidden" name="radioSelect" value="<%=orderinforadio%>">
<%
	if("null".equals(refOrdNo) || "".equals(refOrdNo) || refOrdNo==null )
	{
%>
	<input type="hidden" name="PONO" value="<%=PONO%>">
	<input type="hidden" name="fromDate" value="<%=fromDate%>">
	<input type="hidden" name="toDate" value="<%=toDate%>">
	<input type="hidden" name="proCodeDesc" value="<%=prdCODE%>">
	<input type="hidden" name="SAPSO" value="<%=SAPSO%>">
	<input type="hidden" name="UPC" value="<%=UPC%>">
	<input type="hidden" name="parentSol" value="<%=selParent%>">
	<input type="hidden" name="selSoldTo" value="<%=request.getParameter("selSoldTo")%>">
	<input type="hidden" name="shipTo" value="<%=selShipTo%>">
	<input type="hidden" name="orderType" value="<%=orderType%>">
	<input type="hidden" name="ordStat" value="<%=ordStat%>">
	<input type="hidden" name="ordType" value="<%=ordTypeSel%>">
	<input type="hidden" name="selOrds" value="<%=selOrds%>">
	<input type="hidden" name="orderinforadio" value="<%=selOrds%>">
	<input type="hidden" name="tempSoldTo" value="<%=request.getParameter("tempSoldTo")%>">
	
<%
	}

	String dispHeader = "Order Search Results";
	if("null".equals(refOrdNo) || "".equals(refOrdNo) || refOrdNo==null )
		dispHeader = "Order Search Results";
	else
		dispHeader = "Orders created against template  "+tempName;
	
	for(int i=retHeader.getRowCount()-1;i>=0;i--)
	{
		String docType 		= retHeader.getFieldValueString(i,"DOC_TYPE");
		if("L2".equals(docType) || "ZRET".equals(docType) || "G2".equals(docType))
			retHeader.deleteRow(i);
	}		
	int count1=retHeader.getRowCount();
	if(count1<=0)
		dispHeader = "<font color='red'> No&nbsp;</font>Orders Found with specified Criteria";
%>
	<!--<div class="highlight" style="height:50px;width:100%" >
	<div style="width: 625px; float: left">
			<br>&nbsp;<font size="5" color="black"><b><%=dispHeader%></b> </font><br>
			
		</div>	

		<!--<div style="width: 100px; float: right">
			<ul id="navbar">
				<li><span class="larrow"></span>&nbsp;&nbsp;<a href="javascript: funBack()">Go to Search</a>
			</li>
			</ul>
		</div>
		</div>
		

	</div>-->
 	<div class="block" style="padding-left:0px; width:100%;">
	 	<div class="block-title">
	 		<strong>
	 			<span><%=dispHeader%></span>
	 		</strong>
	 	</div>
	</div>	
	<div id="divAction" style="display:block">
		<button type="button" title="Back" class="button" onclick="javascript:funBack()">
		<span>Back to Search</span></button>	
	</div>	
	<br>
<%	
	
	Set set = new HashSet();
	//retHeader.sort(new String[]{"BACKEND_ORNO"},true);
	
%>
	<!--<h2 class="sub-title"><%=dispHeader%></h2>
	<a href="javascript:funBack()"><span>Back to Search Criteria</span></a>-->

<%	
	int cnt= 0;
	ezc.ezparam.ReturnObjFromRetrieve ret = null;
	if(retHeader!=null) cnt = retHeader.getRowCount();
	if(cnt>0)
	{
		/*String sortCols[]= new String[1];
		sortCols[0]="DOC_DATE";
		retHeader.sort(sortCols,true);*/

		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");

		EzGlobal.setColTypes(types);
		Vector names = new Vector();
		names.addElement("DOC_DATE");
		names.addElement("VALID_FROM");

		EzGlobal.setColNames(names);

		ret = EzGlobal.getGlobal(retHeader);
	}	
	//out.println(retHeader.toEzcString());
	Hashtable poSalesOrdersHT = null;
	Hashtable webOrdersHT = null;
	Hashtable poValueHT =null;
	Hashtable poSysKeyHT = null;
	
	if(count1>0)
	{
		poSalesOrdersHT = new Hashtable();
		webOrdersHT	= new Hashtable(); // this HT is to handle the orders from DB
		poValueHT = new Hashtable();
		poSysKeyHT = new Hashtable();
		Vector poVector = new Vector();
		count1=retHeader.getRowCount();
		
		for(int i=0;i<count1;i++)
		{
			String poNumber 	= retHeader.getFieldValueString(i,"PO_NO");
			String soNumber 	= retHeader.getFieldValueString(i,"BACKEND_ORNO");
			String soNetValue  	= retHeader.getFieldValueString(i,"NET_VALUE");
			String shipTo		= retHeader.getFieldValueString(i,"SHIP_TO");
			String docDate 		= ret.getFieldValueString(i,"DOC_DATE");
			Date chkDate 		= (Date)retHeader.getFieldValue(i,"VALID_FROM");//DOC_DATE
			String webOrd		= retHeader.getFieldValueString(i,"WEB_ORNO");
			String docType 		= retHeader.getFieldValueString(i,"DOC_TYPE");
			String soSyskey		= retHeader.getFieldValueString(i,"SYSKEY");
			if("L2".equals(docType) || "ZRET".equals(docType) || "G2".equals(docType))
				continue;
			
			//out.println("webOrd::::::::::::"+webOrd);
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
			String chkKey = poNumber+shipTo+chkDate.getTime();
			//out.println("chkKey::::::::::::"+chkKey);
			
			if(poVector.contains(chkKey))
			{
				try{
					poValueHT.put(chkKey,Double.parseDouble((String)poValueHT.get(chkKey))+Double.parseDouble(soNetValue)+"");
				}catch(Exception e){
				
				
				}	
			
				poSysKeyHT.put(chkKey,(String)poSysKeyHT.get(chkKey)+"ÿ"+soSyskey);
				poSalesOrdersHT.put(chkKey,(String)poSalesOrdersHT.get(chkKey)+"ÿ"+soNumber);
				if(soNumber==null || "".equals(soNumber) || "null".equals(soNumber))
					webOrdersHT.put(chkKey,(String)webOrdersHT.get(chkKey)+"ÿ"+webOrd);

			}else{
				poVector.addElement(chkKey);
				poSalesOrdersHT.put(chkKey,soNumber);
				if(soNumber==null || "".equals(soNumber) || "null".equals(soNumber))
					webOrdersHT.put(chkKey,webOrd);
				poValueHT.put(chkKey,soNetValue);
				poSysKeyHT.put(chkKey,soSyskey);
			}
		}
		//out.println(poSalesOrdersHT);
		//out.println(poSalesOrdersHT);
		int vecSize = poVector.size();
%>	
		<div class="col1-set">
		<div class="info-box"><br>
		<!--<div >
				
			<B><P><%//=searchRslt%> resulted in  <font color='red'><B><%//=vecSize%></B></font> Po's.</P></B>
		</div>	-->
		<table class="data-table" id="example" >				
		<thead>																		
		
		<tr>
<%
		if("RETURNS".equalsIgnoreCase(orderinforadio) || "CANCEL".equalsIgnoreCase(orderinforadio))
		{
%>			
			<th width=10%>Cancelled Id</th>
<%
		}
%>		
		<th width=15%>PO No.</th>
		<!--<th width=10%>Template Name</th>-->
		<th width=10%>Po Date</th>
		<th width=15%>Order Posted Date</th>
<%
		if(!"RETURNS".equalsIgnoreCase(orderinforadio) && !"CANCEL".equalsIgnoreCase(orderinforadio))
		{
%>		
			<th width=10%>Order Value[USD]</th>
<%
		}
%>			
		<th width=15%>Status</th>
		<th width=10%>Ship To</th>
		<th width=10%>Created By</th>
		</tr>
		</thead>
		<tbody>
<%		
		Date wdateString=null;
		String backEndOrderNo = null;
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		Hashtable dStatusHT = new Hashtable();
		
		dStatusHT.put(" ","Not Available");
		dStatusHT.put("A","Open");
		dStatusHT.put("B","Open");
		dStatusHT.put("C","Closed");
		// Statuses from Saved Templates
		dStatusHT.put("NEW","Saved Template");
		// Statuses from In Negotiation
		dStatusHT.put("NEGOTIATED","Waiting for Ops Manager Approval");
		dStatusHT.put("INPROCESS","Waiting for Ops Manager Approval");
		dStatusHT.put("APPROVED","Awaiting Customer Acceptance");
		dStatusHT.put("ACCEPTED","Awaiting Customer Acceptance");
		dStatusHT.put("REJECTED","Sent Back to Customer with AS Rejection");
		dStatusHT.put("TRANSFERED","Accepted by AS");
		dStatusHT.put("SUBMITTED","Waiting for Internal Approval");
		
		dStatusHT.put("P","In ASB Claims Processing"); 
		if("RETURNS".equalsIgnoreCase(orderinforadio) || "CANCEL".equalsIgnoreCase(orderinforadio))		
			dStatusHT.put("A","In Customer Queue"); 
		dStatusHT.put("R","Rejected by Customer"); 
		dStatusHT.put("CA","Accepted by Customer"); 
		
		poVector = new Vector();

		int wl=0;

		for(int rCount=0;rCount<retHeader.getRowCount();rCount++)
		{

			String docType = retHeader.getFieldValueString(rCount,"DOC_TYPE");
			String retSatus = retHeader.getFieldValueString(rCount,"DOC_STATUS");
			String createdBy = retHeader.getFieldValueString(rCount,"CREATED_BY");
			if("".equals(retSatus) || retSatus=="")retSatus="C";
			//out.println("docType:::::"+docType+":::"+retHeader.getFieldValueString(rCount,"PO_NO")+":::"+retHeader.getFieldValueString(rCount,"BACKEND_ORNO"));
			/****** DR in SAP L2 in JCO ; CR IN SAP G2 in JCO ******/			
			if("L2".equals(docType) || "ZRET".equals(docType) || "G2".equals(docType))
				continue;
			//if("A".equalsIgnoreCase(ordStat) && !"CM".equals(userRole))	
				//if("NEW".equals(retSatus) && createdBy!=Session.getUserId())
					//continue;
			
			String poNo	 = retHeader.getFieldValueString(rCount,"PO_NO"); 
			backEndOrderNo	 = retHeader.getFieldValueString(rCount,"BACKEND_ORNO");
			backEndOrderNo=("null".equals(backEndOrderNo))?"N/A": backEndOrderNo;
			String DocDate 	= ret.getFieldValueString(rCount,"DOC_DATE"); 
			Date chkDate 	= (Date)retHeader.getFieldValue(rCount,"VALID_FROM");//DOC_DATE
			String templateName = retHeader.getFieldValueString(rCount,"TEMPLATE_NAME");
			
			String cancelId = retHeader.getFieldValueString(rCount,"CANCEL_ID");
			if(cancelId==null || "".equals(cancelId) || "null".equals(cancelId))cancelId = "";
			String shipTo=retHeader.getFieldValueString(rCount,"SHIP_TO");
			if((templateName==null)||(templateName=="null")||(templateName.trim().length() == 0)) templateName ="";
			if((createdBy==null)||(createdBy=="null")||(createdBy.trim().length() == 0)) createdBy ="";
			
			StringTokenizer st1 = new StringTokenizer(DocDate,"/");
			String[] docsplit = new String[3];
			int h=0;
			while(st1.hasMoreTokens())
			{
				docsplit[h]=st1.nextToken();
				h++;
			}			
			//out.println("+++ 0 - Tokenized the Date"+DocDate);
			java.util.Date dDate = new java.util.Date(Integer.parseInt(docsplit[2])-1900,Integer.parseInt(docsplit[0])-1,Integer.parseInt(docsplit[1]));
			//out.println("dDate:::::"+dDate.getTime());
			DocDate = formatDate.getStringFromDate(dDate,"/",formatDate.MMDDYYYY);			
			
			if(poVector.contains(poNo+shipTo+chkDate.getTime()))
				continue;
			else
				poVector.addElement(poNo+shipTo+chkDate.getTime());
				
			String podate=ret.getFieldValueString(rCount,"VALID_FROM");
			//out.println("+++ 1");
			if((DocDate==null)||(DocDate=="null")||(DocDate.trim().length() == 0)) DocDate ="N/A";
			if((podate==null)||(podate=="null")||(podate.trim().length() == 0)) podate ="N/A";
			//out.println("retSatus:::::"+retSatus+"::::poNo::::"+poNo);

			String soldtocode =retHeader.getFieldValueString(rCount,"SOLD_TO");
			String backEndOrNo =retHeader.getFieldValueString(rCount,"BACKEND_ORNO");
			
			try{
				backEndOrNo = Long.parseLong(backEndOrNo)+"";
			}
			catch(Exception e){}
			
			String cuname= retHeader.getFieldValueString(rCount,"SOLD_TO_NAME");
			//String createdBy = retHeader.getFieldValueString(rCount,"SOLD_TO");
			//cuname = replaceAll(cuname,'&');
			//createdBy = replaceAll(createdBy,'&');
			String poValueBD="0";
			poValueBD = (String)poValueHT.get(poNo+shipTo+chkDate.getTime());//retHeader.getFieldValueString(rCount,"NET_VALUE"); //(
			
			String shipToName = retHeader.getFieldValueString(rCount,"SHIP_TO_NAME");
			//out.println("+++ 2");
			try
			{
				poValueBD = new java.math.BigDecimal(poValueBD).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			}
			catch(Exception e){
				poValueBD = (String)poValueHT.get(poNo+shipTo+chkDate.getTime());
			}
			//out.println("+++ 3"+poValueBD);
			String docStat=(String)dStatusHT.get(retSatus);
			if("RETURNS".equalsIgnoreCase(orderinforadio) && "A".equals(retSatus))
				docStat="Approved and Processed";
			
			if(docStat==null || "null".equals(docStat) || "".equals(docStat))docStat="Not Available";
			
			String web_No = (String)poSalesOrdersHT.get(poNo+shipTo+chkDate.getTime());
			String sysKey_A = (String)poSysKeyHT.get(poNo+shipTo+chkDate.getTime());
			if("".equals(web_No) || "ÿ".equals(web_No))
				web_No = (String)webOrdersHT.get(poNo+shipTo+chkDate.getTime());
%>
			<tr>
			
<%
			if("RETURNS".equalsIgnoreCase(orderinforadio) || "CANCEL".equalsIgnoreCase(orderinforadio))
			{
%>			
				<td width=10%><a href="javascript:getDetails('<%=web_No.trim()%>','<%=soldtocode%>','<%=retSatus%>','<%=cancelId%>','<%=sysKey_A%>')"><%=cancelId%></a></td>
<%
			}
%>			
			<td width=15%><a href="javascript:getDetails('<%=web_No.trim()%>','<%=soldtocode%>','<%=retSatus%>','<%=cancelId%>','<%=sysKey_A%>')"><%=poNo%></a></td>
			<!--<td width=10%><%//=templateName%></td>-->
			<td width=10%><%=podate%></td>
			<td width=15%><%=DocDate%></td>
<%
			if(!"RETURNS".equalsIgnoreCase(orderinforadio) && !"CANCEL".equalsIgnoreCase(orderinforadio))
			{
%>			
				<td width=10%><%=nullCheck(myFormat.getCurrencyString(poValueBD))%></td>
<%
			}
%>			
			<td width=15%><%=docStat%></td>
			<td width=20%><%=nullCheck(shipTo)%><br><%=nullCheck(shipToName)%></td>
			<td width=10%><%=nullCheck(createdBy)%></td>
			<input type="hidden" name="sapShipTo" value="<%=shipTo%>">
			</tr>
<%
		}
		//out.println(poVector.size());
		
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
	String singleList = request.getParameter("singleList");
	//out.println(poSalesOrdersHT.size());
	//out.println("singleList::::::"+singleList);
	if(poSalesOrdersHT.size()==1 )
	{
		if(singleList==null)
		{
			Date chkDate 	   = (Date)retHeader.getFieldValue(0,"VALID_FROM");//DOC_DATE
			String docType = retHeader.getFieldValueString(0,"DOC_TYPE");
			String chkKey = retHeader.getFieldValueString(0,"PO_NO")+retHeader.getFieldValueString(0,"SHIP_TO")+chkDate.getTime();
			String webNo = (String)poSalesOrdersHT.get(chkKey);
			//out.println("docType:::::"+docType);
			if("null".equals(webNo) || webNo==null || "".equals(webNo) || webNo=="" || "ÿ".equals(webNo))
				webNo = (String)webOrdersHT.get(chkKey);
				//out.println("webNo:::::"+webNo);
				//webNo = retHeader.getFieldValueString(0,"WEB_ORNO");
%>
				getDetails('<%=webNo.trim()%>','<%=retHeader.getFieldValueString(0,"SOLD_TO")%>','<%=retHeader.getFieldValueString(0,"DOC_STATUS")%>','<%=retHeader.getFieldValueString(0,"CANCEL_ID")%>','<%=retHeader.getFieldValueString(0,"SYSKEY")%>')
			
<%
		}
		else{
%>	
			funBack()
<%
		}
	}
%>	

</script>
</form>
</div>
</div>
</div>
</div>
</div>
</div>
	
