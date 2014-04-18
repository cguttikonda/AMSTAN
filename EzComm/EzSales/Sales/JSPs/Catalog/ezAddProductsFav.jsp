<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%> 
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%> 
<%
	String prodfavgroup 	= (String)session.getValue("USR_FAV_GRP");
	String pGroupDesc   	= (String)session.getValue("USR_FAV_DESC");
        String chkProds     	= request.getParameter("chkProds");
        String classificationID = request.getParameter("classificationID");
        String categoryID    	= request.getParameter("categoryID");
        
      	ezc.ezcommon.EzLog4j.log("prodfavgroup111:::::::::::::::::::::::"+prodfavgroup,"D");
        ezc.ezcommon.EzLog4j.log("pGroupDesc111:::::::::::::::::::"+pGroupDesc,"D");
        ezc.ezcommon.EzLog4j.log("chkProds111:::::::::::::::::::::"+chkProds,"D");
        ezc.ezcommon.EzLog4j.log("classificationID:::::::::::::::::::::"+classificationID,"D");
	ezc.ezcommon.EzLog4j.log("categoryID:::::::::::::::::::::"+categoryID,"D");
	
        java.util.StringTokenizer chkSt = null;
        java.util.StringTokenizer prdSt = null;
        int chkcount =0;
        String prdStr="";
          
        chkSt = new java.util.StringTokenizer(chkProds,"$$");
        
        chkcount = chkSt.countTokens();
        
        String [] products = new String[chkcount];
        String [] vendCatalogs = new String[chkcount];
        String [] matIds = new String[chkcount];
        String [] itemCat = new String[chkcount];
        String [] type = new String[chkcount];
        String [] newVC = new String[chkcount];
        
        int i=0;
        while(chkSt.hasMoreTokens())
	{
           prdStr = chkSt.nextToken()+"";
           
            prdSt = new java.util.StringTokenizer(prdStr,"~~");
	    while(prdSt.hasMoreTokens())
	    {
		 products[i]	   = prdSt.nextToken();
		 vendCatalogs[i]   = "10";
		 matIds[i]	   = "10";
		 itemCat[i]	   = prdSt.nextToken();
		 type[i]	   = prdSt.nextToken();
		 newVC[i]          = vendCatalogs[i]+"@@@"+matIds[i]+"@@@"+type[i]+"@@@"+itemCat[i];
		i++;
	    } 
           
        }  
      
	//To check if they are added or not

	EzCatalogParams ezread = new EzCatalogParams();
       	ezread.setLanguage("EN");
        ezread.setProductGroup(prodfavgroup);
      	Session.prepareParams(ezread);

	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
	
	ReturnObjFromRetrieve cnetRet = (ReturnObjFromRetrieve)ret.getObject("CNETRET");
	//ezc.ezcommon.EzLog4j.log("cnetRet:::::::::::::::::::::::"+cnetRet.toEzcString(),"D");
	String newProducts[]     = null;
	String newVendCatalogs[] = null;

	if(cnetRet!=null && cnetRet.getRowCount()>0)
	{
		int prodLen = products.length;
		String tempProducts[] = new String[prodLen];
		String tempVendCatalogs[] = new String[prodLen];
		String tempMatIds[] = new String[prodLen];
		String [] tempItemCat = new String[prodLen];
		String [] tempType = new String[prodLen];

		int tempProdIndex=0;

		for ( int j = 0; j < prodLen; j++)
		{
			String retProd = products[j];
			String iCat = itemCat[j];
			boolean pres = false;
			for ( int k = 0; k < cnetRet.getRowCount(); k++)
			{
				if(retProd.equals(cnetRet.getFieldValueString(k,"EPF_MAT_NO")) && iCat.equals(cnetRet.getFieldValueString(k,"EPF_ITEMCAT")))
				{
					pres = true;
					break;
				}
			}


			if(!pres)
			{
				tempProducts[tempProdIndex] = products[j];
				tempVendCatalogs[tempProdIndex] = vendCatalogs[j];
				tempMatIds[tempProdIndex] = matIds[j];
				tempItemCat[tempProdIndex] = itemCat[j];
				tempType[tempProdIndex++] = type[j];
			}
		}

		newProducts     = new String[tempProdIndex];
		newVendCatalogs = new String[tempProdIndex];
		

		for( int k = 0; k < tempProdIndex; k++)
		{
			if ( tempProducts[k] != null )
			{
			       newProducts[k]     = tempProducts[k];
			       newVendCatalogs[k] = tempVendCatalogs[k]+"@@@"+tempMatIds[k]+"@@@"+tempType[k]+"@@@"+tempItemCat[k];


			}
		 }
	}
	else
	{
		newProducts     = products;
		newVendCatalogs = newVC;
	
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
	//ezc.ezcommon.EzLog4j.log("EzcPersonalizationManager:::::::::::::::::::::::","D");
	

%>
