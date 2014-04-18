<%
	//String prodCodeInfo	= (String)session.getAttribute("PRODCODE");
	String prodCodeInfo	= request.getParameter("prod");
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve prodDimObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT EZP_PRODUCT_CODE,EZP_STYLE,EZP_SIZE,EZP_FINISH,EZP_LENGTH,EZP_LENGTH_UOM,EZP_WIDTH,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE ='"+prodCodeInfo+"'";
	
	catalogParams.setQuery(query);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		prodDimObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(prodDimObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	//session.removeAttribute(prodCodeInfo);
%> 