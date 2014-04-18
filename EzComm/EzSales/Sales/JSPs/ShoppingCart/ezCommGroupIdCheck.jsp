

<%
	EzcParams mainParamsMisc_PA= new EzcParams(false);
	EziMiscParams miscParams_PA = new EziMiscParams();

	ReturnObjFromRetrieve retObjMisc_PA = null;
	int countMisc_PA=0;

	miscParams_PA.setIdenKey("MISC_SELECT");
	miscParams_PA.setQuery("SELECT * FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE = '"+prodCode+"'  AND EPA_ATTR_CODE='SAP_COMM_GROUP'");

	mainParamsMisc_PA.setLocalStore("Y");
	mainParamsMisc_PA.setObject(miscParams_PA);
	Session.prepareParams(mainParamsMisc_PA);

	String commGorupId_PA = "";

	try
	{		
		retObjMisc_PA = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_PA);
	}
	catch(Exception e){}

	if(retObjMisc_PA!=null && retObjMisc_PA.getRowCount()>0)
	{
		if("SAP_COMM_GROUP".equals(retObjMisc_PA.getFieldValueString(0,"EPA_ATTR_CODE")))
		{
			commGorupId_PA = retObjMisc_PA.getFieldValueString(0,"EPA_ATTR_VALUE");
		}

	}	
%>

