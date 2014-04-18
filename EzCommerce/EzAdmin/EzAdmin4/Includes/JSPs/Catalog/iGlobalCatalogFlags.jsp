<%@ page import = "ezc.ezadmin.EzSystemConfig" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page">
</jsp:useBean>
<%
// Key Variables : Globals in the page
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;


String sys_key = null;
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);

retsyskey = (ReturnObjFromRetrieve)ezsc.getSystemKeyDesc(sparams);
retsyskey.check();

//Number of Catalog Areas
int numCatArea = retsyskey.getRowCount();

if(numCatArea > 0){
	sys_key = request.getParameter("SysKey");
	if (sys_key == null) {
		sys_key = (retsyskey.getFieldValue(0,SYSTEM_KEY)).toString();
	}
	sys_key = sys_key.trim();

	ret = AdminObject.readCatalogAll (servlet , sys_key, "EN");
	ret.check();
}//end if
%>