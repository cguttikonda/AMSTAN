<%@ page import = "ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	EzShoppingCartManager SCManager = new EzShoppingCartManager( Session );
	String matId    =  request.getParameter("matId");
	String product  =  request.getParameter("product");
	String quantity =  request.getParameter("quantity");
	String catalog  =  request.getParameter("catalog");
	String cartQty  =  request.getParameter("cartQty");
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
	
	String[] discPer_A	= new String[1]; 
	String[] discCode_A	= new String[1];
	String[] orgPrice_A	= new String[1];
	

	matIds[0] = matId;
	products[0] = product;
	reqQtys[0]  = reqQty;
	reqDates[0] ="1.11.1000";
	catalogs[0] = catalog;
	
	discPer_A[0] = "N/A";
	discCode_A[0] = "N/A";
	orgPrice_A[0] = "N/A";

	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	reqparams.setMatId(matIds);
	reqparams.setProducts(products);
	reqparams.setReqDate(reqDates);
	reqparams.setReqQty(reqQtys);
	reqparams.setVendorCatalogs(catalogs);

	reqparams.setDiscPer(discPer_A);
	reqparams.setDiscCode(discCode_A);
	reqparams.setOrgPrice(orgPrice_A);
	
	subparams.setType("AF");
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
