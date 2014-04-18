<%@ include file="../../Lib/ArmsBean.jsp" %>
<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%
	ReturnObjFromRetrieve retTopLevelAuth = null;
	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );

	ReturnObjFromRetrieve ret = null;
	String roles=request.getParameter("param"); // Multiple role number coming from IAddEngineer.jsp
	String userid=request.getParameter("userid");

	if ( userid == null )
	userid = "";
	String syskey="";
	if(roles!=null && !roles.equals("sel"))
	{
		Session.traceOn=true;
		ezc.client.EzcUtilManager utilmanager=new ezc.client.EzcUtilManager(Session);
		syskey=utilmanager.getCurrSysKey(); //To get the SystemKey
		if ( syskey != null )
			syskey=syskey.substring(0,3);
		syskey = "0";
		EzcParams params=new EzcParams(false);
		EziRoleAuthParams sparams = new EziRoleAuthParams();
		sparams.setRoleNo(roles);
		sparams.setSysKey(syskey);
		params.setObject(sparams);
		Session.prepareParams(params);
		ret = (ReturnObjFromRetrieve)ArmsManager.ezRoleAuthList(params);

		ezc.client.EzSystemConfigManager sysManager = new ezc.client.EzSystemConfigManager();
		EzcSysConfigParams aparams = new EzcSysConfigParams();
		EzcSysConfigNKParams ankparams = new EzcSysConfigNKParams();
		ankparams.setLanguage("EN");
		aparams.setObject(ankparams);
		Session.prepareParams(aparams);
		retTopLevelAuth = (ReturnObjFromRetrieve)sysManager.getAllAuthDesc(aparams);
	}
%>