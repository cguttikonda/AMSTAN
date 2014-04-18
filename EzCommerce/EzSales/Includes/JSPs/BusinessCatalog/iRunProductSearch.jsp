<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<%
 
 String UserRole 			= (String)session.getValue("UserRole");
 ReturnObjFromRetrieve retProducts 	= null;
 ReturnObjFromRetrieve retprodfav 	= null;

 String prodDesc 			= request.getParameter("ProdDesc");
 String prodFrom 			= request.getParameter("ProdFrom");
 String prodTo 				= request.getParameter("ProdTo");
 String prodSpecs 			= request.getParameter("ProdSpec");
 String searchType 			= request.getParameter("SearchType");
 boolean ADDCART			= true;
 
 if(searchType.equals("PRICE")){
	if( prodFrom.equals("")){
		prodFrom = null;
	} 
	if( prodTo.equals("")){
		prodTo = null;
	} 
  }

    if(prodDesc!=null)
	prodDesc=prodDesc.replace('*',' ');
	
    if(prodSpecs!=null)
	prodSpecs=prodSpecs.replace('*',' ');	
	
    EzcPersonalizationParams ezget = new EzcPersonalizationParams();
    EziPersonalizationParams izget = new EziPersonalizationParams();
    izget.setLanguage("EN");
    izget.setProductFavGroupDesc(prodDesc);
    ezget.setObject(izget);
    Session.prepareParams(ezget);
    retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
    int groupRows = retprodfav.getRowCount();
    
         //Code changes end here
        // Calls for getting Products List
    if(searchType.equals("DESC")){
      //Commented by Venkat on 1/29/2001
     //retProducts = SBObject.searchByProdWebDesc(servlet, prodDesc);
    //Added by Venkat on 1/29/2001
          EzCatalogSearchParams ecppd = new EzCatalogSearchParams();
          EzCatalogParams ezc1 = new EzCatalogParams();
          ecppd.setSearchWebDesc(prodDesc.trim());
          ezc1.setLanguage("EN");
          ezc1.setObject(ecppd);
          Session.prepareParams(ezc1);
          retProducts = (ReturnObjFromRetrieve) EzCatalogManager.searchByProdWebDesc(ezc1);
//Code changes end here
}

 if(searchType.equals("PRICE")){
        //Commented by Venkat on 1/29/2001
       //retProducts = SBObject.searchByProdPriceWebDesc(servlet, prodDesc, prodFrom, prodTo);
      //Added by Venkat on 1/29/2001
          EzCatalogSearchParams ecpprcd = new EzCatalogSearchParams();
          EzCatalogParams ezc2 = new EzCatalogParams();
          ecpprcd.setSearchWebDesc(prodDesc.trim());
          ecpprcd.setFromPrice(prodFrom.trim());
          ecpprcd.setToPrice(prodTo.trim());
          ezc2.setLanguage("EN");
          ezc2.setObject(ecpprcd);
          Session.prepareParams(ezc2);
          retProducts = (ReturnObjFromRetrieve) EzCatalogManager.searchByProdPriceWebDesc(ezc2);
 //Code changes end here
  }

 if(searchType.equals("SPEC")){
      //Commented by Venkat on 1/29/2001
	//retProducts = SBObject.searchByProdSpecs(servlet, prodDesc, prodSpecs);

      //Added by Venkat on 1/29/2001
          EzCatalogSearchParams ecppdsp = new EzCatalogSearchParams();
          EzCatalogParams ezc3 = new EzCatalogParams();
          ecppdsp.setSearchWebDesc(prodDesc.trim());
          ecppdsp.setSearchSpecs(prodSpecs.trim());
          ezc3.setLanguage("EN");
          ezc3.setObject(ecppdsp);
          Session.prepareParams(ezc3);
          retProducts = (ReturnObjFromRetrieve) EzCatalogManager.searchByProdSpec(ezc3);
       //Code changes end here
 }

   //Number of Products
   int prodCount = retProducts.getRowCount();
 %>
 