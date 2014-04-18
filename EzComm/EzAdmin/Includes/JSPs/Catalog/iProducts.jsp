<%
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve productsObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT TOP 100 EZP_PRODUCT_CODE, EZP_TYPE, EZP_STATUS, EZP_WEB_SKU, EZP_UPC_CODE, EZP_BRAND, EZP_MODEL  FROM EZC_PRODUCTS";
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		productsObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(productsObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
%> 