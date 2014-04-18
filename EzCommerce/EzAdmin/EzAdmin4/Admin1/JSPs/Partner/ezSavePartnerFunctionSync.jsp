<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iSavePartnerFunctionSync.jsp"%>
<%
	String Area=request.getParameter("Area");
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");
%>
<html>
<body>
	<input type="hidden" name="BusPartner" value="<%=BusPartner%>">
	<input type="hidden" name="SysKey" value="<%=SysKey%>">
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
<%

	if(Area!=null && !"".equals(Area))
	{
		System.out.println("IN --------------------------------------------------------------------------------> ezSavePartnerFunctionSync.jsp, mySearchCriteria = "+mySearchCriteria+"  ");
		response.sendRedirect("ezSynchListBPBySysKey.jsp?BusinessPartner="+BusPartner+"&WebSysKey="+SysKey+"&FUNCTION="+FUNCTION+"&Area="+Area+"&searchcriteria="+mySearchCriteria);
	}
	else
	{
		response.sendRedirect("ezBPCustSync.jsp?BusinessPartner="+BusPartner+"&SysKey="+SysKey+"&FUNCTION="+FUNCTION);
	}
%>
</body>
</html>
