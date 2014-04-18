<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>


<%
// Key Variables : Globals in the page
ReturnObjFromRetrieve retcat = null;
ReturnObjFromRetrieve catdesc = null;

String catalog_number = null;
String catalog_description = " ";

//Read All Catalog Numbers
//retcat = AdminObject.getCatalogList(servlet);
EzCatalogParams catalogParams = new EzCatalogParams();
Session.prepareParams(catalogParams);
catalogParams.setLanguage("EN"); // to be filled from the system number
retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);
retcat.check();

//Get number of Catalogs
int numCat = retcat.getRowCount();

if(numCat > 0){
	catalog_number = request.getParameter("CatalogNumber");
	

	if ( catalog_number != null && !catalog_number.equals("sel")) {
		EzCatalogParams catalogParams1 = new EzCatalogParams();
		Session.prepareParams(catalogParams1);
		catalogParams1.setLanguage("EN"); // to be filled from the system number
		catalogParams1.setCatalogNumber(catalog_number);
		//catdesc = AdminObject.getCatalogNumberDesc(servlet, catalog_number);
		catdesc = (ReturnObjFromRetrieve)catalogObj.getCatalogNumberDesc(catalogParams1);
		catdesc.check();
		catalog_description = (String)(catdesc.getFieldValue(0,CATALOG_DESC));
	}
}//end if
%>