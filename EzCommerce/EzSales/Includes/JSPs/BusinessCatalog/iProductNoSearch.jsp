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
 String catalogCode = (String)session.getValue("CatalogCode");
 boolean ADDCART			= true;
 if(searchType.equals("PRICE")){
	if( prodFrom.equals("")){
		prodFrom = null;
	} 
	if( prodTo.equals("")){
		prodTo = null;
	} 
  }

    EzcPersonalizationParams ezget = new EzcPersonalizationParams();
    EziPersonalizationParams izget = new EziPersonalizationParams();
    izget.setLanguage("EN");
    izget.setProductFavGroupDesc(prodDesc);
    ezget.setObject(izget);
    Session.prepareParams(ezget);
    retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
    int groupRows = retprodfav.getRowCount();



	String matCode = request.getParameter("MatNo");
	//String id 	= request.getParameter("ID");
	
	
	/*if(matCode!=null)
	{
		try
		{
			
			matCode = Integer.parseInt(matCode.replace('*',' ').trim())+"";
			matCode = "*00000"+matCode+"*";
			
		}
		catch(Exception e)
		{}
	}*/
		
	if(matCode!=null)
		matCode=matCode.replace('*','%');
	
	ArrayList mat = new ArrayList();
	ArrayList Desc = new ArrayList();
	ArrayList Uom = new ArrayList();
	String skey=(String) session.getValue("SalesAreaCode");
	 
	ezc.ezprojections.client.EzProjectionsManager ProjManager = new ezc.ezprojections.client.EzProjectionsManager();
	ezc.ezparam.EzcParams ezcpparams = new ezc.ezparam.EzcParams(true);

	ezc.ezprojections.params.EziProjectionHeaderParams inparamsProj=new ezc.ezprojections.params.EziProjectionHeaderParams();
	
	inparamsProj.setSystemKey(skey+"') AND ECG_CATALOG_NO ='"+catalogCode+"' AND EMM_NO LIKE ('"+matCode);
	//inparamsProj.setSystemKey("999666') AND EMM_NO LIKE ('%A%");
	//inparamsProj.setUserCatalog((String) session.getValue("CatalogCode"));
	
	//inparamsProj.setUserCatalog("14280");
	ezcpparams.setObject(inparamsProj);
	ezcpparams.setLocalStore("Y");
	
	Session.prepareParams(ezcpparams);
	
	
	 	
	ezc.ezparam.ReturnObjFromRetrieve retpro = (ezc.ezparam.ReturnObjFromRetrieve)ProjManager.ezGetMaterialsByCountry(ezcpparams);
	
	
	if(retpro!=null && retpro.getRowCount()>0){
		for(int i=0;i<retpro.getRowCount();i++){
			mat.add(retpro.getFieldValueString(i,"MATNO"));
			Desc.add(retpro.getFieldValueString(i,"MATDESC"));
			Uom.add(retpro.getFieldValueString(i,"UOM"));
		}
	}
	


	int rowCount = mat.size();
	
	
	
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