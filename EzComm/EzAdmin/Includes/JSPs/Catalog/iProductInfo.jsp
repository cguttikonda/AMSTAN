<%
	//String prodCodeInfo	= (String)session.getAttribute("PRODCODE");
	String prodCodeInfo	= request.getParameter("prod");
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve prodInfoObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT EZP_PRODUCT_CODE, EZP_TYPE,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND, EZP_FAMILY, EZP_MODEL,EZP_COLOR, EZP_CURR_PRICE,EZP_FUTURE_PRICE, EZP_CURR_EFF_DATE, EZP_FUTURE_EFF_DATE FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE ='"+prodCodeInfo+"'";
	
	catalogParams.setQuery(query);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		prodInfoObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(prodInfoObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	//session.removeAttribute(prodCodeInfo);
%> 