<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../ShoppingCart/ezGetProductInfo.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iMethods.jsp"%>
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

	String shipToCode = request.getParameter("shipToCode");
	String soldToCode = request.getParameter("soldToCode");
	String allowed = "Y";

	if(Cart!=null && Cart.getRowCount()>0)
	{
		Hashtable custAttrs = getCustAttrs(shipToCode,Session);

		for(int c=0;c<Cart.getRowCount();c++)
		{
			String prodAttr = (String)Cart.getExt3(c);
			String salesOrg = (String)Cart.getSalesOrg(c);

			try
			{
				String custAttr = (String)custAttrs.get(salesOrg);
				boolean prdAllowed = checkAttributes(prodAttr,custAttr);	// Product/Customer Attributes Check

				if(!prdAllowed)
				{
					allowed = "X";
					break;
				}
			}
			catch(Exception e){}
		}
	}
	out.print("ALLOWED##"+allowed);
%>