<%@ page import = "ezc.ezcsm.EzUser" %>
<%@ page import = "ezc.ezcommon.EzUserDBLight" %>
<%@ include file="../../../Includes/Lib/SalesBean.jsp"%>

<%
EzUser ezUser = SBObject.getEzUser ();
EzUserDBLight ezudb = new EzUserDBLight();
String lang = null;
String user = null;

	if (ezUser != null) {
		user = ezUser.getUserId();
		//lang = SBObject.getLanguage();
		if (lang == null)
			lang = "EN";
	}//End if

	String mypwd = request.getParameter("oldpasswd");

	if ((!(mypwd == null))) {
		boolean ret = ezudb.validateUserPassword(user,mypwd,lang);
		if (ret) {
			String newpwd = request.getParameter("password1");
			ezudb.changeUserPassword(user, newpwd);
	  	}//End if	
	}//End if
%>

