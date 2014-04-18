<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%

	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve ret1 = null;
	ReturnObjFromRetrieve ret2 = null;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

	ret = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	//ret1 = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);

	ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
	eds.setAreaFlag("S");
	eds.setSyncFlag("N");
	snkparams.setEzDescStructure(eds);
	ret2 = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);

	//ret.append(ret1);
	ret.append(ret2);

%>
