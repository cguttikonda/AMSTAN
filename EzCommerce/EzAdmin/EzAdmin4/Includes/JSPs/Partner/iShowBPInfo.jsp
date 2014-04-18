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
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retinfo = null;
ReturnObjFromRetrieve retconfig = null;
ReturnObjFromRetrieve retbpsys = null;
ReturnObjFromRetrieve retcat = null;
String lang = "EN";
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
bnkparams.setLanguage(lang);
bparams.setObject(bnkparams);
Session.prepareParams(bparams);

//Get the list of systems
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage(lang);
sparams.setObject(snkparams);
Session.prepareParams(sparams);
ret = (ReturnObjFromRetrieve)sysManager.getSystemDesc(sparams);
ret.check();

//Read All Catalog Numbers
//retcat = AdminObject.getCatalogList(servlet);

EzCatalogParams cparams = new EzCatalogParams();
cparams.setLanguage(lang);
Session.prepareParams(cparams);
retcat = (ReturnObjFromRetrieve)CatalogManager.getCatalogList(cparams);
//retcat.check();

//Get Business Partner Value
String BusPartner = request.getParameter("BusPartner");


// Get Business Partner Basic Information
//retinfo = AdminObject.getBussPartnerInfo(servlet, BusPartner);
EzcBussPartnerParams bparams1 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams1 = new EzcBussPartnerNKParams();
bparams1.setBussPartner(BusPartner);
bnkparams1.setLanguage(lang);
bparams1.setObject(bnkparams1);
Session.prepareParams(bparams1);

retinfo = (ReturnObjFromRetrieve)BPManager.getBussPartnerInfo(bparams1);
retinfo.check();

// Get Business Partner Config
//retconfig = AdminObject.getBussPartnerConfig(servlet, BusPartner);
EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
bparams2.setBussPartner(BusPartner);
bnkparams2.setLanguage(lang);
bparams2.setObject(bnkparams2);
Session.prepareParams(bparams2);
retconfig = (ReturnObjFromRetrieve)BPManager.getBussPartnerConfig(bparams2);
retconfig.check();

//Get the systems for the BP
//retbpsys = AdminObject.getBussPartnerSystems(servlet, BusPartner);
EzcBussPartnerParams bparams3 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams3 = new EzcBussPartnerNKParams();
bparams3.setBussPartner(BusPartner);
bnkparams3.setLanguage(lang);
bparams3.setObject(bnkparams3);
Session.prepareParams(bparams3);
retbpsys = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystems(bparams3);
retbpsys.check();
%>