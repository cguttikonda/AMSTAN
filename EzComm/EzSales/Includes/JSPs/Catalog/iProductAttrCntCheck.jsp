<%

	EzcParams mainParamsMisc_ACC= new EzcParams(false);
	EziMiscParams miscParams_ACC = new EziMiscParams();

	ReturnObjFromRetrieve retObjMisc_ACC = null;
	
	miscParams_ACC.setIdenKey("MISC_SELECT");
	miscParams_ACC.setQuery("SELECT EZP_PRODUCT_CODE,EPA_ATTR_CODE,EPA_ATTR_VALUE FROM EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES WHERE EZP_PRODUCT_CODE=EPA_PRODUCT_CODE AND EZP_PRODUCT_CODE = '"+attrRetCode+"'");

	mainParamsMisc_ACC.setLocalStore("Y");
	mainParamsMisc_ACC.setObject(miscParams_ACC);
	Session.prepareParams(mainParamsMisc_ACC);

	try
	{		
		retObjMisc_ACC = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_ACC);
	}
	catch(Exception e){}
	
	if(retObjMisc_ACC!=null && retObjMisc_ACC.getRowCount()>0)
	{	
		for(int acc=0;acc<retObjMisc_ACC.getRowCount();acc++)
		{
			String attrCode_ACC = retObjMisc_ACC.getFieldValueString(acc,"EPA_ATTR_CODE");
			
			if(attrAL_ACC.contains(attrCode_ACC))
			{
			
				if(attrHM.containsKey(attrCode_ACC))
				{					
					try{
						attrHM.put(attrCode_ACC,Double.parseDouble((String)attrHM.get(attrCode_ACC))+Double.parseDouble(attrCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					attrHM.put(attrCode_ACC,attrCnt);
				}
				
			}			
		}		
		
	}	
%>




