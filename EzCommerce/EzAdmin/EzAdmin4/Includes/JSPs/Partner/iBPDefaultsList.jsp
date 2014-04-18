<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>

<%!
// Start Declarations

final String EZC_CUSTOMER_NUM = "EC_NO";
final String EZC_CUSTOMER_SYSKEY = "EC_SYS_KEY";
final String ERP_CUST_NO = "EC_ERP_CUST_NO";

final String ERP_CUST_DEFAULTS_KEY = "EECD_DEFAULTS_KEY";
final String ERP_CUST_DEFAULTS_VALUE = "EECD_DEFAULTS_VALUE";
final String ERP_CUST_SYSTEM_KEY = "EECD_SYS_KEY";

//End Declarations
%>

<%

String FUNCTION = request.getParameter("FUNCTION");
// Key Variables : Globals in the page
ReturnObjFromRetrieve retbpsyskey = null;
ReturnObjFromRetrieve retcust = null;
ReturnObjFromRetrieve retdef = null;
ReturnObjFromRetrieve reterpdef = null;

//Get Business Partner Value
String Bus_Partner = request.getParameter("BusPartner");


ReturnObjFromRetrieve retbp = null;
EzcBussPartnerParams bparamsB = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparamsB = new EzcBussPartnerNKParams();
bnkparamsB.setLanguage("EN");
bparamsB.setBussPartner(Bus_Partner);
bparamsB.setObject(bnkparamsB);
Session.prepareParams(bparamsB);
retbp = (ReturnObjFromRetrieve) BPManager.getBussPartnerInfo(bparamsB);

String bpdesc = retbp.getFieldValueString(0,"ECA_COMPANY_NAME");

retbp.check();

Bus_Partner = Bus_Partner.trim();


//Get the Customers for the BP
/**
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage("EN");
bparams.setBussPartner(Bus_Partner);
bparams.setObject(bnkparams);
Session.prepareParams(bparams);

retcust = (ReturnObjFromRetrieve)BPManager.getBussPartnerErpCustomers(bparams);
retcust.check();
if(retcust.getRowCount() < 1)
{
	response.sendRedirect("../Partner/Error.jsp");
}
**/

//Get ERPCustomer
//String Sold_To = request.getParameter("SoldToParty");
String Sold_To = request.getParameter("SoldTo");


/**
if (Sold_To == null) 
{
	Sold_To = (retcust.getFieldValue(0, ERP_CUST_NO)).toString();
}
**/

/**
EzcBussPartnerParams bparams1 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams1 = new EzcBussPartnerNKParams();
bnkparams1.setLanguage("EN");
bparams1.setBussPartner(Bus_Partner);
bnkparams1.setCust_id(Sold_To);
bparams1.setObject(bnkparams1);
Session.prepareParams(bparams1);
retbpsyskey = (ReturnObjFromRetrieve)BPManager.getErpCustomerSystems(bparams1);
retbpsyskey.check();
**/

//Get System Key Value
//String sys_key = request.getParameter("SystemKey");
String sys_key = request.getParameter("area");

/**
if (sys_key == null) 
{
	sys_key = (retbpsyskey.getFieldValue(0,SYSTEM_KEY)).toString();
}
**/

sys_key = sys_key.toUpperCase();
sys_key = sys_key.trim();

EzcSysConfigParams configparams = new EzcSysConfigParams();
EzcSysConfigNKParams confignkparams = new EzcSysConfigNKParams();
confignkparams.setLanguage("EN");
confignkparams.setSystemKey(sys_key);
configparams.setObject(confignkparams);
Session.prepareParams(configparams);
retdef = (ReturnObjFromRetrieve)sysManager.getDefaultsDesc(configparams);
retdef.check();


//Get ERP Customer Defaults
EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
bnkparams2.setLanguage("EN");
bparams2.setBussPartner(Bus_Partner);
bnkparams2.setCust_id(Sold_To);
bnkparams2.setSys_key(sys_key);
bparams2.setObject(bnkparams2);
Session.prepareParams(bparams2);
reterpdef = (ReturnObjFromRetrieve)BPManager.getErpCustomerCatAreaDefaults(bparams2);
reterpdef.check();
%>