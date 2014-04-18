<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;

EzcUserParams uparams= new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);
//Get All Users
ret =	(ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparams);
ret.check();
%>