<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
// Key Variables
ReturnObjFromRetrieve retuser = null;
ReturnObjFromRetrieve ret = null;

EzcUserParams uparams= new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

//Get All Users
retuser = (ReturnObjFromRetrieve)UserManager.getAllUsers(uparams);
retuser.check();

//Get Selected User Value
String bus_user = request.getParameter("BusUser");
if (bus_user == null) {
	bus_user = (retuser.getFieldValue(0,USER_ID)).toString();
}

uparams.setUserId(bus_user);

// Get Basic User Information
ret = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);
ret.check();
String oldPasswd = (String) (ret.getFieldValue(0,USER_PASSWORD));

String error = "";
String mypwd = request.getParameter("oldpasswd");

if ((!(mypwd == null)) && (mypwd.equals(oldPasswd))) {
	error = "";
} else {
	if(mypwd == null){
		error = "";
	} else {
		error = "E";
		mypwd = "";

	}
}	
%>