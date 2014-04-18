<%
	String categoryID = request.getParameter("categoryID");
	String classificationID = request.getParameter("classificationID");
	
	ArrayList attrValuesALSesGet = new ArrayList();		
	attrValuesALSesGet = (ArrayList)session.getValue("attrValuesALSes");
		

	String catType = request.getParameter("catType");

	if(catType==null || "null".equalsIgnoreCase(catType) || "".equals(catType)) catType = "PT";

	//out.println(":::categoryID:::"+categoryID);

	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();
	
	%><%@include file="iFiltersRet.jsp"%><%
	
	ReturnObjFromRetrieve categoryAssetsListObj = null;
	ReturnObjFromRetrieve categoryDetailsObj = null;
	String query = "",query2="",query3="",queryProd="";
	catalogParams.setIdenKey("MISC_SELECT");
	if ( categoryID != null && !"null".equals(categoryID)){
		query2 = "select eca_category_code, eca_asset_id, eca_image_type , eza_link , eza_mime_type "+
					 "from ezc_category_assets join EZC_ASSETS "+
					 " on EZA_ASSET_ID = eca_asset_id "+
			" where eca_category_code = '"+categoryID+"'";
		query3 = "select ECD_TEXT, ECD_DESC from EZC_CATEGORY_DESCRIPTION where ECD_LANG = 'EN' and ECD_CODE = '"+categoryID+"'";
	};
		
	
	catalogParams.setQuery(query2);
		
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{
		//out.println("Hello ...."+parentCatId);
		categoryAssetsListObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);

		//out.println(categoryAssetsListObj.toEzcString());
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	
	catalogParams.setQuery(query3);
			
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{
		//out.println("Hello ...."+parentCatId);
		categoryDetailsObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);

		//out.println(categoryDetailsObj.toEzcString());
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
		
	

	catalogParamsMisc= new EzcParams(false);
	catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve catalogAttributesRetObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	if ( categoryID != null && !"null".equals(categoryID))
		query="SELECT ECAS_CATEGORY_CODE,EASA_SET_ID,EASA_ATTR_ID,EAC_ID,EAC_DESC,EAC_FILTERABLE FROM EZC_CAT_ATTR_SET,EZC_ATTRIBUTE_SET_ATTR,EZC_ATTRIBUTES_CONFIG WHERE ECAS_ATTR_SET=EASA_SET_ID AND EASA_ATTR_ID=EAC_ID AND ECAS_CATEGORY_CODE='"+categoryID+"' AND EASA_ATTR_ID IN (SELECT EPA_ATTR_CODE FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND ECP_CATEGORY_CODE = '"+categoryID+"' AND ECP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS,EZC_PRODUCT_ATTRIBUTES AT,EZC_ASSETS,EZC_PRODUCT_ASSETS PA  WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND AT.EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE = PA.EPA_PRODUCT_CODE AND EPA_ASSET_ID=EZA_ASSET_ID AND  EPA_IMAGE_TYPE='TN' AND ECP_CATEGORY_CODE = '"+categoryID+"' AND EPA_ATTR_CODE='DCH_STATUS' AND  EPA_ATTR_VALUE NOT IN ('Z2','Z3') AND EPD_LANG_CODE= 'EN' AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE "+filterQryStr+"))";
	if ( classificationID != null && !"null".equals(classificationID))
		query="SELECT ECAS_CATEGORY_CODE,EASA_SET_ID,EASA_ATTR_ID,EAC_ID,EAC_DESC,EAC_FILTERABLE FROM EZC_CAT_ATTR_SET,EZC_ATTRIBUTE_SET_ATTR,EZC_ATTRIBUTES_CONFIG WHERE ECAS_ATTR_SET=EASA_SET_ID AND EASA_ATTR_ID=EAC_ID AND ECAS_CATEGORY_CODE='"+categoryID+"' AND EASA_ATTR_ID IN (SELECT EPA_ATTR_CODE FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND ECP_CATEGORY_CODE = '"+categoryID+"' AND ECP_PRODUCT_CODE IN (SELECT ECP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS,EZC_PRODUCT_ATTRIBUTES AT,EZC_ASSETS,EZC_PRODUCT_ASSETS PA  WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND AT.EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE = PA.EPA_PRODUCT_CODE AND EPA_ASSET_ID=EZA_ASSET_ID AND  EPA_IMAGE_TYPE='TN' AND ECP_CATEGORY_CODE = '"+categoryID+"' AND EPA_ATTR_CODE='DCH_STATUS' AND  EPA_ATTR_VALUE NOT IN ('Z2','Z3') AND EPD_LANG_CODE= 'EN' AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE "+filterQryStr+"))";
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		catalogAttributesRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(catalogStylesRetObj.toEzcString());
	}
	catch(Exception e)
	{
		//out.println("Exception in Getting Data"+e);
	}

