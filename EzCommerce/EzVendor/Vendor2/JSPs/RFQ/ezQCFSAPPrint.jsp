<%
	String colNo = request.getParameter("qcfNumber");
	session.putValue("repCollRFQ",colNo);
%>
<html>
<head>

<Title>Quotation Comparison Form --Powered by EzCommerce Inc</Title>
</head>

<frameset rows="93%,7%" frameborder=0>
<frame src="ezQcfSAPColorView.jsp" frameborder=0 name='viewframe'>
<frame src="ezQCFPrintButtons.jsp" frameborder=0 scrolling="NO">
</frameset>
</html>