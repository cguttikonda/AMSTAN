<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page">
</jsp:useBean>
<%

// Key Variables

String sys_key = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retcat = null;
int retObjCount =0;
int retCatCount =0;


// Get List Of System Keys

EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);

retsyskey = (ReturnObjFromRetrieve)ezsc.getCatalogAreas(sparams);
retsyskey.check();

// Key Variables


EzCatalogParams catalogParams = new EzCatalogParams();
Session.prepareParams(catalogParams);
catalogParams.setLanguage("EN");
retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);
retcat.check();

if(retsyskey!=null){
	retObjCount= retsyskey.getRowCount();
}

if(retcat!=null){
	retCatCount= retcat.getRowCount();
}




%>