<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%!
// Start Declarations

final String STD_SYTEM_TYPE = "ESTD_SYS_TYPE";
final String STD_DEFAULTS_LANG = "ESTD_LANG";
final String STD_DEFAULTS_KEY = "ESTD_DEFAULT_KEY";
final String STD_DEFAULTS_TYPE = "ESTD_DEFAULT_TYPE";
final String STD_DEFAULTS_DESC = "ESTD_DEFAULT_DESC";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;

// System Configuration Class
//Get the list of standard defaults
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ret = (ReturnObjFromRetrieve)sysManager.getUserAndCustMasterDefaults(sparams);
	ret.check();
%>