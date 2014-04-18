<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
// Get the input parameters
String BusUser = null;
String SysKey = null;

String ChgFlag = null; 
String pChgFlag = null; 
String ChkUser = null; 
String pChkUser = null; 
String pFinalFlag = null; 

String DefKey = null; 
String pDefKey = null; 
String DefValue = null; 
String pDefValue = null; 

BusUser = request.getParameter("BusUser");	
SysKey = request.getParameter("SystemKey");	// SysKey changed 7/13/2000 Man


// Transfer Structure for the Descriptions
EzKeyValueStructure in = new EzKeyValueStructure();

// Set the Structure Values
in.setPKey(BusUser.trim());
in.setValue(SysKey.trim());

EzcUserParams uparams = new EzcUserParams();
EzcUserNKParams userNKParams = new  EzcUserNKParams();
userNKParams.setEzKeyValueStructure(in);
uparams.createContainer();
uparams.setObject(userNKParams);
Session.prepareParams(uparams);

// Set User Default System Key
UserManager.setUserDefSysKey(uparams);
response.sendRedirect("../User/ezUserDefaultsList.jsp?BusUser=" + BusUser);
%>