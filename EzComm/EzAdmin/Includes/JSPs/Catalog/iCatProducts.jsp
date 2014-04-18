<%
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve catProductObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT TOP 100 * FROM EZC_CATEGORY_PRODUCTS";
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		catProductObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(catProductObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
%> 