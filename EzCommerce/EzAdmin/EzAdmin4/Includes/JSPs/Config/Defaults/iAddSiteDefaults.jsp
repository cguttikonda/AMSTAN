<%@ include file="../../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../../Includes/Lib/Defaults.jsp"%>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve retlang = null;
ReturnObjFromRetrieve retdeftype = null;

// System Configuration Class
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
retlang = (ReturnObjFromRetrieve)sysManager.getAllLangKeys(sparams);
retlang.check();

//Get Defaults Type
	EzcSysConfigParams sparams1 = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
	snkparams1.setLanguage("EN");
	sparams1.setObject(snkparams1);
	Session.prepareParams(sparams1);
retdeftype = (ReturnObjFromRetrieve)sysManager.getNotCatDefTypeDesc(sparams1);
retdeftype.check();
%>