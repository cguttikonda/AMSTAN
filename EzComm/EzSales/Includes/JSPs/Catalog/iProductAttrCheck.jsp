<%
	EzcParams mainParamsMisc_AC= new EzcParams(false);
	EziMiscParams miscParams_AC = new EziMiscParams();

	ReturnObjFromRetrieve retObjMisc_AC = null;
	
	miscParams_AC.setIdenKey("MISC_SELECT");
	miscParams_AC.setQuery("SELECT EZP_PRODUCT_CODE,EPA_ATTR_CODE,EPA_ATTR_VALUE FROM EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES WHERE EZP_PRODUCT_CODE=EPA_PRODUCT_CODE AND EZP_PRODUCT_CODE = '"+attrProdCode+"'");

	mainParamsMisc_AC.setLocalStore("Y");
	mainParamsMisc_AC.setObject(miscParams_AC);
	Session.prepareParams(mainParamsMisc_AC);

	int attrRetCnt = 0;

	try
	{		
		retObjMisc_AC = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_AC);
	}
	catch(Exception e){}

	if(retObjMisc_AC!=null && retObjMisc_AC.getRowCount()>0)
	{	
		for(int ac=0;ac<retObjMisc_AC.getRowCount();ac++)
		{
			String attrCode = retObjMisc_AC.getFieldValueString(ac,"EPA_ATTR_CODE");
			
			if(attrVect.contains(attrCode))
			{
				attrRetCnt++;
			}			
		}
	}	
%>




