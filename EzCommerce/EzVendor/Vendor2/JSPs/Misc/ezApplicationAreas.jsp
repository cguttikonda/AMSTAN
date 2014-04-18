<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezcommon.EzGlobalConfig" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.ezworkflow.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />

<%
ezc.client.EzSystemConfigManager esManager = new ezc.client.EzSystemConfigManager();
%>
<html>
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<%
	final String SYSTEM_KEY = "ESKD_SYS_KEY";

	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");

	ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();
	String userId = request.getParameter( "username" );
	String passWord = request.getParameter("password" );
	String site = request.getParameter("site");
	String language = request.getParameter("language" );

        session.putValue("username",userId);
        session.putValue("password",passWord);

	if(userId != null){
		userId =  userId.toUpperCase();

	}
        if(language == null)
              language = "ENGLISH" ;

        language = language.toUpperCase();

  	// we need not set the user group
	logs.setUserGroup("0");
	logs.setUserId(userId.trim());
	logs.setPassWd(passWord.trim());
	logs.setConnGroup(site);
	ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);

	if ( LogonStatus.IsSuccess())
	{
		try{
			ReturnObjFromRetrieve ret = LogonStatus.getUserInfo();
			session.putValue("LAST_LOGIN_TIME",ret.getFieldValueString("EU_LAST_LOGIN_TIME"));
			session.putValue("LAST_LOGIN_DATE",ret.getFieldValueString("EU_LAST_LOGIN_DATE"));

		}
		catch(Exception e){System.out.println(e.getMessage());}

                session.putValue("userLang",language);

		ezc.ezparam.EzDefReturn ezDefSales = Session.isValidSalesUser();
		boolean DEF_SYS_KEY_EXISTS = ezDefSales.ifDefSysKeyExists();
		boolean DEF_ERP_CUST_EXISTS = ezDefSales.IfDefSoldToExists();

		ezc.ezparam.EzDefReturn ezDef = Session.isValidSimUser();

		if (ezDef.isValidSimUser())
		{

		  	response.sendRedirect("../Misc/ezDesclaimerConfirm.jsp");
		}
		else
		{
			response.sendRedirect("../Misc/ezLoginError.jsp");
		}
	}
	else
	{
		response.sendRedirect("../Misc/ezLoginError.jsp");
	}
%>
<Div id="MenuSol"></Div>
</body>
</html>
