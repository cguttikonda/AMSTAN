<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	ReturnObjFromRetrieve retWebStats = null;
	EzcParams mainParams = new EzcParams(false);
	EziWebStatsParams  webStatparams= new EziWebStatsParams();
	webStatparams.setSysKey(WebSysKey);
	webStatparams.setFromDate(fromDate);
	webStatparams.setToDate(toDate);
	mainParams.setObject(webStatparams);
	Session.prepareParams(mainParams);
	WebStatsManager.clearWebStats(mainParams);
%>

