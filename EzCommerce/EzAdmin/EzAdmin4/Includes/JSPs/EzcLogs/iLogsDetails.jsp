<%@ include file="../../Lib/iEzMain.jsp" %>
<%
	ReturnObjFromRetrieve retLogsDetails=null;
	logNo=request.getParameter("logNumber");
	ezc.ezparam.EzcParams ezcparams = new ezc.ezparam.EzcParams(false);
	EziSFALogsParams ezisfalogsparams= new EziSFALogsParams();
	ezisfalogsparams.setlogNo(logNo);
	ezcparams.setObject(ezisfalogsparams);
	Session.prepareParams(ezcparams);
	retLogsDetails =(ezc.ezparam.ReturnObjFromRetrieve)cmanager1.getSFALogsDetails(ezcparams);
%>

