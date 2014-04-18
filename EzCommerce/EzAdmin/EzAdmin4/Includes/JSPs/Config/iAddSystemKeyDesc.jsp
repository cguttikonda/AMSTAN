<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%!
// Start Declarations

final String SYSTEM_NO = "ESD_SYS_NO";
final String SYSTEM_NO_DESC_LANGUAGE = "ESD_LANG";
final String SYSTEM_NO_DESCRIPTION = "ESD_SYS_DESC";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve retlang = null;
ReturnObjFromRetrieve retsys = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();//Get All Languages
retlang = sysManager.getAllLangKeys();
retlang.check();

// Get List Of Systems
retsys = sysManager.getSystemDesc();
retsys.check();
%>
