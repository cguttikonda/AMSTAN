<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iPOInvoices_Labels.jsp"%>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.ezparam.*,ezc.ezshipment.params.*"%>
<%@ page import="ezc.ezshipment.client.*"%>
<jsp:useBean id="Manager" class="ezc.ezshipment.client.EzShipmentManager" />
<%

	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat("Rs",false,false);
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();

	String purNum = request.getParameter("PurchaseOrder");
	purNum = "00000000"+purNum;
	purNum = purNum.substring(purNum.length()-10,purNum.length());

	String base = request.getParameter("base");
	//String base1 = request.getParameter("base1");
	//String poPrice = request.getParameter("POPrice");
	String ordCur = request.getParameter("orderCurrency");
	String ordValue = request.getParameter("OrderValue");
	// out.println("....."+poPrice);
	
	java.util.Hashtable compht = (java.util.Hashtable)session.getValue("COMP_CODE");
	String compCode = (String)compht.get(session.getValue("SYSKEY"));
%>
<html>
	<head>
	<title>Purchase Order Payment Details</title>
	<meta name="Author" Content="Soma Jandhyala">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<Script>
	var tabHeadWidth=68
	var tabHeight="50%"
	</Script>
	<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	</head>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>

	<form method="post">
		<!-- <table width="40%" border="0" align="center">
		<tr align="center">
		<td class="displayheader">Invoice List</td>
		</tr>
		</table> -->
		<%	String display_header=invoiceList_L; %>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>

		<%
		ReturnObjFromRetrieve ezPOPayDetails = null;
		if(base != null)
		{
			ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
			String vendor=(String) PurManager.getUserDefErpVendor();

			EzcParams params=new EzcParams(true);
			String grno=request.getParameter("GRNo");

			EziSearchInputStructure inStruct=new EziSearchInputStructure();
			inStruct.setBase("GRIN");
			inStruct.setVendor(vendor);
			inStruct.setDocnum(grno + purNum);

			params.setObject(inStruct);
			Session.prepareParams(params);

			ezPOPayDetails = (ReturnObjFromRetrieve)Manager.ezGetInvoicesForGR(params);

			String docType = null;
			if(ezPOPayDetails.getRowCount() == 1)
			{
				response.sendRedirect("ezInvoiceDetails.jsp?invnum="+ezPOPayDetails.getFieldValue(0,"INVOICENUMBER")+"&purNum="+ezPOPayDetails.getFieldValue(0,"PURCHASEORDER")+"&compCode="+compCode+"&docType="+ezPOPayDetails.getFieldValue(0,"DOCTYPE")+"&invDate="+fd.getStringFromDate((Date)ezPOPayDetails.getFieldValue(0,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))+"&invCur="+ezPOPayDetails.getFieldValue(0,"INVOICECURRENCY")+"&invAmount="+ezPOPayDetails.getFieldValue(0,"AMOUNT")+"&PostDate="+fd.getStringFromDate((Date)ezPOPayDetails.getFieldValue(0,"POSTINGDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))+"&fromGRDTL=Y");
			}

			for(int i=ezPOPayDetails.getRowCount()-1;i>=0;i--)
			{
				docType = ezPOPayDetails.getFieldValueString(i,"DOCTYPE");
				docType = docType.trim();
				if(docType!=null)
				{
					if(docType.equals("AB") || docType.equals("RE") || docType.equals("OV") || docType.equals("KR") || docType.equals("RC"))
					{
						//// DO NOTHING. ////
					}
					else
					{
						ezPOPayDetails.deleteRow(i);

					}
				}
			}


		}
		%>
		<table align = center border=3 bordercolor="#660066">
		<%
		if(base.equals("PurchaseOrder"))
		{
			out.println("<th bordercolor=\"#ffffff\"  height=\"21\">"+poNo_L+"</th>");

		}
		else if(base.equals("PContracts"))
		{
			out.println("<th bordercolor=\"#ffffff\"  height=\"21\">"+agrmNo_L+"</th>");
		}
		%>

		<td bordercolor="#ffffff"><%=Long.parseLong(purNum)%></td>
		<th bordercolor="#ffffff" height="21"><%=totOrdVal_L%> [<%=ordCur%>]</th>
		<td bordercolor="#ffffff"><%out.println(myFormat.getCurrencyString(ordValue));
		%></td>
		</table>
		<br>
		<input type="hidden" name="purNum" value="<%=purNum%>">
<%
		int detailsCount = ezPOPayDetails.getRowCount();
		if(detailsCount != 0){
%>
		<div id="theads">
		<table id="tabHead" align="center" width="68%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr align="center">
		<th height="21" rowspan="2" width="15%"><%=vendorInvNo_L%></th>
		<th height="21" rowspan="2" width="15%"><%=sapInvNo_L%></th>
		<th height="21" rowspan="2" width="15%"><%=invDate_L%></th>
		<th height="21" colspan="2" width="25%"><%=invoiceValue_L%></th>
		</tr>
		<tr><th height="21" widht="6%"><%=curr_L%></th><th height="21"><%=amount_L%></th></tr>
		</Table>
		</div>
		<div id="InnerBox1Div" style="overflow:auto;position:absolute;width:68%;height:50%;left:2%">
		<Table id="InnerBox1Tab" align=center width=100%>
		<%
		
			for(int i=0;i<detailsCount;i++)
			{
				%>
				<tr>
				<td align="center" width="15%"><input type="text" class="tx" size=9 value="<%=ezPOPayDetails.getFieldValueString(i,"REFDOC")%>"></td>
				<td align="center" width="15%">
				<a href="ezInvoiceDetails.jsp?invnum=<%=ezPOPayDetails.getFieldValue(i,"INVOICENUMBER")%>&invDate=<%=fd.getStringFromDate((Date)ezPOPayDetails.getFieldValue(i,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>&compCode=<%=compCode%>&invCur=<%=ezPOPayDetails.getFieldValue(i,"INVOICECURRENCY")%>&invAmount=<%=ezPOPayDetails.getFieldValue(i,"AMOUNT")%>&purNum=<%=purNum%>&docType=<%=ezPOPayDetails.getFieldValue(i,"DOCTYPE")%>&PostDate=<%=fd.getStringFromDate((Date)ezPOPayDetails.getFieldValue(i,"POSTINGDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>">
				<%=Long.parseLong(ezPOPayDetails.getFieldValueString(i,"INVOICENUMBER"))%></a>
				</td>
				<td align="center" width="15%">
				<%
				Date dt = (Date)ezPOPayDetails.getFieldValue(i,"INVOICEDATE");
				ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
				out.println(formatDate.getStringFromDate(dt,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))));
				%>
				</td>
				<td align="center" width="10%"><%=ezPOPayDetails.getFieldValueString(i,"INVOICECURRENCY")%>
				</td>
				<td align="right" width="15%">
				<%
				String amt = ezPOPayDetails.getFieldValueString(i,"AMOUNT")+"0000";
				out.println(myFormat.getCurrencyString(amt));
				%>
				</td>
				</tr>
<%			}
		}
		else
		{
			String noDataStatement = noInvPo_L;
		%>
			<!--<tr>
			<td colspan=5 align="center">No Invoices present for this Purchase Order</td>
			</tr>-->
			<%@ include file="../Misc/ezDisplayNoData.jsp" %>

		<%
		}
		%>
		</table>
		</div>

		<!-- <div align='center' style='position:absolute;top:90%;width:100%'> -->
		<Div id="ButtonDiv" align='center' style="position:absolute;top:90%;left:45%;visibility:visible">
		<!-- <a href='javascript:history.go(-1)'  onMouseover="window.status='Click to view the previous screen.'; return true" onMouseout="window.status=' '; return true">
		<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none"></a> -->
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Back");
			buttonMethod.add("history.go(-1)");
			
			out.println(getButtonStr(buttonName,buttonMethod));	
		%>
		</div>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
