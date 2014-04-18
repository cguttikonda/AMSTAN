<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<html>
<body>

<%
// Get the Connection parameters from the User Entry screen
String GroupID = request.getParameter("GroupId");

// System Configuration Class
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	snkparams.setUsergroup(GroupID);
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	sysManager.deleteUserGroup(sparams);

// Output the Result
//out.println(" Successfully Deleted the following Group:"  + GroupID);

response.sendRedirect("../CParam/ezDeleteConnectParam.jsp");
%>
</body>
</html>