<%@ include file="../../Lib/ArmsBean.jsp" %>
<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<jsp:useBean id="ezc" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<%
	ReturnObjFromRetrieve retlang = null;
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	retlang =(ReturnObjFromRetrieve) ezc.getAllLangKeys(sparams);
%>