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
	// Get List Of All Areas for a BP
	EzcBussPartnerParams bparamsA = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparamsA = new EzcBussPartnerNKParams();
	bnkparamsA.setLanguage("EN");
	bparamsA.setBussPartner(Bus_Partner);
	bparamsA.setObject(bnkparamsA);
	Session.prepareParams(bparamsA);
	retbpareas = (ReturnObjFromRetrieve)BPManager.getBussPartnerAreas(bparamsA);
	retbpareas.check();

	//Added code to remove Service area - 6/6/2001
	String removeServiceArea = request.getParameter("removeServiceArea");
	if ( removeServiceArea == null )
	{
		int rCnt = retbpareas.getRowCount();
		for ( int k = 0; k < rCnt; k++ )
		{
			String serviceFlag = retbpareas.getFieldValueString(k,"ESKD_SUPP_CUST_FLAG");
			serviceFlag = serviceFlag.trim();
			if ( serviceFlag.equals( "S" ) )
			{
				retbpareas.deleteRow(k);
				k--;
				rCnt--;
			}
		} //end for
	}
	//Changes end here


	//Get the ErpCustomers for the BP
	EzcBussPartnerParams bparamsC = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparamsC = new EzcBussPartnerNKParams();
	bnkparamsC.setLanguage("EN");
	bparamsC.setBussPartner(Bus_Partner);
	bparamsC.setObject(bnkparamsC);
	Session.prepareParams(bparamsC);
	retcust = (ReturnObjFromRetrieve)BPManager.getBussPartnerErpCustomers(bparamsC);
	retcust.check();

	String remAreaFlag = "";
	if ( FUNCTION.equals("AG") )
	{
		remAreaFlag="VN";
	}
	else
	{
		remAreaFlag="AG";
	}

	retFinal=retcust;
}//end if

%>

