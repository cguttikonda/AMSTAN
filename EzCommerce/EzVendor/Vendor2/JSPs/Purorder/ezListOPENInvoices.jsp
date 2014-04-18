<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>

<%@ include file="../../../Includes/JSPs/Purorder/iListOPENInvoices.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<script>
	function funLinkInvoice(fileName,invnum,purNum,compCode,docType,invDate,invCur,invAmount,PostDate)
	{
		document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate
	}
	</script>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
	<body id="dt_example" scroll=no>
	<form name="myForm" method="post">
<%
	String display_header	= "Open Invoices";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
		<div id="container">
		<div id="demo">
		<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
		<thead>
			<tr>
				<th>Vendor Inv.Number</th>
				<th>SAP Inv.Number</th>
				<th>Invoice Date</th>
				<th>Pay. Due Date</th>
				<th>PO Number</th>
				<th>Currency</th>
				<th>Amount</th>
			</tr>
		</thead>
		<tbody>
<%
	FormatDate formatDate = new FormatDate();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));


	int Count = 0;
	int rowCnt= 0;
	if(SeqInv != null)
		Count = SeqInv.getRowCount();

	Hashtable invAmtHT = new Hashtable();
	if (Count > 0)
	{
		SeqInv.sort(new String[]{"INVOICEDATE"},false);
		String invNumber = new String();
		double invConAmt = 0;
		for(int i=0;i<Count;i++)
		{
			if(SeqInv.getFieldValue(i,"DOCTYPE").equals("AB") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
				continue;
			if(!invAmtHT.containsKey(SeqInv.getFieldValueString(i,"INVOICENUMBER")))
			{
				invAmtHT.put(SeqInv.getFieldValueString(i,"INVOICENUMBER"),SeqInv.getFieldValueString(i,"AMOUNT"));
			}
			else
			{
				invNumber = SeqInv.getFieldValueString(i,"INVOICENUMBER");
				try
				{
					invConAmt = Double.parseDouble(SeqInv.getFieldValueString(i,"AMOUNT"))+Double.parseDouble(invAmtHT.get(invNumber).toString());
				}
				catch(Exception numFmtEx)
				{
					invConAmt = Double.parseDouble((String)invAmtHT.get(invNumber));
				}
				invAmtHT.put(invNumber,new Double(invConAmt).toString());
			}	
		}
	}	

	if (Count > 0)
	{
		String vndInvNumber = "";
		String sapInvNumber = "";
		String invDate	    = "";
		String payDueDate   = "";
		String poNumber	    = "";
		String invCurrency  = "";
		String invAmount    = "";
		String compCode	    = "";
		String docType	    = "";
		String postDate	    = "";
		String amt = null;
		for (int i= 0; i<Count; i++)
		{
			if(SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
			{
				try
				{
					amt = (String)invAmtHT.get(SeqInv.getFieldValueString(i,"INVOICENUMBER"));
				}
				catch(Exception ae)
				{
					amt = "0.00";
				}
				if(!"0.00".equals(myFormat.getCurrencyString(amt)))
				{
					vndInvNumber 	= SeqInv.getFieldValueString(i,"REFDOC");
					if(vndInvNumber == null || vndInvNumber.trim().length() == 0  || "null".equals(vndInvNumber))
						vndInvNumber = "";
					sapInvNumber	= SeqInv.getFieldValueString(i,"INVOICENUMBER");
					invDate 	= formatDate.getStringFromDate((Date) SeqInv.getFieldValue(i,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					payDueDate 	= formatDate.getStringFromDate((Date) SeqInv.getFieldValue(i,"PAYMENTDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					poNumber 	= SeqInv.getFieldValueString(i,"PURCHASEORDER").trim();
					compCode	= SeqInv.getFieldValueString(i,"COMPCODE");
					invCurrency	= SeqInv.getFieldValueString(i,"INVOICECURRENCY");
					invAmount	= SeqInv.getFieldValueString(i,"AMOUNT");
					invAmount	= myFormat.getCurrencyString(invAmount);
					docType		= SeqInv.getFieldValueString(i,"DOCTYPE");
					postDate	= formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"));
					rowCnt		= rowCnt+1;
				}
			}
%>
				<tr>
					<td align="center"><%=vndInvNumber%></td>
					<td align="center"><%="<a href=\"JavaScript:funLinkInvoice('ezInvoiceDetails.jsp','"+sapInvNumber+"','"+poNumber+"','"+compCode+"','"+SeqInv.getFieldValue(i,"DOCTYPE")+"','"+invDate+"','"+invCurrency+"','"+invAmount+"','"+formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+"')\" onMouseover=\"window.status='Click To View Details '; return true\" onMouseout=\"window.status=' '; return true\">"+sapInvNumber+"</a>"%></td>
					<td align="center"><%=invDate%></td>
					<td align="center"><%=payDueDate%></td>
					<td align="center"><%=poNumber%></td>
					<td align="center"><%=invCurrency%></td>
					<td align="right"><%=invAmount%></td>
				</tr>
<%
		}
	}
%>
</tbody>
</table>
</div>
<div class="spacer"></div>
<!--<div align="center">
	<button type="button">Back</button>
</div>-->
</div>
<Div id="MenuSol"></Div>
</form>
</body>
</html>