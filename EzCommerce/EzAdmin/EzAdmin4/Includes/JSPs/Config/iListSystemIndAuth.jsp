<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%!
// Start Declarations

final String AUTH_KEY = "EUAD_AUTH_KEY";
final String AUTH_LANG = "EUAD_LANG";
final String AUTH_DESC = "EUAD_AUTH_DESC";
final String AUTH_DEL_FLAG = "EUAD_DELETION_FLAG";

//System Authorizations
final String SYSAUTH_NUM = "ESA_SYS_NO";
final String SYSAUTH_KEY = "ESA_AUTH_KEY";
final String SYSAUTH_VALUE = "ESA_AUTH_VALUE";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsys = null;
ReturnObjFromRetrieve retauth = null;

String Sys_Num = null;;
String language = "EN";

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

// Get List Of Systems
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);
retsys = (ReturnObjFromRetrieve) sysManager.getSystemDesc(sparams);
retsys.check();

//Get List of Systems
int numSystem = retsys.getRowCount();

if(numSystem > 0){
	//Sys_Num = request.getParameter("sysnum");
	Sys_Num = "0";
	if (Sys_Num == null) {
		Sys_Num = (retsys.getFieldValue(0,SYSTEM_NO)).toString();
	}

	//Get All Master Authorizations
EzcSysConfigParams sparams1 = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
snkparams1.setLanguage("EN");
sparams1.setObject(snkparams1);
Session.prepareParams(sparams1);
ret = (ReturnObjFromRetrieve)sysManager.getAllAuthDesc(sparams1);
ret.check(); 
}//end if
%>