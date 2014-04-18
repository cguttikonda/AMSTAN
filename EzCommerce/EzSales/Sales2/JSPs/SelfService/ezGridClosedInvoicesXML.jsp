<%
	response.setContentType("text/xml");
	out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" ?>");	
	out.println("<rows>");
%>

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ page import ="ezc.ezparam.*" %>
<%
	
	ReturnObjFromRetrieve orgLinesRet = (ReturnObjFromRetrieve)session.getValue("InvoiceReturnObject");	
	String invoiceTotal = "0";
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	invoiceTotal = (String)session.getValue("InvoiceTotal");
	
	if(invoiceTotal!=null)
	{
		java.math.BigDecimal invoiceTotalB = new java.math.BigDecimal(invoiceTotal);
		invoiceTotal = (invoiceTotalB.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
		invoiceTotal = myFormat.getCurrencyString(invoiceTotal);
	}
	
	//out.println("<?xml version=\"1.0\"?>");
	//out.println("<rows>");

	//log4j.log("<?xml version=\"1.0\"?>","W");
	//log4j.log("<rows>","W");
	
	

	int rowno = 0;
	String  tcustbillNum = "",tinvNum= "";
	if(orgLinesRet!=null)
		rowno = orgLinesRet.getRowCount();
	if (rowno > 0)
	{

		
		String invNum 		= null;
		String custInvNum 	= null;
		String custbillNum	= null;
		String invAm 		= null;
		String pstDate		= null;
		double total		= 0;
		String postingDate	= null;
		String clearDate	= null;

		for (int i= 0; i<rowno ; i++)
		{
			postingDate	= orgLinesRet.getFieldValueString(i,"INVOICEDATE");
			clearDate	= orgLinesRet.getFieldValueString(i,"CLEARDATE");
			invNum 		= orgLinesRet.getFieldValueString(i,"SAPINVOICENO");
			custbillNum 	= orgLinesRet.getFieldValueString(i,"BILLINGDOCUMENTNO");
			invAm 		= orgLinesRet.getFieldValueString(i,"INVOICEVALUE");
			
			invAm 		= myFormat.getCurrencyString(invAm);
			try
			{
				tcustbillNum = Long.parseLong(custbillNum)+"";
			}
			catch(Exception e)
			{
				tcustbillNum = custbillNum;	
			}


			try
			{
					tinvNum=Long.parseLong(invNum)+"";
			}
			catch(Exception e1)
			{
				tinvNum	=	 invNum;
			}
			
			out.println("<row id='"+custbillNum+"'><cell><![CDATA[<nobr><a href='ezInvoiceDetails.jsp?custInvNo="+custbillNum+"&amp;sapInvNo="+invNum+"&amp;InvDate="+postingDate+"'>"+tcustbillNum+"</a></nobr>]]></cell><cell>"+clearDate+"</cell><cell>"+postingDate+"</cell><cell>"+invAm+"</cell></row>");
			//log4j.log("<row id='"+custbillNum+"'><cell><![CDATA[<nobr><a href='ezInvoiceDetails.jsp?custInvNo="+custbillNum+"&amp;sapInvNo="+invNum+"&amp;InvDate="+postingDate+"'>"+tcustbillNum+"</a></nobr>]]></cell><cell>"+tinvNum+"</cell><cell>"+postingDate+"</cell><cell>"+invAm+"</cell></row>","W");
		}
		out.println("<row id='"+rowno+"' style='background-Color:pink;color:darkblue;font-weight:600;'><cell>Total</cell><cell></cell><cell></cell><cell>"+invoiceTotal+"</cell></row>");
		//log4j.log("<row id='"+rowno+"' style='background-Color:pink;color:darkblue;font-weight:600;'><cell>Total</cell><cell></cell><cell></cell><cell>"+invoiceTotal+"</cell></row>","W");
	}
	else
	{
		
		out.println("<row id='"+rowno+"'></row>");
		//log4j.log("<row id='"+rowno+"'></row>","W");
	}
	out.println("</rows>");
	//log4j.log("</rows>","W");
%>
