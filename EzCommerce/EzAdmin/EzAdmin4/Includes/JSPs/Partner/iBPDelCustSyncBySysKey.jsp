<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="session"></jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<%
	String FUNCTION = request.getParameter("FUNCTION");
	if (FUNCTION == null)
		FUNCTION="AG";
	FUNCTION = FUNCTION.trim();

	String cTitle = (FUNCTION.equals("AG"))?"Customer":"Vendor";
	String cFlag = (FUNCTION.equals("AG"))?"C":"V";
	String cDesc = (FUNCTION.equals("AG"))?"Sold To":"Pay To";

	ReturnObjFromRetrieve retdel = null;
	ReturnObjFromRetrieve retFinal = null;
	ReturnObjFromRetrieve retbpareas = null;
	ReturnObjFromRetrieve retcust = null;

	String Bus_Partner = null;
	String CatalogNumber = null;
	int ezcCustCount = 0;
	int retCatRows = 0;

	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
	bnkparams.setLanguage("EN");
	bparams.setObject(bnkparams);
	Session.prepareParams(bparams);
	retdel =(ReturnObjFromRetrieve) BPManager.getBussPartners(bparams);
	retdel.check();
	int numBPs=0;
	if(ret1!=null)
	 	numBPs = retdel.getRowCount();
	if(numBPs > 0)
	{
		Bus_Partner = request.getParameter("BusinessPartner");
		/*if (Bus_Partner == null)
		{
			Bus_Partner = (retdel.getFieldValue(0,BP_NUMBER)).toString();
		}*/

		//Get the ErpCustomers for the BP
		if(Bus_Partner!=null && !"sel".equals(Bus_Partner))
		{
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
		}
	}//end if
%>

