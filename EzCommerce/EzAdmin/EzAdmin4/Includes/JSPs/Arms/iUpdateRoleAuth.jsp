<%@ include file="../../Lib/ArmsBean.jsp" %>
<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ page import="java.util.*" %>
<%
	String UserId =  request.getParameter("userid");
	String SysKey = request.getParameter("syskey");
	
	EzcParams params=new EzcParams(false);

	EziRoleAuthParams retExc=new EziRoleAuthParams();
	retExc.setRoleNo(UserId);
	retExc.setSysKey(SysKey);
	params.setObject(retExc);

	Session.prepareParams(params);
	ArmsManager.ezDeleteRoleAuth(params);

	EzRoleAuthStructure inparams	= new EzRoleAuthStructure();
	
	ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams authparams	= new ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams();
	ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager utilManager = new ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager();
	
	inparams.setRoleNo(UserId);
	inparams.setSysKey(SysKey);
	String  pDelCheck[]= request.getParameterValues("CheckBox");
	int tokensCount = 0;
	if(pDelCheck!=null)
	{
		for ( int i = 0 ; i < pDelCheck.length; i++ )
		{
			StringTokenizer tokens = new StringTokenizer(pDelCheck[i],"#");
			String action 	= "";
			tokensCount = tokens.countTokens();
			
			String authKey	= tokens.nextToken();
			String authValue= tokens.nextToken();
			if(tokensCount == 3)
				action 	= tokens.nextToken();

			System.out.println("ACTIONACTIONACTION:"+action);			
		
			inparams.setAuthKey(authKey);
			inparams.setAuthValue(authValue);
			params.setObject(inparams);
			Session.prepareParams(params);
			ArmsManager.ezAddRoleAuth(params);
			
			authparams.setAuthKey(authKey);
			authparams.setActionStr(action);
			params.setObject(authparams);
			Session.prepareParams(params);
			//utilManager.updateAuthActions(params);
		}
	}
	response.sendRedirect("ezListRoleAuth.jsp?param="+UserId);
%>