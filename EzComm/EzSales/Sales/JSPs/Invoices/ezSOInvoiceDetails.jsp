<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import ="ezc.ezdispatch.params.*,ezc.ezdispatch.client.*,ezc.client.*"%>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />

<%

	//String custInvNo 		=  "0098482592";//request.getParameter("custInvNo");
	String sapInvNo 		= request.getParameter("sapInvNo");
	String tempInvNo		= "0000000000"+sapInvNo;
	sapInvNo= tempInvNo.substring((tempInvNo.length()-10),tempInvNo.length());
	String fromPage = request.getParameter("fromPage");
	String soldto=(String) session.getValue("AgentCode");
	String soldtoFromSO = request.getParameter("soldToCode");
	if(fromPage==null || "".equals(fromPage))fromPage="N";
	//out.println("sapInvNo::::::::::::::::::::"+sapInvNo);
	//String InvDate 			= request.getParameter("InvDate");
	
	String [] myRetCols = {"BILLING_HEADERS_OUT","BILLING_ITEMS_OUT"};
	String [] myHeaderCols = {"Acctstatus","Billcateg","Billingdoc","BillType","Cancelled","Currency","CurrencyIso","Customer","ExRate","Ext1","Ext2","Ext3","NetValue","Payer","SdDocCat","TaxValue","InvoiceDate"};
	String [] myItemsCols = {"Baseunit","BillDoc","BillDocIt","CashDisc","DelDate","DelDoc","DelDocItem","ExRate","Ext1","Ext2","Ext3","NetValue","Quantity","Salesorder","Salesunit","Taxes","MatText","Matno","OrderQuantity","OrdUOM"};

	ReturnObjFromRetrieve finalRetObject 	= new ReturnObjFromRetrieve(myRetCols);
	ReturnObjFromRetrieve retHeader 		= new ReturnObjFromRetrieve(myHeaderCols);
	ReturnObjFromRetrieve retItems 			= new ReturnObjFromRetrieve(myItemsCols);

	JCO.Client client=null;
	JCO.Function functionInv = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";

	try
	{

	functionInv= EzSAPHandler.getFunction("Z_EZ_GET_CUSTOMER_INVOICE_DTL",site_S+"~"+skey_S);
	JCO.ParameterList 	sapProc 	= functionInv.getImportParameterList();
	//sapProc.setValue(salesOrg,"SALESORG");
	if ((soldtoFromSO != null) && !soldtoFromSO.equals("")) {
		sapProc.setValue(soldtoFromSO,"CUSTOMER");
		//out.println(" going for Sold To:"+soldtoFromSO);
	} else {
		sapProc.setValue(soldto,"CUSTOMER");
	}

	sapProc.setValue(sapInvNo,"BILL_DOC_NO");
	sapProc.setValue("I","SELECTION");
	
	try
		{	// Execute RFC Call
			client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
			client.execute(functionInv);
			//out.println(":::::::::::::::::::ec::::::::::::::::::::"+client1);
		}
		catch(Exception ec)
		{
			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
	}
	JCO.Table headerTable 			= functionInv.getTableParameterList().getTable("BILLING_HEADERS_OUT");
	JCO.Table itemsTable 			= functionInv.getTableParameterList().getTable("BILLING_ITEMS_OUT");
	if ( headerTable != null )
	{
		if (headerTable.getNumRows() > 0)
		{
			do
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
				//retHeader.setFieldValue("InvoiceDate", headerTable.getValue("INVOICEDATE"));
				
				System.out.println(">>>"+retHeader.getFieldValue("Billingdoc"));
				retHeader.addRow();



			}while(headerTable.nextRow());
		}	
	}
	if ( itemsTable != null )
	{
		if (itemsTable.getNumRows() > 0)
		{
			do
			{
				retItems.setFieldValue("Baseunit",itemsTable.getValue("BASEUNIT"));
				retItems.setFieldValue("BillDoc",itemsTable.getValue("BILL_DOC"));
				retItems.setFieldValue("BillDocIt", itemsTable.getValue("BILL_DOC_IT"));
				retItems.setFieldValue("CashDisc", itemsTable.getValue("CASH_DISC"));		
				retItems.setFieldValue("DelDate", itemsTable.getValue("DEL_DATE"));
				retItems.setFieldValue("DelDoc", itemsTable.getValue("DEL_DOC"));		
				retItems.setFieldValue("DelDocItem",itemsTable.getValue("DEL_DOC_ITEM"));
				retItems.setFieldValue("ExRate", itemsTable.getValue("EX_RATE"));					
				retItems.setFieldValue("Ext1", itemsTable.getValue("EXT1"));
				retItems.setFieldValue("Ext2", itemsTable.getValue("EXT2"));
				retItems.setFieldValue("Ext3", itemsTable.getValue("EXT3"));
				retItems.setFieldValue("NetValue",itemsTable.getValue("NETVALUE"));
				retItems.setFieldValue("Quantity",itemsTable.getValue("QUANTITY"));						
				retItems.setFieldValue("OrderQuantity",itemsTable.getValue("ORDQTY"));
				retItems.setFieldValue("Salesorder", itemsTable.getValue("SALESORDER"));
				retItems.setFieldValue("Salesunit", itemsTable.getValue("SALESUNIT"));
				retItems.setFieldValue("Taxes", itemsTable.getValue("TAXES"));
				retItems.setFieldValue("MatText", itemsTable.getValue("MAT_TEXT"));
				retItems.setFieldValue("Matno", itemsTable.getValue("MATNO"));
				retItems.addRow();
			}while(itemsTable.nextRow());
		}	
	}			

	finalRetObject.setFieldValue("BILLING_HEADERS_OUT",retHeader);
	finalRetObject.setFieldValue("BILLING_ITEMS_OUT",retItems);
	finalRetObject.addRow();
	}
 	catch(Exception e)
 	{
 		out.println("EXCEPTION>>>>>>"+e);
 	}
 	finally
 	{
 		if (client!=null)
 		{
 			JCO.releaseClient(client);
 			client = null;
 			functionInv=null;
 		}
 	}

	ReturnObjFromRetrieve billHeaders 	= (ReturnObjFromRetrieve)finalRetObject.getFieldValue("BILLING_HEADERS_OUT");
	ReturnObjFromRetrieve billItems 	= (ReturnObjFromRetrieve)finalRetObject.getFieldValue("BILLING_ITEMS_OUT");


	//out.println(billHeaders.toEzcString());
	//out.println(billItems.toEzcString());

