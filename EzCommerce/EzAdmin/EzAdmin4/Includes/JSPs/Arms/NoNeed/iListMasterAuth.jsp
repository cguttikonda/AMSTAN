<%@ page import="ezc.ezparam.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezc" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<%
	final String AUTH_KEY = "EUAD_AUTH_KEY";
	final String AUTH_LANG = "EUAD_LANG";
	final String AUTH_DESC = "EUAD_AUTH_DESC";
	final String AUTH_DEL_FLAG = "EUAD_DELETION_FLAG";

	String language = "EN";
	EzcSysConfigParams sparams1 = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
	snkparams1.setLanguage(language);
	sparams1.setObject(snkparams1);
	Session.prepareParams(sparams1);

	ReturnObjFromRetrieve retauth = (ReturnObjFromRetrieve)ezc.getMasterAuthDesc(sparams1);
%>