<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
%>
<%@ include file="../../../Includes/JSPs/Purorder/iBankDet.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
	<body id="dt_example" scroll=no>
<%
	String display_header	= "Bank Details";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
		<div id="container">
		<div id="demo">
		<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
		<thead>
			<tr>
				<th>Bank</th>
				<th>Bank Name</th>
				<th>Bank Type</th>
				<th>Bank Address</th>
				<th>Bank Account</th>
				<th>Account Type</th>
			</tr>
		</thead>
		<tbody>

<%
			i=0;
			while (i++ < count)
			{		
				String bankNo   = (String)suppacct.getFieldValue(i-1,bank)==null || "null".equals((String)suppacct.getFieldValue(i-1,bank))?" ":(String)suppacct.getFieldValue(i-1,bank);
				String bankName = (String)suppacct.getFieldValue(i-1,name);
				String bankType = (String)suppacct.getFieldValue(i-1,type);
				String bankAddr = (String)suppacct.getFieldValue(i-1,addr);
				String bankAcct = (String)suppacct.getFieldValue(i-1,acct);
				String acctType = (String)suppacct.getFieldValue(i-1,atyp);
%>		
		<tr>
			<td align="center"><%=bankNo%></td>
			<td align="center"><%=bankName%></td>
			<td align="center"><%=bankType%></td>
			<td align="center"><%=bankAddr%></td>
			<td align="center"><%=bankAcct%></td>
			<td align="center"><%=acctType%></td>
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
</body>
</html>