%>



<script type="text/javascript">

function checkAll(field)
{	
	if(document.myForm.CheckBoxAll.checked)
	{	
		for (i = 0; i < field.length; i++)
		{
			document.myForm.CheckBox1[i].checked = true ;
			alert(document.myForm.CheckBox1[i].checked)
		}
	}	
	else
	{	
		for (i = 0; i < field.length; i++)
		{
			document.myForm.CheckBox1[i].checked = false ;
			alert(document.myForm.CheckBox1[i].checked)
		}
	}				
}

function funBack(from)
{
	if(from=='N')
		document.myForm.action = "ezSOInvoiceList.jsp";
	else if(from=='Y')
		document.myForm.action = "ezOpenInvoices.jsp";
	document.myForm.submit();
}

function funPrint()
{
	document.myForm.action = "ezInvoicePrint.jsp";
	document.myForm.submit();
}
function getProductDetails(code)
{
	document.myForm.prodCode_D.value=code;

	document.myForm.action="../Catalog/ezProductDetails.jsp";
	document.myForm.submit();
}
</script>

<%!
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
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
				    "bFooter":false,
				    "mColumns": [ 0, 1 ,2,3,4,5,6]

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

<!-- jQuery for sorting & pagination ENDS here -->
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>

<%
	String dispHeader = "Invoice Lines for Invoice "+sapInvNo;
	String formattedNetVal	= "0";
	try{
		//formattedNetVal = billHeaders.getFieldValueString(0,"NetValue");
		formattedNetVal = (new  java.math.BigDecimal(billHeaders.getFieldValueString(0,"NetValue")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
	}catch(Exception e){}	
%>
	<div class="page-title">
	<div class="highlight" id="invheader" >
	<div style="width: 100%; float: left">
		<br>&nbsp;<font size="5" color="black"><b>INVOICE DETAILS</b> </font><br>
		<% Date invdtObj = (Date)billItems.getFieldValue(0,"DelDate");
				DateFormat formatter2 = new SimpleDateFormat("MM/dd/yyyy");
				String invdtStr = formatter2.format(invdtObj);
	%>
		&nbsp;<strong>INVOICE NO:</strong>&nbsp;<%=sapInvNo%><strong> INVOICE DATE:</strong>&nbsp;<%=invdtStr%> <strong>PO NO:</strong>&nbsp;<%=request.getParameter("poNumber")%>&nbsp;<strong>DELIVERY DOC NO.:</strong>&nbsp;<%=billItems.getFieldValueString(0,"DelDoc")%><br>
	</div>
	</div>

	<div style="padding-left:2px"><br>
<h3> Print Invoice to view PDF Version similar to Paper Copy Invoice and obtain additional Details</h3>
		<br>
	</div>
	<div id="divAction" style="display:block">
	<button type="button" title="Back" class="button btn-update" onclick="javascript:funBack('<%=fromPage%>')"><span>Back to List</span></button>
	<button type="button" title="Print" class="button btn-update" onclick="javascript:funPrint()"><span>Print Invoice</span></button>
	</div>
</div> <!-- page title div-->
<br>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title">Sold To</h2>
<%
		String sysKey = (String)session.getValue("SalesAreaCode");
		ezc.ezcommon.EzLog4j.log("Check Call:::::Start","D");
		ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(sysKey);
		ezc.ezcommon.EzLog4j.log("Check Call:::::End","D");
		//out.println("retsoldto_A:::::::"+retsoldto_A.toEzcString());
		String soldToInfo = "";
		String payerInfo = "";
		if(retsoldto_A!=null)
		{
			for(int i=0;i<retsoldto_A.getRowCount();i++)
			{
				String soldToCode_A 	= retsoldto_A.getFieldValueString(i,"EC_ERP_CUST_NO");
				String soldToName_A 	= retsoldto_A.getFieldValueString(i,"ECA_NAME");

				String selected_A = "";

				if(billHeaders.getFieldValueString(0,"Customer").equals(soldToCode_A))
				{
					soldToInfo+=billHeaders.getFieldValueString(0,"Customer")+"<br>";
					
					soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_NAME")+"<br>";
					
					soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_ADDR_1")+"<br>";
					
					soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_CITY")+"&nbsp;";
					if ((retsoldto_A.getFieldValueString(i,"ECA_DISTRICT") != null) && (retsoldto_A.getFieldValueString(i,"ECA_DISTRICT") != "null"))
					soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_DISTRICT")+"<br>";
					if ((retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE") != null) && (retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE") != "null"))
					soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE")+"<br>";
					
				}
				if(billHeaders.getFieldValueString(0,"Payer").equals(soldToCode_A))
				{
					payerInfo+=billHeaders.getFieldValueString(0,"Customer")+"<br>";

					payerInfo+=retsoldto_A.getFieldValueString(i,"ECA_NAME")+"<br>";

					payerInfo+=retsoldto_A.getFieldValueString(i,"ECA_ADDR_1")+"<br>";

					payerInfo+=retsoldto_A.getFieldValueString(i,"ECA_CITY")+"&nbsp;";
					if ((retsoldto_A.getFieldValueString(i,"ECA_DISTRICT") != null) && (retsoldto_A.getFieldValueString(i,"ECA_DISTRICT") != "null"))
					payerInfo+=retsoldto_A.getFieldValueString(i,"ECA_DISTRICT")+"<br>";
					if ((retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE") != null) && (retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE") != "null"))
					payerInfo+=retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE")+"<br>";

				}

			}
		}	

