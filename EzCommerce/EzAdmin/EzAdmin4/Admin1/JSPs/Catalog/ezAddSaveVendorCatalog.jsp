 <%@ page import = "ezc.ezcommon.*" %>
 <%@ page import = "ezc.ezparam.*" %>
 <%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
 <%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
 <jsp:useBean id="EzWebCatalogManager" class="ezc.client.EzWebCatalogManager"/>
 
 <%
 	String sysKey = request.getParameter("SystemKey");
 	String catalogName = request.getParameter("CatalogName");
 	ReturnObjFromRetrieve retcat = null;
 	String vCatNo="";
 	int rowId=-1;
 	
 	EzCatalogParams catalogParams = new EzCatalogParams();
 	EzWebCatalogSearchParams ezwebparams = new EzWebCatalogSearchParams();
 	
	catalogParams.setSysKey(sysKey);
	Session.prepareParams(catalogParams);
	catalogParams.setLanguage("EN");
	catalogParams.setCatalogDesc(catalogName);
	catalogParams.setProducts(new String[0]);
	catalogParams.setProductIndicators(new String[0]);
	
	ReturnObjFromRetrieve retC = (ReturnObjFromRetrieve) catalogObj.addProductGroupsToCatalog(catalogParams);
	
	/******* List of catalogs *********/
	
	catalogParams.setLanguage("EN");
	Session.prepareParams(catalogParams);
	retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);

        /*********************************/
                               
	if(retcat!=null && retcat.getRowCount()>0)
		rowId = retcat.getRowId("EPC_NAME",catalogName);

	vCatNo=retcat.getFieldValueString(rowId,"EPC_NO");
    	
    	if(vCatNo!=null && !"".equals(vCatNo))
    	    vCatNo=vCatNo.trim();
    		
	/*
	ezwebparams.setCatalogCode(vCatNo);
	ezwebparams.setCatalogType("CV");
	catalogParams.setObject(ezwebparams);
	Session.prepareParams(catalogParams);
	EzWebCatalogManager.maintainCatalogView(catalogParams);
	*/
		
	response.sendRedirect("ezAddVendorCatalog.jsp");
 	
 %>