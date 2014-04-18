<%
	EzcParams catalogParamsMisc	= new EzcParams(false);
	EziMiscParams catalogParams	= new EziMiscParams();
	ReturnObjFromRetrieve productAttributesConObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query	= "SELECT EAC_ID,EAC_DESC FROM EZC_ATTRIBUTES_CONFIG";
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		productAttributesConObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(productAttributesConObj.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}

%> 
