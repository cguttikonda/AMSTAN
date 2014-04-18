<%@ include file="../../../Includes/Lib/Currency.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve ret = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

//Get Catalog Description
ret = sysManager.getCurrencyDesc();
ret.check();
%>