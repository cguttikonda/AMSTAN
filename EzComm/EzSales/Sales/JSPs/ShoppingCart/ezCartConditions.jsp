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
	boolean DXVProd = false;
	boolean nonDXVProd = false;
	boolean rpDXVProd = false;

	if(Cart!=null && Cart.getRowCount()>0)
	{
		cartRows = Cart.getRowCount();
		catType_C = Cart.getType(0);  

		for(int c=0;c<Cart.getRowCount();c++)
		{
			String prodDiv = (String)Cart.getCat2(c);

			if("D1".equals(prodDiv) || "D2".equals(prodDiv) || "D3".equals(prodDiv) || "D4".equals(prodDiv) || "D5".equals(prodDiv))
			{
				DXVProd = true;
			}
			else if("D9".equals(prodDiv))
			{
				rpDXVProd = true;
			}
			else
			{
				nonDXVProd = true;
			}
		}
		if(DXVProd || nonDXVProd) rpDXVProd = false;
	}

	if(catType_C==null || "null".equalsIgnoreCase(catType_C) || "".equals(catType_C)) catType_C = "PT";
%>