<%
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve assetsObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT TOP 100 * FROM EZC_ASSETS";
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		assetsObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(assetsObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
%> 