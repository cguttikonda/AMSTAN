<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
 <%@ page import ="ezc.customer.invoice.params.*" %>
 <%@ page import ="ezc.ezparam.*,ezc.client.*,java.util.*"%>
 
 <%@ page import = "ezc.ezparam.*" %>
 <%@ page import ="ezc.ezparam.*,ezc.ezsap.*" %>
 <%@ page import="com.sap.mw.jco.*,java.util.*" %>
 <%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
 <%
 	String dlHdrCols[] = {"DELIVERY_NUM","DELIVERY_DATE"};
 
 	ReturnObjFromRetrieve dlvHeader = new ReturnObjFromRetrieve(dlHdrCols);
 	
 	
 	
 	String soldto=(String) session.getValue("AgentCode");
 	String syskey=(String) session.getValue("SalesAreaCode");
 	String salesOrg=(String) session.getValue("SALESORG");
 	
 	String lineNumber = request.getParameter("LineNumber");
 	
 	
 	
 	String soNumber = request.getParameter("SalesOrder");
 	
 	if ( soNumber == null || soNumber.equals("null"))
 		soNumber = request.getParameter("salesOrder");
 		
 	
 
 	//out.println("SO nr is "+soNumber);
 	String poSONums[] = null;
 	if(soNumber!=null)
		poSONums = soNumber.split("ÿ");	

 	String soldtoFromSO = request.getParameter("soldToCode");
 	//out.println("soldto"+soldto+"syskey"+syskey+"soNumber"+soNumber+""+poNumber);
 
 	JCO.Client client2=null;
 	JCO.Function function1 = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";

 	try
 	{
 		function1= EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_DELIVERY",site_S+"~"+skey_S);
 		//out.println("function>>>>>>"+function);
 		JCO.ParameterList 	sapProc 	= function1.getImportParameterList();
 		
 		//sapProc.setValue(soNumber,"SALESDOCUMENT");
		if ((soldtoFromSO != null) && !soldtoFromSO.equals("")) {
			sapProc.setValue(soldtoFromSO,"CUSTOMER");
			//out.println(" going for Sold To:"+soldtoFromSO);
		} else {
			sapProc.setValue(soldto,"CUSTOMER");
		}

 		//sapProc.setValue("1001","SALESORG");
 		sapProc.setValue("H","SELECTION");
 		
 		if (lineNumber != null && !(lineNumber.trim().equals(""))){
 			sapProc.setValue(lineNumber,"LINEITEM");
 			//out.println("Setting lineNumber "+lineNumber);
 		}

 		
 		//JCO.Table salesTable = function.getTableParameterList().getTable("DELIV_HEADER");
 		JCO.Table soNumTable = function1.getTableParameterList().getTable("SALES_DOCUMENTS");
 
 		if (poSONums != null) {
 		
 		for (int sn=0;sn<poSONums.length;sn++){
 		soNumTable.appendRow();
 		soNumTable.setValue(poSONums[sn],"VBELN");
 		} 
 		
 		}
 		else {
 		sapProc.setValue(poNumber,"PO_NUMBER");
 		}

 		try
 		{	// Execute RFC Call
 			client2 = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
 			client2.execute(function1);
 			//out.println(":::::::::::::::::::ec::::::::::::::::::::"+client1);
 		}
 		catch(Exception ec)
 		{
 			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
 		}
 
 		JCO.Table headerTable 		= function1.getTableParameterList().getTable("DELIV_HEADER");
 		
 		//out.println(":::::::::::::::::::headerTable::::::::::::::::::::"+headerTable);
 
 		if(headerTable!=null)
 		{
 			if (headerTable.getNumRows() > 0)
 			{
 				do
 				{
 					dlvHeader.setFieldValue("DELIVERY_NUM",headerTable.getValue("DELIV_NUMB"));
 					dlvHeader.setFieldValue("DELIVERY_DATE",headerTable.getValue("DELIV_DATE"));
 					dlvHeader.addRow();
 				
 					 //out.println(" DELIV_NUMB :::::::::::::::::::"+headerTable.getValue("DELIV_NUMB"));
 					 //out.println(" DELIV_DATE :::::::::::::::::::"+headerTable.getValue("DELIV_DATE"));
 					  
 
 				}
 				while(headerTable.nextRow());
 			}
 		}
 	}
 	catch(Exception e)
 	{
 		out.println("EXCEPTION>>>>>>"+e);
 	}
 	finally
 	{
 		if (client2!=null)
 		{
 			JCO.releaseClient(client2);
 			client2 = null;
 			function1=null;
 		}
 	}
 	
 	
 	//out.println(dlvHeader.toEzcString());
 	
 	int billHeadersCnt = dlvHeader.getRowCount();
 	
 	
