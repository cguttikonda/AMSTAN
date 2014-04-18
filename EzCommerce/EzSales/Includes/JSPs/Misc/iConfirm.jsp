<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezcommon.EzGlobalConfig" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>




<%

/**ezc.ezutil.EzSystem.out.println("I am in iconfirm");
//response.setHeader("Pragma", "No-cache");
//response.setDateHeader("Expires", 0);
//response.setHeader("Cache-Control", "no-cache");
//ezc.ezutil.EzSystem.out.println("System number is : " + POsysType);

ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();
String redirectfile = null;
String userId = request.getParameter( "username" );
String passWord = request.getParameter( "password" );
String language = request.getParameter( "Language" );
if(userId != null){
	userId =  userId.toUpperCase();
}
// we need not set the user group
logs.setUserGroup("0");
logs.setUserId(userId);
logs.setPassWd(passWord);
ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);
**/
%>
