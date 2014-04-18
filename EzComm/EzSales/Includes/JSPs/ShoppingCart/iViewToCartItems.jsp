<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%
	String categoryID  =  request.getParameter("categoryID"); 
	String categoryDesc  =  request.getParameter("categoryDesc");
	String webOrdNo	= request.getParameter("webOrdNo");
	//out.println("categoryDesc:::"+categoryDesc+"categoryID:::"+categoryID);
	EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);

	EzcShoppingCartParams params = new EzcShoppingCartParams();
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
%>