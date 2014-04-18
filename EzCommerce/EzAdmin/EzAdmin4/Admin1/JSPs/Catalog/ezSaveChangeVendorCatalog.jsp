<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page">
</jsp:useBean>

<%
String catalog_number = null;	
String catalog_desc = null;

String CheckBox = null;
String pCheckBox = null;
String PurArea = null;
String pPurArea = null;

catalog_number = request.getParameter("CatalogNumber");	
catalog_desc = request.getParameter("CatalogName");

String strCount = request.getParameter("TotalCount");
int Count = new Integer(strCount) .intValue();

// Fill Array of Product groups from Selection
String[] product_groups = new String[1];
for ( int j = 0 ; j < 1; j++ ){
	product_groups[0] = " ";
}

String[] index_array = new String[1];
for ( int k = 0 ; k < 1; k++ ){
	index_array[k] = " ";
}

for ( int i = 0 ; i < Count; i++ ) {
	CheckBox = "CheckBox_"+i;
	PurArea = "PurArea_"+i;
	pCheckBox = request.getParameter(CheckBox);
	// Check For Addition
	 if ( pCheckBox != null ){
		pPurArea = request.getParameter(PurArea);
		
		//Change Vendor Catalog Call
		//AdminObject.saveProductGroupsToCatalog(servlet, catalog_number, pPurArea, product_groups, index_array);
		EzCatalogParams catalogParams = new EzCatalogParams();
		Session.prepareParams(catalogParams);

	}//End if
}// End For

// Route to Show Catalog
response.sendRedirect("../Catalog/ezListCatalogs.jsp");
%>
<html>
<head>
</head>
<body >
</body>
</html>