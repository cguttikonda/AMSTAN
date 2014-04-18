<%@ page import = "ezc.ezparam.EzKeyValueStructure" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>

<%
// Get the input parameters
String BusUser = null;
String AuthCount  = null; 
String pAuthCount  = null; 

String Check = null; 
String pCheck = null; 
String Stat = null; 
String pStat = null; 
String AuthKey = null; 
String pAuthKey = null; 
String AuthDesc = null; 
String pAuthDesc = null;

BusUser = request.getParameter("BusUser");	

String strTcount =  request.getParameter("TotalCount");
if ( strTcount != null ){
int TotalCount = (new Integer(strTcount)).intValue();  

for ( int j = 0  ; j < TotalCount; j++ ){

	AuthCount = "AuthCount_"+j;	
	pAuthCount = request.getParameter(AuthCount);	

	if ( pAuthCount != null ){
	int intAuthCount = (new Integer(pAuthCount)).intValue();  

		for ( int i = 0  ; i < intAuthCount; i++ ){
			Check = "Check_"+j+"_"+i;
			AuthKey= "AuthKey_"+j+"_"+i;
			AuthDesc= "AuthDesc_"+j+"_"+i;
			Stat = "Stat_"+j+"_"+i;

			pCheck = request.getParameter(Check);
			pStat = request.getParameter(Stat);

			// Check For Selection
			if ( pCheck != null ){
				if ( pCheck.equals("Selected"))	{
				if(pStat == null){

				pAuthKey = request.getParameter(AuthKey);
				pAuthDesc = request.getParameter(AuthDesc);

				// Transfer Structure for the Descriptions
				EzKeyValueStructure in = new EzKeyValueStructure();

				// Set the Structure Values
				in.setPKey(BusUser.trim());
				in.setKey(pAuthKey.trim());
				in.setValue(pAuthDesc.trim());

				// Add Business User Authorizations
				AdminObject.setUserMasterAuth(servlet, in); 
				}//End if
				}//End if
			}else{
				if(pStat != null){

				pAuthKey = request.getParameter(AuthKey);
				pAuthDesc = request.getParameter(AuthDesc);

				// Transfer Structure for the Descriptions
				EzKeyValueStructure in = new EzKeyValueStructure();

				// Set the Structure Values
				in.setPKey(BusUser.trim());
				in.setKey(pAuthKey.trim());
				in.setValue(pAuthDesc.trim());

				// Add Business User Authorizations
				AdminObject.setUserMasterAuth(servlet, in); 
				}
			}	
		}//End For Auth Keys
	}// End if AuthCount
	}//End For Business Partner
}// End if TotalCount not null

response.sendRedirect("../User/ezUserEzcAuthList.jsp?BusinessUser=" + BusUser);
%>