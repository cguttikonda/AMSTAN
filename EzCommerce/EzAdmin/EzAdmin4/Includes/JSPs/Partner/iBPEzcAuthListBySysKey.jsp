<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"/>
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
String Bus_SysKey  = request.getParameter("BPsyskey");

if(Bus_SysKey!=null && !"null".equals(Bus_SysKey))
	websyskey = Bus_SysKey;




int numBP=0;
if(ret1!=null)
numBP=ret1.getRowCount();

%>