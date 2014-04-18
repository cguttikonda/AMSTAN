<%@ page import = "ezc.ezutil.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>

<%!
// Date Function
	java.util.GregorianCalendar fromDate = null ;
// Convert java.util.Date to java.util.GregorianCalendar
	public java.util.GregorianCalendar getConvertedDate(java.util.GregorianCalendar inDate)
	{
		if ( inDate != null )
			return ( new java.util.GregorianCalendar( inDate.get(inDate.YEAR) , inDate.get(inDate.MONTH), inDate.get(inDate.DATE) ) )	;
		return null;
	}
%>

<%

	EzShoppingCart prevCart = null;
	EzcShoppingCartParams prevparams    = new EzcShoppingCartParams();
	EziShoppingCartParams prevsubparams = new EziShoppingCartParams();
	EziReqParams 	      prevreqparams = null;
	prevsubparams.setLanguage("EN");
	prevparams.setObject(prevsubparams);
	Session.prepareParams(prevparams);
	prevCart = (EzShoppingCart)SCManager.getSavedCart(prevparams);
	
	int rCount = prevCart.getRowCount();
	
	String[] prevproducts = null;
	String[] prevreqQtys  = null;
	String[] prevreqDates = null;
	String   prevpNo	  = null;	
	String   prevreqQty	  = null;
	
	if(rCount>0)
	{
		prevproducts = new String[rCount];
		prevreqQtys  = new String[rCount];
		prevreqDates = new String[rCount];
		
		for(int i=0;i<rCount;i++)
		{
			prevpNo  = prevCart.getMaterialNumber(i)+"";
						
			if(prevpNo!=null && !"null".equals(prevpNo.trim()) && !"".equals(prevpNo.trim()))
				prevproducts[i] = prevpNo;
				
			prevreqQty  = (String)prevCart.getOrderQty(i)+"";
						
			if(prevreqQty!=null && !"null".equals(prevreqQty.trim()) && !"".equals(prevreqQty.trim()))
				prevreqQtys[i] = prevreqQty;
				
			prevreqDates[i] = "1.11.1000";	
		
		}
		
		prevparams    = new EzcShoppingCartParams();
		prevsubparams = new EziShoppingCartParams();
		prevreqparams = new EziReqParams();

		prevreqparams.setProducts(prevproducts);
		prevreqparams.setReqDate(prevreqDates);
		prevreqparams.setReqQty(prevreqQtys);

		prevsubparams.setLanguage("EN");
		prevsubparams.setEziReqParams(prevreqparams);
		prevsubparams.setObject(prevreqparams);

		prevparams.setObject(prevsubparams);
		Session.prepareParams(prevparams);
		try
		{
			Object retObj = SCManager.deleteCartElement(prevparams);
		}
		catch(Exception e)
		{
			out.println("deleteCartElementdeleteCartElementdeleteCartElement EXCEPTION  "+e);
		}
			
	}

	String from 			= request.getParameter("from");
	String CatalogDescription 	= request.getParameter("CatalogDescription");
	String groupDesc 		= request.getParameter("GroupDesc");
	String ProductGroup 		= request.getParameter("ProductGroup");
	String strTcount 		= request.getParameter("TotalCount");
	
	if("ezFavGroupFinalLevel.jsp".equalsIgnoreCase(from))
		ProductGroup =request.getParameter("FavGroup");

	// Return Values for the SaveCart function
	int [] iSuccess = null;
	int selCount = 0;

	String checkbox = null; 
	String product  = null; 
	String reqQty  	= null;

	String pCheckBox = null;
	String pProductNumber = null;
	String pReqQty = null;

	FormatDate formatDate = new FormatDate();

	

	String chkString = "";
	
	if ( strTcount != null )
	{
		int totCount = (new Integer(strTcount)).intValue();
		// This is to find the number of selected rows
		
	
		for ( int i = 0 ; i < totCount; i++ )
		{
			checkbox = "CheckBox_"+i;
			pCheckBox = request.getParameter(checkbox);
			// Check For Selected Count
			if ( pCheckBox != null )
			{
				selCount = selCount + 1;
			}
		}
		
		
		String [] products = new String[selCount];
		String [] reqQtys  = new String[selCount];
		String [] reqDates = new String[selCount];

		selCount = 0;
		// Loop thru the last selection
		for ( int i = 0 ; i < totCount; i++ )
		{

			checkbox = "CheckBox_"+i;
			product  = "Product_"+i;
			reqQty   = "Reqqty_"+i;
			
			pCheckBox = request.getParameter(checkbox);
			//out.println("pCheckBoxpCheckBox  "+pCheckBox);
			// Check For Addition

			 if ( pCheckBox != null )
			{
				pProductNumber = request.getParameter(product);
				chkString =chkString + pProductNumber +",";
				products[selCount] = new String(pProductNumber);
				
				pReqQty  =  request.getParameter(reqQty);
				if(pReqQty!=null && !"null".equals(pReqQty) && !"".equals(pReqQty))
				        reqQtys[selCount] = pReqQty;
				else
					reqQtys[selCount] = new String("0");
					
				// reqDates[selCount] = formatDate.getStringFromDate(getConvertedDate(fromDate));
				reqDates[selCount] ="1.11.1000" ;//formatDate.getStringFromDate(new Date(),".",formatDate.DDMMYYYY);
				selCount++;
			}
		}// End For
		
		if ( products != null || reqQtys != null || reqDates != null )
		{
			// Store selected Products to Shopping cart
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
			  }catch(Exception e){}

			pProductNumber = null;
			products = null;
			reqQtys  = null;
			reqDates  = null;
		}

	}

%>
