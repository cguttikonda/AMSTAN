<%@ include file="../../Lib/iEzMain1.jsp" %>
<%
	ReturnObjFromRetrieve retLogsList=null;
	int LogsListCount=0;
	ezc.ezparam.EzcParams ezcparams = new ezc.ezparam.EzcParams(false);
	EziSFALogsParams ezisfalogsparams= new EziSFALogsParams();
	ezcparams.setObject(ezisfalogsparams);
	Session.prepareParams(ezcparams);
	System.out.println("CHECK LOGS");
	retLogsList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getSFALogsList(ezcparams);
	System.out.println("CHECK LOGS11");
	if(retLogsList != null)
		LogsListCount = retLogsList.getRowCount();
%>