%>

<script type="text/javascript">
	
	function getDetails(dlvNumber)
	{
		Popup.showModal('headermodal');
		document.myForm.dlvNumber.value=dlvNumber;
		document.myForm.soldToCode.value = '<%=soldtoFromSO%>';
		document.myForm.action="ezSODeliveryDetailsMain.jsp";
		document.myForm.submit();
	}
	function getPrintDtl()
	{
		Popup.showModal('headermodal');
		var dlvNoLen = eval("document.myForm.dlvNo").length
		var dlvNo;
		for(i=0;i<dlvNoLen;i++)
		{
			if(document.myForm.dlvNo[i].checked)
			{
				dlvNo = document.myForm.dlvNo[i].value
				break;
			}
		}
		if(dlvNo=='')
		{
			alert("Please select the document to print")
			return;
		}
		document.myForm.delivNo.value=dlvNo
		document.myForm.action="ezSODeliveryPrint.jsp";
		document.myForm.submit();
	
	}
	function funBack()
	{
		document.myForm.action = "../Sales/ezSalesOrderDetails.jsp";
		document.myForm.submit();
	}
	function getDetailsOnLoad()
	{
		Popup.showModal('headermodal');
		document.myForm.dlvNumber.value = '<%=dlvHeader.getFieldValueString(0,"DELIVERY_NUM")%>';
		document.myForm.soldToCode.value = '<%=soldtoFromSO%>';
		document.myForm.action = "ezSODeliveryDetailsMain.jsp";
		document.myForm.submit();	
	
	}
	
</script>
<form name="myForm" method="post">

<input type='hidden' name='salesOrder' value='<%=soNumber%>'>
<input type='hidden' name='soldTo' value='<%=soldto%>'>
<input type='hidden' name='delivNo' >
<%
	String dispHeader = "NO ASN/PACKING SLIP FOR PO# "+poNumber;

	if(billHeadersCnt>0)
		dispHeader = "ASN/PACKING SLIP FOR PO# "+poNumber;
%>
<div class="highlight" >
<br>
<font size="5" color="black">
<b> <%=dispHeader%> </b>
</font>
</div>
<br>
<div id="divAction" style="display:block;">
	<button type="button" title="Print" class="button btn-update" onclick="javascript:funBack()"><span>Back to PO</span></button>
</div>
<br>
<!-- <h2 class="sub-title"><%=dispHeader%></h2> -->

<%
	if(billHeadersCnt>0)
	{
%>
<div class="col1-set">
<div class="info-box"><br>

<input type="hidden" name="dlvNumber">
<input type="hidden" name="billHeadersCnt" value="<%=billHeadersCnt%>">
<input type="hidden" name="PurchaseOrder" value='<%=poNumber%>'>
<input type="hidden" name = "soldToCode" value="<%=soldtoFromSO%>">
	<table class="data-table" id="example">
	<thead>
	<tr>
	<!-- <th width=5%>&nbsp;</th> -->
	<th width=30%>ASN/Packing Slip No.</th>
	<th width=40%>ASN/Packing Slip Date</th>
	</tr>
	</thead>
	<tbody>
<%
		FormatDate frmDt=new FormatDate();
		for(int i=0;i<billHeadersCnt;i++)
		{
			String dlvNumber	= dlvHeader.getFieldValueString(i,"DELIVERY_NUM");
			//String dlvDate = FormatDate.getStringFromDate((Date)dlvHeader.getFieldValue(i,"DELIVERY_DATE"),".",frmDt.MMDDYYYY);
			
			
			Date dlvDtObj = (Date)dlvHeader.getFieldValue(i,"DELIVERY_DATE");
			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			String dlvDate = formatter.format(dlvDtObj);
			
			
%>
			<tr>
			<!-- <td width=5%><input type="radio" name="dlvNo" value="<%=dlvNumber%>"></td> -->
			<td width=30%><a href="javascript:getDetails('<%=dlvNumber%>')"><%=dlvNumber%></a></td>
			<td width=30%><%=dlvDate%></td>
			</tr>
<%
		}
%>
	</tbody>
	</table>
		
</div>
		<br>
<!--		<P><input type="button" onClick="javascript:getPrintDtl()" value="Print ASN/Packing Slip"/></P> 
		<button type="button" title="Print ASN/Packing Slip" class="button" 
		onclick="javascript:getPrintDtl()">Print ASN/Packing Slip</button>-->

</div>

<%
	}
%>
</form>
</div>
</div>
</div>
</div>
<script>
var cnt = <%=billHeadersCnt%>
if(cnt=='1')
	getDetailsOnLoad()

</script>