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
	retWebStats=(ReturnObjFromRetrieve)WebStatsManager.getTimeStats(mainParams);

	String [] myColumns= new String[] { "FREQUENCY","USERS"};

	ReturnObjFromRetrieve excelRet=new ReturnObjFromRetrieve(myColumns);

	int rowCount = retWebStats.getRowCount();
	int freq=0;
	for(int i=0;i<rowCount;i++)
	{
		freq=Integer.parseInt(retWebStats.getFieldValueString(i,"FREQUENCY"));
		if(freq!=0)
		{
			excelRet.setFieldValue("FREQUENCY",retWebStats.getFieldValue(i,"FREQUENCY"));
			excelRet.setFieldValue("USERS",retWebStats.getFieldValue(i,"USERS"));
			excelRet.addRow();
		}
	}
 	if(excelRet.getRowCount() > 0)
	{
		ezc.ezbasicutil.EzExcelDriver excel=new ezc.ezbasicutil.EzExcelDriver();
		String retr=excel.ezCreateExcel("EzWebStats.xls","Sheet1",response,excelRet);
        }
%>
