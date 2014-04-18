<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
	ReturnObjFromRetrieve retprodfav 	= null;
	
	int rowId       =-1;
	String pCatNo   ="";
	
	String favgroupdesc 			= request.getParameter("FavGroupDesc");
	String favgroupwebdesc 			= request.getParameter("FavWebDesc");
	if ( favgroupdesc != null) favgroupdesc = favgroupdesc.trim();
	if ( favgroupwebdesc != null) favgroupwebdesc = favgroupwebdesc.trim();
	
	//Add New Favourite Group
	//Commented by Venkat on 1/29/2001
	//SBObject.addUserProdFavDesc(servlet, favgroupdesc, favgroupwebdesc);

	//Venkat Added the following code on 1/29/2001
    	EzcPersonalizationParams ezpparams = new EzcPersonalizationParams();
    	EziPersonalizationParams iparams = new EziPersonalizationParams();
    	
    	ezc.ezparam.EzCatalogParams ezcparams = new ezc.ezparam.EzCatalogParams();
    	ezc.ezparam.EzWebCatalogSearchParams ezwebparams = new ezc.ezparam.EzWebCatalogSearchParams();
    	
    	 
    	iparams.setLanguage("EN");
    	iparams.setProductFavGroupDesc(favgroupdesc);
    	iparams.setProductFavGroupWebDesc(favgroupwebdesc);
    	ezpparams.setObject(iparams);
    	Session.prepareParams(ezpparams);

    	retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezpparams);
    	
    	

    	if ( !retprodfav.find("EPGD_DESC",favgroupdesc) )
    	{
    	 	EzcPersonalizationManager.addUserProdFavDesc(ezpparams);
    	 	
    	 	retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezpparams);
    	 	
    	 	if(retprodfav!=null && retprodfav.getRowCount()>0)
    	 		rowId = retprodfav.getRowId("EPGD_DESC",favgroupdesc);
    	 		
    	 	pCatNo=retprodfav.getFieldValueString(rowId,"EPG_NO");
    	 	
    	 	if(pCatNo!=null && !"".equals(pCatNo))
    	    		pCatNo=pCatNo.trim();
    	    
    	 	/*
    	 	ezwebparams.setCatalogCode(pCatNo);
    	 	ezwebparams.setCatalogType("CP");
    	 	ezcparams.setObject(ezwebparams);
    	 	Session.prepareParams(ezcparams);
    	 	EzWebCatalogManager.maintainCatalogView(ezcparams);
    	 	*/
    	}
    	else
    	{
		//response.sendRedirect("../../../Sales2/JSPs/BusinessCatalog/ezAddGroup.jsp?fd="+favgroupdesc+"&fwd="+favgroupwebdesc); 
		response.sendRedirect("../BusinessCatalog/ezAddGroup.jsp?fd="+favgroupdesc+"&fwd="+favgroupwebdesc); 
    	}
	//Code changes end here
%>

