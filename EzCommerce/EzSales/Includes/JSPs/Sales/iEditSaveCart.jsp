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
	String[] prevMatIDs  = null;
	String   prevpNo	  = null;	
	String   prevreqQty	  = null;
	String   prevVenCat	  = null;


	if(cartRows>0){
	
		prevproducts    = new String[cartRows];
		prevreqQtys     = new String[cartRows];
		prevreqDates    = new String[cartRows];
		prevVenCatalogs = new String[cartRows];
		prevMatIDs      = new String[cartRows];
		
		
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
			
			prevMatIDs[i]  =Cart.getMatId(i);

		}

		params    = new EzcShoppingCartParams();
		reqparams = new EziReqParams();
		subparams = new EziShoppingCartParams();

		reqparams.setProducts(prevproducts);
		reqparams.setMatId(prevMatIDs);  
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
		
	int len = myLineID.size();		
	
	String [] products = new String[len];
	String [] reqQtys  = new String[len];
	String [] reqDates = new String[len];
	String [] catalogs = new String[len];
	String [] matIDs   = new String[len];

	String soLine ="";
        int fIndex =0;
	
	for(int i=0;i<retLinesCount;i++)
	{
	   
	    String prodNo 		= retLines.getFieldValueString(i,"PROD_CODE");
	    String custMat              = retLines.getFieldValueString(i,"CUST_MAT");
	    String qty                  = retLines.getFieldValueString(i,"DESIRED_QTY"); 
	    
	    soLine=retLines.getFieldValueString(i,"SO_LINE_NO"); 
	    	    
	    if(myLineID.containsKey(soLine)){

		    if(custMat!=null && !"null".equals(custMat))
			prodNo =custMat.trim();

		    if(prod!=null && desiredQty!=null && prod[i].equals(prodNo))
			qty=desiredQty[i];

		    products[fIndex] = prodNo; 
		    reqQtys[fIndex]  = qty; 
		    reqDates[fIndex] = retLines.getFieldValueString(i,"REQ_DATE"); 
		    reqDates[fIndex] = "1.11.1000" ; 
		    catalogs[fIndex] = retLines.getFieldValueString(i,"VENDOR_CATALOG"); 
		    matIDs[fIndex] = (String)myLineID.get(soLine);
		    
		    fIndex++; 
	    }
	    
	    
	}

	
	
	params    = new EzcShoppingCartParams();
	reqparams = new EziReqParams();
	subparams = new EziShoppingCartParams();

	reqparams.setProducts(products);
	reqparams.setMatId(matIDs); 
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
