<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ include file="../../Lib/ArmsBean.jsp" %>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="URManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" scope="session" />

<%
	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );

	ReturnObjFromRetrieve ret = null;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

	ret = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);


	ReturnObjFromRetrieve ret1 = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);

	ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
	eds.setAreaFlag("S");
	eds.setSyncFlag("N");
	snkparams.setEzDescStructure(eds);
	ReturnObjFromRetrieve ret2 = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);

	ret.append(ret1);
	ret.append(ret2);


	String selRole=request.getParameter("role");
	String selSysKey=request.getParameter("sysKey");
	String fromMod=request.getParameter("fromMod");


	String roles="";
	String sysKeys="";
	String roleAllSel="";
	String sysAllSel="";
	ReturnObjFromRetrieve usersRet=null;
	if(selRole !=null && selSysKey != null)
	{
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezcommon.arms.params.EziRolesByUserParams params=new ezc.ezcommon.arms.params.EziRolesByUserParams();
		params.setSysKey("'"+selSysKey+"'");
		params.setRoleNr("'"+selRole+"'");
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		usersRet=(ezc.ezparam.ReturnObjFromRetrieve)URManager.ezUsersListByRoleAndArea(mainParams);
	}
%>