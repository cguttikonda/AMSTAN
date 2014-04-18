<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%@ include file="iAttributesList.jsp"%>
<%@ include file="iWFAuthList.jsp" %>

<%
	String roleId=request.getParameter("Role");
%>