<%
	//String prodCodeImage	= (String)session.getAttribute("PRODCODE");
	String prodCodeImage	= request.getParameter("prod");
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve prodImagesObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query = "SELECT EPA_PRODUCT_CODE,EPA_ASSET_ID,EPA_IMAGE_TYPE,EPA_SCREEN_NAME,EZA_MIME_TYPE,EZA_LINK FROM EZC_PRODUCT_ASSETS,EZC_ASSETS WHERE EPA_ASSET_ID = EZA_ASSET_ID AND EPA_PRODUCT_CODE='6550005.020' AND EPA_IMAGE_TYPE='TN'";
	
	catalogParams.setQuery(query);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		prodImagesObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(prodImagesObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	//session.removeAttribute(prodCodeImage);
%> 