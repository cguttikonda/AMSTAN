<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
// Get the input parameters
String BusUser = null;
String ChgFlag = null; 
String pChgFlag = null; 
String ChkUser = null; 
String pChkUser = null; 
String pFinalFlag = null; 

String DefKey = null; 
String pDefKey = null; 
String DefValue = null; 
String pDefValue = null; 

BusUser = request.getParameter("BusUser");	

String strTcount =  request.getParameter("TotalCount");
if ( strTcount != null )
{
	int TotalCount = (new Integer(strTcount)).intValue();  

	for ( int j = 0  ; j < TotalCount; j++ )
	{

		ChkUser = "ChkUser_"+j;
		DefKey = "DefaultsKey_"+j;
		DefValue = "DefaultsValue_"+j;

		pChkUser = request.getParameter(ChkUser);
		pDefKey = request.getParameter(DefKey);
		pDefValue = request.getParameter(DefValue);

		// Check For Selection
		if ( pChkUser != null ){
			pFinalFlag = "Y";
		} else {
			pFinalFlag = "N";
		}

		// Transfer Structure for the Descriptions
		EzKeyValueStructure in = new EzKeyValueStructure();

		// Set the Structure Values
		in.setPKey(BusUser.trim());
		in.setKey(pDefKey.trim());
		in.setValue(pDefValue.trim());

		EzcUserParams uparams = new EzcUserParams();
		EzcUserNKParams userNKParams = new  EzcUserNKParams();
		userNKParams.setEzKeyValueStructure(in);
		userNKParams.setIsUserAKey(pFinalFlag);
		uparams.createContainer();
		uparams.setObject(userNKParams);
		Session.prepareParams(uparams);

		// Add Business User Defaults
		UserManager.setUserDefaults(uparams); 
		//AdminObject.setUserDefaults(servlet, in, pFinalFlag, null); 
	}//End For
}// End if TotalCount not null

response.sendRedirect("../User/ezUserOnlyDefaultsList.jsp?saved=Y&BusUser=" + BusUser);
%>