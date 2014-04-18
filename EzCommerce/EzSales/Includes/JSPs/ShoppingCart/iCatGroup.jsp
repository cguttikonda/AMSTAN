<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />


<%
	
	
	ReturnObjFromRetrieve retprodfav 	= null;
	String favgroupdesc 			= request.getParameter("FavGroupDesc");
	String favgroupwebdesc 			= request.getParameter("FavWebDesc");
	if ( favgroupdesc != null) favgroupdesc = favgroupdesc.trim();
	if ( favgroupwebdesc != null) favgroupwebdesc = favgroupwebdesc.trim();
		
    	EzcPersonalizationParams ezpparams = new EzcPersonalizationParams();
    	EziPersonalizationParams iparams = new EziPersonalizationParams();
    	iparams.setLanguage("EN");
    	iparams.setProductFavGroupDesc(favgroupdesc);
    	iparams.setProductFavGroupWebDesc(favgroupwebdesc);
    	ezpparams.setObject(iparams);
    	Session.prepareParams(ezpparams);

    	retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezpparams);

        
    	if ( !retprodfav.find("EPGD_DESC",favgroupdesc) )
    	{
    	 	//creating the new group
    	 	EzcPersonalizationManager.addUserProdFavDesc(ezpparams);
    	 	
    	 	
    	 	//this code is used to get the fav group number
    	 	String groupNumber = "";
    	 	String groupDesc = "";
    	 	String webDesc = "";
    	 	String finalGroupNumber="";
    	 	EzcPersonalizationParams ezget = new EzcPersonalizationParams();
		EziPersonalizationParams izget = new EziPersonalizationParams();
		izget.setLanguage("EN");
		ezget.setObject(izget);
		Session.prepareParams(ezget);
		ReturnObjFromRetrieve retFAV = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
		int retprodfavCount=retFAV.getRowCount();
		for ( int i = 0 ; i < retprodfavCount ; i++ )
		{
			groupNumber     = retFAV.getFieldValueString(i,"EPG_NO");
			groupDesc       = retFAV.getFieldValueString(i,"EPGD_DESC");
			webDesc         = retFAV.getFieldValueString(i,"EPGD_WEB_DESC");
			if( webDesc.equals(favgroupwebdesc) || favgroupwebdesc.equals(webDesc) )
			{
				finalGroupNumber = groupNumber;	
			}
			
		}
		
		log4j.log("44444444444444444--- "+finalGroupNumber,"W");
		//end of finding the group number

    	 	//geting the products list from the session object
    	 	String [] products = (String [])session.getAttribute("productscg");
    	 	String [] vendCatalogs = (String [])session.getAttribute("prodCatalogscg");
		
		log4j.log("55555555555555555--- "+products,"W");
		log4j.log("66666666666666666--- "+vendCatalogs,"W");
		
		//this code is used to fill the group with products retrieved from session
		EzcPersonalizationParams ezcparams = new EzcPersonalizationParams();
		EziPersonalizationParams iperparams = new EziPersonalizationParams();
		iperparams.setLanguage("EN");
		iperparams.setObject(products);
		iperparams.setVendorCatalogs(vendCatalogs);
		iperparams.setProductFavGroup(finalGroupNumber);
		ezcparams.setObject(iperparams);
		Session.prepareParams(ezcparams);
		EzcPersonalizationManager.addUserProdFavMat(ezcparams);
		//end of filling the group with products
		
               
		
    	}
    	else
    	{
		response.sendRedirect("../ShoppingCart/ezCreateCatalogGroup.jsp?fd="+favgroupdesc+"&fwd="+favgroupwebdesc); 
    	}
	
%>
