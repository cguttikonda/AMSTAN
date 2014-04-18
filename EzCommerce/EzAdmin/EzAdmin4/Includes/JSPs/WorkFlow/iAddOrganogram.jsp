<%@ include file="../../Lib/CatalogArea.jsp"%>
<%@ include file="../../Lib/AdminConfig.jsp"%>
<%
	ReturnObjFromRetrieve retsyskey = null;
	
	//Get All Catalog Areas
	EzcSysConfigParams sparams1 = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
	snkparams1.setLanguage("EN");
	sparams1.setObject(snkparams1);
	Session.prepareParams(sparams1);
	retsyskey = (ReturnObjFromRetrieve)sysManager.getSystemKeyDesc(sparams1);
	retsyskey.check();
%>


