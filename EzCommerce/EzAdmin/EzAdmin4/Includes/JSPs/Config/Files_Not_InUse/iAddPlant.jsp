<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve retlang = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();//Get All Languages
retlang = sysManager.getAllLangKeys();
retlang.check();
%>