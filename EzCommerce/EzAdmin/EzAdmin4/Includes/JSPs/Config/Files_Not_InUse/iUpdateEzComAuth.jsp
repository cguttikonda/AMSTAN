<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
String DelCheck = null; 
String AuthLang = null; 
String AuthKey = null; 
String AuthDesc = null; 

String pDelCheck = null; 
String pAuthLang = null; 
String pAuthKey = null; 
String pAuthDesc = null; 

String pFinalDel = null; 

String strTcount =  request.getParameter("TotalCount");
if ( strTcount != null ){
int totCount = (new Integer(strTcount)).intValue();  

// System Configuration Class
//ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();
for ( int i = 0 ; i < totCount; i++ ) {
	DelCheck = "ChkDel_"+i;
	AuthLang= "AuthLang_"+i;
	AuthKey= "AuthKey_"+i;
	AuthDesc= "AuthDesc_"+i;

	pDelCheck = request.getParameter(DelCheck);
	pAuthLang = request.getParameter(AuthLang);
	pAuthKey = request.getParameter(AuthKey);
	pAuthDesc = request.getParameter(AuthDesc);

	// Check For Selection
	if ( pDelCheck != null ){
		pFinalDel = "N";
	} else {
		pFinalDel = "Y";
	}

	// Transfer Structure for the Descriptions
	EzDescStructure in = new EzDescStructure();

	// Set the Structer Values
	in.setKey(pAuthKey);
	in.setLang(pAuthLang);
	in.setDesc(pAuthDesc);

	// Update EzCom Authorizations
	sysManager.updateAuthDesc(in, pFinalDel);
	in = null;

}// End For
}//End if

response.sendRedirect("../Config/ezListEzComAuth.jsp");
%>