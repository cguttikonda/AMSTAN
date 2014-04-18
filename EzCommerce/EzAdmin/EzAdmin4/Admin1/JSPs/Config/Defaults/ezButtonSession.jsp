<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%
	String header = request.getParameter("header");
	String body = request.getParameter("body");
	session.putValue("Header",header);
	session.putValue("Body",body);
	response.sendRedirect("ezButtons.jsp");	
%>
