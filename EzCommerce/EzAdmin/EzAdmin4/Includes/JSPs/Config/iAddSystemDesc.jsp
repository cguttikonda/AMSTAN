<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%!
// Start Declarations

final String SYSTEM_TYPE = "EST_SYS_TYPE";
final String SYSTEM_TYPE_LANG = "EST_LANG";
final String SYSTEM_TYPE_DESC = "EST_DESC";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve retlang = null;
ReturnObjFromRetrieve retsystype = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();//Get All Languages
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
        snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	retlang = (ReturnObjFromRetrieve)sysManager.getAllLangKeys(sparams);
	retlang.check();

//Get System Type
	EzcSysConfigParams sparams1 = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
        snkparams1.setLanguage("EN");
	sparams1.setObject(snkparams1);
	Session.prepareParams(sparams1);
	retsystype = (ReturnObjFromRetrieve)sysManager.getAllSysTypes(sparams1);
	retsystype.check();
%>
