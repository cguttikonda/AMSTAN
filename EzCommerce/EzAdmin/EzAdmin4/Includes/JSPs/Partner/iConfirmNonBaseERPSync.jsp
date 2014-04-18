<%@ page import = "ezc.ezsap.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/ServerFunctions.jsp"%>

<script language="Javascript">
function CheckSel(){
	var pCount=0;
	var selCount=0;
	pCount = document.ConfirmSync.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.ConfirmSync.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert("Select Sold To(s) To Synchronize");
		document.returnValue = false;
	}else{
		document.returnValue = true;
	}
}
</script>

<%
final String EC_NAME_X					= "ECA_NAME";
final String EC_COMPANY_NAME_X				= "ECA_COMPANY_NAME";
final String EC_PHONE_X					= "ECA_PHONE";
final String EC_EMAIL_X					= "ECA_EMAIL";
final String EC_WEB_ADDR_X				= "ECA_WEB_ADDR";
final String EC_ADDR_1_X					= "ECA_ADDR_1";
final String EC_ADDR_2_X					= "ECA_ADDR_2";
final String EC_CITY_X					= "ECA_CITY";
final String EC_STATE_X					= "ECA_STATE";
final String EC_PIN_X					= "ECA_PIN";

// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retbasesys = null;
ReturnObjFromRetrieve retbpinfo = null;
ReturnObjFromRetrieve retcustadd = null;

Z_EZ_GET_BUS_CUSTOMER_MASTER buss_customer = null;

ZezbuspartTable buss_partner_table = null;
ZezbuspartTableRow bRow = null;

ZezcustmasTable address_table = null;
ZezcustmasTableRow addRow = null;

String BusPartner = null;
String BPDesc = null;
String NonBaseErp = null;
String SysKey = null;
String SoldTo = null;
String pSoldTo = null;

String EzcCust = null;
String pEzcCust = null;

String strTcount =  request.getParameter("TotalCount");
int totCount = (new Integer(strTcount)).intValue();  

BusPartner = request.getParameter("BusPartner");	
SysKey = request.getParameter("SysKey");	
NonBaseErp = request.getParameter("NonBaseERP");	


// Get Business Partner Basic Information
retbpinfo = AdminObject.getBussPartnerInfo(servlet, BusPartner);
retbpinfo.check();

BPDesc = (String)(retbpinfo.getFieldValue(0,BP_COMPANY_NAME));
%>