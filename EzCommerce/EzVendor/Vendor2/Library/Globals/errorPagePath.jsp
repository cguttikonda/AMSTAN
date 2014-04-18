<% System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Inside Error Path"); %>
<%@ page language="java" errorPage="../../JSPs/Misc/ezErrorDisplay.jsp"%>
<%
	
	
	if(!"Y".equals((String)session.getValue("ValidVendorUser")))
	{
		response.sendRedirect("../../../Vendor2/Library/Globals/ezValidVendorUserError.jsp");
		
	}
	
%>