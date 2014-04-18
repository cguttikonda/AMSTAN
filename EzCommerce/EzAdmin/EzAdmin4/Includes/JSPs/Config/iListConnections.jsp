<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%!
// Start Declarations

final String GROUP_TYPE = "EUG_ID";
final String CONNECTION_DETAILS = "EUG_CONN_EXIST";

//final String GROUP_TYPE = "EUG_ID";
//final String CONNECTION_DETAILS = "EUG_CONN_EXIST";


//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

//Get All Systems
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);
ret = (ReturnObjFromRetrieve)sysManager.getConnectionPool(sparams);
%>