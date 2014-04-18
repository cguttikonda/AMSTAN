<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope = "session"></jsp:useBean>
<%
	ReturnObjFromRetrieve retWebStats = null;
	EzcParams mainParams = new EzcParams(false);
	EziWebStatsParams  webStatparams= new EziWebStatsParams();
	webStatparams.setSysKey(WebSysKey);
	webStatparams.setFromDate(fromDate);
	webStatparams.setToDate(toDate);
	mainParams.setObject(webStatparams);
	Session.prepareParams(mainParams);
	retWebStats=(ReturnObjFromRetrieve)WebStatsManager.getUserFrequency(mainParams);

	String [] myColumns= new String[] { "USERID","USERNAME","FREQUENCY"};

	ReturnObjFromRetrieve excelRet=new ReturnObjFromRetrieve(myColumns);
	String userName = "";
	String fName = "",mName = "",lName = "",s="";
	int rowCount = retWebStats.getRowCount();
	retWebStats.sort(new String[]{"FREQUENCY"},false);
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
		excelRet.setFieldValue("FREQUENCY",retWebStats.getFieldValueString(i,"FREQUENCY"));
		excelRet.addRow();
	}
 	if(excelRet.getRowCount() > 0)
	{
		ezc.ezbasicutil.EzExcelDriver excel=new ezc.ezbasicutil.EzExcelDriver();
		String retr=excel.ezCreateExcel("EzWebStats.xls","Sheet1",response,excelRet);
        }
%>