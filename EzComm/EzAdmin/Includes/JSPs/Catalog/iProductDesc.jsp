<%
	//String prodCodeDesc	= (String )session.getAttribute("PRODCODE");
	String prodCodeDesc	= request.getParameter("prod");
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve prodDescObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query	= "SELECT EPD_PRODUCT_CODE,EPD_LANG_CODE,EPD_PRODUCT_DESC,EPD_PRODUCT_DETAILS,EPD_PRODUCT_PROP1,EPD_PRODUCT_PROP2,EPD_PRODUCT_PROP3 FROM EZC_PRODUCT_DESCRIPTIONS WHERE EPD_PRODUCT_CODE ='"+prodCodeDesc+"'";
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		prodDescObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(prodDescObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	//session.removeAttribute(prodCodeDesc);
%> 
