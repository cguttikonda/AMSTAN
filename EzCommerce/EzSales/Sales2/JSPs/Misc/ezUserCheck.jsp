<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%
	String remAddr=request.getRemoteAddr();
	response.sendRedirect("ezSelectSoldToFrameset.jsp");
	System.out.println("Request from " +request.getRemoteAddr());
%>