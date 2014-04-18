<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%!
// Start Declarations

final String AUTH_KEY = "EUAD_AUTH_KEY";
final String AUTH_LANG = "EUAD_LANG";
final String AUTH_DESC = "EUAD_AUTH_DESC";
final String AUTH_DEL_FLAG = "EUAD_DELETION_FLAG";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

//Get All EzCommerce Authorizations
ret = sysManager.getAllAuthDesc();
ret.check();
%>