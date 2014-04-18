<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
String checkbox = null; 
String SysKey = null; 
String SysKeyDesc = null; 
String SysKeyLang = null; 

String pCheckBox = null; 
String pSysKey = null; 
String pSysKeyDesc = null; 
String pSysKeyLang = null; 

String strTcount =  request.getParameter("TotalCount");

if ( strTcount != null ){
int totCount = (new Integer(strTcount)).intValue();  

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

for ( int i = 0 ; i < totCount; i++ ) {
	checkbox = "CheckBox_"+i;
	SysKey = "SysKey_"+i;
	SysKeyDesc = "SysKeyDesc_"+i;
	SysKeyLang = "SysKeyLang_"+i;

	pCheckBox = request.getParameter(checkbox);

	// Check For Selection
	if ( pCheckBox != null ){
		pSysKey = request.getParameter(SysKey);
		pSysKeyDesc = request.getParameter(SysKeyDesc);
		pSysKeyLang = request.getParameter(SysKeyLang);

		// Set the Structure Values
		in.setKey(pSysKey);
		in.setLang(pSysKeyLang);
		in.setDesc(pSysKeyDesc);

		// System Configuration Class
                        EzcSysConfigParams sparams = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
			snkparams.setLanguage("EN");
			snkparams.setEzDescStructure(in);
			sparams.setObject(snkparams);
			Session.prepareParams(sparams);
			esManager.updateSystemKeyDesc(sparams);
		in = null;
	}
}// End For
}

response.sendRedirect("../Config/ezUpdateCatAreas.jsp");
%>