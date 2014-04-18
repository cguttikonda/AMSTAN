<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ include file="../../Lib/ArmsBean.jsp" %>
<%
	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );
%>