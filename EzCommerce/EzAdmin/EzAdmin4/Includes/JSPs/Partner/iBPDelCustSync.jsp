<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="session">
</jsp:useBean>

<%
String FUNCTION = request.getParameter("FUNCTION");

if (FUNCTION == null)FUNCTION="AG";
FUNCTION = FUNCTION.trim();

String cTitle = (FUNCTION.equals("AG"))?"Customer":"Vendor";
String cFlag = (FUNCTION.equals("AG"))?"C":"V";
String cDesc = (FUNCTION.equals("AG"))?"Sold To":"Pay To";



// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retFinal = null;
ReturnObjFromRetrieve retbpareas = null;
ReturnObjFromRetrieve retcust = null;

String Bus_Partner = null;
String CatalogNumber = null;
int ezcCustCount = 0;
int retCatRows = 0;

// Get Business Partners
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);
ret =(ReturnObjFromRetrieve) BPManager.getBussPartners(bparams);
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

	//Get the ErpCustomers for the BP
	EzcBussPartnerParams bparamsC = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparamsC = new EzcBussPartnerNKParams();
	bnkparamsC.setLanguage("EN");
	bparamsC.setBussPartner(Bus_Partner);
	bparamsC.setObject(bnkparamsC);
	Session.prepareParams(bparamsC);
	retFinal = (ReturnObjFromRetrieve)BPManager.getBussPartnerErpCustomers(bparamsC);
	retFinal.check();
	
	String remAreaFlag = "";
	if ( FUNCTION.equals("AG") )
	{
		remAreaFlag="VN";
	}
	else
	{
		remAreaFlag="AG";
	}
	
	int retFinalRows = retFinal.getRowCount();
	for ( int t=0; t < retFinalRows; t++)
	{
		String pFuncFlag = retFinal.getFieldValueString(t, "EC_PARTNER_FUNCTION");
		pFuncFlag = pFuncFlag.trim();
		if ( pFuncFlag.equals( remAreaFlag ) )
		{
			retFinal.deleteRow(t);
			retFinalRows--;
			t--;
		} //end if
	} //end for
	
}//end if

%>

