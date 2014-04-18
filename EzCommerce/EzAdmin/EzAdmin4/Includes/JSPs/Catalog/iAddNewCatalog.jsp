<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>

<%
	
	String catalog_number = null;	
	String catalog_desc = null;
	String sys_key = null;

	String checkbox = null;
	String product_group = null;
	String pProductGroup = null;
	String MainIndex = null;
	String pMainIndex = null;
	String pCheckBox = null;
	String pFinalFlag = null;

	catalog_desc = request.getParameter("CatalogName");
	sys_key = request.getParameter("SystemKey");
	
	
	
	
	
	
// Fill Array of Product groups from Selection
String[] product_groups = request.getParameterValues("CheckBox");
String[] index_array = new String[product_groups.length];

String temp=null;
for ( int j = 0 ; j < product_groups.length; j++ )
{
	temp=request.getParameter(product_groups[j]);
	if(temp==null || "null".equals(temp))
		index_array[j] = "N";
	else
		index_array[j]="Y";
	
	
}

// Add the Selcted Product Groups to the Catalog Number
EzCatalogParams catalogParams = new EzCatalogParams();
catalogParams.setSysKey(sys_key);
Session.prepareParams(catalogParams);
catalogParams.setLanguage("EN");
catalogParams.setCatalogDesc(catalog_desc);
catalogParams.setProducts(product_groups);
catalogParams.setProductIndicators(index_array);

ReturnObjFromRetrieve retC = (ReturnObjFromRetrieve) catalogObj.addProductGroupsToCatalog(catalogParams);
catalog_number = (String) retC.getFieldValue(0,CATALOG_NUMBER);

response.sendRedirect("ezListCatalogs.jsp");

%>