%>
		<p><%=soldToInfo%></p>
	</div>

	</div>
	<div class="col-2">
		<div class="info-box">
			<h2 class="sub-title">Payer</h2>
			<p><%=payerInfo%></p>
		</div>
	</div>
	<div class="col-3">
		<div class="info-box">
			<h2 class="sub-title">Net Value</h2>
			<p><%=formattedNetVal%>&nbsp;<%=billHeaders.getFieldValueString(0,"Currency")%><br></p>
			<h2 class="sub-title"> ASB Sales Order #</h2>
			<p><%=billItems.getFieldValueString(0,"Salesorder")%></p>
		</div>
	</div>
	
</div>
<br><br>
<div class="col1-set">
<div class="info-box">

<form name="myForm" method="POST">	

<input type='hidden' name='SalesOrder' value='<%=request.getParameter("soNumber")%>'>
<input type='hidden' name='PurchaseOrder' value='<%=request.getParameter("poNumber")%>'>
<input type='hidden' name='custInvNo' value='<%=sapInvNo%>'>
<input type='hidden' name='Site' value='200'>
<input type='hidden' name='fromPage' value='ezSOInvoiceDetails.jsp'>
<input type='hidden' name='AgentCode' value='<%="102400000"%>'>
<input type="hidden" name="soldToCode" value="<%=request.getParameter("soldToCode")%>">
<input type="hidden" name="prodCode_D">
<!-- http://colwd162/AST/EzComm/EzSales/Sales/JSPs/Invoices/ezSOInvoicePrint.jsp?custInvNo=0095583484&AgentCode=102400000&Site=200&fromPage=invoicelist -->


	<table class="data-table" id="example">
	<thead>
	<tr>
	<th> Product No.</th>
	<th> Description</th>
	<th> UOM</th>
	<th> Ordered <br>Quantity</th>
	<th> Invoice <br>Quantity</th>
	<th> Price </th>
	<th> Value[USD]</th>
	<!-- <th>Cash Disc. Value </th> -->
	</tr>
	</thead>
	<tbody>
