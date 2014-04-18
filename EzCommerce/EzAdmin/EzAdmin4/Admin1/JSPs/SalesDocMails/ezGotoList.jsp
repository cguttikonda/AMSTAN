<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String planner=request.getParameter("planner");
	response.sendRedirect("ezListPlantPlannerMails.jsp?cenPlan=flag");
%>
