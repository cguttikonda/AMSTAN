<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<%
	//String areaFlag = (String)session.getValue("myAreaFlag");
	
	String areaFlag = request.getParameter ("AreaStr");
	String user_id = request.getParameter ("UserID");
	String webSysKey = request.getParameter ("WebSysKey");
	if(webSysKey==null)
		webSysKey = (String)session.getValue("myWebSysKey");
	if(webSysKey!=null)
		session.putValue("myWebSyskey",webSysKey);

	if(areaFlag==null || "null".equals(areaFlag))
		areaFlag = (String)session.getValue("myAreaFlag");
	
	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retbp = null;
	ReturnObjFromRetrieve retcat = null;
	ReturnObjFromRetrieve retsoldto = null;

	ReturnObjFromRetrieve retSyskey = null;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	
	if ("C".equals(areaFlag))
	{
		retSyskey = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	}
	else if ("V".equals(areaFlag))
	{
		retSyskey = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);
	}
	else if ("S".equals(areaFlag))
	{
		ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
		eds.setAreaFlag(areaFlag);
		eds.setSyncFlag("N");
		snkparams.setEzDescStructure(eds);
		retSyskey = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);
	}

	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
	bNKParams.setLanguage("EN");
	bparams.createContainer();
	bparams.setObject(bNKParams);
	Session.prepareParams(bparams);

	EzcUserParams uparams= new EzcUserParams();
	uparams.setUserId(user_id);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	uparams.createContainer();
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);

	retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);

	//out.println("retbp"+retbp.toEzcString());

	ret = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);

	//out.println("ret"+ret.toEzcString());

	retcat = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparams);
	String catalogNumber = retcat.getFieldValueString(0,CATALOG_DESC_NUMBER);


	EzcUserParams uparams3= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams3 = new EzcUserNKParams();
	ezcUserNKParams3.setCatalog_Number(catalogNumber);

	String[] partFunctions = {"AG","VN"};
	ezcUserNKParams3.setPartnerFunctions(partFunctions);
	ezcUserNKParams3.setLanguage("EN");
	uparams3.setUserId(user_id);
	uparams3.createContainer();
	uparams3.setObject(ezcUserNKParams3);
	Session.prepareParams(uparams3);

	retsoldto = (ReturnObjFromRetrieve)UserManager.getUserCustomers(uparams3);
%>
