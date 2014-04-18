<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String roleType=request.getParameter("roleType");
	String language=request.getParameter("Lang");
	String roleDesc=request.getParameter("roleDesc");
	String roleNr = request.getParameter("rolenum1ber");
	String busComp = request.getParameter("buscomponent");
	String busDom = request.getParameter("busdomain");
%>
<%@ include file="../../../Includes/JSPs/Arms/iAddSaveRoleDefinition.jsp"%>