<%


	
	if(catgId!=null && !catgId.equals("null"))
	{
		miscParams1.setIdenKey("MISC_SELECT");
		miscParams1.setQuery("SELECT * FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE ='"+catgId+"' ");
		mainParams1.setLocalStore("Y");
		mainParams1.setObject(miscParams1);
		Session.prepareParams(mainParams1);
		try
		{		
			retProdsList = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams1);

		}
		catch(Exception e)
		{}
	}
	
	if(retProdsList!=null && retProdsList.getRowCount() > 0)cntretProdsList =  retProdsList.getRowCount();		
			

%>
