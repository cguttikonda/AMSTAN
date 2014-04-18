<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iPOPaymentDetails_Labels.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="ezc.ezparam.*,ezc.ezshipment.params.*"%>
<%@ page import="ezc.client.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.ezshipment.client.EzShipmentManager" />
<%@ page import="ezc.ezvendor.params.*" %>
<%
	String purNum = request.getParameter("PurchaseOrder");
	purNum = "00000000"+purNum;
	purNum = purNum.substring(purNum.length()-10,purNum.length());
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
	String vendor=(String) PurManager.getUserDefErpVendor();
	
	EzcParams params=new EzcParams(true);
	EziSearchInputStructure inStruct=new EziSearchInputStructure();
	inStruct.setBase("POIN");
	inStruct.setVendor(vendor);
	inStruct.setDocnum(purNum);
	params.setObject(inStruct);
	Session.prepareParams(params);
	EzInvoice ezPOPayDetails = (EzInvoice) Manager.ezGetInvoicesForGR(params);
	int retPoDetCount = 0;
	if(ezPOPayDetails != null)
		retPoDetCount = ezPOPayDetails.getRowCount();
	//ezc.ezcommon.EzLog4j.log("MY  232COMPCPCPC"+ezPOPayDetails.toEzcString(),"I");		
	
	java.util.Hashtable compht = (java.util.Hashtable)session.getValue("COMP_CODE");
	String compCode = (String)compht.get(session.getValue("SYSKEY"));
	
	//ezc.ezcommon.EzLog4j.log("MY  CO_CODE>>>>"+compht.get(session.getValue("SYSKEY")),"I");
	
	

	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	String base 	= request.getParameter("base");
	String base1 	= request.getParameter("base1");
	String ordCur 	= request.getParameter("orderCurrency");
	String ordValue = request.getParameter("OrderValue");
	
	String cellHeader = "";
	if(base.equals("PurchaseOrder"))
	{
		cellHeader = poNo_L;
		
	}
	else if(base.equals("PContracts"))
	{
		cellHeader = agmtNo_L;
		poPayDet_L = "Schedule Agreement Payment Details";
		noInvPo_L = "No Invoices present for this Schedule Agreement";
	}
	
	try
	{
		purNum = Long.parseLong(purNum)+"";
	}
	catch(Exception e){}
	
	//ordValue = myFormat.getCurrencyString(ordValue);
	
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	
%>

<html>
	<head>
		<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=80
	var tabHeight="45%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form method="post" name="myForm">
<input type="hidden" name="purNum" value="<%=purNum%>" >
<% 
	String display_header=poPayDet_L;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<Div id='inputDiv' style='position:relative;align:center;top:2%;width:100%;'>
<Table width="80%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" class=welcomecell>
			<Tr>
				<Td style="background-color:'F3F3F3';" align='left'>
					<font size=2><B><%=cellHeader%>&nbsp;:&nbsp;</B><%=purNum%></font>
				</Td>
				<Td style="background-color:'F3F3F3';" align='right'>
					<font size=2><B>Net Value [<%=ordCur%>]&nbsp;:&nbsp;</B><%=ordValue%></font>
				</Td>
			</Tr>
		</Table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>
<br>
<%
	if(retPoDetCount  == 0)
	{
		String noDataStatement = noInvPo_L;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		<div id="ButtonDiv" style="position:absolute;top:90%;visibility:visible;width:100%">
		<center>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Back");
			buttonMethod.add("history.go(-1)");

			out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
		</div>
<%             
	}
	else
	{
		String refDoc 		= "";
		String invoiceNo 	= "";
		String invoiceDate	= "";
		String invoiceCurr	= "";
		String invAmount	= "";
		String postDate		= "";
		String docType		= "";
		String payDate		= "";
		String paidAmount	= "";
		String chqNo		= "";
		String bankName		= "";
		String bankAddr		= "";
		String disInvDate	= "";
%>
		<DIV id="theads">
		<TABLE id="tabHead" width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<tr align="center">
				<th height="21" rowspan="2" width="15%"><%=vendorInvNo_L%></th>
				<th height="21" rowspan="2" width="15%"><%=sapInvNo_L%></th>
				<th height="21" rowspan="2" width="15%"><%=invDate_L%></th>
				<th height="21" colspan="2" width="25%"><%=invoiceValue_L%></th>
			</tr>
			<tr><th height="21" widht="6%">Curr.</th><th height="21">Amount</th></tr>
		</Table>
		</DIV>

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%

		for(int i=0;i<ezPOPayDetails.getRowCount();i++)
		{
			refDoc 		= ezPOPayDetails.getFieldValueString(i,"REFDOC");
			invoiceNo 	= ezPOPayDetails.getFieldValueString(i,"INVOICENUMBER");
			invoiceDate	= formatDate.getStringFromDate((Date)ezPOPayDetails.getFieldValue(i,"INVOICEDATE"),".",formatDate.DDMMYYYY)+"";
			disInvDate	= formatDate.getStringFromDate((Date)ezPOPayDetails.getFieldValue(i,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))+"";
			
			invoiceCurr	= ezPOPayDetails.getFieldValueString(i,"INVOICECURRENCY");
			invAmount	= ezPOPayDetails.getFieldValueString(i,"AMOUNT");
			postDate	= formatDate.getStringFromDate((Date)ezPOPayDetails.getFieldValue(i,"POSTINGDATE"),".",formatDate.DDMMYYYY);
			docType		= ezPOPayDetails.getFieldValueString(i,"DOCTYPE");

			String amt = invAmount+"0000";
			amt = myFormat.getCurrencyString(amt);

%>				
			<tr>
				<td width="15%"><%=refDoc%>&nbsp;</td>
				<td align="center" width="15%">
					<a href="ezInvoiceDetails.jsp?invnum=<%=invoiceNo%>&invDate=<%=disInvDate%>&compCode=<%=compCode%>&invCur=<%=invoiceCurr%>&invAmount=<%=invAmount%>&purNum=<%=purNum%>&PostDate=<%=postDate%>&docType=<%=docType%>" onMouseover="window.status='Click To View Details '; return true" onMouseout="window.status=' '; return true">
						<%=Long.parseLong(invoiceNo)%>
					</a>
				</td>
				<td align="center" width="15%">
					<%=disInvDate%>
				</td>
				<td align="center" width="10%">
					<%=invoiceCurr%>
				</td>
				<td align="right" width="15%">
					<%=amt%>
				</td>
			</tr>
<%			
		}		
%>
		</table>
		</div>

		<div id="ButtonDiv" style="position:absolute;top:90%;visibility:visible;width:100%">
		<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Back");
		buttonMethod.add("history.go(-1)");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
		</div>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
