<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iSavePartnerFunctionSyncBySysKey.jsp"%>
<html>
<body>
	<input type="hidden" name="BusPartner" value="<%=BusPartner%>">
	<input type="hidden" name="SysKey" value="<%=SysKey%>">
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
<%
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	System.out.println("IN --------------------------------------------------------------------------------> ezSavePartnerFunctionSyncBySYSKEY.jsp, mySearchCriteria = "+mySearchCriteria+"  ");

	response.sendRedirect("ezSynchListBPBySysKey.jsp?BusinessPartner="+BusPartner+"&WebSysKey="+SysKey+"&FUNCTION="+FUNCTION+"&Area="+Area+"&searchcriteria="+mySearchCriteria);
%>
</body>
</html>
