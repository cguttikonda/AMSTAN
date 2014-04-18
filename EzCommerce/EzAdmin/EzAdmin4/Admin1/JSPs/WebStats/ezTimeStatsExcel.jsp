<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String WebSysKey = request.getParameter("WebSysKey");
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
%>
<%@ include file="../../../Includes/JSPs/WebStats/iListTimeStatsExcel.jsp"%>

