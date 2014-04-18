<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
String pCheckBox[] = request.getParameterValues("CheckBox"); 

String pDefLang[] = request.getParameterValues("DefLang");
String pDefKey[] = request.getParameterValues("DefKey");
String pDefDesc[] = request.getParameterValues("DefDesc");
String pDefType[] = request.getParameterValues("DefType");
for ( int i = 0 ; i < pCheckBox.length; i++ ) {
	// Transfer Structure for the Descriptions
	EzDescStructure in = new EzDescStructure();

	// Set the Structer Values
	in.setKey(pDefKey[i]);
	in.setLang(pDefLang[i]);
	in.setDesc(pDefDesc[i]);
	// Update Defaults
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	snkparams.setEzDescStructure(in);
	snkparams.setDef_type(pDefType[i].trim());
	snkparams.setSystemKey(null);
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	esManager.addDefaultsDesc(sparams);
	in = null;
}
response.sendRedirect("ezListSiteDefaults.jsp");
%>