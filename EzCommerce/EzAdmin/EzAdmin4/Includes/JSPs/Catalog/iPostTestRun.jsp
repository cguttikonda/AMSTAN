<%@ page import = "ezc.ezadmin.EzSystemConfig" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsys = null;

EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);

// Get List Of System Keys
retsys = (ReturnObjFromRetrieve)ezsc.getSystemKeyDesc(sparams);


//Get System Key
String Sys_Key = request.getParameter("sysnum");
if (Sys_Key == null) {
	Sys_Key = (retsys.getFieldValue(0,SYSTEM_KEY)).toString();
}

ret = AdminObject.readCatalogAll (servlet , Sys_Key, "EN");
%>