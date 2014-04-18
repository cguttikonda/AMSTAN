<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve ret = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

//Get All Catalog Areas
ret = sysManager.getSystemKeyDesc();
ret.check();
%>