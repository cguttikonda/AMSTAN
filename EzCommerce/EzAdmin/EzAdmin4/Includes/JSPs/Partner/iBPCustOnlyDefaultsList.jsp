<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

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
ReturnObjFromRetrieve retbp = null;
ReturnObjFromRetrieve retcust = null;
ReturnObjFromRetrieve reterpdef = null;

String Bus_Partner = request.getParameter("BusinessPartner");

// Get Business Partners
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
	bnkparams.setLanguage("EN");
	bparams.setObject(bnkparams);
	bparams.setBussPartner(Bus_Partner);
	Session.prepareParams(bparams);
	//retbp =(ReturnObjFromRetrieve) BPManager.getBussPartners(bparams);
	retbp = (ReturnObjFromRetrieve) BPManager.getBussPartnerInfo(bparams);

	String bpdesc = retbp.getFieldValueString(0,"ECA_PARTNER_LISTBOX_DESC");

	retbp.check();
	//retbp = AdminObject.getBussPartners(servlet);


//Get the Customers for the BP
/**
	EzcBussPartnerParams bparams1 = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams1 = new EzcBussPartnerNKParams();
	bparams1.setBussPartner(Bus_Partner.trim());
	bnkparams1.setLanguage("EN");
	bparams1.setObject(bnkparams1);
	Session.prepareParams(bparams1);
	retcust = (ReturnObjFromRetrieve) BPManager.getBussPartnerErpCustomers(bparams1);
	retcust.check();
	//retcust = AdminObject.getBussPartnerErpCustomers(servlet, Bus_Partner.trim());
**/

//Get ERPCustomer
String Sold_To = request.getParameter("SoldTo");

String sys_key = request.getParameter("SysKey");

/**
if (Sold_To == null) {
	Sold_To = (retcust.getFieldValue(0, ERP_CUST_NO)).toString();
}
**/


//Get ERP Customer Defaults
	EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
	bnkparams2.setLanguage("EN");
	bnkparams2.setCust_id(Sold_To);
	bnkparams2.setSys_key("NOT");
	bparams2.setObject(bnkparams2);
	Session.prepareParams(bparams2);
	reterpdef = (ReturnObjFromRetrieve)BPManager.getErpCustomerDefaults(bparams2);
	reterpdef.check();
	//reterpdef = AdminObject.getErpCustomerDefaults(servlet, Sold_To, null);
%>