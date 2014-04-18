<%@ include file="../../Lib/CatalogArea.jsp"%>
<%@ include file="../../Lib/AdminConfig.jsp"%>
<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />

<%
	String gNo=request.getParameter("NO");

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	
	ezc.ezparam.ReturnObjFromRetrieve areaRet1 = (ezc.ezparam.ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	ezc.ezparam.ReturnObjFromRetrieve areaRet2 = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);

	ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
	eds.setAreaFlag("S");
	eds.setSyncFlag("N");
	snkparams.setEzDescStructure(eds);
	ezc.ezparam.ReturnObjFromRetrieve sysRet = (ezc.ezparam.ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);
	sysRet.append(areaRet1);
	sysRet.append(areaRet2);
	
	int sCnt=sysRet.getRowCount();
	String allSysKeys="";
	if(sCnt > 0)
		allSysKeys="'"+sysRet.getFieldValueString(0,SYSTEM_KEY)+"'";
	for(int i=1;i<sCnt;i++)
	{
		allSysKeys +=",'"+sysRet.getFieldValueString(i,SYSTEM_KEY)+"'";
	}
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeParams params= new ezc.ezworkflow.params.EziTemplateCodeParams();
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve templateRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplatesList(mainParams);
	


%>