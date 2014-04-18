<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../Lib/AdminUtilsBean.jsp"%>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%@ page import = "ezc.sales.client.*" %>

<%
  	String venCatalog = request.getParameter("catalog");
  	String type       = request.getParameter("type");
  	
  	String[] pCheckBox = request.getParameterValues("chk1");
  	String prdStr="'";
  	
  	/***************** Delete products ***********************/
  	
	int pCheckLen=0;

	if("S".equals(type) && pCheckBox!=null)
	{
	 pCheckLen = pCheckBox.length;

	    for(int i=0;i<pCheckBox.length;i++)
	    {
	       if(i==0)
		    prdStr+=pCheckBox[i].trim()+"','" ;
	       else
		    prdStr+=pCheckBox[i].trim()+"','" ;
	    }

	  if(prdStr.indexOf(",")>0)
		prdStr = prdStr.substring(0,prdStr.length()-2);
	}

	if(venCatalog!=null && !"null".equals(venCatalog) && type!=null && !"null".equals(type))
	{
	EzSalesOrderManager ezManager=new EzSalesOrderManager();
	EzcParams ezcParams=new EzcParams(false);
	EzCatalogParams catParams = new EzCatalogParams();

	if("A".equals(type)){
	   catParams.setType("A");
	}else{
	   catParams.setType("S");
	   catParams.setMatId(prdStr);
	}
	catParams.setCatalogNumber("'"+venCatalog+"'");
	ezcParams.setObject(catParams);
	Session.prepareParams(ezcParams);
	Object o = ezManager.ezDeleteMatSynch(ezcParams);

	}
  	
  	/*************************************************************/
  	
  	
  	String cat_num=null;
  	
  	ReturnObjFromRetrieve ret  = null;
    	
    	ReturnObjFromRetrieve retcat = null;
	int retCatCount =0;
	int retCount=0;
	
	EzCatalogParams catalogParams = new EzCatalogParams();
	Session.prepareParams(catalogParams);
	catalogParams.setLanguage("EN");
	retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);
	retcat.check();
	
		
	if(retcat!=null){
		retCatCount= retcat.getRowCount();
	}   
		
	if(venCatalog!=null)
	{
		
		/*
		EzCatalogParams catalogParams1 = new EzCatalogParams();
		EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();
		searchParams.setSearchType("C");
		searchParams.setCatalogType("V");
		searchParams.setCatalogCode(venCatalog);
		//catalogParams1.setSysKey(skey);
		catalogParams1.setLanguage("EN");
		catalogParams1.setObject(searchParams);
		catalogParams1.setLocalStore("Y");
		Session.prepareParams(catalogParams1);

		ret =(ReturnObjFromRetrieve)webCatalogObj.searchByOptions(catalogParams1);
		*/
		
		EziMaterialSearchParams searchParams = new EziMaterialSearchParams();
		searchParams.setCatalog(venCatalog);
		
		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(searchParams);
		Session.prepareParams(mainParams);
		
		ret = (ReturnObjFromRetrieve)AUM.searchMaterials(mainParams);

		if(ret!=null)
		   retCount = ret.getRowCount();
	}
	
	     
	  	  	
  	
%>


