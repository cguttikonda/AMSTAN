<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%> 
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
	String prodfavgroup = request.getParameter("FavGroup");
	String pGroupDesc   = request.getParameter("GroupDesc");
        String chkProds     = request.getParameter("chkProds");
        java.util.StringTokenizer chkSt = null;
        java.util.StringTokenizer prdSt = null;
        int chkcount =0;
        String prdStr="";
          
        chkSt = new java.util.StringTokenizer(chkProds,"$$");
        
        chkcount = chkSt.countTokens();
        
        String [] products = new String[chkcount];
        String [] vendCatalogs = new String[chkcount];
        String [] matIds = new String[chkcount];
        
        int i=0;
        while(chkSt.hasMoreTokens())
	{
           prdStr = chkSt.nextToken()+"";
           
            prdSt = new java.util.StringTokenizer(prdStr,"~~");
	    while(prdSt.hasMoreTokens())
	    {
		 products[i]	   = prdSt.nextToken();
		 vendCatalogs[i]   = prdSt.nextToken();
		 matIds[i]	   = prdSt.nextToken();
		i++;
	    } 
           
        }  
      
	//To check if they are added or not

	EzCatalogParams ezread = new EzCatalogParams();
       	ezread.setLanguage("EN");
        ezread.setProductGroup(prodfavgroup);
      	Session.prepareParams(ezread);

	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);

	int prodLen = products.length;
        String tempProducts[] = new String[prodLen];
        String tempVendCatalogs[] = new String[prodLen];
        String tempMatIds[] = new String[prodLen];
      	int tempProdIndex=0;
       
	for ( int j = 0; j < prodLen; j++)
	{
		String retProd = matIds[j];
		if ( ret != null && !ret.find("EMM_ID",retProd))
		{
			int foundRow = ret.getRowId("EMM_ID",retProd);
			tempProducts[tempProdIndex] = products[j];
			tempVendCatalogs[tempProdIndex] = vendCatalogs[j];
			tempMatIds[tempProdIndex++] = matIds[j];
		}
	}

	String newProducts[]     = new String[tempProdIndex];
	String newVendCatalogs[] = new String[tempProdIndex];
	String newMatIds[]       = new String[tempProdIndex];
	
        for( int k = 0; k < tempProdIndex; k++)
        {
        	if ( tempProducts[k] != null )
            	{
	               newProducts[k]     = tempProducts[k];
	               newVendCatalogs[k] = tempVendCatalogs[k]+"@@@"+tempMatIds[k];
	               
	               
      	        }
         }
	
	// end of check if they are added or not	

        EzcPersonalizationParams ezcparams = new EzcPersonalizationParams();
        EziPersonalizationParams iparams = new EziPersonalizationParams();
        iparams.setLanguage("EN");
        iparams.setObject(newProducts);
        iparams.setVendorCatalogs(newVendCatalogs);
	iparams.setProductFavGroup(prodfavgroup);
	ezcparams.setObject(iparams);
	Session.prepareParams(ezcparams);
	EzcPersonalizationManager.addUserProdFavMat(ezcparams);
	
   
	
	
%>
