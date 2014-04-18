<%@ page import = "ezc.ezsap.*" %>
<%@ page import ="ezc.ezadmin.*" %>
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
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
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retbasesys = null;
ReturnObjFromRetrieve retbpinfo = null;

//Z_EZ_GET_BUS_CUSTOMER_MASTER buss_customer = null;
EzBusinessPartner buss_customer = null;
ReturnObjFromRetrieve buss_cust_retObj = null;

//ZezbuspartTable buss_partner_table = null;
//ZezbuspartTableRow bRow = null;
EzCustomerTable buss_partner_table = null;
EzCustomerRow bRow = null;
ReturnObjFromRetrieve busspartnerObj = null;

//ZezcustmasTable address_table = null;
//ZezcustmasTableRow addRow = null;

EzAddressTable address_table = null;
EzAddressRow addRow = null;
ReturnObjFromRetrieve addressObj = null;

String BusPartner = null;
String BPDesc = null;
String SysKey = null;
String SoldTo = null;
String pSoldTo = null;

String strTcount =  request.getParameter("TotalCount");
int totCount = (new Integer(strTcount)).intValue();  

BusPartner = request.getParameter("BusPartner");	
SysKey = request.getParameter("SysKey");	



// Get Business Partner Basic Information
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams= new EzcBussPartnerNKParams();
bparams.setBussPartner(BusPartner);
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);
retbpinfo = (ReturnObjFromRetrieve)BPManager.getBussPartnerInfo(bparams);
retbpinfo.check();
//retbpinfo = AdminObject.getBussPartnerInfo(servlet, BusPartner);

BPDesc = (String)(retbpinfo.getFieldValue(0,BP_COMPANY_NAME));
%>