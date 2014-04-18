<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/ServerFunctions.jsp"%>



<%
boolean returnObjCheck = false;
final String EC_NAME_X					= "ECA_NAME";
final String EC_COMPANY_NAME_X			= "ECA_COMPANY_NAME";
final String EC_PHONE_X					= "ECA_PHONE";
final String EC_EMAIL_X					= "ECA_EMAIL";
final String EC_WEB_ADDR_X				= "ECA_WEB_ADDR";
final String EC_ADDR_1_X			      = "ECA_ADDR_1";
final String EC_ADDR_2_X				= "ECA_ADDR_2";
final String EC_CITY_X					= "ECA_CITY";
final String EC_STATE_X					= "ECA_STATE";
final String EC_PIN_X					= "ECA_PIN";


ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retbasesys = null;
ReturnObjFromRetrieve retbpinfo = null;
ReturnObjFromRetrieve retcustadd = null;
ReturnObjFromRetrieve retbpezcust = null;


EzBusinessPartner buss_customer = null;
ReturnObjFromRetrieve buss_cust_retObj = null;

EzCustomerTable buss_partner_table = (EzCustomerTable)session.getValue("buss_partner_table");
EzCustomerRow bRow = null;


EzAddressTable address_table = (EzAddressTable)session.getValue("address_table");
EzAddressRow addRow = null;

ReturnObjFromRetrieve busspartnerObj = (ReturnObjFromRetrieve)session.getValue("busspartnerObj");
ReturnObjFromRetrieve addressObj = (ReturnObjFromRetrieve)session.getValue("addressObj");


String BusPartner = null;
String BPDesc = null;
String SysKey = null;
BusPartner = request.getParameter("BusPartner");
SysKey = request.getParameter("SysKey");

EzcBussPartnerParams bparams = new  EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bparams.setBussPartner(BusPartner);
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);

retbpinfo = (ReturnObjFromRetrieve)BPManager.getBussPartnerInfo(bparams);
retbpinfo.check();

String[] pf = new String[4];
if ( FUNCTION.equals("AG") )
{
	pf[0] = "AG";
	pf[1] = "RE";
	pf[2] = "WE";
	pf[3] = "ZC";
}
else
{
	pf[0] = "VN";
	pf[1] = "OA";
	pf[2] = "PI";
}
//out.println(pf[3]);
bnkparams.setPartnerFunctions(pf);
retbpezcust = (ReturnObjFromRetrieve)BPManager.getBussPartnerEzcCustomers(bparams);
retbpezcust.check();

BPDesc = (String)(retbpinfo.getFieldValue(0,BP_COMPANY_NAME));
%>