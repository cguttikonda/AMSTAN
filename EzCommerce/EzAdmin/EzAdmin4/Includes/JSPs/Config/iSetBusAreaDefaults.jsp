<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String areaFlag = request.getParameter("Area");
	String areaLabel = "";
	if ( areaFlag.equals("C") )
		areaLabel = "Sales Area";
	else if ( areaFlag.equals("V") )
		areaLabel = "Purchase Area";
	else if ( areaFlag.equals("S") )
		areaLabel = "Service Area";
	else
		areaLabel = "Other Area";

	ReturnObjFromRetrieve retsyskey = null;
	ReturnObjFromRetrieve retdef = null;

	String sys_key = null;
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

	if ( areaFlag.equals("C") )
	{
		retsyskey = (ReturnObjFromRetrieve)esManager.getCatalogAreas(sparams);
	}
	else if ( areaFlag.equals("V") )
	{
		retsyskey = (ReturnObjFromRetrieve)esManager.getPurchaseAreas(sparams);
	}
	else if ( areaFlag.equals("S") )
	{
		ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
		eds.setAreaFlag(areaFlag);
		eds.setSyncFlag("N");
		snkparams.setEzDescStructure(eds);
		retsyskey = (ReturnObjFromRetrieve)esManager.getBusinessAreas(sparams);
	}
	retsyskey.check();

	int numCatarea = retsyskey.getRowCount();
	if(numCatarea > 0)
	{
		sys_key = request.getParameter("SystemKey");
		if(sys_key!=null && !sys_key.equals("sel"))
		{
			sys_key = sys_key.toUpperCase();
			sys_key = sys_key.trim();
			EzcSysConfigParams sparams1 = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
			snkparams1.setLanguage("EN");
			snkparams1.setSystemKey(sys_key);
			snkparams1.setSiteNumber(200);
			sparams1.setObject(snkparams1);
			Session.prepareParams(sparams1);
			retdef = (ReturnObjFromRetrieve)esManager.getCatAreaDefaults(sparams1);
			retdef.check();
		}
	}

	//Added by Srinivas to List WF Defaults
	ezc.client.CEzBussPartnerManager cbpm= new ezc.client.CEzBussPartnerManager();
	EzcSysConfigParams wfsparams = new EzcSysConfigParams();
	EzcSysConfigNKParams wfsnkparams = new EzcSysConfigNKParams();
	wfsnkparams.setSystemNumber("555");
	wfsparams.setObject(wfsnkparams);
	Session.prepareParams(wfsparams);
%>