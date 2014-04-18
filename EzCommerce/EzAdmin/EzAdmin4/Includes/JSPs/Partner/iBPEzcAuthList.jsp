<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../Lib/ArmsConfig.jsp" %>

<%

	EzcParams einParams = new EzcParams(false);
	Session.prepareParams( einParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( einParams );
	String userRolesYN = null;

	java.util.ResourceBundle res = java.util.ResourceBundle.getBundle("Site");

	try
	{
			userRolesYN = res.getString("Roles");
			
	
	}
	catch ( Exception e ) 
	{
			e.printStackTrace();
			userRolesYN = "N";
					
	}
				
	boolean showRoles = true;
	if ( userRolesYN != null && userRolesYN.trim().equals("N") )
	{
		showRoles = false;
	}
	else
	{
		showRoles = true;
	}
// Key Variables
ReturnObjFromRetrieve retbp = null;
ReturnObjFromRetrieve retauth = null;
ReturnObjFromRetrieve retbpauth = null;

// Get Business Partners
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);
retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
retbp.check();

//Get Business Partner Value
String Bus_Partner = request.getParameter("BusinessPartner");
if (Bus_Partner == null) {
	Bus_Partner = (retbp.getFieldValue(0,BP_NUMBER)).toString();
}

%>