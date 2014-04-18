<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%
	String FUNCTION = request.getParameter("FUNCTION");
	String Area=request.getParameter("Area");
%>

<%@ include file="../../../Includes/JSPs/Partner/iSaveNonBaseERPSync.jsp"%>

<html>
<body>
	<input type="hidden" name="BusPartner" value="<%=BusPartner%>">
	<input type="hidden" name="SysKey" value="<%=SysKey%>">
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
	<input type="hidden" name="genezc" value="<%=genEzc%>">
	<input type="hidden" name="Area" value="<%=Area%>" >
<%
response.sendRedirect("ezConfirmPartnerFunctionSyncBySysKey.jsp?BusPartner="+BusPartner+"&SysKey="+SysKey+"&FUNCTION="+FUNCTION.trim()+"&genezc="+genEzc+"&Area="+Area);
%>
</body>
</html>