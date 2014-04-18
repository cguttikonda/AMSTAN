<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page">
</jsp:useBean>

<%
	String catalog_number = null;	
	String sys_key = null;


	catalog_number = request.getParameter("CatalogNumber");	
	sys_key = request.getParameter("SystemKey");



	// Fill Array of Product groups from Selection
	String[] product_groups = request.getParameterValues("CheckBox");
	String[] index_array = new String[0];
	
	if(product_groups!=null)
	{
			index_array=new String[product_groups.length];
	
		for ( int j = 0 ; j < product_groups.length; j++ )
		{
			String temp=request.getParameter(product_groups[j]);
			if(temp==null || "null".equals(temp))
				index_array[j] = "N";
			else
				index_array[j]="Y";
		
		
		}
	}


	EzCatalogParams catalogParams = new EzCatalogParams();
	catalogParams.setSysKey(sys_key);
	Session.prepareParams(catalogParams);
	catalogParams.setCatalogNumber(catalog_number);
	catalogParams.setLanguage("EN");
	catalogParams.setProducts(product_groups);
	catalogParams.setProductIndicators(index_array);
	catalogObj.saveProductGroupsToCatalog(catalogParams);

	response.sendRedirect("../Catalog/ezModifyCatalog.jsp?saved=Y&CatalogNumber=" + catalog_number + "&SystemKey="+sys_key);
%>
