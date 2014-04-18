<%
	String parentCatId = request.getParameter("mainCatID");

	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve subCatalogsListObj = null;
	ReturnObjFromRetrieve categoryAssetsListObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	String query="SELECT EC_CODE SUB_CAT_ID,ECD_DESC SUB_CAT_DESC,ECD_TEXT LONG_TEXT,EC_PARENT PARENT_CAT_ID,(SELECT ECD_DESC FROM EZC_CATEGORY_DESCRIPTION WHERE ECD_CODE='"+parentCatId+"') PARENT_DESC,(SELECT ECD_TEXT FROM EZC_CATEGORY_DESCRIPTION WHERE ECD_CODE='"+parentCatId+"') PARENT_TEXT FROM EZC_CATEGORIES,EZC_CATEGORY_DESCRIPTION WHERE EC_CODE = ECD_CODE AND EC_PARENT='"+parentCatId+"'";
	String query2 = "SELECT ECA_CATEGORY_CODE,EZA_LINK FROM EZC_CATEGORY_ASSETS,EZC_ASSETS,EZC_CATEGORIES WHERE ECA_ASSET_ID=EZA_ASSET_ID and EC_CODE=ECA_CATEGORY_CODE and EC_PARENT='"+parentCatId+"'";
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{
		subCatalogsListObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(subCatalogsListObj.toEzcString());
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	catalogParams.setQuery(query2);
	
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{
		categoryAssetsListObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	
	//out.println("categoryAssetsListObj:::"+categoryAssetsListObj.toEzcString());
	
	ArrayList catImgAL = new ArrayList();
	HashMap catImgHM = new HashMap();
	if(categoryAssetsListObj!=null)
	{
		for(int l=0;l<categoryAssetsListObj.getRowCount();l++)
		{

			if(catImgAL.contains(categoryAssetsListObj.getFieldValueString(l,"ECA_CATEGORY_CODE")))
				continue;

			catImgHM.put(categoryAssetsListObj.getFieldValueString(l,"ECA_CATEGORY_CODE"),categoryAssetsListObj.getFieldValueString(l,"EZA_LINK"));
			catImgAL.add(categoryAssetsListObj.getFieldValueString(l,"ECA_CATEGORY_CODE"));


		}
	}
	
	//out.println("catImgHM:::"+catImgHM);
%>