<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/JSPs/Purorder/iContract.jsp"%>
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	String orderType1	= request.getParameter("OrderType");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
<body id="dt_example" scroll=no>
	
<%
	String display_header	= "";
	if("Open".equals(orderType1))
	{
		display_header	= "Open Schedule Agreements";
	}
	else if("Closed".equals(orderType1))
	{
		display_header	= "Closed Schedule Agreements";
	}
	else 
	{
		display_header	= "All Schedule Agreements";
	}
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<div id="container">
	<div id="demo">
	<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
	<thead>
		<tr>
			<th>Agreement</th>
			<th>Date</th>
			<th>Value</th>
		</tr>
	</thead>
	<tbody>

<%
			
			String	cur = (String)session.getValue("CURRENCY");
			String currency = purchctrhdr.getFieldValueString(0,"CURRENCY");
			if (currency == null){
				currency = "INR";
			}
			for(int i=0;i<contractRows;i++)
			{		
				String contractNum 	= Long.parseLong((String)purchctrhdr.getFieldValue(i, contract))+"";
				String agreeDate   	= formatDate.getStringFromDate((java.util.Date)purchctrhdr.getFieldValue(i, contrdate),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				String contractValue	= myFormat.getCurrencyString(purchctrhdr.getFieldValueString(i, "NETAMOUNT"));
%>		
		<tr>
			<td align="center"><a href="ezContractDetails.jsp?contractNum=<%=contractNum%>&currency=<%=cur%>&orderType=All&contractValue=<%=contractValue%>"><%=contractNum%></a></td>
			<td align="center"><%=agreeDate%></td>
			<td align="right"><%=contractValue%></td>
		</tr>
<%
			}
%>
	</tbody>
	</table>
</div>
<div class="spacer"></div>
<!--<div align="center">
	<button type="button" onclick="goBack()">Back</button>
</div>-->
</div>
<Div id="MenuSol"></Div>
</body>
</html>