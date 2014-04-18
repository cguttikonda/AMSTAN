<%@ page import = "ezc.ezutil.*" %>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>

<%
	
	String from = request.getParameter("frmConfirm");
	String[] desiredQty = request.getParameterValues("desiredQty");
	String[] prod = request.getParameterValues("prodNo");
	
	int cartRows       =  0;
	int cartItems      =  0;
	int retLinesCount  =  0;
	
	EzShoppingCart Cart = null;
	
	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();

	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);
	try{
		Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	}catch(Exception err){

	}
	if(Cart!=null && Cart.getRowCount()>0 )
		cartRows = Cart.getRowCount();
		

 if(!"confirm".equals(from) )
 {	
	
	String[] prevproducts     = null;
	String[] prevreqQtys      = null;
	String[] prevreqDates     = null;
	String[] prevVenCatalogs  = null;
	String   prevpNo	  = null;	
	String   prevreqQty	  = null;
	String   prevVenCat	  = null;


	if(cartRows>0){
	
		prevproducts    = new String[cartRows];
		prevreqQtys     = new String[cartRows];
		prevreqDates    = new String[cartRows];
		prevVenCatalogs = new String[cartRows];
		
		for(int i=0;i<cartRows;i++){
			
			prevpNo  = Cart.getMaterialNumber(i)+"";
			
			if(prevpNo!=null && !"null".equals(prevpNo.trim()) && !"".equals(prevpNo.trim()))
				prevproducts[i] = prevpNo;

			prevreqQty  = (String)Cart.getOrderQty(i)+"";

			if(prevreqQty!=null && !"null".equals(prevreqQty.trim()) && !"".equals(prevreqQty.trim()))
				prevreqQtys[i] = prevreqQty;
				
			prevVenCat  = (String)Cart.getVendorCatalog(i)+"";
				
			if(prevVenCat!=null && !"null".equals(prevVenCat.trim()) && !"".equals(prevVenCat.trim()))
				prevVenCatalogs[i] = prevVenCat;

			prevreqDates[i] = "1.11.1000";	

		}

		params    = new EzcShoppingCartParams();
		reqparams = new EziReqParams();
		subparams = new EziShoppingCartParams();

		reqparams.setProducts(prevproducts);
		reqparams.setReqDate(prevreqDates);
		reqparams.setReqQty(prevreqQtys);
		reqparams.setVendorCatalogs(prevVenCatalogs);
                subparams.setType("AF");
		subparams.setLanguage("EN");
		subparams.setEziReqParams(reqparams);
		subparams.setObject(reqparams);

		params.setObject(subparams);
		Session.prepareParams(params);
		try{
			Object retObj = SCManager.deleteCartElement(params);
			Cart = (EzShoppingCart)SCManager.getSavedCart(params);
		}
		catch(Exception e){ }
		
		if(Cart!=null && Cart.getRowCount()>0 )
		   	cartRows = Cart.getRowCount();
		
		
	}

	if(retLines!=null)
		retLinesCount = retLines.getRowCount();
	
	String [] products = new String[retLinesCount];
	String [] reqQtys  = new String[retLinesCount];
	String [] reqDates = new String[retLinesCount];
	String [] catalogs = new String[retLinesCount];

	
	
	for(int i=0;i<retLinesCount;i++)
	{
	   
	    String prodNo 		= retLines.getFieldValueString(i,"PROD_CODE");
	    String custMat          = retLines.getFieldValueString(i,"CUST_MAT");
	    String qty              = retLines.getFieldValueString(i,"DESIRED_QTY");

	    if(custMat!=null && !"null".equals(custMat))
		prodNo =custMat.trim();
		    	
	    if(prod!=null && desiredQty!=null && prod[i].equals(prodNo))
	   	qty=desiredQty[i];
	
	    products[i] = prodNo;
	    reqQtys[i]  = qty;
	    reqDates[i] = retLines.getFieldValueString(i,"REQ_DATE");
	    reqDates[i] = "1.11.1000" ;
	    catalogs[i] = retLines.getFieldValueString(i,"VENDOR_CATALOG");
	    
	    
	}

	
	
	params    = new EzcShoppingCartParams();
	reqparams = new EziReqParams();
	subparams = new EziShoppingCartParams();

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
		Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	}catch(Exception e){
	
	}
	
	
	if(Cart!=null && Cart.getRowCount()>0 )
		cartRows = Cart.getRowCount();
	
                
       	for(int i=0;i<cartRows;i++){
       		try{
       		   cartItems+=Double.parseDouble(Cart.getOrderQty(i));
       		}catch(Exception e){
       
       		}
       	}

	
                
 }	
		
%>
