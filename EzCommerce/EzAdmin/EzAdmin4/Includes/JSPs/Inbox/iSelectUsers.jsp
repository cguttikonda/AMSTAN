<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />

<%
	String selSysKey=request.getParameter("SysKey");


	ReturnObjFromRetrieve sysKeysList = null;
	ReturnObjFromRetrieve sysKeysList1 = null;
	ReturnObjFromRetrieve sysKeysList2 = null;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

	sysKeysList = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	sysKeysList1 = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);

	ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
	eds.setAreaFlag("S");
	eds.setSyncFlag("N");
	snkparams.setEzDescStructure(eds);
	sysKeysList2 = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);

	sysKeysList.append(sysKeysList1);
	sysKeysList.append(sysKeysList2);

	ReturnObjFromRetrieve retUser = null;
	if(selSysKey != null)
	{
		EzcUserParams uparams= new EzcUserParams();
		Session.prepareParams(uparams);

		EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
		ezcUserNKParams.setLanguage("EN");
		ezcUserNKParams.setSys_Key(selSysKey);
		uparams.createContainer();
		boolean result_flag = uparams.setObject(ezcUserNKParams);

		retUser =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);

	}


/*

String language = "EN";
String client = "200";

EzcUserParams uparams= new EzcUserParams();
Session.prepareParams(uparams);

EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");


uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);


retUser = (ReturnObjFromRetrieve)UserManager.getAllUsers(uparams);
*/

%>
