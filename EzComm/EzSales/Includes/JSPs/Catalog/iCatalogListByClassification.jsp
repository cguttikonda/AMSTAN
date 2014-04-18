<%
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve catalogsListObj = null;
	String classType = request.getParameter("ctype");
	String myLabel = "Bath Suites";
	if ((classType == null) || (classType.equals(""))) {
		classType = "'S'";
	}
	if (classType.equals("'Q'")){ 
		myLabel = "Quick Ship";
	}	
	if (classType.equals("'C'")){
		myLabel = "Custom";
	}
	if (classType.equals("'K'")){
		myLabel = "Kitchen Collections";
	}
	if (classType.equals("'B'")){
		myLabel = "Bath Collections";
	}
	//out.println("Class type is "+classType);
	catalogParams.setIdenKey("MISC_SELECT");
	
	//String query="SELECT ECC_CATALOG_ID CATALOG_ID,ECC_CATEGORY_ID CATEGORY_ID,ECD_DESC CATEGORY_DESC,ECD_LANG LANGUAGE,ECD_TEXT LONG_TEXT,EC_STATUS STATUS,EC_VISIBLE VISIBILITY FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORY_DESCRIPTION ,EZC_CATEGORIES WHERE ECC_CATALOG_ID = '10010' AND ECC_CATEGORY_ID = ECD_CODE AND ECD_LANG = 'EN' AND EC_CODE = ECC_CATEGORY_ID";
	String query="SELECT EPCL_CODE CLASSIFICATION_ID,EPCL_TYPE TYPE, ECLD_DESC CLASSIFICATION_DESC,ECLD_LANG LANGUAGE,ECLD_TEXT LONG_TEXT,EPCL_STATUS STATUS,EPCL_VISIBLE VISIBILITY FROM EZC_CLASSIFICATION_DESCRIPTION ,EZC_PRODUCT_CLASSIFICATION WHERE EPCL_CODE = ECLD_CODE AND ECLD_LANG = 'EN' and EPCL_TYPE = "+classType+" and EPCL_VISIBLE = 'Y'";
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
	query="SELECT  EC_CODE SUB_CAT_ID,ECD_DESC SUB_CAT_DESC,EC_PARENT PARENT_CAT_ID FROM EZC_CATEGORIES,EZC_CATEGORY_DESCRIPTION WHERE EC_CODE = ECD_CODE";
	
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