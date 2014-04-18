
<%@ page import = "ezc.ezparam.EzUserGroupParameters" %>
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

String GroupID = request.getParameter("GroupID");
String ERPSystemNumber = request.getParameter("SysNum");

String GroupName = request.getParameter("GroupName");
String Validations = request.getParameter("Validations");
String Connection = request.getParameter("Connection");
String ReadHistory = request.getParameter("ReadHistory");
String MaterialAccess = request.getParameter("MaterialAccess");
String CustomerAccess = request.getParameter("CustomerAccess");
String DBMemCache = request.getParameter("DBMemCache");
String DataSync = request.getParameter("DataSync");
String HistoryWrite = request.getParameter("HistoryWrite");

String R3Host = request.getParameter("R3Host");
String R3SystemNumber = request.getParameter("R3SystemNumber");
String R3GatewayHost = request.getParameter("*R3GatewayHost");
String R3SystemName = request.getParameter("R3SystemName");
String R3GroupName = request.getParameter("*R3GroupName");
String R3MessageServer = request.getParameter("R3MessageServer");
String R3LoadBalance = request.getParameter("R3LoadBalance");
String R3CheckAuth = request.getParameter("R3CheckAuth");
String R3CodePage = request.getParameter("R3CodePage");
String R3Lang = request.getParameter("R3Lang");
String R3Client = request.getParameter("R3Client");

String R3UserID = request.getParameter("R3UserID");
String R3Password = request.getParameter("R3Password");
String R3Connections = request.getParameter("R3Connections");
String DBConnections = request.getParameter("DBConnections");
String R3Retrys = request.getParameter("R3Retrys");
String DBRetrys = request.getParameter("DBRetrys");

String AutoRetry = request.getParameter("AutoRetry");
String ConnectionFlag = request.getParameter("ConnectionFlag");
String CorrectionFlag = request.getParameter("CorrectionFlag");
String LogFileSize = request.getParameter("LogFileSize");
String LogFilePath = request.getParameter("*LogFilePath");
String XMLPath = request.getParameter("*XMLPath");

// Transfer Structure for the Connection Parameters
EzUserGroupParameters in = new EzUserGroupParameters();

// Set the Structure Values
in.setGroupId(new Integer(GroupID).intValue());
in.setSystemNo(new Integer(ERPSystemNumber).intValue());
in.setGroupName(GroupName);
in.setValidationType(new Integer(Validations).intValue());
in.setConnectionType(new Integer(Connection).intValue());
in.setHistoryRead(new Integer(ReadHistory).intValue());
//in.setHistoryRead(new Integer(ReadHistory).intValue());
in.setMaterialAccess(new Integer(MaterialAccess).intValue());
in.setCustInfoAccess(new Integer(CustomerAccess).intValue());
in.setDbMemCache(new Integer(DBMemCache).intValue());
in.setDataSyncType(new Integer(DataSync).intValue());
in.setHistoryWrite(new Integer(HistoryWrite).intValue());

in.setR3Host(R3Host);
in.setR3SystemNo(new Integer(R3SystemNumber).intValue());
in.setR3GatewayHost(R3GatewayHost);
in.setR3SystemName(R3SystemName);
in.setR3GroupName(R3GroupName);
in.setR3MessageServer(R3MessageServer);
in.setR3LoadBalance(R3LoadBalance);
in.setR3CheckAuth(R3CheckAuth);
in.setR3CodePage(new Integer(R3CodePage).intValue());
in.setR3Lang(R3Lang);
in.setR3Client(R3Client);

in.setR3UserId(R3UserID);
in.setR3Password(R3Password);
in.setR3NumberOfConnections(new Integer(R3Connections).intValue());
in.setDBNumberOfConnections(new Integer(DBConnections).intValue());
in.setR3NumberOfRetry(new Integer(R3Retrys).intValue());
in.setDBNumberOfRetry(new Integer(DBRetrys).intValue());

in.setTransacionAutoRetry(new Integer(AutoRetry).intValue());
in.setConnectionLog(ConnectionFlag);
in.setAutoCorrectionYesNo(CorrectionFlag);
in.setLogSize(new Integer(LogFileSize).intValue());
in.setLogFilePath(LogFilePath);
in.setXMLExchangePath(XMLPath);

// FILLING THE PARAMETER CONTAINER
			EzcSysConfigParams sparams = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
			snkparams.setLanguage("EN");
			snkparams.setEzUserGroupParameters(in);
            snkparams.setUsergroup(GroupID); //Added by Venkat on 4/9/2001
			sparams.setObject(snkparams);
			Session.prepareParams(sparams);

/****** Added by Venkat on 4/9/2001 to check if the group already exists *********/
                 ReturnObjFromRetrieve rt = (ReturnObjFromRetrieve) sysManager.getUserGroupInfo(sparams);
                 int rtRows = rt.getRowCount();
                 if ( rtRows > 0 )
                 {
%>
                      <BR><BR><BR><BR><BR><BR><center><b>Group ID:<%=GroupID%> already exists.. Try a different GroupID</b></center>
                      <BR><center><input type="button" name="Back" value="Back" onClick="history.back()"></center>
 <%
                      return;
                 }
			sysManager.addUserGroups(sparams);

		EzcSysConfigParams sparams2 = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
		snkparams2.setLanguage("EN");

        snkparams2.setGroupId(GroupID);
		sparams2.setObject(snkparams2);
		Session.prepareParams(sparams2);
		ReturnObjFromRetrieve connectionStatus = null;
	try{
		connectionStatus = (ReturnObjFromRetrieve) sysManager.testConnection(sparams2);
	}
	catch(Exception exp)
	{
	response.sendRedirect("../CParam/ezAlert.jsp?GRPID="+GroupID);
	}
       if(connectionStatus.isError()){
			response.sendRedirect("../CParam/ezAlert.jsp?GRPID="+GroupID);
 		response.sendRedirect("../CParam/ezUpdateConnectParam.jsp?SystemNumber="+GroupID);
		}
		else{
		//response.sendRedirect("../CParam/ezAddConnectParam.jsp");
		response.sendRedirect("../Config/ezListConnections.jsp?saved=Y&GName="+GroupName);
		}
%>
</body>
</html>
