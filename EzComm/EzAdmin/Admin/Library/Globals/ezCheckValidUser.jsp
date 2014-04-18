<%
	
	
	if(!"Y".equals((String)session.getValue("ValidSalesUser")))
	{
		response.sendRedirect("../../Library/Globals/ezValidSalesUserError.jsp");
	}
	
%>