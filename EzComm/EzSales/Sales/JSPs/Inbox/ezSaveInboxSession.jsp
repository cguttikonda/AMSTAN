
<%
	String server = request.getParameter("server");
	String protocol = request.getParameter("protocol");
	String userId = request.getParameter("userId");
	String password = request.getParameter("password");
	
	session.putValue("SERVER",server);
	session.putValue("PROTOCOL",protocol);
	session.putValue("USERID",userId);
	session.putValue("PASSWORD",password);
	
	response.sendRedirect("ezListPersMsgs.jsp?temp=allmess");
%>