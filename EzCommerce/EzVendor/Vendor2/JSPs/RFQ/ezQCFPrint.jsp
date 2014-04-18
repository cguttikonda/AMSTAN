<html>
<head>
<Title>POPrint--Powered by EzCommerce Inc</Title>
</head>
<%
	String collectiveRFQNo = request.getParameter("qcfNumber");
%>
<frameset rows="95%,5%" frameborder=0>
<frame src="ezQCFPrintVersion.jsp?collectiveRFQNo=<%=collectiveRFQNo%>" frameborder=0>
<frame src="ezQCFPrintButtons.jsp" frameborder=0 scrolling="NO">
</frameset>
</html>