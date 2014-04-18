<%
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve categoryAssetsObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT TOP 100 * FROM EZC_CATEGORY_ASSETS";
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		categoryAssetsObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(categoryAssetsObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
%> 