// ADDED TO GET CLASSIFICATION AND ITS DESCRIPTION 
	String classDesc = request.getParameter("classDesc");

	catalogParamsMisc= new EzcParams(false);
	catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve productsCntRetObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	if ( categoryID != null && !"null".equals(categoryID))
	query="SELECT  ECP_CATEGORY_CODE,EZP_PRODUCT_CODE,EPA_ATTR_VALUE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE, EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR, EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM, EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE, EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2, EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5,(Select TOP 1 EZA_LINK from EZC_ASSETS,EZC_PRODUCT_ASSETS  where EPA_ASSET_ID=EZA_ASSET_ID AND  EPA_IMAGE_TYPE='TN' and  EZP_PRODUCT_CODE = EPA_PRODUCT_CODE) EZA_LINK  FROM EZC_CATEGORY_PRODUCTS, EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS,EZC_PRODUCT_ATTRIBUTES WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_PRODUCT_CODE = EZP_PRODUCT_CODE  AND ECP_CATEGORY_CODE = '"+categoryID+"' AND EPA_ATTR_CODE='DCH_STATUS' AND  EPA_ATTR_VALUE NOT IN ('Z2','Z3') AND EPD_LANG_CODE= 'EN'  AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE  ORDER BY EZA_LINK desc "; //"+filterQryStr+" 
	if ( classificationID != null && !"null".equals(classificationID))
	query="SELECT  ECP_CLASSIFICATION_CODE,EZP_PRODUCT_CODE,EPA_ATTR_VALUE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5,(Select TOP 1 EZA_LINK from EZC_ASSETS,EZC_PRODUCT_ASSETS  where EPA_ASSET_ID=EZA_ASSET_ID AND  EPA_IMAGE_TYPE='TN' and  EZP_PRODUCT_CODE = EPA_PRODUCT_CODE) EZA_LINK FROM EZC_CLASSIFICATION_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS,EZC_PRODUCT_ATTRIBUTES  WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND  ECP_CLASSIFICATION_CODE = '"+classificationID+"' AND EPA_ATTR_CODE='DCH_STATUS' AND  EPA_ATTR_VALUE NOT IN ('Z2','Z3') AND EPD_LANG_CODE= 'EN'  AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE ORDER BY EZA_LINK desc "; //"+filterQryStr+" 
	catalogParams.setQuery(query);
