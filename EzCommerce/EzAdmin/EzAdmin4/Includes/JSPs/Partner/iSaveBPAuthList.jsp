<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%
// Get the input parameters
String BusPartner = null;
String SysNum = null;
String pSysNum = null;
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

String strTcount =  request.getParameter("TotalCount");

if ( strTcount != null ){
int TotalCount = (new Integer(strTcount)).intValue();  

	BusPartner = request.getParameter("BusPartner");	

	for ( int j = 0  ; j < TotalCount; j++ ){

		SysNum = "SysNum_"+j;	
		pSysNum = request.getParameter(SysNum);	
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
				if(pStat == null){
					pAuthKey = request.getParameter(AuthKey);
					pAuthDesc = request.getParameter(AuthDesc);

					// Transfer Structure for the Descriptions
					EzKeyValueStructure in = new EzKeyValueStructure();

					// Set the Structure Values
					in.setPKey(BusPartner.trim());
					in.setKey(pAuthKey.trim());
					in.setValue(pAuthDesc.trim());

                              EzcBussPartnerParams bparams = new EzcBussPartnerParams();
					//bparams.setBussPartner();
					EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
					bnkparams.setLanguage("EN");
					bnkparams.setSys_no(pSysNum);
                              bnkparams.setEzKeyValueStructure(in);
					bparams.setObject(bnkparams);
					Session.prepareParams(bparams);

					// Add Business Partner Authorizations
					//AdminObject.setBussPartnerAuth(servlet, in, pSysNum); 
					BPManager.setBussPartnerAuth(bparams); 
				}//End if
			}else{
				if(pStat != null){
					pAuthKey = request.getParameter(AuthKey);
					pAuthDesc = request.getParameter(AuthDesc);

					// Transfer Structure for the Descriptions
					EzKeyValueStructure in = new EzKeyValueStructure();

					// Set the Structure Values
					in.setPKey(BusPartner.trim());
					in.setKey(pAuthKey.trim());
					in.setValue(pAuthDesc.trim());

                                       	EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
					//bparams.setBussPartner();
					EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
					bnkparams2.setLanguage("EN");
					bnkparams2.setSys_no(pSysNum);
                                        bnkparams2.setEzKeyValueStructure(in);
					bparams2.setObject(bnkparams2);
					Session.prepareParams(bparams2);

					// Add Business Partner Authorizations
					//AdminObject.setBussPartnerAuth(servlet, in, pSysNum); 
					BPManager.setBussPartnerAuth(bparams2); 
				}
			}	
		}//End For Auth Keys
	}// End if AuthCount
	}//End For Systems
}// End if TotalCount not null
//response.sendRedirect("../Partner/ezBPAuthList.jsp?BusinessPartner=" + BusPartner);
response.sendRedirect("ezBPAuthList.jsp?saved=Y&BusinessPartner=" + BusPartner);
%>