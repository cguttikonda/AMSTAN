<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />


<%!
// Start Declarations

final String AUTH_KEY = "EUAD_AUTH_KEY";
final String AUTH_LANG = "EUAD_LANG";
final String AUTH_DESC = "EUAD_AUTH_DESC";
final String AUTH_DEL_FLAG = "EUAD_DELETION_FLAG";
final String WF_ENABLED = "EUAD_IS_WF_ENABLED";
final String TRANS_TYPE = "EUAD_TYPE_OF_TRANS";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

//Get All Master Authorizations
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);
ret = (ReturnObjFromRetrieve)sysManager.getAllAuthDesc(sparams);
ret.check();

%>