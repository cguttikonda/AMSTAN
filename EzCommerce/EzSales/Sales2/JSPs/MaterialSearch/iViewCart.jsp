

<%@ page import = "ezc.shopping.cart.common.*" %>
<%

  	
	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);
	EzShoppingCart Cart = (EzShoppingCart)SCManager.getSavedCart(params);
  	java.util.ArrayList selectedItems=new java.util.ArrayList();
  	int cartCount=0;
  	if(Cart!=null){
		Cart.getCatAreaCart((String)session.getValue("SalesAreaCode"));
		if(Cart!=null){
			cartCount=Cart.getRowCount();
			for(int i=0;i<cartCount;i++){
				selectedItems.add(Cart.getMaterialNumber(i));
			}
		}
	}
	

%>

