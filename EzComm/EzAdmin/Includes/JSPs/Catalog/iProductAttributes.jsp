<%
	//String prodCodeAttr	= (String)session.getAttribute("PRODCODE");
	String prodCodeAttr	= request.getParameter("prod");
	EzcParams catalogParamMisc= new EzcParams(false);
	EziMiscParams catalogParam = new EziMiscParams();
	ReturnObjFromRetrieve productAttributesObj = null;

	catalogParam.setIdenKey("MISC_SELECT");
	String query1	= "SELECT EPA_PRODUCT_CODE,EPA_ATTR_CODE,EPA_ATTR_VALUE,EAC_DESC FROM EZC_PRODUCT_ATTRIBUTES,EZC_ATTRIBUTES_CONFIG WHERE EPA_ATTR_CODE=EAC_ID AND EPA_PRODUCT_CODE= '"+prodCodeAttr+"'";
	
	catalogParam.setQuery(query1);

	catalogParamMisc.setLocalStore("Y");
	catalogParamMisc.setObject(catalogParam);
	Session.prepareParams(catalogParamMisc);	

	try
	{		
		productAttributesObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamMisc);
		//out.println(productAttributesObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	//session.removeAttribute(prodCodeAttr);
%> 
