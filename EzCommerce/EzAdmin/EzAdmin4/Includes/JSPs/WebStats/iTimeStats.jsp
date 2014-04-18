<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager"></jsp:useBean>
<%
	String toDateString = "";
	String toMonthString = "";
	java.util.Date toDateObj = new java.util.Date(toDate);
	int toDateInt = toDateObj.getDate()+1;
	if(toDateInt <= 10)
		toDateString = "0"+toDateInt;
	else
		toDateString = ""+toDateInt;
	int toMonthInt = toDateObj.getMonth()+1;
	if(toMonthInt <= 10)
		toMonthString = "0"+toMonthInt;
	else
		toMonthString = ""+toMonthInt;
	String formatToDate = toMonthString+"/"+toDateString+"/"+(toDateObj.getYear()+1900);	

	
	ReturnObjFromRetrieve retWebStats = null;
	EzcParams mainParams = new EzcParams(false);
	EziWebStatsParams  webStatparams= new EziWebStatsParams();
	webStatparams.setUserId("BULK");
	webStatparams.setSysKey(WebSysKey);
	webStatparams.setIP("152.63.9.60");
	webStatparams.setFromDate(fromDate);
	webStatparams.setToDate(formatToDate);
	mainParams.setObject(webStatparams);
	Session.prepareParams(mainParams);
	retWebStats=(ReturnObjFromRetrieve)WebStatsManager.getTimeStats(mainParams);
%>

