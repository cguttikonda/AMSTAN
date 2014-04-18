<%@ page import = "ezc.ezutil.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>

<%
	
	String product  =  request.getParameter("product");
	String quantity =  request.getParameter("quantity");
	String catalog  =  request.getParameter("catalog");
        int cartRows    =  0;
	
	
	

	String [] products = new String[1];
	String [] reqQtys  = new String[1];
	String [] reqDates = new String[1];
	String [] catalogs = new String[1];


	products[0] = product;
	reqQtys[0]  = quantity;
	reqDates[0] ="1.11.1000" ;
	catalogs[0] = catalog;

	// Store selected Products to Shopping cart
	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	reqparams.setProducts(products);
	reqparams.setReqDate(reqDates);
	reqparams.setReqQty(reqQtys);
	reqparams.setVendorCatalogs(catalogs);
	subparams.setType("AF");
	subparams.setLanguage("EN");
	subparams.setEziReqParams(reqparams);
	params.setObject(subparams);
	Session.prepareParams(params);

	try{
		SCManager.saveCart(params);
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
		out.print("¥"+cartRows+"¥");
	}
	

	

%>
