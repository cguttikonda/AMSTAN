<%@ include file="iGetFavProducts.jsp"%>
<%
	String prodCode_D   = request.getParameter("prodCode_D");
	String categoryID   = request.getParameter("categoryID");
	String categoryDesc = request.getParameter("categoryDesc");
	String mainCatID    = request.getParameter("mainCatID");
	String mainCatDesc  = request.getParameter("mainCatDesc");
	
	//out.println("categoryID:::"+categoryID);
	//out.println("categoryDesc:::"+categoryDesc);	

	EzcParams prodParamsMisc = new EzcParams(false);
	EziMiscParams prodParams = new EziMiscParams();

	ReturnObjFromRetrieve prodDetailsRetObj = null;
	ReturnObjFromRetrieve prodCatRetObj = null;
	ReturnObjFromRetrieve prodMainCatRetObj = null;

	prodParams.setIdenKey("MISC_SELECT");
	String query="SELECT EZP_PRODUCT_CODE,EZP_PROD_ATTRS,EPA_ATTR_CODE,EPA_ATTR_VALUE,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5,EPD_PRODUCT_DESC,EPD_PRODUCT_DETAILS,EPD_PRODUCT_PROP1,EPD_PRODUCT_PROP2,EPD_PRODUCT_PROP3,EPD_PRODUCT_PROP4,EPD_PRODUCT_PROP5,EPD_PRODUCT_PROP6 FROM EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES,EZC_PRODUCT_DESCRIPTIONS WHERE EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE =  EPD_PRODUCT_CODE  AND EZP_PRODUCT_CODE='"+prodCode_D+"' AND EPD_LANG_CODE='EN'";

	prodParams.setQuery(query);

	prodParamsMisc.setLocalStore("Y");
	prodParamsMisc.setObject(prodParams);
	Session.prepareParams(prodParamsMisc);	

	try
	{
		prodDetailsRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMisc);
	}
	catch(Exception e){}
	
	String modelForRP = prodDetailsRetObj.getFieldValueString(0,"EZP_MODEL");
	
	if(categoryID==null || "null".equals(categoryID) || "".equals(categoryID))
	{
		prodParams.setIdenKey("MISC_SELECT");
		query="SELECT ECD_CODE,ECD_DESC FROM EZC_CATEGORY_PRODUCTS,EZC_CATEGORY_DESCRIPTION WHERE ECP_CATEGORY_CODE=ECD_CODE AND ECP_PRODUCT_CODE='"+prodCode_D+"' AND ECD_LANG='EN' ";
	
		prodParams.setQuery(query);
	
		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	
		
		try
		{
			prodCatRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMisc);
		}
		catch(Exception e){}
		
		categoryID   = nullCheck(prodCatRetObj.getFieldValueString(0,"ECD_CODE"));
		categoryDesc = nullCheck(prodCatRetObj.getFieldValueString(0,"ECD_DESC"));
		
	}
	
	if(mainCatID==null || "null".equals(mainCatID) || "".equals(mainCatID))
	{
		prodParams.setIdenKey("MISC_SELECT");
		query="SELECT EC_CODE,EC_PARENT,ECD_DESC FROM EZC_CATEGORIES,EZC_CATEGORY_DESCRIPTION WHERE EC_PARENT=ECD_CODE AND EC_CODE='"+categoryID+"'";

		prodParams.setQuery(query);

		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{
			prodMainCatRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMisc);
		}
		catch(Exception e){}

		mainCatID   = nullCheck(prodMainCatRetObj.getFieldValueString(0,"EC_PARENT"));
		mainCatDesc = nullCheck(prodMainCatRetObj.getFieldValueString(0,"ECD_DESC"));
			
	}
	
	
	//Product Relations 
	
	EzcParams prodParamsMiscREL = new EzcParams(false);
	EziMiscParams prodParamsREL = new EziMiscParams();

	ReturnObjFromRetrieve prodDetailsRetObjREL = null;

	prodParamsREL.setIdenKey("MISC_SELECT");
	// Sam requested on 3/19/2014 to run Repair Part relationship by Model # 
	// hence added a EPR_PRODUCT_1 comparison with Model # also.
	String queryREL="SELECT EPR_PRODUCT_CODE1,EZP_PRODUCT_CODE,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5,EZP_SALES_ORG, EZP_PROD_ATTRS,EPR_PRODUCT_CODE1,EPR_PRODUCT_CODE2,EPR_RELATION_TYPE,EPD_PRODUCT_DESC,EPD_PRODUCT_DETAILS,EPD_PRODUCT_PROP1,EPD_PRODUCT_PROP2,EPD_PRODUCT_PROP3,EPD_PRODUCT_PROP4,EPD_PRODUCT_PROP5,EPD_PRODUCT_PROP6 from EZC_PRODUCTS,EZC_PRODUCT_RELATIONS,EZC_PRODUCT_DESCRIPTIONS WHERE EZP_PRODUCT_CODE = EPR_PRODUCT_CODE2 AND EPR_PRODUCT_CODE2 = EPD_PRODUCT_CODE and ( EPR_PRODUCT_CODE1='"+prodCode_D+"' OR EPR_PRODUCT_CODE1 = '"+modelForRP+"') AND EZP_STATUS not in ('Z2','Z3','01','ZR','ZM','ZL','ZE','ZD','ZP') AND  EPD_LANG_CODE='EN'";

	prodParamsREL.setQuery(queryREL);

	prodParamsMiscREL.setLocalStore("Y");
	prodParamsMiscREL.setObject(prodParamsREL);
	Session.prepareParams(prodParamsMiscREL);	

	try
	{
		prodDetailsRetObjREL = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscREL);
	}
	catch(Exception e){}
	
	//out.println("prodDetailsRetObjREL:::"+prodDetailsRetObjREL.toEzcString());

	int repairCnt=0;
	int simiCnt=0;
	int compCnt=0;
	int replaceCnt=0;
	ArrayList prodCodesAL = new ArrayList();
	String prodCodeAL  = null;

	for(int r=0;r<prodDetailsRetObjREL.getRowCount();r++)
	{
		prodCodeAL  = prodDetailsRetObjREL.getFieldValueString(r,"EZP_PRODUCT_CODE");	
		
		if("R".equals(prodDetailsRetObjREL.getFieldValueString(r,"EPR_RELATION_TYPE")))
		{
			repairCnt++;
		}
		else if("SIMI".equals(prodDetailsRetObjREL.getFieldValueString(r,"EPR_RELATION_TYPE")))
		{
			simiCnt++;
			if("DXV".equals(prodDetailsRetObjREL.getFieldValueString(r,"EZP_BRAND")))
			{
				prodCodesAL.add(prodCodeAL);
			}
		}
		else if("COMP".equals(prodDetailsRetObjREL.getFieldValueString(r,"EPR_RELATION_TYPE")))
		{
			compCnt++;
			if("DXV".equals(prodDetailsRetObjREL.getFieldValueString(r,"EZP_BRAND")))
			{
				prodCodesAL.add(prodCodeAL);
			}
		}
		else if("REPL".equals(prodDetailsRetObjREL.getFieldValueString(r,"EPR_RELATION_TYPE")))
		{
			replaceCnt++;
		}
	}

	//Downlaods 

	EzcParams prodParamsMiscDWN = new EzcParams(false);
	EziMiscParams prodParamsDWN = new EziMiscParams();

	ReturnObjFromRetrieve prodDetailsRetObjDWN = null;
	ReturnObjFromRetrieve prodDetailsRetObjDWNN = null;

	prodParamsDWN.setIdenKey("MISC_SELECT");
	String queryDWN="SELECT EPA_PRODUCT_CODE,SUBSTRING(EPA_PRODUCT_CODE,PATINDEX('%.%',EPA_PRODUCT_CODE)+1,(LEN(EPA_PRODUCT_CODE))) COLOR,EPA_IMAGE_TYPE,EPA_SCREEN_NAME,EZA_ASSET_ID,EZA_MIME_TYPE,EZA_LINK FROM EZC_ASSETS,EZC_PRODUCT_ASSETS WHERE EPA_ASSET_ID=EZA_ASSET_ID AND EPA_PRODUCT_CODE='"+prodCode_D+"' AND EZA_LINK not like '%swatch%' order by EPA_SCREEN_NAME desc";

	prodParamsDWN.setQuery(queryDWN);

	prodParamsMiscDWN.setLocalStore("Y");
	prodParamsMiscDWN.setObject(prodParamsDWN);
	Session.prepareParams(prodParamsMiscDWN);	

	try
	{
		prodDetailsRetObjDWN = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscDWN);
	}
	catch(Exception e){}
	
	try
	{
		prodDetailsRetObjDWNN = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscDWN);
	}
	catch(Exception e){}
	
	
	EzcParams prodParamsMiscV = new EzcParams(false);
	EziMiscParams prodParamsV = new EziMiscParams();

	ReturnObjFromRetrieve prodDetailsRetObjV = null;

	prodParamsV.setIdenKey("MISC_SELECT");
	String queryV="SELECT EZP_PRODUCT_CODE,ECP_CLASSIFICATION_CODE,EPCL_CODE,EPCL_TYPE FROM EZC_CLASSIFICATION_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_CLASSIFICATION WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND ECP_CLASSIFICATION_CODE=EPCL_CODE AND EZP_PRODUCT_CODE='"+prodCode_D+"'";

	prodParamsV.setQuery(queryV);

	prodParamsMiscV.setLocalStore("Y");
	prodParamsMiscV.setObject(prodParamsV);
	Session.prepareParams(prodParamsMiscV);	

	try
	{
		prodDetailsRetObjV = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscV);
	}
	catch(Exception e){}
	
	int downCnt=0;
	
		
	if(prodDetailsRetObjDWNN!=null && prodDetailsRetObjDWNN.getRowCount()>0)
	{
		
		for(int i=prodDetailsRetObjDWNN.getRowCount()-1;i>=0;i--)
		{
			if(!"NA".equals(prodDetailsRetObjDWNN.getFieldValueString(i,"EPA_IMAGE_TYPE")))
			{
				prodDetailsRetObjDWNN.deleteRow(i);				
			}
		}
		
	}
	downCnt = prodDetailsRetObjDWNN.getRowCount();	
	
	//out.println("prodDetailsRetObjDWN:::"+prodDetailsRetObjDWN.toEzcString());
	String catType_E = "PT";
	if(prodDetailsRetObjV!=null && prodDetailsRetObjV.getRowCount()>0)
	{
		catType_E = nullCheck(prodDetailsRetObjV.getFieldValueString(0,"EPCL_TYPE"));
	}
		
	//out.println("catType_E:::"+catType_E);
	
	ArrayList favProdsAL = new ArrayList();
	if(catalogProductsRetObj_F!=null && catalogProductsRetObj_F.getRowCount()>0)
	{
		for(int f=0;f<catalogProductsRetObj_F.getRowCount();f++)
		{
			String favProdCode  =  catalogProductsRetObj_F.getFieldValueString(f,"EZP_PRODUCT_CODE");
			favProdsAL.add(favProdCode);
		}
	}
	
	EzcParams prodParamsMiscREP = new EzcParams(false);
	EziMiscParams prodParamsREP = new EziMiscParams();

	ReturnObjFromRetrieve prodDetailsRetObjREP = null;

	prodParamsREP.setIdenKey("MISC_SELECT");
	
	String queryREP="SELECT * FROM EZC_PRODUCT_RELATIONS WHERE EPR_PRODUCT_CODE2='"+prodCode_D+"' AND EPR_RELATION_TYPE='R'";
	
	prodParamsREP.setQuery(queryREP);

	prodParamsMiscREP.setLocalStore("Y");
	prodParamsMiscREP.setObject(prodParamsREP);
	Session.prepareParams(prodParamsMiscREP);	

	try
	{
		prodDetailsRetObjREP = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscREP);
	}
	catch(Exception e){}	
	ezc.ezcommon.EzLog4j.log("prodDetailsRetObjREP>>>>>>>"+prodDetailsRetObjREP.toEzcString() ,"I");
	
	ReturnObjFromRetrieve newsValMapRetObjd = null;
			
	ezc.ezparam.EzcParams mainParams_NVMd = new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams_NVMd = new EziMiscParams();

	miscParams_NVMd.setIdenKey("VALUE_MAP"); // Mandatory 

	miscParams_NVMd.setExt3("NEWSVALMAP"); // NEWSVALMAP is the map_type in the table and it is optional should pass the blank parameter
	//miscParams_NVMd.setExt3("");

	mainParams_NVMd.setLocalStore("Y");
	mainParams_NVMd.setObject(miscParams_NVMd);
	Session.prepareParams(mainParams_NVMd);	
	try{	

		ezc.ezcommon.EzLog4j.log("Hi:::ValueMapping:::TEST::Start","D");
		newsValMapRetObjd = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_NVMd);
		ezc.ezcommon.EzLog4j.log("Hi:::ValueMapping:::TEST::End","D");

	}
	catch(Exception e){out.println("Exception in Getting Data"+e);}
%>