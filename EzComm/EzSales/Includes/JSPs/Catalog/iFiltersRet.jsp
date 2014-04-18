<%	
	
	String queryBrand = "",queryStyle="",queryFamily="",queryModel="",queryLength="",querySubType="";
	ReturnObjFromRetrieve catalogBrandRetObj   = null;
	ReturnObjFromRetrieve catalogStyleRetObj   = null;
	ReturnObjFromRetrieve catalogFamilyRetObj  = null;
	ReturnObjFromRetrieve catalogModelRetObj   = null;
	ReturnObjFromRetrieve catalogLengthRetObj  = null;
	ReturnObjFromRetrieve catalogSubTypeRetObj = null;	
	
	if ( categoryID != null && !"null".equals(categoryID))
	{
		queryBrand   =  "SELECT DISTINCT(EZP_BRAND)    	BRANDS FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE = '"+categoryID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_BRAND <> 'TBD'";	
		queryStyle   =  "SELECT DISTINCT(EZP_STYLE)    	STYLES FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE = '"+categoryID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_STYLE <> 'TBD'";	
		queryFamily  =  "SELECT DISTINCT(EZP_FAMILY)   	FAMILY FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE = '"+categoryID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_FAMILY <> 'TBD'";	
		queryModel   =  "SELECT DISTINCT(EZP_MODEL)    	MODEL FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE = '"+categoryID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_MODEL <> 'TBD'";	
		queryLength  =  "SELECT DISTINCT(EZP_LENGTH)   	LENGTH FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE = '"+categoryID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_LENGTH <> 'TBD'";	
		querySubType =  "SELECT DISTINCT(EZP_SUB_TYPE) 	SUBTYPE FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE = '"+categoryID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_SUB_TYPE <> 'TBD'";	
	}
	else if ( classificationID != null && !"null".equals(classificationID))
	{
		queryBrand   =  "SELECT DISTINCT(EZP_BRAND) 	BRANDS FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CLASSIFICATION_PRODUCTS WHERE ECP_CLASSIFICATION_CODE = '"+classificationID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_BRAND <> 'TBD'";
		queryStyle   =  "SELECT DISTINCT(EZP_STYLE) 	STYLES FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CLASSIFICATION_PRODUCTS WHERE ECP_CLASSIFICATION_CODE = '"+classificationID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_STYLE <> 'TBD'";
		queryFamily  =  "SELECT DISTINCT(EZP_FAMILY) 	FAMILY FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CLASSIFICATION_PRODUCTS WHERE ECP_CLASSIFICATION_CODE = '"+classificationID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_FAMILY <> 'TBD'";
		queryModel   =  "SELECT DISTINCT(EZP_MODEL) 	MODEL FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CLASSIFICATION_PRODUCTS WHERE ECP_CLASSIFICATION_CODE = '"+classificationID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_MODEL <> 'TBD'";
		queryLength  =  "SELECT DISTINCT(EZP_LENGTH) 	LENGTH FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CLASSIFICATION_PRODUCTS WHERE ECP_CLASSIFICATION_CODE = '"+classificationID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_LENGTH <> 'TBD'";
		querySubType =  "SELECT DISTINCT(EZP_SUB_TYPE)  SUBTYPE FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CLASSIFICATION_PRODUCTS WHERE ECP_CLASSIFICATION_CODE = '"+classificationID+"') AND EZP_STATUS NOT IN  ('Z2','Z3') AND EZP_SUB_TYPE <> 'TBD'";
	}

	/*******BRAND******/
	
	catalogParams.setIdenKey("MISC_SELECT");	
	catalogParams.setQuery(queryBrand);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);
	try { catalogBrandRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc); }	
	catch(Exception e){}
	
	/*******BRAND******/
	
	/*******STYLES******/
	
	catalogParams.setQuery(queryStyle);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);
	try { catalogStyleRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc); }	
	catch(Exception e){}
	
	/*******STYLES******/

	/*******FAMILY******/

	catalogParams.setQuery(queryFamily);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	
	try { catalogFamilyRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc); }	
	catch(Exception e){}
	
	/*******FAMILY******/
	
	/*******MODEL******/

	catalogParams.setQuery(queryModel);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	
	try { catalogModelRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc); }	
	catch(Exception e){}
	
	/*******MODEL******/
	
	/*******LENGTH******/

	catalogParams.setQuery(queryLength);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	
	try { catalogLengthRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc); }	
	catch(Exception e){}
	
	/*******LENGTH******/
	
	/*******SUBTYPE******/

	catalogParams.setQuery(querySubType);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	
	try { catalogSubTypeRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc); }	
	catch(Exception e){}
	
	/*******SUBTYPE******/
	
%>