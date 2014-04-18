<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>

<%

// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retsys = null;
ReturnObjFromRetrieve retbpcust = null;
ReturnObjFromRetrieve retbpinfo = null;

String Bus_Partner = null;
String BPDesc = "";
String Sys_Num = null;
int numSys = 0;


String Area=request.getParameter("Area");
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);
ret = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
ret.check();

//Number of BPs
int numBPs = ret.getRowCount();

if(numBPs > 0)
{

	//Get Business Partner Value
	Bus_Partner = request.getParameter("BusinessPartner");
	if (Bus_Partner == null) 
	{
		Bus_Partner = (ret.getFieldValue(0,BP_NUMBER)).toString();
	}

	// Get Non Base ERP Systems
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

	if(numSys > 0)
	{
		//Get System Value
		Sys_Num = request.getParameter("SystemNumber");
		if (Sys_Num == null) 
		{
			Sys_Num = (retsys.getFieldValue(0,BPP_KEY_VALUE)).toString();
		}

		// Get List Of System Keys for the Non Base ERP System
		EzcBussPartnerParams bparams5 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams5 = new EzcBussPartnerNKParams();
		bparams5.setBussPartner(Bus_Partner);
		bnkparams5.setLanguage("EN");
		bnkparams5.setSys_no(Sys_Num+"");
		bparams5.setObject(bnkparams5);
		Session.prepareParams(bparams5);
		
		retbpinfo = (ReturnObjFromRetrieve)BPManager.getBussPartnerInfo(bparams5);
		retbpinfo.check();
		BPDesc = (String)(retbpinfo.getFieldValue(0,BP_COMPANY_NAME));
		

		/**
		if ( FUNCTION.equals("AG") )
		{
			retsyskey = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystemCatalogAreas(bparams5);
		}
		else
		{
			retsyskey = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystemPurchaseAreas(bparams5);		
		}
		**/

		retsyskey = (ReturnObjFromRetrieve)BPManager.getBussPartnerAreas(bparams5);
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