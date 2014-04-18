<%
	String ordCatType = request.getParameter("orderNeed");
	
	String dxvOrGeneral = request.getParameter("dxvOrGeneral");
	
	if(dxvOrGeneral==null || "null".equalsIgnoreCase(dxvOrGeneral) || "".equals(dxvOrGeneral)) dxvOrGeneral = "GENERAL";

	if(ordCatType==null || "null".equalsIgnoreCase(ordCatType) || "".equals(ordCatType)) ordCatType = "PT";

	String catalogCode = (String)session.getValue("CatalogCode");

	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve catalogsListObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT ECC_CATALOG_ID CATALOG_ID,ECC_CATEGORY_ID CATEGORY_ID,ECD_DESC CATEGORY_DESC,ECD_LANG LANGUAGE,ECD_TEXT LONG_TEXT,EC_STATUS STATUS,EC_VISIBLE VISIBILITY FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORY_DESCRIPTION ,EZC_CATEGORIES WHERE ECC_CATALOG_ID IN ('"+catalogCode+"') AND ECC_CATEGORY_ID = ECD_CODE AND ECD_LANG = 'EN' AND EC_CODE = ECC_CATEGORY_ID";
	if (dxvOrGeneral.equalsIgnoreCase("GENERAL")){
		// EC_CODE not like DXV
		query="SELECT ECC_CATALOG_ID CATALOG_ID,ECC_CATEGORY_ID CATEGORY_ID,ECD_DESC CATEGORY_DESC,ECD_LANG LANGUAGE,ECD_TEXT LONG_TEXT,EC_STATUS STATUS,EC_VISIBLE VISIBILITY FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORY_DESCRIPTION ,EZC_CATEGORIES WHERE ECC_CATALOG_ID IN ('"+catalogCode+"') AND ECC_CATEGORY_ID = ECD_CODE AND ECD_LANG = 'EN' AND EC_CODE = ECC_CATEGORY_ID and EC_CODE not like 'DXV%'";
	} else {
		// EC_CODE like DXV
	 	query="SELECT ECC_CATALOG_ID CATALOG_ID,ECC_CATEGORY_ID CATEGORY_ID,ECD_DESC CATEGORY_DESC,ECD_LANG LANGUAGE,ECD_TEXT LONG_TEXT,EC_STATUS STATUS,EC_VISIBLE VISIBILITY FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORY_DESCRIPTION ,EZC_CATEGORIES WHERE ECC_CATALOG_ID IN ('"+catalogCode+"') AND ECC_CATEGORY_ID = ECD_CODE AND ECD_LANG = 'EN' AND EC_CODE = ECC_CATEGORY_ID  and EC_CODE like 'DXV%'";
	}
	//String query="SELECT  EC_CODE,ECD_DESC,EC_PARENT FROM EZC_CATEGORIES,EZC_CATEGORY_DESCRIPTION WHERE EC_PARENT = 'BATHFAUCACCESORIES' AND EC_CODE = ECD_CODE";
	//String query="select ECP_CATEGORY_CODE,ECP_PRODUCT_CODE,EZP_BRAND from EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS WHERE ECP_CATEGORY_CODE = 'BATHFAUCETS' AND ECP_PRODUCT_CODE = EZP_PRODUCT_CODE";
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		catalogsListObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(catalogsListObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}




	catalogParamsMisc= new EzcParams(false);
	catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve subCatalogsListObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	if (dxvOrGeneral.equalsIgnoreCase("GENERAL")){
		query="SELECT  EC_CODE SUB_CAT_ID,ECD_DESC SUB_CAT_DESC,EC_PARENT PARENT_CAT_ID FROM EZC_CATEGORIES,EZC_CATEGORY_DESCRIPTION WHERE EC_CODE = ECD_CODE and EC_CODE not like 'DXV%'";
	}else {
		// search for category codes starting with DXV only
		query="SELECT  EC_CODE SUB_CAT_ID,ECD_DESC SUB_CAT_DESC,EC_PARENT PARENT_CAT_ID FROM EZC_CATEGORIES,EZC_CATEGORY_DESCRIPTION WHERE EC_CODE = ECD_CODE and EC_CODE like 'DXV%'";
	}
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		subCatalogsListObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(subCatalogsListObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}



%> 