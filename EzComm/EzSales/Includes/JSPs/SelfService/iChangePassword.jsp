<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iPassword_Lables.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>



<%
String str=request.getParameter("Flag");
String error = "";
String mypwd = null;
mypwd = request.getParameter("oldpasswd");

//ReturnObjFromRetrieve ret = null;

EzcUserParams uparams= new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
ezcUserNKParams.setPassword(mypwd);
uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

if ((!(mypwd == null)) || (error.equals("O"))) 
{
	boolean ret = UserManager.validateUserPassword(uparams);
	if (ret)
	{
		error = "";
	}
	else
	{
		error = "E";
		mypwd = "";
	}
}
else
{
	mypwd="";
	error = "W";
}//end if
%>