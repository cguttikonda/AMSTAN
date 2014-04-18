<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/Currency.jsp"%>

<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>


<%
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve reterpdef = null;
ReturnObjFromRetrieve retcur = null;

String userBP = null;
String bus_user= null;

//Get Business User Value
bus_user = request.getParameter("BusUser");
bus_user = bus_user.trim();



EzcUserParams uparams = new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
uparams.setUserId(bus_user);
uparams.createContainer();
uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

// System Configuration Class
//EzSystemConfig ezsc = new EzSystemConfig();

//Read Selected Languages
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);
ret = (ReturnObjFromRetrieve)ConfigManager.getLangKeys(sparams);
ret.check();
//ret = ezc.getLangKeys();

//Get Valid Currencies
EzcSysConfigParams sparams1 = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
snkparams1.setLanguage("EN");

sparams1.setObject(snkparams1);
Session.prepareParams(sparams1);
retcur = (ReturnObjFromRetrieve) ConfigManager.getCurrencyDesc(sparams1);
retcur.check();

//Get ERP Customer Defaults
reterpdef = (ReturnObjFromRetrieve)UserManager.getAddUserDefaults(uparams);
reterpdef.check();
//reterpdef = AdminObject.getAddUserDefaults(servlet, bus_user, null);
%>