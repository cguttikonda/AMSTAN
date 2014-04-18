<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>

<script language = "javascript">
function myalert(){
	//myhost = window.location.host;
	//mUrl1 =  "http://" + myhost + "/Admin/Admin1/JSPs/Partner/ezNewVendSync.jsp?";
	//mUrl2 = "BusinessPartner=" + document.VendSync.BusPartner.value;
	//mUrl =  mUrl1 + mUrl2;
	//location.href= mUrl;

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
      mUrl2 = "BusinessPartner=" + document.VendSync.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function syschange(){
	//myhost = window.location.host;
	//mUrl1 =  "http://" + myhost + "/Admin/Admin1/JSPs/Partner/ezNewVendSync.jsp?";
	//mUrl2 = "SystemNumber=" + document.VendSync.NonBaseERP.value + "&";
	//mUrl3 = "BusinessPartner=" + document.VendSync.BusPartner.value;
	//mUrl =  mUrl1 + mUrl2 + mUrl3;
	//location.href= mUrl;

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.VendSync.NonBaseERP.value + "&";
	mUrl3 = "BusinessPartner=" + document.VendSync.BusPartner.value;
	mUrl =  mUrl1 + mUrl2+mUrl3;
	location.href= mUrl;

}
</script>

<%


// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retsys = null;
ReturnObjFromRetrieve retbpcust = null;

String Bus_Partner = null;
String Sys_Num = null;
int numSys = 0;

// Get Business Partners
//ret = AdminObject.getBussPartners(servlet);
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);
ret = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
ret.check();

//Number of BPs
int numBPs = ret.getRowCount();

if(numBPs > 0){

	//Get Business Partner Value
	Bus_Partner = request.getParameter("BusinessPartner");
	if (Bus_Partner == null) {
		Bus_Partner = (ret.getFieldValue(0,BP_NUMBER)).toString();
	}

	// Get Non Base ERP Systems

//	retsys = AdminObject.getBPNonBaseErpSystems(servlet, Bus_Partner);

	EzcBussPartnerParams bparams1 = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams1 = new EzcBussPartnerNKParams();
	bnkparams1.setLanguage("EN");
	bparams1.setBussPartner(Bus_Partner);
	bparams1.setObject(bnkparams1);
	Session.prepareParams(bparams1);
	retsys = (ReturnObjFromRetrieve)BPManager.getBPNonBaseErpSystems(bparams1);
	retsys.check();
	
	//Number of Non Base ERPs
	numSys = retsys.getRowCount();

	if(numSys > 0){
		//Get System Value
		Sys_Num = request.getParameter("SystemNumber");
		if (Sys_Num == null) {
			Sys_Num = (retsys.getFieldValue(0,BPP_KEY_VALUE)).toString();
		}

		// Get List Of System Keys for the Non Base ERP System
		// This call is discarded......	
/*
		EzcUtilityParams utilparams = new EzcUtilityParams();
	    EzcUtilityNKParams utilnkparams = new EzcUtilityNKParams();
	    utilnkparams.setSys_Number(Integer.parseInt(Sys_Num));
		utilnkparams.setLanguage("EN");
	    utilparams.setObject(utilnkparams);
       	Session.prepareParams(utilparams);
		//retsyskey = AdminObject.getSysKeysForSystem(servlet, Sys_Num);
		//retsyskey = (ReturnObjFromRetrieve)UtilityManager.getSysKeysForSystem(utilparams);
		retsyskey = (ReturnObjFromRetrieve)UtilityManager.getPurchaseAreasForSystem(utilparams);
		retsyskey.check();
*/

		EzcBussPartnerParams bparams5 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams5 = new EzcBussPartnerNKParams();
		bparams5.setBussPartner(Bus_Partner);
		bnkparams5.setLanguage("EN");
		bnkparams5.setSys_no(Sys_Num+"");
		bparams5.setObject(bnkparams5);
		Session.prepareParams(bparams5);
		retsyskey = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystemPurchaseAreas(bparams5);
		retsyskey.check();

	}//end if numSys 

	// Get List Of Ezc Customers for a BP
	EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
	bnkparams2.setLanguage("EN");
	bparams2.setBussPartner(Bus_Partner);
	bparams2.setObject(bnkparams2);
	Session.prepareParams(bparams2);
	retbpcust = (ReturnObjFromRetrieve)BPManager.getBussPartnerEzcCustomers(bparams2);
	retbpcust.check();
	//retbpcust = AdminObject.getBussPartnerEzcCustomers(servlet, Bus_Partner, "EN");
}//end if
%>