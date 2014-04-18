<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>

<%@ page import = "ezc.session.EzSession" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzcUserParams" %>
<%@ page import = "ezc.ezparam.EzcUserNKParams" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>

<%@ page import="ezc.client.EzUserAdminManager" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%

ReturnObjFromRetrieve retbpsyskey = null;
ReturnObjFromRetrieve retcust = null;
ReturnObjFromRetrieve retdef = null;
ReturnObjFromRetrieve reterpdef = null;
ReturnObjFromRetrieve retuser = null;

String userBP = null;
String bus_user= null;

EzcUserParams uparams = new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
uparams.createContainer();
uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

retuser = (ReturnObjFromRetrieve)UserManager.getAllUsers(uparams);


bus_user = request.getParameter("BusinessUser");
if (bus_user == null) {
	bus_user = (retuser.getFieldValue(0,USER_ID)).toString();
}
bus_user = bus_user.trim();

EzcUserParams uparamsNEW = new EzcUserParams();
EzcUserNKParams ezcUserNKParamsNEW  = new EzcUserNKParams();
ezcUserNKParamsNEW.setLanguage("EN");
uparamsNEW.setUserId(bus_user);
uparamsNEW.createContainer();
uparamsNEW.setObject(ezcUserNKParamsNEW);
Session.prepareParams(uparamsNEW);


retbpsyskey = (ReturnObjFromRetrieve)UserManager.getUserCatalogAreas(uparamsNEW);
retbpsyskey.check();


String sys_key = request.getParameter("SystemKey");
if (sys_key == null) {
	sys_key = (retbpsyskey.getFieldValue(0,SYSTEM_KEY)).toString();
}


EzcUserParams userparams = new EzcUserParams();
EzcUserNKParams userNKParams = new EzcUserNKParams();
userparams.setUserId(bus_user);
userNKParams.setSys_Key(sys_key);
userNKParams.setLanguage("EN");
userparams.createContainer();
userparams.setObject(userNKParams);
Session.prepareParams(userparams);

reterpdef = (ReturnObjFromRetrieve)UserManager.getAddCatAreaUserDefaults(userparams);

%>