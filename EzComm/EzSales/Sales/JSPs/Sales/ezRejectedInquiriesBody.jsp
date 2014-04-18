 <%@ include file="../../../Includes/JSPs/Sales/iRejectedInquiries.jsp"%>
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
 	//out.print("rejInqObj:::"+rejInqObj.toEzcString());
 
 	String fromDate = request.getParameter("fromDate");
 	String toDate = request.getParameter("toDate");
 	ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
 	String soldToQT = request.getParameter("selSoldTo");
 	if(soldToQT==null || "null".equals(soldToQT)) soldToQT ="";		
	
 	if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_S+"/"+fDate_S+"/"+fyear;
 	if(toDate==null || "null".equalsIgnoreCase(toDate)) toDate = cMonth_S+"/"+cDate_S+"/"+cYear;
 	int rejInqObjCnt = 0;
 	if(rejInqObj!=null && rejInqObj.getRowCount()>0)
 		 rejInqObjCnt = rejInqObj.getRowCount();
 	
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
<script>
function getOrders()
{
	Popup.showModal('headermodal');
	document. myForm.action="ezRejectedInquiries.jsp";
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
 
 <!-- jQuery for sorting & pagination ENDS here -->
 <link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
 <%
 	String searchStat = request.getParameter("searchStat");
 	String BussPart =  (String)session.getValue("BussPart");
 	String shipToQT = request.getParameter("shipTo");
  	if(shipToQT==null || "null".equals(shipToQT)) shipToQT ="";
 	ReturnObjFromRetrieve retShips = null;
 	
 	String dispHeader = "Rejected Orders";
 
 	String disp="display:none";
 	HashMap soldToHash = (HashMap)session.getValue("SOLDTONAMES");
 	//out.println("soldToHash::::"+soldToHash);
 	String soldToName = "";
 
 	if("Y".equals(searchStat) || "Y"==searchStat)
 		disp = "";
 	if(request.getParameter("selSoldTo")!=null && !"".equals(request.getParameter("selSoldTo")) && !"null".equals(request.getParameter("selSoldTo")) && "Y".equals(searchStat))
 	{
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
 

 <div class="col1-set">
 <div class="info-box"><br>
 
 <input type="hidden" name="webOrNo">
 <input type="hidden" name="soldTo">
 <input type="hidden" name="selectedSoldTo">
 <input type="hidden" name="sysKey">
 <input type="hidden" name="fromNeg" value ="Y">
 <input type="hidden" name="negotiateType" value="REJECTED">
 	<table class="data-table" id="example">
 	<thead>
 	<tr>
 	<th width=20%>PO Id</th>
 	<th width=20%>PO Date</th>
 	<th width=20%>Rejected Date</th>
 	<th width=20%>Customer</th>
 	<th width=20%>Status</th>
 	</tr>
 	</thead>
 	<tbody>
<%
   	for(int i=0;i<rejInqObjCnt;i++)
 	{

		String poId		= rejInqObj.getFieldValueString(i,"ESDH_PO_NO");
		String docId		= rejInqObj.getFieldValueString(i,"ESDH_DOC_NUMBER");
		String createdOn	= rejInqObj.getFieldValueString(i,"ESDH_CREATE_ON");
		String modifiedOn	= rejInqObj.getFieldValueString(i,"ESDH_MODIFIED_ON");
		String createdBy	= rejInqObj.getFieldValueString(i,"ESDH_SOLD_TO");
		String status		= rejInqObj.getFieldValueString(i,"ESDH_STATUS");
		String sysKey		= rejInqObj.getFieldValueString(i,"ESDH_SYS_KEY");

		Date DateTo = new Date();
		DateFormat formatter1 = new SimpleDateFormat("MM/dd/yyyy");
		createdOn = formatter1.format(DateTo);
		modifiedOn = formatter1.format(DateTo);
%>
 		<tr>
 		<td width=20%><a href="javascript:getDetails('<%=docId%>','<%=createdBy%>','<%=sysKey%>')"><%=poId%></a></td>
 		<td width=20%><%=createdOn%></td>
 		<td width=20%><%=modifiedOn%></td>
 		<td width=20%><%=createdBy%></td>
 		<td width=20%><%=status%></td>
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
