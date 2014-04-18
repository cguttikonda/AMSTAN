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

//Z_EZ_GET_BUS_CUSTOMER_MASTER buss_customer = null;
EzBusinessPartner buss_customer = null;
ReturnObjFromRetrieve buss_cust_retObj = null;


//ZezbuspartTable buss_partner_table = null;
//ZezbuspartTableRow bRow = null;
EzCustomerTable buss_partner_table = null;
EzCustomerRow bRow = null;

//ZezcustmasTable address_table = null;
//ZezcustmasTableRow addRow = null;

EzAddressTable address_table = null;
EzAddressRow addRow = null;

ReturnObjFromRetrieve busspartnerObj = null;
ReturnObjFromRetrieve addressObj = null;

String BusPartner = null;
String BPDesc = null;
String NonBaseErp = null;
String SysKey = null;
String SoldTo = null;
String pSoldTo = null;

String EzcCust = null;
String pEzcCust = null;
String ReSynchFlag  = null;


ReSynchFlag = request.getParameter("ReSynchFlag");

	/*if("Y".equals(ReSynchFlag))
	{
		ezc.ezdrlsales.client.EzDrlSalesManager DrlManager = new ezc.ezdrlsales.client.EzDrlSalesManager();

		EzcParams myParams= new EzcParams(false);
		EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
		bnkparams2.setPartnerNumber(request.getParameter("BusPartner"));
		bnkparams2.setSys_key(request.getParameter("SysKey"));
		String tempSoldTo= request.getParameter("NonBaseERPSoldTo");
		String myZeros="000000000000000";
		if(tempSoldTo.length()<10)
		{
			tempSoldTo=myZeros.substring(0,10-tempSoldTo.length()) + tempSoldTo;
		}
		bnkparams2.setErp_customer(tempSoldTo);
		myParams.setObject(bnkparams2);
		Session.prepareParams(myParams);
		DrlManager.ezDeleteSynch(myParams);
	}
	*/


BusPartner = request.getParameter("BusPartner");
SysKey = request.getParameter("SysKey");
NonBaseErp = request.getParameter("NonBaseERP");


//To get Systems Desc
ReturnObjFromRetrieve mySystemRet = null;

EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);
mySystemRet = (ReturnObjFromRetrieve)sysManager.getSystemDesc(sparams);

String mySystemDesc = "";
if(!(mySystemRet==null || SysKey==null))
{
	int mySystemsCount = mySystemRet.getRowCount();
	String sysNo = SysKey.substring(0,3);
	for (int i =0;i<mySystemsCount;i++)
	{
		if(sysNo.equals(mySystemRet.getFieldValueString(i,SYSTEM_NO)))
			mySystemDesc = mySystemRet.getFieldValueString(i,SYSTEM_DESC);
	}
}




EzcBussPartnerParams bparams = new  EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bparams.setBussPartner(BusPartner);
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);

retbpinfo = (ReturnObjFromRetrieve)BPManager.getBussPartnerInfo(bparams);

BPDesc = (String)(retbpinfo.getFieldValue(0,BP_COMPANY_NAME));
%>