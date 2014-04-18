

<%@ include file="../../Lib/CatalogArea.jsp"%>
<%@ include file="../../Lib/AdminConfig.jsp"%>
<%@ include file="../../Lib/AdminUser.jsp" %>
<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%@ page import="ezc.ezparam.*" %>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%
	ezc.ezparam.ReturnObjFromRetrieve areaRet=null;
	ezc.ezparam.ReturnObjFromRetrieve usersRet=null;
	ezc.ezparam.ReturnObjFromRetrieve listTSRet=null;
	String areaLabel = "Areas";

	String uType=request.getParameter("uType");
	String sysKey=request.getParameter("WebSysKey");
	String tSteps=request.getParameter("templateStep");
	String formObj=request.getParameter("formObj");

	if(uType != null)
	{
		
		if ( uType.equals("C") )
		{
			areaLabel = "Sales Areas";
		}
		else if ( uType.equals("V") )
		{
			areaLabel = "Purchase Areas";
		}
		else if ( uType.equals("S") )
		{
			areaLabel = "Service Areas";
		}
		
		EzcSysConfigParams sparams = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
		snkparams.setLanguage("EN");
		sparams.setObject(snkparams);
		Session.prepareParams(sparams);
		if ( uType.equals("C") )
		{
			areaRet = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
		}
		else if ( uType.equals("V") )
		{
			areaRet = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);
		}
		else if ( uType.equals("S") )
		{
			ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
			eds.setAreaFlag(uType);
			eds.setSyncFlag("N");
			snkparams.setEzDescStructure(eds);
			areaRet = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);
		}

		
	}
	
	if(sysKey != null && !(sysKey.equals("sel")) )
	{

		if(sysKey .equals("All"))
		{
			EzcUserParams uparams= new EzcUserParams();
			Session.prepareParams(uparams);
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			uparams.createContainer();
			boolean result_flag = uparams.setObject(ezcUserNKParams);
			usersRet =(ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparams);

		}else{

			EzcUserParams uparams= new EzcUserParams();
			Session.prepareParams(uparams);
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setSys_Key(sysKey);
			uparams.createContainer();
			boolean result_flag = uparams.setObject(ezcUserNKParams);
			usersRet = (ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);
		}
	}
%>

<%
	String tCode=request.getParameter("tCode");
	if((tCode != null )&&(!("DestUser".equals(formObj))))
	{
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziTemplateStepsParams params1= new ezc.ezworkflow.params.EziTemplateStepsParams();
		params1.setCode(tCode);
		mainParams1.setObject(params1);
		Session.prepareParams(mainParams1);
		listTSRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams1);
	
	}
	

%>
