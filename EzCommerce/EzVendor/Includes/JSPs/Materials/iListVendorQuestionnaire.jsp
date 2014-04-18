<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezvendorapp.client.*" %>
<%@ page import = "ezc.ezvendorapp.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%

	String sysKey= (String)session.getValue("SYSKEY");
	String soldTo = (String)session.getValue("SOLDTO");

	EzVendorAppManager appManager= new EzVendorAppManager();
	EzVendorQuestionnaireStructure struct =new EzVendorQuestionnaireStructure();

	struct.setSysKey(sysKey);
	struct.setSoldTo(soldTo.trim());

	EzcParams ezcparams= new EzcParams(true);
	ezcparams.setLocalStore("Y");
	ezcparams.setObject(struct);
	Session.prepareParams(ezcparams);
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)appManager.ezGetVendorQuestionnaire(ezcparams);

	int Count = ret.getRowCount();

%>