
<%@ page language="java" errorPage="/EzCommerce/EzAdmin/EzAdmin4/Admin1/JSPs/Misc/ezErrorDisplay.jsp"%>

<%
	
	
	if(!"Y".equals((String)session.getValue("ValidAdminUser")))
	{
		response.sendRedirect("../../Library/Globals/ezValidAdminUserError.jsp");
	}
	
%>