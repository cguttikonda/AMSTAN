<%
	ReturnObjFromRetrieve retObjPlants = null;

	try
	{
		ezc.ezparam.EzcParams mainParams_RGA = new ezc.ezparam.EzcParams(false);
		EziMiscParams miscParams_RGA = new EziMiscParams();
		miscParams_RGA.setIdenKey("MISC_SELECT");
		String query_RGA = "SELECT VALUE1 PLANTCODE,VALUE2 PLANTNAME FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='RGAPLANTS'";
		miscParams_RGA.setQuery(query_RGA);
		mainParams_RGA.setLocalStore("Y");
		mainParams_RGA.setObject(miscParams_RGA);
		Session.prepareParams(mainParams_RGA);	

		retObjPlants = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_RGA);
	}
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("Exception while getting plant codes from DB ::::"+e,"I");
	}
	//out.println("retObjPlants::"+retObjPlants.toEzcString());
%>