//out.println(query);
	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	int itemsCnt = 0;

	try
	{		
		productsCntRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(productsCntRetObj.toEzcString());
		itemsCnt = productsCntRetObj.getRowCount();
	}
	catch(Exception e)
	{
		//out.println("Exception in Getting Data"+e);
	}

	int pageSize = 9;

	try
	{
		if(request.getParameter("pageSize") != null)
		{
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}
		else
		{
			pageSize = 9;
		}
	}
	catch(Exception ex)
	{
		pageSize = 9;
	}

	int pageNum_T = 1;
	int pageMaxNo = pageSize;

	try
	{
		if(request.getParameter("pageNum") != null)
		{
			pageNum_T = Integer.parseInt(request.getParameter("pageNum"));
		}
		else
		{
			pageNum_T = 1;
		}
	}
	catch(Exception ex) 
	{
		pageNum_T = 1;
	}

	pageMaxNo = pageNum_T*pageSize;
	
	
	catalogParamsMisc= new EzcParams(false);
	catalogParams = new EziMiscParams();
	ReturnObjFromRetrieve catalogProductsRetObj = null;

	catalogParams.setIdenKey("MISC_SELECT");
	if ( categoryID != null && !"null".equals(categoryID))
	query="SELECT * FROM (SELECT TOP "+itemsCnt+" * FROM (SELECT TOP "+itemsCnt+" ECP_CATEGORY_CODE,EZP_PRODUCT_CODE,EPA_ATTR_VALUE, EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND, EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME, EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED, EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3, EZP_ATTR4,EZP_ATTR5,(Select TOP 1 EZA_LINK from EZC_ASSETS,EZC_PRODUCT_ASSETS  where EPA_ASSET_ID=EZA_ASSET_ID AND  EPA_IMAGE_TYPE='TN' and  EZP_PRODUCT_CODE = EPA_PRODUCT_CODE) EZA_LINK  FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS,EZC_PRODUCT_ATTRIBUTES  WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND ECP_CATEGORY_CODE = '"+categoryID+"'   AND EPA_ATTR_CODE='DCH_STATUS' AND  EPA_ATTR_VALUE NOT IN ('Z2','Z3') AND EPD_LANG_CODE= 'EN' AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE  "+filterQryStr+" ORDER BY PROD_DESC ASC) AS NEWTBL1 ORDER BY PROD_DESC DESC) AS NEWTBL2 ORDER BY EZA_LINK desc";
	if ( classificationID != null && !"null".equals(classificationID))
	query="SELECT * FROM (SELECT TOP "+itemsCnt+" * FROM (SELECT TOP "+itemsCnt+" ECP_CLASSIFICATION_CODE, EZP_PRODUCT_CODE,EPA_ATTR_VALUE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU, EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE, EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM, EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED, EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3, EZP_ATTR4,EZP_ATTR5,(Select TOP 1 EZA_LINK from EZC_ASSETS,EZC_PRODUCT_ASSETS  where EPA_ASSET_ID=EZA_ASSET_ID AND  EPA_IMAGE_TYPE='TN' and  EZP_PRODUCT_CODE = EPA_PRODUCT_CODE) EZA_LINK FROM EZC_CLASSIFICATION_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS, EZC_PRODUCT_ATTRIBUTES WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND  EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND   ECP_CLASSIFICATION_CODE = '"+classificationID+"' AND EPA_ATTR_CODE='DCH_STATUS' AND  EPA_ATTR_VALUE NOT IN ('Z2','Z3') AND EPD_LANG_CODE= 'EN' AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE  "+filterQryStr+" ORDER BY PROD_DESC ASC) AS NEWTBL1 ORDER BY PROD_DESC DESC) AS NEWTBL2 ORDER BY EZA_LINK desc";
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		catalogProductsRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
		//out.println(catalogProductsRetObj.toEzcString());

	}
	catch(Exception e)
	{
		//out.println("Exception in Getting Data"+e);
	}
	/*****Added To Display the Category Products from Header dropdown Start********/
	if(catalogProductsRetObj.getRowCount()==0)
	{
		String fromHeader = request.getParameter("catIte");
		if(fromHeader!=null && !"null".equals(fromHeader))
		{
			catalogParamsMisc= new EzcParams(false);
			catalogParams = new EziMiscParams();
			catalogParams.setIdenKey("MISC_SELECT");
			query="SELECT * FROM (SELECT TOP "+pageSize+" * FROM (SELECT TOP "+pageMaxNo+" SELECT  ECP_CATEGORY_CODE,EZP_PRODUCT_CODE,EPA_ATTR_VALUE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5,EZA_LINK FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS,EZC_PRODUCT_ATTRIBUTES AT,EZC_ASSETS,EZC_PRODUCT_ASSETS PA  WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND AT.EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE = PA.EPA_PRODUCT_CODE AND EPA_ASSET_ID=EZA_ASSET_ID AND  EPA_IMAGE_TYPE='TN' AND ECP_CATEGORY_CODE = '"+fromHeader+"' AND EPA_ATTR_CODE='DCH_STATUS' AND  EPA_ATTR_VALUE NOT IN ('Z2','Z3') AND EPD_LANG_CODE= 'EN' AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE "+filterQryStr+" ORDER BY PROD_DESC ASC) AS NEWTBL1 ORDER BY PROD_DESC DESC) AS NEWTBL2 ORDER BY PROD_DESC ASC";
			catalogParams.setQuery(query);

			catalogParamsMisc.setLocalStore("Y");
			catalogParamsMisc.setObject(catalogParams);
			Session.prepareParams(catalogParamsMisc);	

			try
			{		
				catalogProductsRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
				//out.println(catalogProductsRetObj.toEzcString());

			}
			catch(Exception e)
			{
				//out.println("Exception in Getting Data"+e);
			}		
		}
	}
	/*****Added To Display the Category Products from Header dropdown End********/	
		
	
	if(attrVectFil.size()>0 && attrValuesALSesGet.size()>0 && productsCntRetObj!=null) 
	{
		for(int f=productsCntRetObj.getRowCount()-1;f>=0;f--)
		{
			boolean removeProduct = true;
			int filCntC=0;
			String attrProdDelC = productsCntRetObj.getFieldValueString(f,"EZP_PRODUCT_CODE");

			for(int i=0;i<attrValuesALSesGet.size();i++)
			{	

				String attrVectFilStrC = (String)attrValuesALSesGet.get(i);
				String attrVectFilSplitC[] = attrVectFilStrC.split("¥");
				
				if(attrProdDelC.equals(attrVectFilSplitC[1]))
				{
					//out.println(""+attrProdDelC+":::"+attrVectFil+"::::"+attrVectFilSplitC[0]+":::"+attrVectFil.contains(attrVectFilSplitC[0]));
					if(attrVectFil.contains(attrVectFilSplitC[0]))
					{
						removeProduct = false;
						break; //filCntC++
					}	
				
				}
				
			}
			//out.println("attrVectFil::::"+attrVectFil.size()+"cnt::::"+filCntC+"mat:::"+attrProdDelC);

			//if(attrVectFil.size()!=filCntC)
			if(removeProduct)
				productsCntRetObj.deleteRow(f);			

		}
	}
	
	//out.println(productsCntRetObj.toEzcString());
	
	if(attrVectFil.size()>0 && attrValuesALSesGet.size()>0 && catalogProductsRetObj!=null) 
	{
		for(int f=catalogProductsRetObj.getRowCount()-1;f>=0;f--)
		{
			boolean removeProduct = true;
			int filCnt=0;
			String attrProdDel = catalogProductsRetObj.getFieldValueString(f,"EZP_PRODUCT_CODE");
			
			for(int i=0;i<attrValuesALSesGet.size();i++)
			{	

				String attrVectFilStr = (String)attrValuesALSesGet.get(i);
				String attrVectFilSplit[] = attrVectFilStr.split("¥");

				if(attrProdDel.equals(attrVectFilSplit[1]))
				{
					//out.println(""+attrProdDel+""+attrVectFil+""+attrVectFilSplit[0]);
					if(attrVectFil.contains(attrVectFilSplit[0]))
					{
						removeProduct = false;
						break; //filCnt++
					}	

				}
							
			}
			//if(attrVectFil.size()!=filCnt)
			if(removeProduct)
				catalogProductsRetObj.deleteRow(f);			
		}
	}


	HashMap brandsHM  = new HashMap();
	HashMap styleHM   = new HashMap();
	HashMap familyHM  = new HashMap();
	HashMap modelHM   = new HashMap();
	HashMap lengthHM  = new HashMap();
	HashMap subtypeHM = new HashMap();
	HashMap statusHM  = new HashMap();
	HashMap attrHM    = new HashMap();
	
	ArrayList brandAL  = new ArrayList();
	ArrayList styleAL  = new ArrayList();
	ArrayList familyAL = new ArrayList();
	ArrayList modelAL   = new ArrayList();
	ArrayList lengthAL  = new ArrayList();
	ArrayList subtypeAL = new ArrayList();
	
	String brandCnt  ="1";
	String styleCnt  ="1";
	String familyCnt ="1";
	String modelCnt  ="1";
	String lengthCnt ="1";
	String subtypeCnt="1";
	String statusCnt ="1";
	String attrCnt   ="1";
	
	if(productsCntRetObj!=null && productsCntRetObj.getRowCount()>0 )
	{
		for(int c=0;c<productsCntRetObj.getRowCount();c++)
		{
			String brandsHMRet   = productsCntRetObj.getFieldValueString(c,"EZP_BRAND");	
			String stylesHMRet   = productsCntRetObj.getFieldValueString(c,"EZP_STYLE");	
			String familysHMRet  = productsCntRetObj.getFieldValueString(c,"EZP_FAMILY");	
			String modelsHMRet   = productsCntRetObj.getFieldValueString(c,"EZP_MODEL");	
			String lengthsHMRet  = productsCntRetObj.getFieldValueString(c,"EZP_LENGTH");	
			String subtypesHMRet = productsCntRetObj.getFieldValueString(c,"EZP_SUB_TYPE");
			String statusHMRet   = productsCntRetObj.getFieldValueString(c,"EPA_ATTR_VALUE");
			String attrRetCode   = productsCntRetObj.getFieldValueString(c,"EZP_PRODUCT_CODE");
			
			brandAL.add(brandsHMRet);
			styleAL.add(stylesHMRet);
			familyAL.add(familysHMRet);

			modelAL.add(modelsHMRet);
			lengthAL.add(lengthsHMRet);
			subtypeAL.add(subtypesHMRet);
			
			
			if(brandsHMRet!=null && !"null".equals(brandsHMRet) && !"".equals(brandsHMRet))
			{				
				if(brandsHM.containsKey(brandsHMRet))
				{					
					try{
						brandsHM.put(brandsHMRet,Double.parseDouble((String)brandsHM.get(brandsHMRet))+Double.parseDouble(brandCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					brandsHM.put(brandsHMRet,brandCnt);
				}				
			}
			
			if(stylesHMRet!=null && !"null".equals(stylesHMRet) && !"".equals(stylesHMRet))
			{				
				if(styleHM.containsKey(stylesHMRet))
				{					
					try{
						styleHM.put(stylesHMRet,Double.parseDouble((String)styleHM.get(stylesHMRet))+Double.parseDouble(styleCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					styleHM.put(stylesHMRet,styleCnt);
				}				
			}
			
			if(familysHMRet!=null && !"null".equals(familysHMRet) && !"".equals(familysHMRet))
			{				
				if(familyHM.containsKey(familysHMRet))
				{					
					try{
						familyHM.put(familysHMRet,Double.parseDouble((String)familyHM.get(familysHMRet))+Double.parseDouble(familyCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					familyHM.put(familysHMRet,familyCnt);
				}				
			}
			
			if(modelsHMRet!=null && !"null".equals(modelsHMRet) && !"".equals(modelsHMRet))
			{				
				if(modelHM.containsKey(modelsHMRet))
				{					
					try{
						modelHM.put(modelsHMRet,Double.parseDouble((String)modelHM.get(modelsHMRet))+Double.parseDouble(modelCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					modelHM.put(modelsHMRet,modelCnt);
				}				
			}
			
			if(lengthsHMRet!=null && !"null".equals(lengthsHMRet) && !"".equals(lengthsHMRet))
			{				
				if(lengthHM.containsKey(lengthsHMRet))
				{					
					try{
						lengthHM.put(lengthsHMRet,Double.parseDouble((String)lengthHM.get(lengthsHMRet))+Double.parseDouble(lengthCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					lengthHM.put(lengthsHMRet,lengthCnt);
				}				
			}
			
			if(subtypesHMRet!=null && !"null".equals(subtypesHMRet) && !"".equals(subtypesHMRet))
			{				
				if(subtypeHM.containsKey(subtypesHMRet))
				{					
					try{
						subtypeHM.put(subtypesHMRet,Double.parseDouble((String)subtypeHM.get(subtypesHMRet))+Double.parseDouble(subtypeCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					subtypeHM.put(subtypesHMRet,subtypeCnt);
				}				
			}	
			
			
			
			/*if(attrRetCode!=null && !"null".equals(attrRetCode) && !"".equals(attrRetCode))
			{	
%>			
			<%@include file="iProductAttrCntCheck.jsp"%>
<%								
			}*/
						

			if("Z3".equals(statusHMRet) || "Z2".equals(statusHMRet) || "Z4".equals(statusHMRet)) 
			{

				if(statusHM.containsKey("Discontinued"))
				{					
					try{
						statusHM.put("Discontinued",Double.parseDouble((String)statusHM.get("Discontinued"))+Double.parseDouble(statusCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					statusHM.put("Discontinued",statusCnt);
				}

			}
			else if("ZF".equals(statusHMRet)) 
			{

				if(statusHM.containsKey("To Be Discontinued"))
				{					
					try{
						statusHM.put("To Be Discontinued",Double.parseDouble((String)statusHM.get("To Be Discontinued"))+Double.parseDouble(statusCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					statusHM.put("To Be Discontinued",statusCnt);
				}

			}
			else if("11".equals(statusHMRet)) 
			{

				if(statusHM.containsKey("New"))
				{					
					try{
						statusHM.put("New",Double.parseDouble((String)statusHM.get("New"))+Double.parseDouble(statusCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					statusHM.put("New",statusCnt);
				}

			}			
			else if(statusHMRet!=null && !"NULL".equals(statusHMRet))
			{				
				if(statusHM.containsKey("Active"))
				{					
					try{
						statusHM.put("Active",Double.parseDouble((String)statusHM.get("Active"))+Double.parseDouble(statusCnt)+"");
					}catch(Exception e){
					}										
				}
				else
				{					
					statusHM.put("Active",statusCnt);
				}					
			}															
		}
	}
	//out.println("statusHM:::"+statusHM);
	//out.println("catalogProductsRetObj:::"+catalogProductsRetObj.getRowCount());
	//out.println("productsCntRetObj:::"+productsCntRetObj.getRowCount());

	
%>