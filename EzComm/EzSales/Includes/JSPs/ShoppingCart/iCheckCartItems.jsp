<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%
	EzShoppingCartManager SCManager_C = new EzShoppingCartManager(Session);

	EzcShoppingCartParams params_C = new EzcShoppingCartParams();
	EziShoppingCartParams subparams_C = new EziShoppingCartParams();

	EzShoppingCart Cart_C = null;
	subparams_C.setLanguage("EN");
	params_C.setObject(subparams_C);
	Session.prepareParams(params_C);

	try
	{
		Cart_C = (EzShoppingCart)SCManager_C.getSavedCart(params_C);
	}
	catch(Exception err){}

	String catType_C = "";

	if(Cart_C!=null && Cart_C.getRowCount()>0)
	{
		catType_C = (String)Cart_C.getType(0);
	}
%>