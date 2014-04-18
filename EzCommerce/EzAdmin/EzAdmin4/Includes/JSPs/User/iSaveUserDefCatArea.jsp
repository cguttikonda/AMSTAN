<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
// Get the input parameters
String BusUser = null;
String SysKey = null;


BusUser = request.getParameter("BusUser");	
SysKey = request.getParameter("CatalogArea");	// SysKey changed 7/13/2000 Man


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
response.sendRedirect("../User/ezUserDefCatAreaList.jsp?BusUser=" + BusUser);
%>