<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ include file="../../Lib/ArmsBean.jsp" %>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="URManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" scope="session" />

<%
	String formObj=request.getParameter("formObj");
	String role=request.getParameter("role");

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

	String selSysKey=request.getParameter("sysKey");

	String sysKeys="";
	ReturnObjFromRetrieve usersRet=null;
	if(selSysKey != null)
	{
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezcommon.arms.params.EziRolesByUserParams params=new ezc.ezcommon.arms.params.EziRolesByUserParams();
		

		if("All".equals(selSysKey))
		{
			int cnt=ret.getRowCount();
			sysKeys="'"+ret.getFieldValueString(0,SYSTEM_KEY)+"'";
			for(int i=1;i<cnt;i++)
			{
				sysKeys += ",'"+ret.getFieldValueString(i,SYSTEM_KEY)+"'";
			}
		}
		else
		{
				sysKeys="'"+selSysKey+"'";
		}
		
		params.setSysKey(sysKeys);
		params.setRoleNr("'"+role+"'");
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		
		usersRet=(ezc.ezparam.ReturnObjFromRetrieve)URManager.ezUsersListByRoleAndArea(mainParams);
	}
	java.util.TreeSet alphaTree = new java.util.TreeSet();
	String alphaName = null;
	int myRowCount = 0;
	if(selSysKey!=null && !"null".equals(selSysKey))
	{
		myRowCount = usersRet.getRowCount();
		for(int i=0;i<myRowCount;i++)
		{
			alphaName = usersRet.getFieldValueString(i,"EU_FIRST_NAME");
			alphaTree.add((alphaName.substring(0,1)).toUpperCase());
		}
	}
	String searchPartner=request.getParameter("searchcriteria");
	if(alphaTree.size()>0 && "$".equals(searchPartner))
		searchPartner=(String)alphaTree.first()+"*";
%>