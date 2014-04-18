<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import = "ezc.ezcommon.*,java.util.Vector" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope = "session"></jsp:useBean>
<%
	global.setDateFormat("MM/dd/yyyy HH:mm:ss");
	ReturnObjFromRetrieve retWebStats = null;
	ReturnObjFromRetrieve GlobObj = null;
	EzcParams mainParams = new EzcParams(false);
	EziWebStatsParams  webStatparams= new EziWebStatsParams();
	webStatparams.setSysKey(WebSysKey);
	webStatparams.setFromDate(fromDate);
	webStatparams.setToDate(toDate);
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
	String [] myColumns= new String[] { "USERID","USERNAME","IP","LOGGEDIN","LOGGEDOUT"};

	ReturnObjFromRetrieve excelRet=new ReturnObjFromRetrieve(myColumns);
	String userName = "";
	String fName = "",mName = "",lName = "";
	int rowCount = retWebStats.getRowCount();
	for(int i=0;i<rowCount;i++)
	{
		fName = retWebStats.getFieldValueString(i,"NAME");
		mName = retWebStats.getFieldValueString(i,"MIDDLENAME");
		lName = retWebStats.getFieldValueString(i,"LASTNAME");
		if(fName == null || "null".equals(fName)) fName="";
		if(mName == null || "null".equals(mName)) mName="";
		if(lName == null || "null".equals(lName)) lName="";
		userName = fName+" "+mName+" "+lName;
		excelRet.setFieldValue("USERID",retWebStats.getFieldValueString(i,"USER_ID"));
		excelRet.setFieldValue("USERNAME",userName);
		excelRet.setFieldValue("IP",retWebStats.getFieldValue(i,"IP"));
		excelRet.setFieldValue("LOGGEDIN",GlobObj.getFieldValueString(i,"LOGGED_IN"));
		excelRet.setFieldValue("LOGGEDOUT",GlobObj.getFieldValueString(i,"LOGGED_OUT"));
		excelRet.addRow();
	}
 	if(excelRet.getRowCount() > 0)
	{
		ezc.ezbasicutil.EzExcelDriver excel=new ezc.ezbasicutil.EzExcelDriver();
		String retr=excel.ezCreateExcel("EzWebStats.xls","Sheet1",response,excelRet);
         }
%>
