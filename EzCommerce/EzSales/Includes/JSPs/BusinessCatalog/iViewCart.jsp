<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<%

	EzShoppingCartManager SaveCartManager = new EzShoppingCartManager( Session );
  	
  	
	EzShoppingCart Cart = null;

// Get The Whole Shopping Cart
/*Added By Venu*/
	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);
	Cart = (EzShoppingCart)SaveCartManager.getSavedCart(params);
	//out.println(Cart.getRowCount());
/*End Of Addition*/

	String from 		= request.getParameter("from");
	String ProductGroup 	= request.getParameter("ProductGroup");
	if("ezFavGroupFinalLevel.jsp".equalsIgnoreCase(from))  ProductGroup = request.getParameter("FavGroup");

%>
