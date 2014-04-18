<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%!
// Start Declarations
final String CATALOG_NUMBER = "ECG_CATALOG_NO";
final String CATALOG_SYSTEM_KEY = "ECG_SYS_KEY";
final String CATALOG_PRODUCT_GROUP = "ECG_PRODUCT_GROUP";

final String CATALOG_DESC_NUMBER = "EPC_NO";
final String CATALOG_DESC_LANG = "EPC_LANG";
final String CATALOG_DESC = "EPC_NAME";
//End Declarations
%>

<%

String websyskey=request.getParameter("WebSysKey");
String Area=request.getParameter("Area");
// Key Variables : Globals in the page
ReturnObjFromRetrieve retinfo = null;
ReturnObjFromRetrieve retcat = null;
ReturnObjFromRetrieve retconfig = null;
ReturnObjFromRetrieve retbp = null;
ReturnObjFromRetrieve retbpsys = null;
ReturnObjFromRetrieve retcatsys = null;
ReturnObjFromRetrieve retcatdesc = null;

String Bus_Partner = "";
String catalog_number = "";
String catalog_description = "";
String BPDesc="";
//Read All Catalog Numbers
EzCatalogParams cparams = new EzCatalogParams();
cparams.setLanguage("EN");
Session.prepareParams(cparams);
retcat = (ReturnObjFromRetrieve)CatalogManager.getCatalogList(cparams);
retcat.check();

// Get Business Partners
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage("EN");
bparams.setObject(bnkparams);
Session.prepareParams(bparams);
retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
retbp.check();

int numBP = retbp.getRowCount();
if(numBP > 0){
//Get Business Partner Value
Bus_Partner = request.getParameter("chk1");
 BPDesc=request.getParameter("BPDesc");
if (Bus_Partner == null) {
	Bus_Partner = (retbp.getFieldValue(0,BP_NUMBER)).toString();
}

// Get Business Partner Basic Information
EzcBussPartnerParams bparams1 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams1 = new EzcBussPartnerNKParams();
bparams1.setBussPartner(Bus_Partner);
bnkparams1.setLanguage("EN");
bparams1.setObject(bnkparams1);
Session.prepareParams(bparams1);
retinfo = (ReturnObjFromRetrieve)BPManager.getBussPartnerInfo(bparams1);
retinfo.check();

// Get Business Partner Config
EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
bparams2.setBussPartner(Bus_Partner);
bnkparams2.setLanguage("EN");
bparams2.setObject(bnkparams2);
Session.prepareParams(bparams2);
retconfig = (ReturnObjFromRetrieve)BPManager.getBussPartnerConfig(bparams2);
retconfig.check();

catalog_number = ((java.math.BigDecimal)(retconfig.getFieldValue(0,BP_CATALOG))).toString();
if ( catalog_number != null ) {
EzCatalogParams cparams1 = new EzCatalogParams();
cparams1.setLanguage("EN");
cparams1.setCatalogNumber(catalog_number);
Session.prepareParams(cparams1);
retcatdesc = (ReturnObjFromRetrieve)CatalogManager.getCatalogNumberDesc(cparams1);
retcatdesc.check();
	catalog_description = (String)(retcatdesc.getFieldValue(0,CATALOG_DESC));
}

//Get the systems for the BP
EzcBussPartnerParams bparams3 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams3 = new EzcBussPartnerNKParams();
bparams3.setBussPartner(Bus_Partner);
bnkparams3.setLanguage("EN");
bparams3.setObject(bnkparams3);
Session.prepareParams(bparams3);
retbpsys = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystems(bparams3);
retbpsys.check();

//Get the systems for the catalog
EzCatalogParams cparams2 = new EzCatalogParams();
cparams2.setLanguage("EN");
cparams2.setCatalogNumber(catalog_number);
Session.prepareParams(cparams2);
retcatsys = (ReturnObjFromRetrieve)CatalogManager.getCatSysNos(cparams2);
retcatsys.check();
}
%>