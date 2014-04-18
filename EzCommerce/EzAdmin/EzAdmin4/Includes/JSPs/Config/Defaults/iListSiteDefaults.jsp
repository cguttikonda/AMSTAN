<%@ include file="../../../../Includes/Lib/Defaults.jsp"%>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
// Key Variables
ReturnObjFromRetrieve retfixed = null;

// System Configuration Class
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	retfixed = (ReturnObjFromRetrieve)sysManager.getNotCatDefaultsDesc(sparams);
	retfixed.check();
%>