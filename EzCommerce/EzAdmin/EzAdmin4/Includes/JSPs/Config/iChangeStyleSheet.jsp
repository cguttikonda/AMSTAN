

<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
// Key Variables
ReturnObjFromRetrieve retStyle = null;

EzcUserParams uparams = new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
ezcUserNKParams.setSys_Key("0");
uparams.setUserId(Session.getUserId());
uparams.createContainer();
uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

//Get User Defaults 
retStyle = (ReturnObjFromRetrieve)UserManager.getAddUserDefaults(uparams);
retStyle.check();
%>