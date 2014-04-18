<%	
	EzcParams mainParamsMisc_AID= new EzcParams(false);
	EziMiscParams miscParams_AID = new EziMiscParams();

	ReturnObjFromRetrieve retObjMisc_AID = null;

	miscParams_AID.setIdenKey("MISC_SELECT");
	miscParams_AID.setQuery("SELECT DISTINCT EPA_ATTR_VALUE,EPA_ATTR_CODE,EPA_PRODUCT_CODE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_ATTR_CODE = '"+attrRetVal+"' AND EPA_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE = '"+categoryID+"')");

	mainParamsMisc_AID.setLocalStore("Y");
	mainParamsMisc_AID.setObject(miscParams_AID);
	Session.prepareParams(mainParamsMisc_AID);

	try
	{		
		retObjMisc_AID = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_AID);
	}
	catch(Exception e){}				
%>




