<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezmisc.params.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<jsp:useBean id="ezMiscManager1" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="ezGetProductInfo.jsp"%>
<%
	
	EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);
	
	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();

	EzShoppingCart Cart = null;
	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);

	try
	{
		Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	}
	catch(Exception err){}

	int cartRows = 0;
	String catType_C = "";

	if(Cart!=null && Cart.getRowCount()>0)
	{
		cartRows  = Cart.getRowCount();
		catType_C = Cart.getType(0);
	}	

	if(catType_C==null || "null".equalsIgnoreCase(catType_C) || "".equals(catType_C)) catType_C = "PT";

	String categoryID  = request.getParameter("categoryID");

	EzcParams prodParamsMisc= new EzcParams(false);
	EziMiscParams prodParams = new EziMiscParams();

	ReturnObjFromRetrieve prodStatObj = null;
	ReturnObjFromRetrieve commGrpRetObj = null;
	ReturnObjFromRetrieve productsRetObj = null;

	String discChk = "";
	String commChk = "";
	String strCommChk="N";
	
	if(matCodeUP!=null && !"null".equals(matCodeUP) && !"".equals(matCodeUP))
	{
		String catalogCode = (String)session.getValue("CatalogCode");
		String appendQry = " AND EZP_STATUS NOT IN ('Z2','Z3','01','11','ZR','ZM','ZL','ZE','ZD','ZP')";

		if(!"CU".equals((String)session.getValue("UserRole")))
			appendQry = " AND EZP_STATUS NOT IN ('Z2','Z3','01','11','ZD','ZP')";

		String query1 = "";
		prodParams.setIdenKey("MISC_SELECT");
		query1="SELECT ECP_CATEGORY_CODE,EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5 FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORIES,EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_CATEGORY_CODE = EC_CODE AND ECC_CATEGORY_ID = EC_PARENT AND ECC_CATALOG_ID IN ('"+catalogCode+"') AND ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE = '"+matCodeUP+"' "+appendQry+" AND EPD_LANG_CODE='EN'";

		prodParams.setQuery(query1);

		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{
			prodStatObj = (ReturnObjFromRetrieve)ezMiscManager1.ezSelect(prodParamsMisc);
		}
		catch(Exception e){}		

		prodParams.setIdenKey("MISC_SELECT");
		prodParams.setQuery("SELECT * from EZC_VALUE_MAPPING where MAP_TYPE='COMMGRPALLOWED'");

		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{
			commGrpRetObj = (ReturnObjFromRetrieve)ezMiscManager1.ezSelect(prodParamsMisc);
		}
		catch(Exception e){}

		String commGrpCodeMap="";

		java.util.ArrayList commGrpAL = new java.util.ArrayList();

		if(commGrpRetObj!=null && commGrpRetObj.getRowCount()>0)
		{
			for(int i=0;i<commGrpRetObj.getRowCount();i++)
			{
				commGrpCodeMap = commGrpRetObj.getFieldValueString(i,"VALUE1");
				commGrpAL.add(commGrpCodeMap);
			}
		}
		
		
		if(prodStatObj!=null && prodStatObj.getRowCount()==0)
		{
			matCodeUP = matCodeUP.trim(); 
			String matCodeUP_A = matCodeUP;

			matCodeUP = matCodeUP.replaceAll("\\,","");
			matCodeUP = matCodeUP.replaceAll("\\.","");
			matCodeUP = matCodeUP.replaceAll("\\-","");
			matCodeUP = matCodeUP.replaceAll("\\/","");

			query1="SELECT ECP_CATEGORY_CODE,EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5 FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORIES,EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_CATEGORY_CODE = EC_CODE AND ECC_CATEGORY_ID = EC_PARENT AND ECC_CATALOG_ID IN ('"+catalogCode+"') AND ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_WEB_SKU LIKE '"+matCodeUP+"' "+appendQry+" AND EPD_LANG_CODE='EN'";
			prodParams.setQuery(query1);

			matCodeUP = matCodeUP_A;

			try
			{
				prodStatObj = (ReturnObjFromRetrieve)ezMiscManager1.ezSelect(prodParamsMisc);
				if(prodStatObj!=null && prodStatObj.getRowCount()>1)
				{
					boolean prdDelete = false;
					String prdCode_Chk = "";
					String prdCode_Chk1 = "";
					for(int i=0;i<prodStatObj.getRowCount();i++)
					{
						if(i==0)
							prdCode_Chk = prodStatObj.getFieldValueString(i,"EZP_PRODUCT_CODE");
						else
							prdCode_Chk1 = prodStatObj.getFieldValueString(i,"EZP_PRODUCT_CODE");

						if(!"".equals(prdCode_Chk) && !"".equals(prdCode_Chk1) && !prdCode_Chk.equals(prdCode_Chk1))
							prdDelete = true;
					}
					if(prdDelete)
					{
						for(int i=(prodStatObj.getRowCount()-1);i>=0;i--)
						{
							prodStatObj.deleteRow(i);
						}
					}
				}
			}
			catch(Exception e){}
		}

		if(prodStatObj!=null && prodStatObj.getRowCount()>0)
		{
			//for(int i=0;i<prodStatObj.getRowCount();i++)
			{
				discChk = prodStatObj.getFieldValueString(0,"EZP_STATUS");
				commChk = prodStatObj.getFieldValueString(0,"EZP_ATTR1");
			}
		}

		if(!"CU".equals((String)session.getValue("UserRole")) && "ZR".equals(discChk)) commChk = "";

		String exclMat  =   (String)session.getValue("EXCLMAT");
		String qeCommGroup  =   (String)session.getValue("CommGroup");

		
		if(commChk==null || "null".equals(commChk)) commChk="";
		
		if(commGrpAL.contains(commChk) || "".equals(commChk))
			strCommChk = "Y";

		if("Y".equals(strCommChk))
		{						
			try
			{
				productsRetObj = (ReturnObjFromRetrieve)prodStatObj;
			}
			catch(Exception e)
			{
			}
		}
		
		
		
		
	}
	
	if(productsRetObj!=null && productsRetObj.getRowCount()>0 && "Y".equals(strCommChk))
	{

	String lineItem	 = "";

	if(cartRows>0)
	{
		lineItem = (String)session.getValue("LINEITEM");

		if(lineItem==null || "null".equalsIgnoreCase(lineItem) || "".equals(lineItem))
			lineItem = ((cartRows+1)*10)+"";
	}
	else
	{
		lineItem = ((cartRows+1)*10)+"";
		cartRows++;
	}
	String lineItemSes = (Integer.parseInt(lineItem)+10)+"";

	session.putValue("LINEITEM",lineItemSes);

	ezc.ezcommon.EzLog4j.log("lineItem::::"+lineItem+"::::lineItem","D");

	String prodCode  =  productsRetObj.getFieldValueString(0,"EZP_PRODUCT_CODE");//EZP_WEB_SKU
	String prodDesc  =  productsRetObj.getFieldValueString(0,"PROD_DESC");
	String listPrice =  productsRetObj.getFieldValueString(0,"EZP_CURR_PRICE");
	String eanUpc 	 =  productsRetObj.getFieldValueString(0,"EZP_UPC_CODE");
	String prodCat 	 =  productsRetObj.getFieldValueString(0,"ECP_CATEGORY_CODE");

	if("KI".equals(productsRetObj.getFieldValueString(0,"EZP_TYPE")))
	{
		listPrice = checkKitCompPrice(Session,prodCode,listPrice);
	}

	if(!"NL".equals(jobItemPrice) && !"NM".equals(jobItemPrice) && !"NQ".equals(jobItemPrice) && !"EQ".equals(jobItemPrice) && !"CQ".equals(jobItemPrice) && !"".equals(jobItemPrice))
	{		
		listPrice = jobItemPrice;
	}

	String dispProd	 = request.getParameter("dispProd");
	//String vipProd	 = request.getParameter("vipProd");

	String defProgType = (String)session.getValue("DEFPROG");

	if("PT".equals(catType_C) || "QT".equals(catType_C))
	{
		if(defProgType!=null && "NONE".equals(defProgType)) catType_C = "PT";
		else if(defProgType!=null && "DISP".equals(defProgType)) catType_C = "DISP";
		else if(defProgType!=null && "VIP".equals(defProgType)) catType_C = "VIP";
		else if(defProgType!=null && "FOC".equals(defProgType)) catType_C = "FOC";
	}

	String progType="";
	if("Disp".equals(progType))
		dispProd = "DISP";
	else if ("VIP".equals(progType))
		dispProd = "VIP";
	else
	{
		dispProd = "N/A";
		//vipProd = "N/A";
	}
	ezc.ezcommon.EzLog4j.log("lineItem11::::"+lineItem+"::::lineItem11","D");
	if(quantity==null || "null".equalsIgnoreCase(quantity) || "".equals(quantity)) quantity = "1";

	if(categoryID==null || "null".equalsIgnoreCase(categoryID) || "".equals(categoryID)) categoryID = prodCat;
%>
<%@include file="../../../Includes/JSPs/Misc/iPointsAlerts.jsp"%>
<%
	String[] matIds   	= new String[1];
	String[] products 	= new String[1];
	String[] reqQtys  	= new String[1];
	String[] reqDates 	= new String[1];
	String[] catalogs 	= new String[1];

	String[] uom	 	= new String[1];
	String[] unitPrice 	= new String[1];
	String[] matDesc 	= new String[1];

	String[] mmFlag 	= new String[1];
	String[] currency 	= new String[1];
	String[] varPriceFlag 	= new String[1];
	String[] brand 		= new String[1];
	String[] upcNo 		= new String[1];
	String[] discPer_A	= new String[1]; 
	String[] discCode_A	= new String[1];
	String[] orgPrice_A	= new String[1];
	String[] mfrCode_A	= new String[1];
	String[] mfrPartNo_A	= new String[1];
	String[] weight_A	= new String[1];

	String[] cat1		= new String[1];
	String[] cat2		= new String[1];
	String[] cat3		= new String[1];
	String[] custSku	= new String[1];
	String[] poLine_A	= new String[1];
	String[] reftype	= new String[1];
	String[] division	= new String[1];
	String[] distChnl	= new String[1];
	String[] salesOrg	= new String[1];
	String[] ordType	= new String[1];
	String[] volume_A	= new String[1];
	String[] points_A	= new String[1];
	String[] plant_A	= new String[1];
	String[] kitComp_A	= new String[1];
	String[] ext1		= new String[1];
	String[] ext2		= new String[1];
	String[] ext3		= new String[1];

	matIds[0] 	= prodCode;
	products[0]     = lineItem;
	reqQtys[0]  	= quantity;
	reqDates[0] 	= "1.11.1000";
	catalogs[0]	= groupID; //prodCat

	uom[0] 		= "EA";
	unitPrice[0] 	= listPrice;
	matDesc[0] 	= prodDesc;

	mmFlag[0]	= "CNET";
	currency[0] 	= imgLinkCart;
	varPriceFlag[0]	= progTypeCart;
	brand[0]	= "N/A";//brandCart;
	upcNo[0]	= eanUpc;
	discPer_A[0]	= brandCart;
	discCode_A[0]	= prodStatus;
	orgPrice_A[0]	= "N/A";
	mfrCode_A[0]	= "N/A";
	mfrPartNo_A[0]	= quoteNo;
	weight_A[0]	= quoteLine;

	cat1[0]		= catType_C;//dispProd;
	//cat2[0]	 = vipProd;
	cat3[0]		= "N/A";
	kitComp_A[0]	= compItems_A;	//num of kit components
	custSku[0]	= prodSku;
	poLine_A[0]	= poLine;
	reftype[0]	= catType_C;
	ext1[0]		= classType;	//this is for classification, LUX for luxury, COM for commercial
	ext2[0]		= quantity;	// Job quantity change
	ext3[0]		= "N/A";

	/*if("QS".equals(progType))
		reftype[0]	= "Q";
	else
		reftype[0]	= "PT";*/

	volume_A[0]	= volume;
	points_A[0]	= points;

	String sOrg_C	= (String)session.getValue("salesOrg");
	String div_C	= (String)session.getValue("division");
	String dChnl_C	= (String)session.getValue("dc");
	String oType_C	= "OR";

	try
	{
		String fileName = "accord3.jsp";
		String filePath = request.getRealPath(fileName);

		if("FOC".equals(catType_C))
			dChnl_C = "70"; // Distribution Channel is 70 for all FOC Orders

		String returnValue = getProductInfo(Session,prodCode,sOrg_C,div_C,dChnl_C,oType_C,fileName,filePath);
		//out.println("returnValue::"+returnValue);

		salesOrg[0] = returnValue.split("¥")[0];
		division[0] = returnValue.split("¥")[1];
		distChnl[0] = returnValue.split("¥")[2];
		ordType[0]  = returnValue.split("¥")[3];
		brand[0]    = returnValue.split("¥")[4];	// setting plant
		cat2[0]     = returnValue.split("¥")[5];	// setting material division
		plant_A[0]  = returnValue.split("¥")[6];	// getting material plant not sure of above plant at [4]
	}
	catch(Exception e){}

	if("DISP".equals(reftype[0]))
	{
		if("ZIDS".equals(ordType[0])) 
			ordType[0] = "ZIDP";
		else
			ordType[0] = "ZDPO";
	}
	else if("VIP".equals(reftype[0]))
	{
		ordType[0] = "ZDPO";
	}
	else if("QS".equals(reftype[0]))	//used for quick ship items
		ordType[0] = "Z1";
	else if("FOC".equals(reftype[0]))
	{
		distChnl[0] = "70";

		if("24".equals(plant_A[0]) || "956".equals(plant_A[0]) || "167".equals(plant_A[0]))//(ordType[0]).startsWith("ZIS"))
			ordType[0] = "ZIDF";
		else
			ordType[0] = "FD";
	}

	if("20".equals(distChnl[0]))
	{
		if("ZDPO".equals(ordType[0]))
			ordType[0] = "Z28";
	}
	/*else if("90".equals(distChnl[0]))
	{
		ordType[0] = "Z1";
	}*/

	reqparams.setMatId(matIds);
	reqparams.setProducts(products);
	reqparams.setReqQty(reqQtys);
	reqparams.setReqDate(reqDates);
	reqparams.setVendorCatalogs(catalogs);

	reqparams.setUom(uom);
	reqparams.setUnitPrice(unitPrice);
	reqparams.setProdDesc(matDesc);

	reqparams.setDiscPer(discPer_A);
	reqparams.setDiscCode(discCode_A);
	reqparams.setOrgPrice(orgPrice_A);
	reqparams.setMfrCode(mfrCode_A);
	reqparams.setMfrPartNo(mfrPartNo_A);
	reqparams.setMmFlag(mmFlag);
	reqparams.setCurrency(currency);
	reqparams.setVarPriceFlag(varPriceFlag);
	reqparams.setBrand(brand);
	reqparams.setUpcNo(upcNo);
	reqparams.setWeight(weight_A);

	reqparams.setCat1(cat1);
	reqparams.setCat2(cat2);
	reqparams.setCat3(cat3);
	reqparams.setCustSku(custSku);
	reqparams.setPoLine(poLine_A);
	reqparams.setType(reftype);
	reqparams.setDivision(division);
	reqparams.setDistChnl(distChnl);
	reqparams.setSalesOrg(salesOrg);
	reqparams.setOrdType(ordType);
	reqparams.setVolume(volume_A);
	reqparams.setPoints(points_A);
	reqparams.setKitComp(kitComp_A);
	reqparams.setExt1(ext1);
	reqparams.setExt2(ext2);
	reqparams.setExt3(ext3);

	subparams.setType("AMSTAN");
	subparams.setLanguage("EN");
	subparams.setEziReqParams(reqparams);
	params.setObject(subparams);
	Session.prepareParams(params);
	
		try
		{
			SCManager.saveCart(params);
			SCManager.updateCart(params);
		}
		catch(Exception e){}
	}
	else if("N".equals(strCommChk))
	{
		notAddedUP = "RE";
	}
	else
	{
		notAddedUP = "N";
	}

%>
