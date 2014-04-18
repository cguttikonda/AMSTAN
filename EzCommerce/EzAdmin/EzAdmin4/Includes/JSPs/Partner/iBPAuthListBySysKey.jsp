<%@ page import="java.util.*"%>
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
ReturnObjFromRetrieve retbpsys = null;
ReturnObjFromRetrieve retauth = null;
ReturnObjFromRetrieve retbpauth = null;

EzcBussPartnerParams bparams = new EzcBussPartnerParams();
//bparams.setBussPartner();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);

// System Configuration Class
String Bus_Partner = null;
String Bus_SysKey = null;

// Get Business Partners
//retbp = AdminObject.getBussPartners(servlet);
retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
retbp.check();


//Number of Business Partners
//int numBP = retbp.getRowCount();
int numBP=0;
if(ret1!=null)
	 numBP = ret1.getRowCount();




if(numBP > 0){
	//Get Business Partner Value
	Bus_Partner = request.getParameter("BusinessPartner");
	Bus_SysKey  = request.getParameter("BPsyskey");
	
	if(Bus_SysKey!=null && !"null".equals(Bus_SysKey))
		websyskey = Bus_SysKey;
	
	////out.println("Bus_Partner>>>"+Bus_Partner+">>>>>>"+websyskey);
	
if(Bus_Partner!=null && !"sel".equals(Bus_Partner))
{
        EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
	bparams2.setBussPartner(Bus_Partner);
	EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
	bnkparams2.setLanguage("EN");
	bparams2.setObject(bnkparams2);
	Session.prepareParams(bparams2);

	//Get the systems for the BP
	retbpsys = (ReturnObjFromRetrieve) BPManager.getBussPartnerSystems(bparams2);

	retbpsys.check();
}//End if
}

%>