<%

/*
 --------------- Row 0 --------------------- 
 0 ::  Field Name : Baseunit ----> Field Value : EA 
 0 ::  Field Name : BillDoc ----> Field Value : 0098482592 
 0 ::  Field Name : BillDocIt ----> Field Value : 000010 
 0 ::  Field Name : CashDisc ----> Field Value : 1042.36 
 0 ::  Field Name : DelDate ----> Field Value : Tue Dec 06 00:00:00 EST 2011 
 0 ::  Field Name : DelDoc ----> Field Value : 0281831325 
 0 ::  Field Name : DelDocItem ----> Field Value : 000010 
 0 ::  Field Name : ExRate ----> Field Value : 1.00000 
 0 ::  Field Name : Ext1 ----> Field Value : 000010 
 0 ::  Field Name : Ext2 ----> Field Value :  
 0 ::  Field Name : Ext3 ----> Field Value :  
 0 ::  Field Name : NetValue ----> Field Value : 1046.12 
 0 ::  Field Name : Quantity ----> Field Value : 4.000 
 0 ::  Field Name : Salesorder ----> Field Value : 0051591817 
 0 ::  Field Name : Salesunit ----> Field Value : EA 
 0 ::  Field Name : Taxes ----> Field Value : 0 
 0 ::  Field Name : MatText ----> Field Value : SELECTRONIC, DC, CAST SPOUT, 1.5 GPM VP 
 0 ::  Field Name : Matno ----> Field Value : 6055102.002
 --------------- End Of Row 0 -------------- 

*/


	java.math.BigDecimal totTax = new java.math.BigDecimal("0");
	int count = billItems.getRowCount();
	String calcFreight = "0";

	for(int i=0;i<count;i++)
	{
		
		String prodCode		= billItems.getFieldValueString(i,"Matno");
		String prodDesc		= billItems.getFieldValueString(i,"MatText");
		String uom		= billItems.getFieldValueString(i,"Salesunit");
		String ordquantity         = billItems.getFieldValueString(i,"OrderQuantity");
		String quantity         = billItems.getFieldValueString(i,"Quantity");
		String value		= billItems.getFieldValueString(i,"NetValue");
		String cashDiscValue 	= billItems.getFieldValueString(i,"CashDisc");
		calcFreight = (Double.parseDouble(calcFreight)+Double.parseDouble(value)-Double.parseDouble(cashDiscValue))+"";
		
		String price		= "0";
		
		try{
			price 		= (Double.parseDouble(cashDiscValue)/Double.parseDouble(quantity))+"";
			price 	= (new  java.math.BigDecimal(price).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
		}catch(Exception e){}	


%>
	
	<tr>
		<td style="text-align: left;"> <a href="../Catalog/ezProductDetails.jsp?prodCode_D=<%=prodCode%>"title="<%=prodDesc%>" target="_blank"><%=prodCode%></a><br></td>
		<td style="text-align: left;"> <%=prodDesc%>&nbsp;</td>
		<td style="text-align: center;"> <%=uom%></td>
		<td class="price"> <%=eliminateDecimals(ordquantity)%> </td>
		<td class="price"> <%=eliminateDecimals(quantity)%> </td>
		<td class="price"> <%=NumberFormat.getCurrencyInstance(Locale.US).format(new java.math.BigDecimal(price).doubleValue())%>&nbsp; </td>
		<td class="price"> <%=NumberFormat.getCurrencyInstance(Locale.US).format(new java.math.BigDecimal(cashDiscValue).doubleValue())%>&nbsp;</td>
		<!-- <td align="a-right"><%=cashDiscValue%></td> -->
	</tr>
<%
	}
	try{
		calcFreight = (new  java.math.BigDecimal(calcFreight).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
	}catch(Exception e){}	
	
%>
	
	</tbody>
	<tfoot>
	<tr>
		<th colspan = "6" class="price">Shipping and Handling &nbsp;</th>
		<th class="price"><%=NumberFormat.getCurrencyInstance(Locale.US).format(new java.math.BigDecimal(calcFreight).doubleValue())%>&nbsp;</th>
	</tr>

	<tr>
		<th colspan = "6" class="price">Net Value&nbsp;</th>
		<th class="price"><%=NumberFormat.getCurrencyInstance(Locale.US).format(new java.math.BigDecimal(formattedNetVal).doubleValue())%>&nbsp;</th>
	</tr>

	</tfoot>
	</table>
	</form>
</div>	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
