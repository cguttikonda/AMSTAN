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
String Bus_Partner = request.getParameter("BusinessPartner");
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

//Get ERPCustomer
String Sold_To = request.getParameter("SoldTo");
//Get System Key Value
String sys_key = request.getParameter("area");
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
retdef.toEzcString();

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
reterpdef.toEzcString();
%>