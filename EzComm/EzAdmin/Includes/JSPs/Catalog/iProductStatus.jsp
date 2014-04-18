<%
	//String prodCodeStatus	= (String)session.getAttribute("PRODCODE");
	String prodCodeStatus	= request.getParameter("prod");
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve prodStatusObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT EZP_PRODUCT_CODE,EZP_FEATURED,EZP_STATUS,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_NEW_FROM,EZP_NEW_TO FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE ='"+prodCodeStatus+"'";
	
	catalogParams.setQuery(query);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		prodStatusObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(prodStatusObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	//session.removeAttribute(prodCodeStatus);
%> 