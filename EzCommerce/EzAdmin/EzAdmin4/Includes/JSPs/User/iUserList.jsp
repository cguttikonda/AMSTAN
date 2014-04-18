<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
// Key Variables
ReturnObjFromRetrieve retuser = null;

EzcUserParams uparams= new EzcUserParams();
Session.prepareParams(uparams);

EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);

//Get All Users
retuser = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparams);
retuser.check();
%>