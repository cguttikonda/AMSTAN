<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retdef = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

String sys_key = null;

//Get All Catalog Areas
retsyskey = ezc.getSystemKeyDesc();
retsyskey.check();

//Get number of Catalog Areas
int numCatarea = retsyskey.getRowCount();

if(numCatarea > 0){
	//Get System Key Value
	sys_key = request.getParameter("SystemKey");
	if (sys_key == null) {
		sys_key = (retsyskey.getFieldValue(0,SYSTEM_KEY)).toString();
	}
	sys_key = sys_key.toUpperCase();
	sys_key = sys_key.trim();

	retdef = esManager.getCatAreaDefaults("200", sys_key, "EN");
	retdef.check();
}//end if
%>