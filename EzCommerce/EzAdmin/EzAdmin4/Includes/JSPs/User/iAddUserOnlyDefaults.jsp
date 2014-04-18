<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/Currency.jsp"%>
<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<%
	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve reterpdef = null;
	ReturnObjFromRetrieve retuser = null;
	ReturnObjFromRetrieve retcur = null;

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
	if (bus_user == null)
	{
		bus_user = (retuser.getFieldValue(0,USER_ID)).toString();
	}
	bus_user = bus_user.trim();

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

	ret = (ReturnObjFromRetrieve)ConfigManager.getLangKeys(sparams);

	EzcSysConfigParams sparams1 = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
	snkparams1.setLanguage("EN");
	sparams1.setObject(snkparams1);
	Session.prepareParams(sparams1);
	retcur = (ReturnObjFromRetrieve)ConfigManager.getCurrencyDesc(sparams1);

	EzcUserParams uparamsNEW = new EzcUserParams();
	EzcUserNKParams ezcUserNKParamsNEW  = new EzcUserNKParams();
	ezcUserNKParamsNEW.setLanguage("EN");
	uparamsNEW.setUserId(bus_user);
	uparamsNEW.createContainer();
	uparamsNEW.setObject(ezcUserNKParamsNEW);
	Session.prepareParams(uparamsNEW);
	reterpdef = (ReturnObjFromRetrieve)UserManager.getAddUserDefaults(uparamsNEW);
%>