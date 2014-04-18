<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/Lib/ShoppingCartBean.jsp"%>

<%
	try
	{
		int [] iSuccess = null;
		int selCount = Integer.parseInt(request.getParameter("Count"));
		String addCartFrom=request.getParameter("From");
		addCartFrom="PS";
		String checkbox = null; 
		String product = null; 

		String pCheckBox = null;
		String pProductNumber = null;
		String pValue =  request.getParameter("pValue");
		String pdValue =  request.getParameter("pdValue");
		String qValue =  request.getParameter("qValue");
		if(pdValue==null)pdValue="";
		StringTokenizer st = new StringTokenizer(pValue,"$");
		StringTokenizer st1 = new StringTokenizer(qValue,"$");
		StringTokenizer st2 = new StringTokenizer(pdValue,"$");
		FormatDate formatDate = new FormatDate();

		String chkString = "";

		String [] products = new String[selCount];
		String [] productDesc = new String[selCount];
		String [] reqQtys  = new String[selCount];
		String [] reqDates = new String[selCount];

		selCount = 0;

		while(st.hasMoreTokens())
		{
			products[selCount] =new String((String)st.nextToken());
			reqQtys[selCount]  =new String((String)st1.nextToken());
			reqDates[selCount] ="1.11.1000" ;
			if("PS".equals(addCartFrom)){
				productDesc[selCount] = new String((String)st2.nextToken());
			}	
			selCount++;
		}	

		if ( products != null || reqQtys != null || reqDates != null )
		{

			if(!"PS".equals(addCartFrom))
			{
				EzcShoppingCartParams params = new EzcShoppingCartParams();
				EziReqParams reqparams = new EziReqParams();
				EziShoppingCartParams subparams = new EziShoppingCartParams();

				reqparams.setProducts(products);
				reqparams.setReqDate(reqDates);
				reqparams.setReqQty(reqQtys);

				subparams.setLanguage("EN");
				subparams.setEziReqParams(reqparams);

				params.setObject(subparams);

				Session.prepareParams(params);
				try{
					SCManager.saveCart(params);
					SCManager.updateCart(params);
				}catch(Exception e){
					out.println("Exception "+e);
				}
				pProductNumber = null;
				products = null;
				reqQtys  = null;
				reqDates  = null;
			}
			else
			{
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
							myrows[k].setMaterialDesc(productDesc[i]);
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
			}
		}



	}catch(Exception e){}

%>
