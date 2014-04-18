<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%
	String FUNCTION = request.getParameter("FUNCTION");
%>

<%@ include file="../../../Includes/JSPs/Partner/iSaveNonBaseERPSync.jsp"%>
             
<html>
<body>
	<input type="hidden" name="BusPartner" value="<%=BusPartner%>">
	<input type="hidden" name="SysKey" value="<%=SysKey%>">
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
	<input type="hidden" name="genezc" value="<%=genEzc%>">   
<%    
response.sendRedirect("ezConfirmPartnerFunctionSync.jsp?BusPartner="+BusPartner+"&SysKey="+SysKey+"&FUNCTION="+FUNCTION.trim()+"&genezc="+genEzc);
%>
</body> 
</html>