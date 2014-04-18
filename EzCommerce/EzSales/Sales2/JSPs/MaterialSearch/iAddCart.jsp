
<%@ page import = "ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>


<%
	
	String[] product = request.getParameterValues("product");
	String[] productDesc = request.getParameterValues("productDesc");
	String[] selClassCharacter       = request.getParameterValues("selectedClassCharacter"); 
	String[] selValues       = request.getParameterValues("selectedValues"); 
	String className 	= request.getParameter("className");
	
	
	
	int selCount = 0;
	String checkbox = null; 
	String pCheckBox = null;
	
	if(product!=null)
	{
		for ( int i = 0 ; i < product.length; i++ )
		{
			pCheckBox = request.getParameter("CheckBox_"+i);
			if ( pCheckBox != null )
			{
				selCount = selCount + 1;
			}
		}
	}	
	
	
	
	String [] products = new String[selCount];
	String [] prodDesc = new String[selCount];
	String [] reqQtys  = new String[selCount];
	String [] reqDates = new String[selCount];
	selCount=0;	
	for ( int i = 0 ; i < product.length; i++ )
	{
		checkbox = "CheckBox_"+i;
		pCheckBox = request.getParameter(checkbox);
		if ( pCheckBox != null )
		{
			products[selCount] = product[i];
			prodDesc[selCount] = productDesc[i];
			reqQtys[selCount] = new String("0");
			reqDates[selCount] ="1.11.1000" ;
			selCount++;
		}
	}// End For
	
	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);
	EzShoppingCart Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	Cart.getCatAreaCart((String)session.getValue("SalesAreaCode"));
	
	java.util.ArrayList cartItems=new java.util.ArrayList();
	for(int i=0;i<Cart.getRowCount();i++){
		cartItems.add(Cart.getMaterialNumber(i));

	}
	int myCount=0;
	for(int i = 0; i < selCount; i++)
	{
		if(!cartItems.contains(products[i])){
			myCount++;
		}
	}	
	
	if(myCount>0){
		CartRow myrows[] = new CartRow[myCount];
		myrows = EzShoppingCart.initializeArray(myrows);
		int k=0;
		for(int i = 0; i < selCount; i++)
		{
			if(!cartItems.contains(products[i])){
				myrows[k].setUserID(Session.getUserId());
				myrows[k].setMaterialNumber(products[i]);
				myrows[k].setSystemKey((String)session.getValue("SalesAreaCode"));
				myrows[k].setUOM("EA");
				myrows[k].setUnitPrice("0.0");
				myrows[k].setMultiMediaFlag("F");
				myrows[k].setMaterialDesc(products[i]);
				myrows[k].setCurrency("USD");
				myrows[k].setOrderQty(reqQtys[i]);
				myrows[k].setReqDate(reqDates[i]);
				myrows[k].setActualPriceFlag(" ");
				myrows[k].setVarPriceFlag("F");
				myrows[k].setCreationDate("  ");
				k++;
				
			}
		}
		
		EzcShoppingCartParams params1 = new EzcShoppingCartParams();
		EziReqParams reqparams = new EziReqParams();
		EziShoppingCartParams subparams1 = new EziShoppingCartParams();

		reqparams.setProducts(products);
		reqparams.setReqDate(reqDates);
		reqparams.setReqQty(reqQtys);

		subparams1.setLanguage("EN");
		subparams1.setEziReqParams(reqparams);
		subparams1.setObject(myrows);
		params1.setObject(subparams1);
		Session.prepareParams(params1);
		try{
			SCManager.saveCart(params1);
		}catch(Exception e){}
	}
	
	

       
       
%>