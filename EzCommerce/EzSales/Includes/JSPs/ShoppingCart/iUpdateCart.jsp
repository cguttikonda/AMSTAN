<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>

<%
	int iSuccess = 0;
	String checkbox = null; 
	String product = null; 
	String quantity = null;
	String reqdate = null;
	String venCatalog = null;
	String myMatId    = null;
	String pCheckBox = null; 
	String pProductNumber = null; 
	String pQuantity = null;
	String pReqDate = null;
	String pVenCatalog = null;
	String pMatId      =null;
	
	String [] products = null;
	String [] reqQtys  = null;
	String [] reqDates = null;
	String [] vendCatalogs = null;
	String [] matIds = null;
	
	String [] productsPS = null;
	String [] reqQtysPS  = null;
	String [] reqDatesPS = null;
	String [] vendCatalogsPS = null;
	String [] matIdsPS = null;
	
	String selectedIndex =  request.getParameter("selectedIndex");
	
	//out.println("::selectedIndex::"+selectedIndex+"<Br>");
	
	
	String strTcount =  request.getParameter("TotalCount");
	String pDelFlag = request.getParameter("DelFlag");
	ezc.ezutil.EzSystem.out.println("Total Count: " + strTcount); 
	ezc.ezutil.EzSystem.out.println("Del Flag: " + pDelFlag); 
	


	if ( strTcount != null )
	{
		int totCount = (new Integer(strTcount)).intValue();  
		int selCount =  0;
		
			//out.println("::totCount::"+totCount+"<Br>");

// This is to find the number of selected rows
	for ( int i = 0 ; i < totCount; i++ ) 
	{
		checkbox = "CheckBox_"+i;	
		pCheckBox = request.getParameter(checkbox);
		//************************************************************************
		//*************************************** for PersistentStorage
			productsPS =  new String[totCount];
			reqQtysPS  =  new String[totCount];
			reqDatesPS =  new String[totCount];
                        vendCatalogsPS=new String[totCount];
                        matIdsPS=new String[totCount];
                        
			productsPS[i] = request.getParameter("Product_"+i);
			reqQtysPS[i] = request.getParameter("Quantity_"+i);
			if( (reqQtysPS[i].trim().length()==0)||(reqQtysPS[i]==null) )
			reqQtysPS[i] = "0";
			reqDatesPS[i] = request.getParameter("Reqdate_"+i);
			if((reqDatesPS[i].trim().length()==0)||(reqDatesPS[i]==null))
			reqDatesPS[i]="1.11.1000";
                        vendCatalogsPS[i]=request.getParameter("VendCatalog_"+i);
                        matIdsPS[i]=request.getParameter("matId_"+i);

		//************************************************************************
		//if ( pCheckBox != null )
		
		if(Integer.parseInt(selectedIndex)==i)
		{
		selCount = selCount + 1;
		//out.println("::selCount::"+selCount+"<Br>");
		}
	}//end for
	ezc.ezutil.EzSystem.out.println("Selected Count: " + selCount); 

// Error checking -- No Rows selected
	if ( selCount > 0 ) 
	{
// 	Loop thru the last selection
		products = new String[selCount];
		reqQtys  = new String[selCount];
		reqDates = new String[selCount];
		vendCatalogs=new String[selCount];
		matIds=new String[selCount];
		
		selCount = 0;

// Update the Shopping cart with selected rows values
		for ( int i = 0 ; i < totCount; i++ ) 
		{
			checkbox = "CheckBox_"+i;
			product = "Product_"+i;
			quantity = "Quantity_"+i;
			reqdate = "Reqdate_"+i;
                        venCatalog="VendCatalog_"+i;
                        myMatId   = "matId_"+i;
                        


                        
			pCheckBox = request.getParameter(checkbox);
			//if ( pCheckBox != null )
			if(Integer.parseInt(selectedIndex)==i)
			{
// Get Data from The Local Database
				pProductNumber = request.getParameter(product);
				pQuantity = request.getParameter(quantity);
				pReqDate  = request.getParameter(reqdate);
                                pVenCatalog=request.getParameter(venCatalog);
                                pMatId     = request.getParameter(myMatId);
                                
				/*out.println("::productt::"+pProductNumber+"<Br>");
				out.println("::quantity::"+pQuantity+"<Br>");
				out.println("::reqdate::"+pReqDate+"<Br>");
				out.println("::venCatalog::"+venCatalog+"<Br>");
                        	out.println("::pMatId::"+pMatId+"<Br>");
                        	*/
                                
				ezc.ezutil.EzSystem.out.println("Product: " + pProductNumber); 
				products[selCount] = new String(pProductNumber);
				reqQtys[selCount] = new String(pQuantity);
				//pReqDate is becoming null;
				reqDates[selCount] = new String(pReqDate);
				vendCatalogs[selCount] = new String(pVenCatalog);
				matIds[selCount] = new String(pMatId);
				
								
				selCount++;
			}
		}// End For
	      EzcShoppingCartParams params1 = new EzcShoppingCartParams();
	      EziReqParams reqparams = new EziReqParams();
	      EziShoppingCartParams subparams = new EziShoppingCartParams();

	      reqparams.setProducts(products);
	      reqparams.setReqDate(reqDates);
	      reqparams.setReqQty(reqQtys);
              reqparams.setVendorCatalogs(vendCatalogs);
              reqparams.setMatId(matIds);
             
	      subparams.setType("AF");
	      subparams.setLanguage("EN");
	      subparams.setEziReqParams(reqparams);
	      subparams.setObject(reqparams);

	      params1.setObject(subparams);

	      Session.prepareParams(params1);
		if (pDelFlag.charAt(0) == 'N')
		{
			Object retObj = SCManager.updateCart(params1);
		}else
		{	
		      	
		      	Object retObj = SCManager.deleteCartElement(params1);

			
		}
	pProductNumber = null;
	pQuantity = null;
	pReqDate  = null;
	pVenCatalog=null;
	}
}

%> 

