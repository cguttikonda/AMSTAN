
<%@ page import="ezc.ezcommon.arms.params.*" %>

<jsp:useBean id="ArmsManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" />
<%
	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );
%>
