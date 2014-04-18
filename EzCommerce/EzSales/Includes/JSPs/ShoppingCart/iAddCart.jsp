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

	String from 			= request.getParameter("from");
	String CatalogDescription 	= request.getParameter("CatalogDescription");
	String groupDesc 		= request.getParameter("GroupDesc");
	String ProductGroup 		= request.getParameter("ProductGroup");
	String strTcount 		= request.getParameter("TotalCount");
	String catalogNo 		= request.getParameter("CatalogNo");
	
	
	if("ezFavGroupFinalLevel.jsp".equalsIgnoreCase(from))
		ProductGroup =request.getParameter("FavGroup");

	// Return Values for the SaveCart function
	int [] iSuccess = null;
	int selCount = 0;

	String checkbox = null; 
	String product  = null; 
	String reqQty  	= null;
	String vendCatalog = null;

	String pCheckBox = null;
	String pProductNumber = null;
	String pReqQty = null;
	String pVendCatalog = null;

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
		String [] vendCatalogs = new String[selCount];

		selCount = 0;
		// Loop thru the last selection
		for ( int i = 0 ; i < totCount; i++ )
		{

			checkbox = "CheckBox_"+i;
			product  = "Product_"+i;
			reqQty   = "Reqqty_"+i;
			vendCatalog ="VendCatalog_" + i;
			pCheckBox = request.getParameter(checkbox);
			
			
			//out.println("pCheckBoxpCheckBox  "+pCheckBox);
			// Check For Addition

			if ( pCheckBox != null )
			{
				pProductNumber = request.getParameter(product);
				pVendCatalog = request.getParameter(vendCatalog);
				
				chkString =chkString + pProductNumber +",";
				products[selCount] = new String(pProductNumber);
				vendCatalogs[selCount] = new String(pVendCatalog);
				
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
			      reqparams.setVendorCatalogs(vendCatalogs);
			      reqparams.setReqQty(reqQtys);
			      subparams.setType("AF");
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
