<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>

<script language = "javascript">
function myalert(){
	//myhost = window.location.host;
	//mUrl1 =  "http://" + myhost + "/Admin/Admin1/JSPs/Partner/ezVendNonBaseERPSync.jsp?";
	//mUrl2 = "BusinessPartner=" + document.CustSync.BusPartner.value;
	//mUrl =  mUrl1 + mUrl2;
	//location.href= mUrl;

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
      mUrl2 = "BusinessPartner=" + document.CustSync.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;

}
function syschange(){
	//myhost = window.location.host;
	//mUrl1 =  "http://" + myhost + "/Admin/Admin1/JSPs/Partner/ezVendNonBaseERPSync.jsp?";
	//mUrl2 = "SystemNumber=" + document.CustSync.NonBaseERP.value + "&";
	//mUrl3 = "BusinessPartner=" + document.CustSync.BusPartner.value;
	//mUrl =  mUrl1 + mUrl2 + mUrl3;
	//location.href= mUrl;

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.CustSync.NonBaseERP.value + "&";
	mUrl3 = "BusinessPartner=" + document.CustSync.BusPartner.value;
	mUrl =  mUrl1 + mUrl2+mUrl3;
	location.href= mUrl;

}
function custalert(){
	//myhost = window.location.host;
	//mUrl1 =  "http://" + myhost + "/Admin/Admin1/JSPs/Partner/ezNonBaseERPSync.jsp?";
	//mUrl2 = "BusinessPartner=" + document.CustSync.BusPartner.value;
	//mUrl =  mUrl1 + mUrl2;
	//location.href= mUrl;

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
      mUrl2 = "BusinessPartner=" + document.CustSync.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function custsyschange(){
	//myhost = window.location.host;
	//mUrl1 =  "http://" + myhost + "/Admin/Admin1/JSPs/Partner/ezNonBaseERPSync.jsp?";
	//mUrl2 = "SystemNumber=" + document.CustSync.NonBaseERP.value + "&";
	//mUrl3 = "BusinessPartner=" + document.CustSync.BusPartner.value;
	//mUrl =  mUrl1 + mUrl2 + mUrl3;
	//location.href= mUrl;

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.CustSync.NonBaseERP.value + "&";
	mUrl3 = "BusinessPartner=" + document.CustSync.BusPartner.value;
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


boolean isEzcCustomer = true;
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
ret =(ReturnObjFromRetrieve) BPManager.getBussPartners(bparams);
ret.check();

//Number of BPs
int numBPs = ret.getRowCount();

String currBaseERP = "";
boolean ErpFound  = false;

if(numBPs > 0)
{

	//Get Business Partner Value
	Bus_Partner = request.getParameter("BusinessPartner");
	if (Bus_Partner == null) 
	{
		Bus_Partner = (ret.getFieldValue(0,BP_NUMBER)).toString();
	}

	// Get Non Base ERP Systems
	//retsys = AdminObject.getBPNonBaseErpSystems(servlet, Bus_Partner);
	EzcBussPartnerParams bparams1 = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams1 = new EzcBussPartnerNKParams();
	bnkparams1.setLanguage("EN");
	bparams1.setBussPartner(Bus_Partner);
	bparams1.setObject(bnkparams1);
	Session.prepareParams(bparams1);
	//retsys = (ReturnObjFromRetrieve)BPManager.getBPNonBaseErpSystems(bparams1);
	retsys = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystems(bparams1);
	retsys.check();

   		EzcSysConfigParams sparams2  = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
		snkparams2.setLanguage("EN");
		sparams2.setObject(snkparams2);
		Session.prepareParams(sparams2);
		//retbasesys = ezc.getBaseErp();
		ReturnObjFromRetrieve retbasesys = (ReturnObjFromRetrieve)ezc.getBaseErp(sparams2);
		retbasesys.check();
		currBaseERP = retbasesys.getFieldValueString(0,"ESG_BASE_ERP_SYS_NO");

		/**if ( retsys.find(BPP_KEY_VALUE,currBaseERP) )
		{
			int rowID = retsys.getRowId(BPP_KEY_VALUE,currBaseERP);
			retsys.deleteRow(rowID);
			ErpFound = true;
		}
		else
		{	
			ErpFound = false;
			//return;
		}**/

	//Number of Non Base ERPs
	numSys = retsys.getRowCount();

	if(numSys > 0)
	{

		//Get System Value
		Sys_Num = request.getParameter("SystemNumber");
		if (Sys_Num == null) 
		{
			//Sys_Num = (retsys.getFieldValue(0,BPP_KEY_VALUE)).toString();
			Sys_Num = retsys.getFieldValueString(0,BPP_KEY_VALUE);
		}


		// Get List Of System Keys for the Non Base ERP System
		EzcBussPartnerParams bparams5 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams5 = new EzcBussPartnerNKParams();
		bparams5.setBussPartner(Bus_Partner);
		bnkparams5.setLanguage("EN");
		bnkparams5.setSys_no(Sys_Num+"");
		bparams5.setObject(bnkparams5);
		Session.prepareParams(bparams5);
		retsyskey = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystemCatalogAreas(bparams5);
		retsyskey.check();
		
		// Get List Of Ezc Customers for a BP
		EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
		bnkparams2.setLanguage("EN");
		bparams2.setBussPartner(Bus_Partner);
		bparams2.setObject(bnkparams2);
		Session.prepareParams(bparams2);
		//retbpcust = AdminObject.getBussPartnerEzcCustomers(servlet, Bus_Partner, "EN");
		retbpcust = (ReturnObjFromRetrieve)BPManager.getBussPartnerEzcCustomers(bparams2);
            String sortArr[] = {"EC_NO"};
		retbpcust.sort(sortArr,true);
		retbpcust.check();
        	if((retbpcust==null)||(retbpcust.getRowCount()<1)) isEzcCustomer = false;
	}//end if numSys 
}//end if
%>

