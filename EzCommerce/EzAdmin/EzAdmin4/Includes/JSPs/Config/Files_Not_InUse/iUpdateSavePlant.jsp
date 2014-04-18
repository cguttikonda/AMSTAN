<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
String checkbox = null; 
String PlantName = null; 
String PlantDesc = null; 
String PlantLang = null; 


String pCheckBox = null; 
String pPlantName = null; 
String pPlantDesc = null; 
String pPlantLang = null; 

String strTcount =  request.getParameter("TotalCount");

if ( strTcount != null ){
int totCount = (new Integer(strTcount)).intValue();  

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

for ( int i = 0 ; i < totCount; i++ ) {
	checkbox = "CheckBox_"+i;
	PlantName = "PlantName_"+i;
	PlantDesc = "PlantDesc_"+i;
	PlantLang = "PlantLang_"+i;

	pCheckBox = request.getParameter(checkbox);

	// Check For Selection
	if ( pCheckBox != null ){
		if ( pCheckBox.equals("Selected"))	{
		// Get the Group Number and the Web Description
		pPlantName = request.getParameter(PlantName);
		pPlantDesc = request.getParameter(PlantDesc);
		pPlantLang = request.getParameter(PlantLang);

		// Set the Structer Values
		in.setKey(pPlantName);
		in.setLang(pPlantLang);
		in.setDesc(pPlantDesc);

		// System Configuration Class
//		ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();// Update Plants Description
		sysManager.updatePlants(in);
		in = null;
		}
	}
}// End For
}

response.sendRedirect("../Config/ezUpdatePlants.jsp");
%>