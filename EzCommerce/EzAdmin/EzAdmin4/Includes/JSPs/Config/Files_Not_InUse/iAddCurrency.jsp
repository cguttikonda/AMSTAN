<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve retlang = null;

// System Configuration Class
//EzSystemConfig ezsc = new EzSystemConfig();
//ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();

//Read All Languages
retlang = sysManager.getAllLangKeys();
retlang.check();
%>