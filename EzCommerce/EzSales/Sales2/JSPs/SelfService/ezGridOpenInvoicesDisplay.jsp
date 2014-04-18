<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import ="ezc.ezparam.*" %>
<%	
	String invoiceTotal = "0";
	FormatDate formatDate = new FormatDate();	
	ReturnObjFromRetrieve orgItems 	= (ReturnObjFromRetrieve)session.getValue("InvoiceReturnObject");
	invoiceTotal 			= (String)session.getValue("InvoiceTotal");

	int invcount = 0;

	if(orgItems!=null)
		invcount = orgItems.getRowCount();
	
	String custbillNum="",invNum="",delDocNo="",invAm="",pd="",bd="",delDocStr="";
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	String  formatkey=(String)session.getValue("formatKey");	

	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");

	if(invcount>0)
	{
		for(int i=0;i<invcount;i++)
		{
			pd		= orgItems.getFieldValueString(i,"INVOICEDATE");
			bd		= orgItems.getFieldValueString(i,"DUEDATE");
			invNum 		= orgItems.getFieldValueString(i,"SAPINVOICENO");
			custbillNum 	= orgItems.getFieldValueString(i,"BILLINGDOCUMENTNO");
			delDocNo 	= orgItems.getFieldValueString(i,"DELIVERYDOCUMENTNO");
			invAm 		= orgItems.getFieldValueString(i,"INVOICEVALUE");

			if(!"".equals(delDocNo))
				delDocStr = "<cell><![CDATA[<nobr><a href='../DeliverySchedules/ezViewDeliveryDetails.jsp?DeliveryNo="+delDocNo+"' target=main>"+delDocNo+"</a></nobr>]]></cell>";
			else	
				delDocStr = "<cell>"+delDocNo+"</cell>";

			out.println("<row id='"+custbillNum+"'><cell><![CDATA[<nobr><a href='ezInvoiceDetails.jsp?custInvNo="+custbillNum+"&amp;sapInvNo="+invNum+"&amp;InvDate="+pd+"' target=main>"+custbillNum+"</a></nobr>]]></cell><cell>"+invNum+"</cell>"+delDocStr+"<cell>"+pd+"</cell><cell>"+bd+"</cell><cell>"+myFormat.getCurrencyString(invAm)+"</cell></row>");
		}
		out.println("<row id='"+invcount+"' style='background-Color:pink;color:darkblue;font-weight:600;'><cell>Total</cell><cell></cell><cell></cell><cell></cell><cell></cell><cell>"+invoiceTotal+"</cell></row>");
	}
	else
		out.println("<row id='"+invcount+"'></row>");
	out.println("</rows>");
%>
<Div id="MenuSol"></Div>