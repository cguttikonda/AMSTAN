<%@ page import = "ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ page import="ezc.ezcnetconnector.params.*" %>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />

<%
	EzShoppingCartManager SCManager = new EzShoppingCartManager( Session );
	String matId    =  request.getParameter("matId");
	String product  =  request.getParameter("product");
	String quantity =  request.getParameter("quantity");
	String catalog  =  request.getParameter("catalog");
	String cartQty  =  request.getParameter("cartQty");
	
	String listPrice = request.getParameter("listPrice");
	String discPer = request.getParameter("discPer");
	String discCode = request.getParameter("discCode");
	String orgPrice = request.getParameter("orgPrice");
	
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
	
	EzcParams ezcpparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	
	cnetParams.setStatus("GET_PRDS_CATEGORY");
	cnetParams.setQuery("and cds_Prod.ProdID='"+product+"' order by cds_Prod.ProdID");
	cnetParams.setCategoryID(catalog);

	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)CnetManager.ezGetCnetProductsByStatus(ezcpparams);
	
	if(retObj!=null && retObj.getRowCount()>0)
	{
		prodDesc[0] 	= retObj.getFieldValueString(0,"ProdIDDesc");
		brand[0]	= retObj.getFieldValueString(0,"MfIDText");
		mmFlag[0] 	= "CNET";
		catalogs[0]     = catalog;
		mfrCode_A[0]	= retObj.getFieldValueString(0,"MfID");
		mfrPartNo_A[0]	= retObj.getFieldValueString(0,"MfPN");
		products[0]     = retObj.getFieldValueString(0,"ProdID");
		varPriceFlag[0] = product;
	}
	else
	{
		prodDesc[0] 	= "N/A";
		brand[0]	= "CNET";
		mmFlag[0] 	= "CNET";
		catalogs[0]     = catalog;
		mfrCode_A[0]	= "N/A";
		mfrPartNo_A[0]	= "N/A";
		products[0]     = "N/A";
		varPriceFlag[0] = product;

	}
	
	/************************Weight of the Product - Start**************************/

	int retDetCnt = 0,retExtCnt = 0;
	
	ezcpparams = new EzcParams(true);
	cnetParams = new EzCnetConnectorParams();
	
	cnetParams.setStatus("GET_PRDDET_BOTHSPECS");
	cnetParams.setProdID(product);
	cnetParams.setQuery("");
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	ReturnObjFromRetrieve retBoth = (ReturnObjFromRetrieve)CnetManager.ezGetCnetPrdDetailsByStatus(ezcpparams);	
	ReturnObjFromRetrieve retDet = (ReturnObjFromRetrieve)retBoth.getFieldValue(0,"MAIN");
	ReturnObjFromRetrieve retExt = (ReturnObjFromRetrieve)retBoth.getFieldValue(0,"EXTENDED");
	
	if(retDet!=null && retDet.getRowCount()>0)
		retDetCnt = retDet.getRowCount();
	if(retExt!=null && retExt.getRowCount()>0)
		retExtCnt = retExt.getRowCount();
	
	String weightStr = "0";
	String headerText = "";
	String bodyText = "";

	if(retDetCnt>0)
	{
		for(int i=0;i<retDetCnt;i++)
		{
			headerText = retDet.getFieldValueString(i,"HeaderText");
	
			if("Weight".equalsIgnoreCase(headerText.trim()))
			{
				bodyText = retDet.getFieldValueString(i,"BodyText");
				break;
			}
		}
	}
	if(bodyText==null || "null".equalsIgnoreCase(bodyText) || "".equals(bodyText))
	{
		if(retExtCnt>0)
		{
			for(int i=0;i<retExtCnt;i++)
			{
				headerText = retExt.getFieldValueString(i,"HeaderText");

				if("Weight".equalsIgnoreCase(headerText.trim()))
				{
					bodyText = retExt.getFieldValueString(i,"BodyText");
					break;
				}
			}
		}
	}
	if(bodyText!=null && !"null".equalsIgnoreCase(bodyText) && !"".equals(bodyText))
	{
		try
		{
			ezc.ezcommon.EzLog4j.log("bodyText::::::::::::::::::"+bodyText,"D");
			
			if(bodyText.indexOf("oz")!=-1)
			{
				String bodyTextStr[] = bodyText.split("oz");
				weightStr = bodyTextStr[0];
				weightStr = weightStr.trim();
				
				ezc.ezcommon.EzLog4j.log("weightStr oz::::::::::::::::::"+weightStr+"::::::","D");
				
				java.math.BigDecimal weightStr_bd = new java.math.BigDecimal(weightStr);
				weightStr_bd = weightStr_bd.multiply(new java.math.BigDecimal("0.0625"));	//Conversion 1 oz = 0.0625 lbs
				
				weightStr = weightStr_bd.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)+"";
			}
			else if(bodyText.indexOf("lbs")!=-1)
			{
				String bodyTextStr[] = bodyText.split("lbs");
				weightStr = bodyTextStr[0];
				weightStr = weightStr.trim();
				
				ezc.ezcommon.EzLog4j.log("weightStr lbs::::::::::::::::::"+weightStr+"::::::","D");
			}
			
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
