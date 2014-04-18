<%@ include file="../../../../Includes/Lib/Defaults.jsp"%>
<%@ include file="../../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retdeftype = null;

String defType = null;
int defRows = 0;
String sys_key = request.getParameter("SystemKey");
// System Configuration Class
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	retsyskey = (ReturnObjFromRetrieve)esManager.getSystemKeyDesc(sparams);
	retsyskey.check();
//Number of Catalog Areas
int numCatArea = retsyskey.getRowCount();
if(numCatArea >0){
/*	if (sys_key == null) {
		sys_key = (String)(retsyskey.getFieldValue(0,SYSTEM_KEY));
	}*/

	if(sys_key!=null && !sys_key.equals("sel"))
	{
		sys_key = sys_key.toUpperCase();
		sys_key = sys_key.trim();
		//Get Defaults Description
		EzcSysConfigParams sparams1 = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
		snkparams1.setLanguage("EN");
		snkparams1.setSystemKey(sys_key);
		sparams1.setObject(snkparams1);
		Session.prepareParams(sparams1);
		ret = (ReturnObjFromRetrieve)esManager.getDefaultsDesc(sparams1); // Other than the Master Defaults
		ret.check();
	}
}//end if

	//Get Defaults Type Master List
		EzcSysConfigParams sparams2 = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
		snkparams2.setLanguage("EN");
		sparams2.setObject(snkparams2);
		Session.prepareParams(sparams2);
		retdeftype = (ReturnObjFromRetrieve)esManager.getCatDefTypeDesc(sparams2);
		retdeftype.check();
%>