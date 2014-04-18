<%@ include file="../../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../../Includes/Lib/Defaults.jsp"%>
<%@ include file="../../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
// Key Variables
ReturnObjFromRetrieve retlang = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retdeftype = null;

EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);

retlang = (ReturnObjFromRetrieve)sysManager.getAllLangKeys(sparams);
retlang.check();

//Get All Catalog Areas
EzcSysConfigParams sparams1 = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
snkparams1.setLanguage("EN");
sparams1.setObject(snkparams1);
Session.prepareParams(sparams1);
retsyskey = (ReturnObjFromRetrieve)sysManager.getSystemKeyDesc(sparams1);
retsyskey.check();

//Number of Catalog Areas
int numCatArea = retsyskey.getRowCount();

//Get Defaults Type
EzcSysConfigParams sparams2 = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
snkparams2.setLanguage("EN");
sparams2.setObject(snkparams2);
Session.prepareParams(sparams2);
retdeftype = (ReturnObjFromRetrieve)sysManager.getCatDefTypeDesc(sparams2);
retdeftype.check();
%>