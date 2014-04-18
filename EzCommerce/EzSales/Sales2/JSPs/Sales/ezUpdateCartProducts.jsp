<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<%@ page import="java.util.*"%>

<%

	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j();

	String prodCodes 	= request.getParameter("productNo");
	String groupIdStr 	= request.getParameter("groupId");
	String reqDts	 	= request.getParameter("reqDt");
	String reqQtyStr 	= request.getParameter("reqQty");
	String upcStr 		= request.getParameter("upc");
	String pageFlag 	= request.getParameter("pageFlag");
	
	log4j.log("pageFlagpageFlagpageFlag::"+pageFlag+"-->"+prodCodes,"W");
	
	int totalCount 		= 0;
	
	StringTokenizer prodSt	= new StringTokenizer(prodCodes,",");
	StringTokenizer groupSt	= null;
	StringTokenizer upcSt 	= null;
	
	if("ADD".equals(pageFlag))
	{	
		groupSt	= new StringTokenizer(groupIdStr,",");
		upcSt 	= new StringTokenizer(upcStr,",");
	}	
	
	log4j.log("111111111111111111::","W");
	
	totalCount 	 	= prodSt.countTokens(); 
	
	log4j.log("22222222222222222::","W"); 
	
	String [] products 	= new String[totalCount];
	String [] reqQtys  	= new String[totalCount];
	String [] reqDates 	= new String[totalCount];
	String [] groupIds 	= new String[totalCount];
	String [] upcs 		= new String[totalCount];
	
	log4j.log("totalCounttotalCounttotalCount::"+totalCount+"-->"+prodSt,"W");
	
	if(prodSt!=null)
	{
		for(int i=0;i<totalCount;i++)
		{
			products[i] 	= prodSt.nextToken();
			reqDates[i] 	= "0";
			reqQtys[i] 	= "0";
			
			log4j.log("productsproducts::"+products[i],"W");
		}
	}
	if("ADD".equals(pageFlag))
	{
		if(groupSt!=null)
		{
			for(int i=0;i<totalCount;i++)
			{
				groupIds[i] = groupSt.nextToken();
			}
		}
		if(upcSt!=null)
		{
			for(int i=0;i<totalCount;i++)
			{
				upcs[i] = upcSt.nextToken();
			}
		}	
	}

	String product 		= null;
	String quantity 	= null;
	String reqdate 		= null;
	String pProductNumber 	= null;
	String pQuantity	= null;
	String pReqDate 	= null;

	String poNo		= request.getParameter("poNo");
	String poDate		= request.getParameter("poDate");
	String shipTo		= request.getParameter("shipTo");
	String soldTo 		= request.getParameter("soldTo");
	String shipToName	= request.getParameter("shipToName");
	String soldToName	= request.getParameter("soldToName");
	String requiredDate	= request.getParameter("requiredDate");
	String carrierName	= request.getParameter("carrierName");
	String orderDate	= request.getParameter("orderDate");
	String ProductGroup	= request.getParameter("ProductGroup");
	
	EzShoppingCart Cart = null;
	int cartRows       =  0;
	int cartItems      =  0;



	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();

	reqparams.setProducts(products);
	reqparams.setReqDate(reqDates);
	reqparams.setReqQty(reqQtys);

	subparams.setLanguage("EN");
	subparams.setEziReqParams(reqparams);
	
	if(!"ADD".equals(pageFlag))
		subparams.setObject(reqparams);

	params.setObject(subparams);

	Session.prepareParams(params);
	try{
		if("ADD".equals(pageFlag)){
			log4j.log("within ADD:","W");	
			SCManager.saveCart(params);
		}else{
			SCManager.deleteCartElement(params);
		}
		
	Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	
	}catch(Exception e){
		log4j.log("Exception Occured while updating cart:"+e,"W");
	}

	if(Cart!=null && Cart.getRowCount()>0 ){
		cartRows = Cart.getRowCount();
		
		for(int i=0;i<cartRows;i++){
		      try{
		           cartItems+=Double.parseDouble(Cart.getOrderQty(i));
		      }catch(Exception e){

		      }
		}	
		out.print("#"+cartItems+"#");
	}
	
	Hashtable selMet= new Hashtable(); 

	
	selMet = (Hashtable)session.getValue("SELECTEDMET"); 

	log4j.log("selMetselMetselMet before:"+selMet,"W");

	if(selMet!=null)
	{
		if("ADD".equals(pageFlag)) 
		{
			for(int i=0;i<products.length;i++)
			{
				selMet.put(products[i],groupIds[i]+"¥"+upcs[i]); 
			}
		}
		else
		{
			for(int i=0;i<products.length;i++)
			{
				selMet.remove(products[i]);
			}
		}

		session.removeAttribute("SELECTEDMET");
		session.putValue("SELECTEDMET",selMet);
	}
	
	log4j.log("selMetselMetselMet After:"+selMet,"W");
	
	log4j.log("Successfully updated in session:"+selMet,"W");
	
	log4j.log("cartRows:::::::::::::MMMMMMMMMM"+cartRows,"W");   



%>
