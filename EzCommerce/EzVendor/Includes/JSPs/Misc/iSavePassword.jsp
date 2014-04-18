<%@ page import ="ezc.ezparam.*"%>
<%@ page import = "ezc.ezcsm.EzUser" %>
<%@ page import = "ezc.ezcommon.EzUserDBLight" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.ezadmin.user.csb.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope = "page">
</jsp:useBean>

<% 
String flag = request.getParameter("Flag");
String mypwd = request.getParameter("oldpasswd");
EzcUserNKParams usernkparams = new EzcUserNKParams();
EzcUserParams newParams = new EzcUserParams();
usernkparams.setLanguage("EN");
newParams.setUserId(Session.getUserId());
newParams.createContainer();
newParams.setObject(usernkparams);
Session.prepareParams(newParams);
usernkparams.setPassword(mypwd);

if ((!(mypwd == null))) {
	//boolean ret = SIMObject.validateUserPassword(servlet, mypwd);
	boolean ret = UserManager.validateUserPassword(newParams);	
	if (ret) {
		String newpwd = request.getParameter("password1");
		usernkparams.setPassword(newpwd);
		//SIMObject.changeUserPassword(servlet, newpwd);
		UserManager.changeUserPassword(newParams);
  	}//End if	
}//End if

if (flag!=null)
{
		ezc.ezshipment.client.EzShipmentManager shipManager= new ezc.ezshipment.client.EzShipmentManager();
		EzcUserParams newParams1 = new EzcUserParams();
		EzcUserParams uparams= new EzcUserParams();
		uparams.setUserId(Session.getUserId());
		newParams1.setObject(uparams);
		Session.prepareParams(newParams1);
		shipManager.ezPutDisclaimerStamp(newParams1);
}

%>

