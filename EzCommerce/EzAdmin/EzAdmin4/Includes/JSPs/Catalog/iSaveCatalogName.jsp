<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page">
</jsp:useBean>

<%
String catalog_number = request.getParameter("CatalogNumber");	
String catalog_desc = request.getParameter("NewCatDesc");

//Update Catalog Description
//AdminObject.updateCatalogDesc(servlet, catalog_number, catalog_desc);
EzCatalogParams catalogParams = new EzCatalogParams();
Session.prepareParams(catalogParams);

EZC_PRODUCT_CATALOG pCat = new EZC_PRODUCT_CATALOG();
pCat.setEPC_NO(Long.parseLong(catalog_number));
pCat.setEPC_LANG("EN");
pCat.setEPC_NAME(catalog_desc);
pCat.setEPC_BUSS_INDICATOR("");
catalogParams.setObject(pCat);

Object ret = catalogObj.updateCatalogDesc(catalogParams);

//Redirect to change description page
response.sendRedirect("../Catalog/ezCatalogName.jsp?saved=Y&CatalogNumber="+ catalog_number);
%>