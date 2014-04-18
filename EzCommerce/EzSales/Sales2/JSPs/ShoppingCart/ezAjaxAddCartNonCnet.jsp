<%@ page import = "ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ page import="ezc.ezcnetconnector.params.*" %>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>  
<%@ include file="../../../Includes/Lib/ezSpChar.jsp"%>
<%
	EzShoppingCartManager SCManager = new EzShoppingCartManager( Session );
	String matId    =  enSp(request.getParameter("matId"));
	String product  =  enSp(request.getParameter("product"));
	String quantity =  enSp(request.getParameter("quantity"));
	String catalog  =  enSp(request.getParameter("catalog"));
	String cartQty  =  enSp(request.getParameter("cartQty"));
	
	String priceStr = (String)session.getValue(product);
	String listPrice= priceStr.split("@")[1];//request.getParameter("listPrice");
	String discPer = enSp(request.getParameter("discPer"));
	String discCode = enSp(request.getParameter("discCode"));
	String orgPrice = priceStr.split("@")[0];//request.getParameter("orgPrice");
	
	int totQty   =  0;
	String reqQty ="";
	
	try{
		totQty = (Integer.parseInt(quantity)+Integer.parseInt(cartQty));
	}catch(Exception e){
	        totQty = 0;
        }
	
	try{
		reqQty =String.valueOf(totQty);
	}catch(Exception e){
	} 
	
	int cartRows    =  0;
	int cartItems    =  0;
	String [] matIds   = new String[1];
	String [] products = new String[1];
	String [] reqQtys  = new String[1];
	String [] reqDates = new String[1];
	String [] catalogs = new String[1];
	
	String[] uom 		= new String[1];
	String[] unitPrice 	= new String[1];
	String[] prodDesc 	= new String[1];
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
	
	EzCatalogParams ezcpparams = new ezc.ezparam.EzCatalogParams(); 
	EzCustomerItemCatParams cnetParams=new EzCustomerItemCatParams();
	
	ezcpparams.setType("GET_PRDS_CATEGORY");
	cnetParams.setQuery("and mm.emm_no = '"+product+"'");
	cnetParams.setCategoryID(catalog);

	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
		//out.println("retCat>>>>"+retCat.toEzcString());
		
		ezc.ezcommon.EzLog4j.log("retObj>>>>STatr","D");


	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
		
		ezc.ezcommon.EzLog4j.log("retObj>>>>"+retObj.toEzcString(),"D");

	
	
	
	if(retObj!=null && retObj.getRowCount()>0)
	{
	
		
			prodDesc[0] 	= retObj.getFieldValueString(0,"EMD_DESC");
			brand[0]	= retObj.getFieldValueString(0,"EMM_MANUFACTURER");
			mmFlag[0] 	= "NONCNET";
			catalogs[0]     = catalog;
			mfrCode_A[0]	= retObj.getFieldValueString(0,"EMM_MANUFACTURER");
			mfrPartNo_A[0]	= retObj.getFieldValueString(0,"EMM_NO");
			products[0]     = retObj.getFieldValueString(0,"EMM_NO");
			varPriceFlag[0] = product;
		
	}
	else
	{
		prodDesc[0] 	= "N/A";
		brand[0]	= "NONCNET";
		mmFlag[0] 	= "NONCNET";
		catalogs[0]     = catalog;
		mfrCode_A[0]	= "N/A";
		mfrPartNo_A[0]	= "N/A";
		products[0]     = "N/A";
		varPriceFlag[0] = product;

	}
	
	/************************Weight of the Product - Start**************************/

	int retDetCnt=0;
	
	EzCatalogParams catalogParamsCRI = new ezc.ezparam.EzCatalogParams();  
	EzCustomerItemCatParams ecicCRI = new EzCustomerItemCatParams(); 

	catalogParamsCRI.setType("GET_NON_CNET_PROD_DET");
	ecicCRI.setProdID(product);	
	ecicCRI.setQuery("");	
	
	catalogParamsCRI.setObject(ecicCRI);
	catalogParamsCRI.setLocalStore("Y");
	Session.prepareParams(catalogParamsCRI);
	ReturnObjFromRetrieve retDet = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParamsCRI);
	
	if(retDet!=null && retDet.getRowCount()>0)
		retDetCnt = retDet.getRowCount();
	
	String weightStr = "0";

	
	if(retDetCnt>0)	
	{
		try
		{
			weightStr = retDet.getFieldValueString(0,"EMM_WEIGHT_NUM");
			weightStr = weightStr.trim();
			ezc.ezcommon.EzLog4j.log("weightStr oz::::::::::::::::::"+weightStr+"::::::","D");

			java.math.BigDecimal weightStr_bd = new java.math.BigDecimal(weightStr);
			weightStr_bd = weightStr_bd.multiply(new java.math.BigDecimal("2.20462262"));	//Conversion 1 kg = 2.20462262 lbs

			weightStr = weightStr_bd.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)+"";			
			ezc.ezcommon.EzLog4j.log("weightStr::::::::::::::::::"+weightStr+"::::::","D");
		}
		catch(Exception ex){}
	}

	/************************Weight of the Product - End****************************/

	matIds[0] = matId;
	reqQtys[0]  = reqQty;
	reqDates[0] ="1.11.1000";
	
	
	uom[0] 		= "EA";
	unitPrice[0] 	= listPrice;
	discPer_A[0]	= discPer;
	discCode_A[0]	= discCode;
	orgPrice_A[0]	= orgPrice;
	currency[0] 	= "USD";
	weight_A[0] 	= weightStr;
	//weight_A[0] 	= "";
	upcNo[0]	= "";
	
	
	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	
	reqparams.setMatId(matIds);
	reqparams.setProducts(products);
	reqparams.setReqDate(reqDates);
	reqparams.setReqQty(reqQtys);
	reqparams.setVendorCatalogs(catalogs);

	reqparams.setUom(uom);
	reqparams.setUnitPrice(unitPrice);
	reqparams.setDiscPer(discPer_A);
	reqparams.setDiscCode(discCode_A);
	reqparams.setOrgPrice(orgPrice_A);
	reqparams.setMfrCode(mfrCode_A);
	reqparams.setMfrPartNo(mfrPartNo_A);
	reqparams.setProdDesc(prodDesc);
	reqparams.setMmFlag(mmFlag);
	reqparams.setCurrency(currency);
	reqparams.setVarPriceFlag(varPriceFlag);
	reqparams.setBrand(brand);
	reqparams.setUpcNo(upcNo);
	reqparams.setWeight(weight_A);
	
	
	subparams.setType("CNET");
	subparams.setLanguage("EN");
	subparams.setEziReqParams(reqparams);
	params.setObject(subparams);
	Session.prepareParams(params);

	try{
		SCManager.saveCart(params);
		SCManager.updateCart(params); 
	}catch(Exception e){
	
	}
	
	EzShoppingCart Cart = null;
	params = new EzcShoppingCartParams();
	subparams = new EziShoppingCartParams();
	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);
	try{
		Cart = (EzShoppingCart)SCManager.getSavedCart(params); 
	}catch(Exception err){
	
	}
	if(Cart!=null && Cart.getRowCount()>0 ){
		cartRows = Cart.getRowCount();
		for(int i=0;i<cartRows;i++){
			try{
                             cartItems+=Double.parseDouble(Cart.getOrderQty(i));
			}catch(Exception e){
                             
			}
		}	
		out.print("#"+cartItems+"#"+totQty+"#");
		
	} 

%>
