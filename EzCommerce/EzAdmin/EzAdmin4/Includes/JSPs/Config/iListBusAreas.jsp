<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	ReturnObjFromRetrieve retSystems = null;
	EzcSysConfigParams mySparams = new EzcSysConfigParams();
	EzcSysConfigNKParams mySnkparams = new EzcSysConfigNKParams();
	mySnkparams.setLanguage("EN");
	mySparams.setObject(mySnkparams);
	Session.prepareParams(mySparams);
	retSystems = (ReturnObjFromRetrieve)sysManager.getSystemDesc(mySparams);
	
	String areaFlag = request.getParameter("Area");
	ezc.ezcommon.EzLog4j.log("areaFlag:::::::::::::::::::"+areaFlag,"D");
	String areaLabel = "";
	if ( areaFlag.equals("C") )
	{
		areaLabel = "Sales Areas";
	}
	else if ( areaFlag.equals("V") )
	{
		areaLabel = "Purchase Areas";
	}
	else if ( areaFlag.equals("S") )
	{
		areaLabel = "Service Areas";
	}

	ReturnObjFromRetrieve ret = null;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	if ( areaFlag.equals("C") )
	{
		ret = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	}
	else if ( areaFlag.equals("V") )
	{
		ret = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);
	}
	else if ( areaFlag.equals("S") )
	{
		ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
		eds.setAreaFlag(areaFlag);
		eds.setSyncFlag("N");
		snkparams.setEzDescStructure(eds);
		ret = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);
	}
	//out.println("ret:::::::::::::::::::"+ret.toEzcString());
	String[] sortArr={"ESKD_SYS_KEY"};
%>
