
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>


<%!
// Start Declarations
final String CATALOG_DESC_NUMBER = "EPC_NO";
final String CATALOG_DESC_LANG = "EPC_LANG";
final String CATALOG_DESC = "EPC_NAME";
//End Declarations
%>

<%

// Key Variables
ReturnObjFromRetrieve retcat = null;

//Read All Catalog Numbers
EzCatalogParams cparams = new EzCatalogParams();
cparams.setLanguage("EN");
Session.prepareParams(cparams);
//retcat = AdminObject.getCatalogList(servlet);
retcat = (ReturnObjFromRetrieve)CatalogManager.getCatalogList(cparams);
retcat.check();
%>