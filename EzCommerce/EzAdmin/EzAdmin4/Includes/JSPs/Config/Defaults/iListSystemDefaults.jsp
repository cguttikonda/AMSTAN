<%@ include file="../../../../Includes/Lib/Defaults.jsp"%>
<%@ include file="../../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
String sys_key = null;
// System Configuration Class
//ezcom.client.EzSystemConfigManager ezc = new ezcom.client.EzSystemConfigManager();String sys_key = null;

//Get System Keys
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
  	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
       retsyskey = (ReturnObjFromRetrieve)sysManager.getSystemKeyDesc(sparams);
	retsyskey.check();

//Number of Catalog Areas
int numCatArea = retsyskey.getRowCount();

if(numCatArea > 0)
{
	sys_key = request.getParameter("SystemKey");
	/*if (sys_key == null) {
		sys_key = (retsyskey.getFieldValue(0,SYSTEM_KEY)).toString();
	}*/

	if(sys_key!=null && !sys_key.equals("sel"))
	{
		sys_key = sys_key.trim();

		//Get Defaults for the selected Catalog Area
		EzcSysConfigParams sparams1 = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
		snkparams1.setLanguage("EN");
  		snkparams1.setSystemKey(sys_key);
    	sparams1.setObject(snkparams1);
		Session.prepareParams(sparams1);
		ret =(ReturnObjFromRetrieve) sysManager.getAllDefaultsDesc(sparams1);
		ret.check();
	}
}//end if
%>