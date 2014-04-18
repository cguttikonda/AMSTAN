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

final String SYSTEM_NO = "ESD_SYS_NO";
final String SYSTEM_DESC = "ESD_SYS_DESC";

// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retbasesys = null;
ReturnObjFromRetrieve retbpinfo = null;
ReturnObjFromRetrieve retcustadd = null;

EzBusinessPartner buss_customer = null;
ReturnObjFromRetrieve buss_cust_retObj = null;

EzCustomerTable buss_partner_table = null;
EzCustomerRow bRow = null;



EzAddressTable address_table = null;
EzAddressRow addRow = null;

ReturnObjFromRetrieve busspartnerObj = null;
ReturnObjFromRetrieve addressObj = null;

String BusPartner = null;
String BPDesc = null;
String NonBaseErp = null;
String SoldTo = null;
String pSoldTo = null;

String EzcCust = null;
String pEzcCust = null;



BusPartner = request.getParameter("BusinessPartner");
String websyskey=request.getParameter("WebSysKey");

String SysKey[] = request.getParameterValues("SysKey");
StringTokenizer st=new StringTokenizer(SysKey[0],"#");
String sKey=st.nextToken();
String ERPCust=st.nextToken();



//To get Systems Desc
ReturnObjFromRetrieve mySystemRet = null;

EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);
mySystemRet = (ReturnObjFromRetrieve)sysManager.getSystemDesc(sparams);

String mySystemDesc = "";
if(!(mySystemRet==null || websyskey==null))
{
	int mySystemsCount = mySystemRet.getRowCount();
	String sysNo = websyskey.substring(0,3);
	for (int i =0;i<mySystemsCount;i++)
	{
		if(sysNo.equals(mySystemRet.getFieldValueString(i,SYSTEM_NO)))
			mySystemDesc = mySystemRet.getFieldValueString(i,SYSTEM_DESC);
	}
}

// Get Business Partner Basic Information
EzcBussPartnerParams bparams = new  EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bparams.setBussPartner(BusPartner);
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);

retbpinfo = (ReturnObjFromRetrieve)BPManager.getBussPartnerInfo(bparams);
retbpinfo.check();
BPDesc = (String)(retbpinfo.getFieldValue(0,BP_COMPANY_NAME));
%>