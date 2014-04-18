<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
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




	global.setDateFormat("MM/dd/yyyy HH:mm:ss");
	ReturnObjFromRetrieve retWebStats = null;
	ReturnObjFromRetrieve GlobObj = null;
	EzcParams mainParams = new EzcParams(false);
	EziWebStatsParams  webStatparams= new EziWebStatsParams();
	webStatparams.setSysKey(WebSysKey);
	webStatparams.setFromDate(fromDate);
	webStatparams.setToDate(formatToDate);
	if(setDateVal!=null)
		webStatparams.setToDate(setDateVal);
	mainParams.setObject(webStatparams);
	Session.prepareParams(mainParams);
	retWebStats=(ReturnObjFromRetrieve)WebStatsManager.getWebStatsList(mainParams);
	
	if(retWebStats.getRowCount()>0)
	{
        	Vector types= new Vector();
        	types.addElement("date");
        	types.addElement("date");

        	Vector cols= new Vector();
        	cols.addElement("LOGGED_IN");
        	cols.addElement("LOGGED_OUT");
        	global.setColTypes(types);
		global.setColNames(cols);
        	GlobObj = global.getGlobal(retWebStats);
	}
%>