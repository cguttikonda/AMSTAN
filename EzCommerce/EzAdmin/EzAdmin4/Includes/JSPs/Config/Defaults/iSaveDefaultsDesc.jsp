<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
// Get the input parameters from the User Entry screen
String syskey = request.getParameter("SysKey");

String lang = request.getParameter("Lang");
String key = request.getParameter("key");
String desc = request.getParameter("Desc");
String deftype = request.getParameter("DefType");

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

// Set the Structer Values
in.setKey((key.trim()).toUpperCase());
in.setLang(lang.trim());
in.setDesc(desc.trim());

// System Configuration Class
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
     	snkparams.setEzDescStructure(in);
	snkparams.setSystemKey(syskey.toUpperCase());
	snkparams.setDef_type(deftype);
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	sysManager.addDefaultsDesc(sparams);
	
	EzcSysConfigParams ezcSysConfigParams 		= new EzcSysConfigParams();
	EzcSysConfigNKParams ezcSysConfigNKParams 	= new EzcSysConfigNKParams();
	EzKeyValueStructure ezKeyValueStructure = new EzKeyValueStructure();
	ezKeyValueStructure.setPKey(syskey);
	ezKeyValueStructure.setKey(key);
	ezKeyValueStructure.setValue("");


	ezcSysConfigParams 	= new EzcSysConfigParams();
	ezcSysConfigNKParams 	= new EzcSysConfigNKParams();
	ezcSysConfigNKParams.setLanguage("EN");
	ezcSysConfigNKParams.setEzKeyValueStructure(ezKeyValueStructure);
	ezcSysConfigParams.setObject(ezcSysConfigNKParams);
	Session.prepareParams(ezcSysConfigParams);
	sysManager.setCatAreaDefaults(ezcSysConfigParams); 	
	

response.sendRedirect("ezListSystemDefaults.jsp?SystemKey="+syskey);
%>