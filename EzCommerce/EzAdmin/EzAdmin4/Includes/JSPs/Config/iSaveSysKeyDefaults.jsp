<%@ page import = "ezc.ezparam.EzKeyValueStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
// Get the input parameters
String SystemKey = null;

String ChgFlag = null; 
String pChgFlag = null; 

String DefKey = null; 
String pDefKey = null; 
String DefValue = null; 
String pDefValue = null; 

String strTcount =  request.getParameter("TotalCount");
SystemKey = request.getParameter("SystemKey");	

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

if ( strTcount != null ){
int TotalCount = (new Integer(strTcount)).intValue();  

	for ( int j = 0  ; j < TotalCount; j++ ){

		ChgFlag = "ChangeFlag_"+j;
		pChgFlag = request.getParameter(ChgFlag);
		if(pChgFlag.equals("Y")){

			DefKey= "DefaultsKey_"+j;
			DefValue= "DefaultsValue_"+j;

			pDefKey = request.getParameter(DefKey);
			pDefValue = request.getParameter(DefValue);

			// Transfer Structure for the Descriptions
			EzKeyValueStructure in = new EzKeyValueStructure();

			// Set the Structure Values
			in.setPKey(SystemKey);
			in.setKey(pDefKey.trim());
			in.setValue(pDefValue.trim());

			// Add Defaults
			sysManager.setCatAreaDefaults(in, "200"); 
		}//End if for ChgFlag
	}//End For
}// End if TotalCount not null

response.sendRedirect("../Config/ezSetSysKeyDefaults.jsp?SystemKey=" + SystemKey);
%>