<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%

	String level = "",selected2 = "",selected3 = "",GroupId = "",desc="";
	String docType = "";
	String tcode = "";
	String duration = "";
	if(request.getParameter("Description") != null)
		desc = request.getParameter("Description");
	if(request.getParameter("Level") != null)
		level = request.getParameter("Level");
	if(request.getParameter("GroupId") != null)	
		GroupId = request.getParameter("GroupId");
		
	if(request.getParameter("docType") != null)	
		docType = request.getParameter("docType");
		
	if(request.getParameter("tcode") != null)	
		tcode = request.getParameter("tcode");

	if(request.getParameter("Duration") != null)	
		duration = request.getParameter("Duration");		
		
	ezc.ezparam.ReturnObjFromRetrieve listTemplateRet = null;	
	
	ezc.ezparam.EzcParams tmainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeParams tparams= new ezc.ezworkflow.params.EziTemplateCodeParams();
	tmainParams.setObject(tparams);
	Session.prepareParams(tmainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplatesList(tmainParams);
	int listCount = 0;
	
	int count = 0;
	if(!"".equals(tcode))
	{
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziOrganogramLevelsParams params= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
		params.setLang(tcode);
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		listTemplateRet = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsDetails(mainParams);
		if(listTemplateRet != null)
		{
			count = listTemplateRet.getRowCount();
		}
	}
	
	ezc.client.EzSystemConfigManager sysconManager = new ezc.client.EzSystemConfigManager();
	EzcSysConfigParams sysconparams = new EzcSysConfigParams();
	EzcSysConfigNKParams sysconnkparams = new EzcSysConfigNKParams();
	sysconnkparams.setLanguage("EN");
	sysconparams.setObject(sysconnkparams);
	Session.prepareParams(sysconparams);
	ReturnObjFromRetrieve authRet = (ReturnObjFromRetrieve)sysconManager.getAllAuthDesc(sysconparams);
	int authCount = 0;
	if(authRet != null)
	{
		authRet.check();
		authCount = authRet.getRowCount();
	}	
	
%>
