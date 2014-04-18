<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<jsp:useBean id="ezManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%!
// Start Declarations

final String SYSTEM_NO = "ESD_SYS_NO";
final String SYSTEM_NO_DESC_LANGUAGE = "ESD_LANG";
final String SYSTEM_NO_DESCRIPTION = "ESD_SYS_DESC";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve retlang = null;
ReturnObjFromRetrieve retsys = null;

	// System Configuration Class
			EzcSysConfigParams sparams = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
			snkparams.setLanguage("EN");
			sparams.setObject(snkparams);
			Session.prepareParams(sparams);
			retlang = (ReturnObjFromRetrieve)ezManager.getAllLangKeys(sparams);
			retlang.check();

	// Get List Of Systems
			EzcSysConfigParams sparams1 = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
			snkparams1.setLanguage("EN");
			sparams1.setObject(snkparams1);
			Session.prepareParams(sparams1);
			retsys = (ReturnObjFromRetrieve)ezManager.getSystemDesc(sparams1);
			retsys.check();
%>
