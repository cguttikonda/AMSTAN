<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*,ezc.ezcnetconnector.params.*" %>


<%
	
	int retObjcount = 0;
	int itemsCnt_F = 0;
	int pageNum_F = 1;
	int pageSize_F = 18;
	int pageMaxNo_F = 0;
	
	
	String favGroup = (String)session.getValue("USR_FAV_GRP");
	String favGrpDesc = (String)session.getValue("USR_FAV_DESC");
	
	
	String noDataStatement ="No Data to Display"; 
	String tempPROIDs = "";

	ReturnObjFromRetrieve prodDetailsRetObj_F = null;
	ReturnObjFromRetrieve catalogProductsRetObj_F = null;
	EzCatalogParams ezcpparams = null;
	EzCustomerItemCatParams cnetParams=null;
	

	ezcpparams=new ezc.ezparam.EzCatalogParams();
	cnetParams=new EzCustomerItemCatParams();

	EzCatalogParams ezread = new EzCatalogParams();
	ezread.setLanguage("EN");
	ezread.setProductGroup(favGroup);
	Session.prepareParams(ezread);

	ReturnObjFromRetrieve gbRet = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
	ReturnObjFromRetrieve cnetRet = (ReturnObjFromRetrieve)gbRet.getObject("CNETRET");
					//out.println("cnetRet>>>>"+cnetRet.toEzcString());


	if(cnetRet!=null && cnetRet.getRowCount()>0)
	{
		String tempPrd="";
		for(int a=0;a<cnetRet.getRowCount();a++)
		{
			String prds = cnetRet.getFieldValueString(a,"EPF_MAT_NO");
			if(a==0)
				tempPrd=prds;
			else
				tempPrd=tempPrd+"','"+prds;
		}	

		ezc.ezcommon.EzLog4j.log("retObj>>>>STatr","D");
		EzcParams prodParamsMisc = new EzcParams(false);
		EziMiscParams prodParams = new EziMiscParams();

		prodParams.setIdenKey("MISC_SELECT");
		String query="SELECT EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU, EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH, EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM, EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE, EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM, EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5,(SELECT TOP 1 EZA_LINK FROM EZC_ASSETS,EZC_PRODUCT_ASSETS WHERE EPA_PRODUCT_CODE = EZP_PRODUCT_CODE  AND EPA_ASSET_ID=EZA_ASSET_ID AND EPA_IMAGE_TYPE='TN' ) EZA_LINK FROM EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE IN  ('"+tempPrd+"') and EPD_LANG_CODE='EN'";

		prodParams.setQuery(query);

		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{	
			prodDetailsRetObj_F = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMisc);
			if(prodDetailsRetObj_F!=null && prodDetailsRetObj_F.getRowCount()>0)
			{
				retObjcount = prodDetailsRetObj_F.getRowCount();
				for(int p=0;p<retObjcount;p++)
				{
					String tempId = prodDetailsRetObj_F.getFieldValueString(p,"EZP_PRODUCT_CODE");
					if(p==0)
						tempPROIDs = tempId;
					else
						tempPROIDs = tempPROIDs+"','"+tempId;
				}	
			}	
		}
		catch(Exception e){}

		ezc.ezcommon.EzLog4j.log("retObj>>>>ENd","D");
//out.println("prodDetailsRetObj_F::::::::::"+prodDetailsRetObj_F.toEzcString());
//out.println("tempPROIDs::::::::::"+tempPROIDs);

	}
	if(retObjcount>0)
	{
		EzcParams catalogParamsMisc= new EzcParams(false);
		EziMiscParams catalogParams = new EziMiscParams();
		ReturnObjFromRetrieve productsCntRetObj = null;

		catalogParams.setIdenKey("MISC_SELECT");
		
		String query="SELECT COUNT(*) PRODSCOUNT FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE IN ('"+tempPROIDs+"') AND EPD_LANG_CODE='EN'";
		
		catalogParams.setQuery(query);

		catalogParamsMisc.setLocalStore("Y");
		catalogParamsMisc.setObject(catalogParams);
		Session.prepareParams(catalogParamsMisc);	

		

		try
		{		
			productsCntRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
			//out.println(productsCntRetObj.toEzcString());
			itemsCnt_F = Integer.parseInt(productsCntRetObj.getFieldValueString(0,"PRODSCOUNT"));
		}
		catch(Exception e)
		{
			//out.println("Exception in Getting Data"+e);
		}

		

		try
		{
			if(request.getParameter("pageSize") != null)
			{
				pageSize_F = Integer.parseInt(request.getParameter("pageSize"));
				pageSize_F = 18;
				
			}
			else
			{
				pageSize_F = 18;
				
			}
		}
		catch(Exception ex)
		{
			pageSize_F = 18;
		}

		
		pageMaxNo_F = pageSize_F;

		try
		{
			if(request.getParameter("pageNum") != null)
			{
				pageNum_F = Integer.parseInt(request.getParameter("pageNum"));
			}
			else
			{
				pageNum_F = 1;
			}
		}
		catch(Exception ex) 
		{
			pageNum_F = 1;
		}

		pageMaxNo_F = pageNum_F*pageSize_F;

		catalogParamsMisc= new EzcParams(false);
		catalogParams = new EziMiscParams();
		

		catalogParams.setIdenKey("MISC_SELECT");
		String userSes = Session.getUserId();
		String query1="SELECT * FROM (SELECT TOP "+pageSize_F+" * FROM (SELECT TOP "+pageSize_F+" EPF_ITEMCAT,EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5,(SELECT TOP 1 EZA_LINK FROM EZC_ASSETS,EZC_PRODUCT_ASSETS WHERE EPA_PRODUCT_CODE = EZP_PRODUCT_CODE  AND EPA_ASSET_ID=EZA_ASSET_ID AND EPA_IMAGE_TYPE='MAIN' ) EZA_LINK FROM EZC_USER_PRODUCT_FAVORITES,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE EPF_MAT_NO = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPF_MAT_NO IN ('"+tempPROIDs+"') AND EPD_LANG_CODE= 'EN' and EPF_USER_ID='"+userSes+"' ORDER BY PROD_DESC ASC) AS NEWTBL1 ORDER BY PROD_DESC DESC) AS NEWTBL2 ORDER BY PROD_DESC ASC ";
		
		catalogParams.setQuery(query1);

		catalogParamsMisc.setLocalStore("Y");
		catalogParamsMisc.setObject(catalogParams);
		Session.prepareParams(catalogParamsMisc);	

		try
		{		
			catalogProductsRetObj_F = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(catalogParamsMisc);
			//out.println("catalogProductsRetObj_F:::::::::"+catalogProductsRetObj_F.toEzcString());

		}
		catch(Exception e)
		{
			//out.println("Exception in Getting Data"+e);
		}	
	}	
	
	
	
%>
