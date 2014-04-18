<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
%>
<%@include file="../../../Includes/JSPs/Rfq/iListRFQs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
	<body id="dt_example" scroll=no>
	<form name="myForm" method="post">
<%
			String display_header	= "List of RFQs";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>
		<div id="container">
		<div id="demo">
		<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
		<thead>
			<tr>
				<th>RFQ</th>
				<th>RFQ Date</th>
				<th>RFQ Closing Date</th>
			</tr>
		</thead>
		<tbody>

<%
			for(int i=0;i<Count;i++)
			{		
				String rfqNum 		= hdrXML.getFieldValueString(i,"ORDER");		
				String rfqDate		= formatDate.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"ORDERDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				String rfqcloseDate	= formatDate.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"CONFIRMDELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>		
		<tr>
			<td align="center"><a href="ezViewRFQDetails.jsp?PurchaseOrder=<%=rfqNum%>&type=<%=type%>&EndDate=<%=rfqcloseDate%>&OrderDate=<%=rfqDate%>"><%=rfqNum%></a></td>
			<td align="center"><%=rfqDate%></td>
			<td align="center"><%=rfqcloseDate%></td>
		</tr>
<%
			}
%>
	</tbody>
	</table>
</div>
<div class="spacer"></div>
</div>
<Div id="MenuSol"></Div>
</form>
</body>
</html>