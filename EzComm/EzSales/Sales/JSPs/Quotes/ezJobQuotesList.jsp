<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners">
<div class="my-account">
<div class="dashboard">
<%@ page import="java.util.*,java.text.ParseException,java.text.SimpleDateFormat,java.text.DateFormat" %>

<script type="text/javascript">
function getOrders()
{
	Popup.showModal('headermodal');
	document.dateForm.action="ezJobQuotes.jsp";
	document.dateForm.submit();
}
function getJobDetails(salesDoc,soldToCode,docStatus)
{
	Popup.showModal('headermodal');
	document.dateForm.salDoc.value=salesDoc;
	document.dateForm.soldTo.value=soldToCode;
	document.dateForm.docStat.value=docStatus;
	document.dateForm.fromPage.value='ezjobQuotesList.jsp';

	document.dateForm.action="ezJobQuoteDetails.jsp";
	document.dateForm.submit();
}
</script>

<!-- jQuery for sorting & pagination STARTS here-->

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper quotetables
	 * please see the themes quotetable in the 'quotetables' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#quotetable_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#quotetable_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#quotetable tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#quotetable thead th:first-child { border-left: 1px solid #AAA; }
	#quotetable thead th:last-child { border-right: 1px solid #AAA; }
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
		$('#quotetable').dataTable( {
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

	$("#quotetable").colResizable({
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
	//out.println("+++++++++ Before Include ");	
	String fromDate   = request.getParameter("fromDate");
	String toDate 	  = request.getParameter("toDate");
	String valFrom    = request.getParameter("valFrom");
	String valTo 	  = request.getParameter("valTo");
	String jobName    = request.getParameter("jobName");
	if(jobName!=null && !"null".equals(jobName) && !"".equals(jobName))
		jobName.trim();
	String quoteNum   = request.getParameter("quoteNum");
	String soldToQT   = request.getParameter("soldToQT");
	//out.println("+++++++++ Before Include 2");
	String openStat = request.getParameter("status");
	//out.println("+++++++++ Before Include 3 openStat is"+openStat);

	String searchStat = request.getParameter("searchStat");

	if(soldToQT==null || "null".equals(soldToQT)) soldToQT ="";
	if(jobName==null  || "null".equals(jobName))   jobName ="";
	if(quoteNum==null || "null".equals(quoteNum)) quoteNum ="";
	
	java.util.Calendar calObj = java.util.Calendar.getInstance();
	java.util.Calendar calTOObj = java.util.Calendar.getInstance();
	
	calTOObj.add(Calendar.DATE, 1825);
	
	int cYearQ = calTOObj.get(Calendar.YEAR);
	int cMonthQ = calTOObj.get(Calendar.MONTH);
	int cDateQ = calTOObj.get(Calendar.DATE);

	calObj.add(Calendar.DATE, -1460);
	
	int fyearQ = calObj.get(Calendar.YEAR);
	int fMonthQ = calObj.get(Calendar.MONTH); 
	int fDateQ = calObj.get(Calendar.DATE);
	

	cMonthQ = cMonthQ+1;
	fMonthQ = fMonthQ+1;

	String fDate_SQ = fDateQ+"";
	String fMonth_SQ = fMonthQ+"";
	String cDate_SQ = (cDateQ+1)+"";  
	String cMonth_SQ = cMonthQ+"";

	if(fDateQ<10) fDate_SQ = "0"+fDateQ;
	if(fMonthQ<10) fMonth_SQ = "0"+fMonthQ; 
	if(cDateQ<10) cDate_SQ = "0"+cDateQ;
	if(cMonthQ<10) cMonth_SQ = "0"+cMonthQ;



	// returning the first date
	Calendar calStartQ=Calendar.getInstance();
	calStartQ.set(Calendar.YEAR,cYear);
	calStartQ.set(Calendar.MONTH,0);
	calStartQ.set(Calendar.DAY_OF_MONTH,1);
	Date startDateQ=calStartQ.getTime();

	int vfYearQ  = calStart.get(Calendar.YEAR);
	int vfMonthQ = calStart.get(Calendar.MONTH); 
	int vfDateQ  = calStart.get(Calendar.DATE);

	// returning the last date
	Calendar calEndQ=Calendar.getInstance();
	calEndQ.set(Calendar.YEAR,cYear);
	calEndQ.set(Calendar.MONTH,11);
	calEndQ.set(Calendar.DAY_OF_MONTH,31);	
	Date endDateQ=calEndQ.getTime();

	calEndQ.add(Calendar.DATE, 1825);
	
	int vtYearQ  = calEndQ.get(Calendar.YEAR);
	int vtMonthQ = calEndQ.get(Calendar.MONTH); 
	int vtDateQ  = calEndQ.get(Calendar.DATE);

	vfMonthQ = vfMonthQ+1;
	vtMonthQ = vtMonthQ+1;

	String vfDate_SQ = vfDateQ+"";
	String vfMonth_SQ = vfMonthQ+"";
	String vtDate_SQ = vtDateQ+"";  
	String vtMonth_SQ = vtMonthQ+"";

	if(vfDateQ<10) vfDate_SQ = "0"+vfDateQ;
	if(vfMonthQ<10) vfMonth_SQ = "0"+vfMonthQ; 
	if(vtDateQ<10) vtDate_SQ = "0"+vtDateQ;
	if(vtMonthQ<10) vtMonth_SQ = "0"+vtMonthQ;
	
	
	
	
	
	if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_SQ+"/"+fDate_SQ+"/"+fyearQ;
	if(toDate==null   || "null".equalsIgnoreCase(toDate)) toDate = cMonth_SQ+"/"+cDate_SQ+"/"+cYearQ;

	//if(valFrom==null  || "null".equalsIgnoreCase(valFrom)) valFrom = vfMonth_S+"/"+vfDate_S+"/"+vfYear;
	if(valFrom==null  || "null".equalsIgnoreCase(valFrom)) valFrom = fMonth_SQ+"/"+fDate_SQ+"/"+fyearQ;
	if(valTo==null    || "null".equalsIgnoreCase(valTo)) valTo = vtMonth_SQ+"/"+vtDate_SQ+"/"+vtYearQ;
	if (openStat==null || "null".equalsIgnoreCase(openStat)) openStat="O";
	
%>
<%@ include file="../../../Includes/JSPs/Quotes/iJobQuotes.jsp"%>


<%	
	ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	
	int cntSQ =0;	
	if(retObjExSQ!=null && retObjExSQ.getRowCount() > 0)	
	 cntSQ =  retObjExSQ.getRowCount();	
	String dispHeader = "Open Job Quotes";
	if (openStat.equalsIgnoreCase("O"))
		dispHeader = "Open Job Quotes";
	if (openStat.equalsIgnoreCase("C"))
		dispHeader = "Closed Job Quotes";	
	if (openStat.equalsIgnoreCase("E"))
		dispHeader = "Expired Job Quotes";
	if (openStat.equalsIgnoreCase("ES"))
		dispHeader = "Job Quotes Expiring Soon";
	String disp="display:block";
		
	if("Y".equals(searchStat) || "Y"==searchStat)
	   disp = "";	
%>
<div class="block" style="padding-left:0px;width:100%">
	<div class="block-title">
		<strong><span><%=dispHeader%></span></strong>
	</div>
</div>

<body>
<form name="dateForm" method="post">

<input type="hidden" name="status" value="<%=openStat%>">
<input type="hidden" name="salDoc">
<input type="hidden" name="soldTo">
<input type="hidden" name="docStat">
<input type="hidden" name="searchStat" value="Y">
<input type="hidden" name="fromPage" value="">



<ul class="form-list">

	<li>
	<div id="it">
	<!--<input type="button" class="button" title="Show/Hide" value="Show/Hide"/>-->
	<button type="button" title="Search" class="button btn-update"><span>Show / Hide Search</span></button>
	</div>
	</li>

	<li>
	<div id="display" style="<%=disp%>" >
		<table class="data-table">
		<thead>
		
		<tr>
		<th width=10%>Document Date</th>
		<th width=10% align=center>From</th>
		<td width=20%><input type="text" size="12" id="fromDate" name="fromDate" value="<%=fromDate%>" readonly /><%=getDateImage("fromDate")%></td>
		<th width=10% align=center>To</th>
		<td width=20%><input type="text" size="12" id="toDate" name="toDate" value="<%=toDate%>" readonly /><%=getDateImage("toDate")%></td>

		</tr>

		<tr>
		<th width=10%>Valid Date</th>
		<th width=10% align=center>From</th>
		<td width=20%><input type="text" size="12" id="valFrom" name="valFrom" value="<%=valFrom%>" readonly /><%=getDateImage("valFrom")%></td>
		<th width=10% align=center>To</th>
		<td width=20%><input type="text" size="12" id="valTo" name="valTo" value="<%=valTo%>" readonly /><%=getDateImage("valTo")%></td>
				
		</tr>				

		<tr>

		<!--<th width=10%>Job Name</th>
		<td width=20%><input type="text" size="12" id="jobName" name="jobName" value="<%=jobName%>"  /></td>-->
		<th width=10%>Sold To Code</th>
		<td width=20% colspan=2>
		<ul>
		<li>
		<div class="input-box">
		<select name="soldToQT">
<%
		if("CU".equals(userRole))
		{
%>		
			<option value =""  >ALL</option>
 			
 <%
		}
		if(retsoldto_A_SesGet!=null)
		{
			for(int i=0;i<retsoldto_A_SesGet.getRowCount();i++)
			{
				String soldToCode_A 	= retsoldto_A_SesGet.getFieldValueString(i,"EC_ERP_CUST_NO");
				String soldToName_A 	= retsoldto_A_SesGet.getFieldValueString(i,"ECA_NAME");

				String selected_A = "selected";

				if(soldToQT.equals(soldToCode_A))
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
		</div>
		</li>
		</ul>				
		</td>
		<th width=10%>Quote Number</th>
		<td width=20%><input type="text" size="12" id="quoteNum" name="quoteNum" value="<%=quoteNum%>"  /></td>
		</tr>

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

	<table class="data-table" id="quotetable" >				
	<thead>																		
	
	<tr>
	
	<th width=25%>Job Name </th>
	<th width=15%>QuoteNo.<br>Quote Date</th>
	<!--<th width=15%>Quote Date</th> -->
	<th width=15%>Validity</th>
	<!-- <th width=15%>Valid To</th> -->
	<th width=35%>Job Ship-to Account</th>
	<!-- <th width=44%>Name</th> -->
	<th width=10%>Net Value [USD]</th>
	
	
	</tr>
	</thead>
	<tbody>
<%
		

		for(int i=0;i<cntSQ;i++)									      
		{												      
														      														     
			String salesDoc 	=   retObjExSQ.getFieldValueString(i,"SALESDOC");			      
			//String itemNo 	=   retObjExSQ.getFieldValueString(i,"ITEMNO");			      
			//String matCode 	=   retObjExSQ.getFieldValueString(i,"MATERIAL");			      
			//String matDesc 	=   retObjExSQ.getFieldValueString(i,"MATDESC"); 
			Date validFrom 	   = (Date)retObjExSQ.getFieldValue(i,"VALIDFROM");
			Date validTo 		=   (Date)retObjExSQ.getFieldValue(i,"VALIDTO");
			//String reqQty 	=   retObjExSQ.getFieldValueString(i,"REQQTY");
			//String netPrice 	=   retObjExSQ.getFieldValueString(i,"NETPRICE");
			String netValue 	=   retObjExSQ.getFieldValueString(i,"NETVALUE");
			Date docDate 		=   (Date)retObjExSQ.getFieldValue(i,"DOCDATE");
			String soldToCode 	=   retObjExSQ.getFieldValueString(i,"SOLDTO");
			String soldToName 	=   retObjExSQ.getFieldValueString(i,"SOLDTONAME");
			String poJobName 	=   retObjExSQ.getFieldValueString(i,"POJOBNAME");
			String docStatus 	=   openStat;//"O";//retObjExSQ.getFieldValueString(i,"DOC_STATUS");
			String shipToCode = retObjExSQ.getFieldValueString(i,"SHIP_TO");
			String shipToName = retObjExSQ.getFieldValueString(i,"SHIP_TO_NAME");

			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			String valFromStr = formatter.format(validFrom);
			String valToStr = formatter.format(validTo);
			String docDateStr = formatter.format(docDate);
			
			String tempSalesDoc="",tempSoldToCode="";
		
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
			}
			catch(Exception e)
			{	
				tempSoldToCode = soldToCode;
			}
			
			
%>
			<tr>
			<td ><a href="javascript:getJobDetails('<%=salesDoc%>','<%=soldToCode%>','<%=docStatus%>')"><%=poJobName%></a></td>
			<td ><%=tempSalesDoc%><br><%=docDateStr%></td>
			<!-- <td width=15%><%=docDateStr%></td> -->
			<td ><%=valFromStr%> to <%=valToStr%></td>
			<!-- <td width=15%><%=valToStr%></td> -->
			<td ><%=shipToName%>:<%=shipToCode%></td>
			<!-- <td width=44%><%=soldToName%></td> -->
			<td ><%=NumberFormat.getCurrencyInstance(Locale.US).format(new java.math.BigDecimal(netValue).doubleValue())%>&nbsp;</td>
			</tr>
<%
		}
%>
	</tbody>
	</table>
</div>
</div>
<Script src="../../Library/Script/popup.js"></Script>
<script>
$("#it").click(function () {
document.getElementById("");
$("#display").toggle( "slow" );
});
<%
	if((request.getParameter("soldToQT")==null || "".equals(request.getParameter("soldToQT")) || "null".equals(request.getParameter("soldToQT"))) && "CU".equals(userRole))		
	{
%>
		document.dateForm.soldToQT.value=""
<%
	}
%> 

function funClickLink(actionPage,statusval){
	Popup.showModal('headermodal');
	document.lMenuForm.status.value = statusval
	document.lMenuForm.action = actionPage;
	document.lMenuForm.submit();
}
</script>
</form>
</body>

</div>
</div>
</div>
<div class="col-left sidebar roundedCorners">
<form id="lMenuForm" name="lMenuForm" >
<input type="hidden" name="status" value=<%=openStat%> id="status">
	<div class="block block-account">
		<div class="block-title">
			<strong><span>View Quotes</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<% if (openStat.equals("O")) { %>
			<li class="current"><strong>Open</strong></li>
			<% } else  { %>
			<li><a href="javascript:funClickLink('../Quotes/ezJobQuotes.jsp','O')">Open</a></li>
			<% } %>
			<% if (openStat.equals("C")) { %>
			<li class="current"><strong>Closed</strong></li>
			<% } else  { %>
			<li><a href="javascript:funClickLink('../Quotes/ezJobQuotes.jsp','C')">Closed</a></li>
			<% } %>
			<li><a href="javascript:funClickLink('../Quotes/ezExpiredJobQuotes.jsp','E')">Expired Quotes</a></li>
			<li><a href="javascript:funClickLink('../Quotes/ezExpiringJobQuotes.jsp','ES')">Expiring Soon</a></li>

			</ul>
		</div>
	</div>
</form>
</div>
</div>
</div>