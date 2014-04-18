<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>

<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page"></jsp:useBean>


<%
	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retsys = null;

	// Get List Of System Keys
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

	retsys = (ReturnObjFromRetrieve)ezsc.getSystemKeyDesc(sparams);
	retsys.check();


	//Get System Key
	String Sys_Key = request.getParameter("sysnum");
	if (Sys_Key == null) {
		Sys_Key = (retsys.getFieldValue(0,SYSTEM_KEY)).toString();
	}


	EzCatalogParams catalogParams = new EzCatalogParams();
	Session.prepareParams(catalogParams);
	catalogParams.setLanguage("EN");
	catalogParams.setSysKey(Sys_Key);
	//ret = (ReturnObjFromRetrieve)catalogObj.readCatalogAll (catalogParams);
	ret = (ReturnObjFromRetrieve)catalogObj.getProductGroups (catalogParams);


%>
