<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import ="ezc.ezparam.*,ezc.client.*,java.util.*,java.text.SimpleDateFormat"%>
 
<%@ page import ="ezc.ezparam.*,ezc.ezsap.*" %>
<%@ page import="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
 
 <jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
 
 <%
 	/*
		ezc.client.EzcUtilManager UtilManager1 = null;

		String soldto=(String) session.getValue("AgentCode");
		//String soldto=(String) session.getValue("docSoldTo");
		//out.println(soldto);
		String syskey=(String) session.getValue("SalesAreaCode");

		 UtilManager1 = new ezc.client.EzcUtilManager(Session);

		//String salesDocNo = "0051591817";
		String salesDocNo = request.getParameter("SalesOrder");
		String poNumber = request.getParameter("PurchaseOrder");

		EzcCustomerInvoiceParams ecparams = new EzcCustomerInvoiceParams();
		EziCustomerInvoiceParams eiParams = new EziCustomerInvoiceParams();

		eiParams.setCustInvoiceNo("1");
		eiParams.setSalesDocNum(salesDocNo);
		eiParams.setSelection("H");  

		ecparams.setObject( eiParams );
		Session.prepareParams(ecparams);

		ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)CustInvManager.getCustomerInvoiceDetails(ecparams);

		//ReturnObjFromRetrieve billHeaders = retObj.getBillingHeadersOut();
		ReturnObjFromRetrieve billHeaders = (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_HEADERS_OUT");


		//out.println(billHeaders.toEzcString());
 	*/
 	
 	
 	String [] myRetCols = {"BILLING_HEADERS_OUT","BILLING_ITEMS_OUT"};
	String [] myHeaderCols = {"Acctstatus","Billcateg","Billingdoc","BillType","Cancelled","Currency","CurrencyIso","Customer","ExRate","Ext1","Ext2","Ext3","NetValue","Payer","SdDocCat","TaxValue"};
 	
 	ReturnObjFromRetrieve finalRetObject 	= new ReturnObjFromRetrieve(myRetCols);
	ReturnObjFromRetrieve retHeader 	= new ReturnObjFromRetrieve(myHeaderCols);
	
	String salesDocNo = request.getParameter("SalesOrder");
  	String poNumber = request.getParameter("PurchaseOrder");
	String soldtoFromSO = request.getParameter("soldToCode");
	String soldto=(String) session.getValue("AgentCode");

	//out.println("SO nr is "+salesDocNo);

 	String poSONums[] = null;
 	if(salesDocNo!=null)
		poSONums = salesDocNo.split("ÿ");	

	
	JCO.Client client2=null;
	JCO.Function function1 = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";

	try
 	{
		function1 = EzSAPHandler.getFunction("Z_EZ_GET_CUSTOMER_INVOICE_DTL",site_S+"~"+skey_S);
		JCO.ParameterList 	sapProc 	= function1.getImportParameterList();
		
		//sapProc.setValue("1001","SALESORG");
		if ((soldtoFromSO != null) && !soldtoFromSO.equals("")) {
			sapProc.setValue(soldtoFromSO,"CUSTOMER");
			//out.println(" going for Sold To:"+soldtoFromSO);
		} else {
			sapProc.setValue(soldto,"CUSTOMER");
		}
		sapProc.setValue("1","BILL_DOC_NO");
		sapProc.setValue("H","SELECTION");
		
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
		{
			client2 = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
			client2.execute(function1);
		}
		catch(Exception ec)
		{
			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
 		}

 		JCO.Table headerTable 	= function1.getTableParameterList().getTable("BILLING_HEADERS_OUT");
 		
		
 		if ( headerTable != null )
		{
			if (headerTable.getNumRows() > 0)
			{
				do
				{
					if(!"LG".equals((String)headerTable.getValue("BILL_TYPE")))
					{
						retHeader.setFieldValue("Acctstatus",headerTable.getValue("ACCTSTATUS"));
						retHeader.setFieldValue("Billcateg",headerTable.getValue("BILLCATEG"));
						retHeader.setFieldValue("Billingdoc", headerTable.getValue("BILLINGDOC"));
						retHeader.setFieldValue("BillType", headerTable.getValue("BILL_TYPE"));		
						retHeader.setFieldValue("Cancelled", headerTable.getValue("CANCELLED"));
						retHeader.setFieldValue("Currency", headerTable.getValue("CURRENCY"));		
						retHeader.setFieldValue("CurrencyIso",headerTable.getValue("CURRENCY_ISO"));
						retHeader.setFieldValue("Customer", headerTable.getValue("CUSTOMER"));			
						retHeader.setFieldValue("ExRate", headerTable.getValue("EX_RATE"));					
						retHeader.setFieldValue("Ext1", headerTable.getValue("EXT1"));
						retHeader.setFieldValue("Ext2", headerTable.getValue("EXT2"));
						retHeader.setFieldValue("Ext3", headerTable.getValue("EXT3"));
						retHeader.setFieldValue("NetValue", headerTable.getValue("NET_VALUE"));
						retHeader.setFieldValue("Payer", headerTable.getValue("PAYER"));
						retHeader.setFieldValue("SdDocCat", headerTable.getValue("SD_DOC_CAT"));
						retHeader.setFieldValue("TaxValue", headerTable.getValue("TAX_VALUE"));
						retHeader.addRow();
					}	



				}while(headerTable.nextRow());
			}	
		}
		
		finalRetObject.setFieldValue("BILLING_HEADERS_OUT",retHeader);
		finalRetObject.addRow();
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
 	 

	ReturnObjFromRetrieve billHeaders = (ReturnObjFromRetrieve)finalRetObject.getFieldValue("BILLING_HEADERS_OUT");
 	
 	
 	int billHeadersCnt = 0;
 	
 	if(billHeaders!=null)
 		billHeadersCnt = billHeaders.getRowCount();
// 	out.println(billHeaders.toEzcString());
 %>

<script type="text/javascript">
	
	function getDetails(invNumber)
	{
		Popup.showModal('headermodal');
		document.myForm.sapInvNo.value=invNumber;

		document.myForm.action="ezSOInvoiceDetailsMain.jsp";
		document.myForm.submit();
	}

	function funBack()
	{
		document.myForm.action = "../Sales/ezSalesOrderDetails.jsp";
		document.myForm.submit();
	}

	 
 </script>
	
</div>
<form name="myForm" method="post">
<input type="hidden" name="sapInvNo">
<input type="hidden" name="soNumber" value='<%=salesDocNo%>'>
<input type="hidden" name="poNumber" value='<%=poNumber%>'>
<input type='hidden' name='soldTo' value='<%=soldto%>'>
<input type='hidden' name='soldToCode' value='<%=request.getParameter("soldToCode")%>'>
<input type='hidden' name='salesOrder' value='<%=salesDocNo%>'>
<style>
.highlight {
                height: 60px;
                width: 100%;
                background: #e9e9e9;
		background: -webkit-linear-gradient(#e9e9e9, #c0c0c0);
		background: -moz-linear-gradient(#e9e9e9, #c0c0c0);
		background: -ms-linear-gradient(#e9e9e9, #c0c0c0);
		background: -o-linear-gradient(#e9e9e9, #c0c0c0);
		background: linear-gradient(#e9e9e9, #c0c0c0);
}
</style>
<%
	String dispHeader = "No Invoices for chosen PO No "+poNumber;

	if(billHeadersCnt>0)
		dispHeader = "Invoices for PO No "+poNumber;
%>
<div class="block" style="padding-left:0px">
<div class="block-title">
<strong>
<span>
<%=dispHeader%></span>
</strong>
</div>
 
</div>
	<br>
	<!--<div>
		<button type="button" title="Back" class="button btn-update" onclick="javascript:funBack()"><span>Back</span></button>
	</div>-->
<br>
<!-- <h2 class="sub-title"><%=dispHeader%></h2> -->
<%
	if(billHeadersCnt>0)
	{
%>
<div class="col1-set">
<div class="info-box"><br>
	<table class="data-table" id="example">
	<thead>
	<tr>
	<th>&nbsp;Invoice No.</th>
	<th>&nbsp;Invoice Date </th>
	<th>&nbsp;Value [USD]</th>
	</tr>
	</thead>
	<tbody>
<%
		for(int i=0;i<billHeadersCnt;i++)
		{
			String invNumber	= billHeaders.getFieldValueString(i,"Billingdoc");
			String ext2	= billHeaders.getFieldValueString(i,"Ext2"); // Invoice Date yyyymmdd
			String currency		= billHeaders.getFieldValueString(i,"Currency");
			String netValue 	= billHeaders.getFieldValueString(i,"NetValue");
			Date invoiceDate = new SimpleDateFormat("yyyyMMdd", Locale.US).parse(ext2);
			String invoiceDateStr = new SimpleDateFormat("MM/dd/yyyy", Locale.US).format(invoiceDate);

			
			try{
				netValue 	= (new  java.math.BigDecimal(billHeaders.getFieldValueString(i,"NetValue")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
			}catch(Exception e){}	
%>
			<tr>
			<td >&nbsp;<a href="javascript:getDetails('<%=invNumber%>')"><%=invNumber%></a></td>
			<td >&nbsp;<%=invoiceDateStr%></td>
			<td >&nbsp;<%=netValue%></td>
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
