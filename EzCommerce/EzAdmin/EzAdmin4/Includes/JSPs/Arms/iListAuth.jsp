<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ include file="../../Lib/ArmsBean.jsp" %>
<jsp:useBean id="ezc" class="ezc.client.EzSystemConfigManager" scope="session" />
<%
	final String AUTH_KEY = "EUAD_AUTH_KEY";
	final String AUTH_LANG = "EUAD_LANG";
	final String AUTH_DESC = "EUAD_AUTH_DESC";
	final String AUTH_DEL_FLAG = "EUAD_DELETION_FLAG";

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve retauth = (ReturnObjFromRetrieve)ezc.getAuthDesc(sparams);
%>