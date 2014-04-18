<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%!
// Start Declarations

final String PLANT_NAME = "EP_PLANT";
final String PLANT_DESC = "EP_PLANT_DESC";
final String PLANT_LANG= "EP_LANG";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

//Get All Plants
ret = sysManager.getPlants();
ret.check();
%>