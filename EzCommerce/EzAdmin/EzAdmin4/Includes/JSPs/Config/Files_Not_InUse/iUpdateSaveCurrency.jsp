<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
String checkbox = null; 
String CurKey = null; 
String CurDesc = null; 
String CurShortDesc = null; 
String CurLang = null; 

String pCheckBox = null; 
String pCurKey = null; 
String pCurDesc = null; 
String pCurShortDesc = null; 
String pCurLang = null; 

String strTcount =  request.getParameter("TotalCount");

if ( strTcount != null ){
int totCount = (new Integer(strTcount)).intValue();  

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

for ( int i = 0 ; i < totCount; i++ ) {
	checkbox = "CheckBox_"+i;
	CurKey = "CurKey_"+i;
	CurDesc = "CurDesc_"+i;
	CurShortDesc = "CurShortDesc_"+i;
	CurLang = "CurLang_"+i;

	pCheckBox = request.getParameter(checkbox);

	// Check For Selection
	if ( pCheckBox != null ){
		// Get the Group Number and the Web Description
		pCurKey = request.getParameter(CurKey);
		pCurDesc = request.getParameter(CurDesc);
		pCurShortDesc = request.getParameter(CurShortDesc);
		pCurLang = request.getParameter(CurLang);

		// Set the Structer Values
		in.setKey(pCurKey);
		in.setLang(pCurLang);
		in.setDesc(pCurDesc);

		// System Configuration Class
		//ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();// Update Plants Description
		sysManager.updateCurrencyDesc(in, CurShortDesc);
		in = null;
	}
}// End For
}//End if

response.sendRedirect("../Config/ezUpdateCurrency.jsp");
%>