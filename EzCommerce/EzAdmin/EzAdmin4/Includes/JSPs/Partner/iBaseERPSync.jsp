<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
 
<%
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retbasesys = null;
String bussPartner = null;
int BaseSysNum = 0;
String tempBusspartner = "";
boolean isthereBaseErp = true;
boolean baseErpExist = false;


EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);

// Get Business Partners
ret = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
tempBusspartner = ret.getFieldValue(0,BP_NUMBER)+"";
ret.check();



//Number of BPs
int numBPs = ret.getRowCount();
String currBaseERP = "";

if(numBPs > 0)
{
	// Get Base ERP System Number
   	EzcSysConfigParams sparams2  = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
	snkparams2.setLanguage("EN");
	sparams2.setObject(snkparams2);
	Session.prepareParams(sparams2);
	//retbasesys = ezc.getBaseErp();
	retbasesys = (ReturnObjFromRetrieve)ezc.getBaseErp(sparams2);
	retbasesys.check();
	if(retbasesys.getRowCount()!=0)
	{
		BaseSysNum = ((java.math.BigDecimal)retbasesys.getFieldValue(0,BASE_ERP)).intValue();
		currBaseERP = retbasesys.getFieldValueString(0,"ESG_BASE_ERP_SYS_NO");
		// Get List Of System Keys
		// this call is been discarded ..... 
		/* 
		EzcUtilityParams utilparams = new EzcUtilityParams();
	    	EzcUtilityNKParams utilnkparams = new EzcUtilityNKParams();
	    	utilnkparams.setSys_Number(BaseSysNum);
		utilnkparams.setLanguage("EN");
	    	utilparams.setObject(utilnkparams);
	    	Session.prepareParams(utilparams);
		//retsyskey = (ReturnObjFromRetrieve)UtilityManager.getSysKeysForSystem(utilparams);
		retsyskey = (ReturnObjFromRetrieve)UtilityManager.getCatalogAreasForSystem(utilparams);
		retsyskey.check();
		*/
  	}
	else 	
	{
		isthereBaseErp = false;
		BaseSysNum =0;
	}
}//end if
%>