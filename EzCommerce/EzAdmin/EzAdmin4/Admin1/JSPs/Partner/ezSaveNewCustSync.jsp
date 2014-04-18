<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iSaveNewCustSync.jsp"%>
<%
	String Area=request.getParameter("Area");
%>

<html>
<body>
	<input type="hidden" name="BusPartner" value="<%=BusPartner%>">
	<input type="hidden" name="SysKey" value="<%=SysKey%>">
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
	<input type="hidden" name="genezc" value="<%=genNewEzc%>">
<%
	response.sendRedirect("ezConfirmPartnerFunctionSync.jsp?BusPartner="+BusPartner+"&SysKey="+SysKey+"&New=Y&FUNCTION="+FUNCTION+"&genezc="+genNewEzc+"&Area="+Area);
%>
</body>
</html>