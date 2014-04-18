<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>

<%
String catalog_number = null;	
String catalog_desc = null;

String CheckBox = null;
String pCheckBox = null;
String PurArea = null;
String pPurArea = null;

//Venkat commented the following line on 3/29/2001
//as Catalog Number is NumberGenerated
//catalog_number = request.getParameter("CatalogNumber");	
catalog_desc = request.getParameter("CatalogName");

String strCount = request.getParameter("TotalCount");
int Count = new Integer(strCount) .intValue();

// Fill Array of Product groups from Selection
String[] product_groups = new String[1];
for ( int j = 0 ; j < 1; j++ ){
	product_groups[0] = "PUR_GRP";
}

String[] index_array = new String[1];
for ( int k = 0 ; k < 1; k++ ){
	index_array[k] = " ";
}

EzCatalogParams catalogParams = new EzCatalogParams();
for ( int i = 0 ; i < Count; i++ ) {
	CheckBox = "CheckBox_"+i;
	PurArea = "PurArea_"+i;
	pCheckBox = request.getParameter(CheckBox);
	// Check For Addition
	 if ( pCheckBox != null ){
		pPurArea = request.getParameter(PurArea);
		
		catalogParams.setSysKey(pPurArea);
		Session.prepareParams(catalogParams);

            //Venkat Commented the following line on 3/29/2001
            //as Catalog Number is Number Generated
		//catalogParams.setCatalogNumber(catalog_number);
		catalogParams.setLanguage("EN");
		catalogParams.setCatalogDesc(catalog_desc);
		catalogParams.setProducts(product_groups);
		catalogParams.setProductIndicators(index_array);
		//Create Vendor Catalog Call
		ReturnObjFromRetrieve retC = (ReturnObjFromRetrieve) catalogObj.addProductGroupsToCatalog(catalogParams);
            catalog_number = (String) retC.getFieldValue(0,CATALOG_NUMBER);

            catalogParams.setCatalogNumber(catalog_number);
 
		//AdminObject.addProductGroupsToCatalog(servlet, pPurArea, catalog_number, catalog_desc , product_groups, index_array);

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