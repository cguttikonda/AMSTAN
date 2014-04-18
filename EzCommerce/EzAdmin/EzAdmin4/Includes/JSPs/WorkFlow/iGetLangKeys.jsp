
<%@page import="ezc.ezparam.*"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>

<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
        snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve langRet = (ezc.ezparam.ReturnObjFromRetrieve)sysManager.getAllLangKeys(sparams);


%>




