<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import ="ezc.ezparam.*" %>
<%
	ReturnObjFromRetrieve orgLinesRet = (ReturnObjFromRetrieve)session.getValue("InvoiceReturnObject");	
	
	String invoiceTotal = "0";
	invoiceTotal = (String)session.getValue("InvoiceTotal");
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");

	int rowno = 0;
	
	if(orgLinesRet!=null)
		rowno = orgLinesRet.getRowCount();
	if (rowno > 0)
	{

		ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
		String invNum 		= null;
		String custInvNum 	= null;
		String custbillNum	= null;
		String invAm 		= null;
		String pstDate		= null;
		double total		= 0;
		String postingDate	= null;

		for (int i= 0; i<rowno ; i++)
		{
			postingDate	= orgLinesRet.getFieldValueString(i,"INVOICEDATE");
			invNum 		= orgLinesRet.getFieldValueString(i,"SAPINVOICENO");
			custbillNum 	= orgLinesRet.getFieldValueString(i,"BILLINGDOCUMENTNO");
			invAm 		= orgLinesRet.getFieldValueString(i,"INVOICEVALUE");
			invAm 		= myFormat.getCurrencyString(invAm);
			out.println("<row id='"+custbillNum+"'><cell><![CDATA[<nobr><a href='ezInvoiceDetails.jsp?custInvNo="+custbillNum+"&amp;sapInvNo="+invNum+"&amp;InvDate="+postingDate+"' target=main>"+custbillNum+"</a></nobr>]]></cell><cell>"+invNum+"</cell><cell>"+postingDate+"</cell><cell>"+invAm+"</cell></row>");
		}
		out.println("<row id='"+rowno+"' style='background-Color:pink;color:darkblue;font-weight:600;'><cell>Total</cell><cell></cell><cell></cell><cell>"+invoiceTotal+"</cell></row>");
	}
	else
	{
		out.println("<row id='"+rowno+"'></row>");
	}
	out.println("</rows>");
%>
<Div id="MenuSol"></Div>