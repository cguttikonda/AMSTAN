<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>

<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>

<jsp:useBean id="reportObj" class="ezc.client.EzReportManager" scope="page">
</jsp:useBean>

<%
	String system = request.getParameter("system");
	String reportName= request.getParameter("reportName");
	String repNo= request.getParameter("repNo");
	reportName = reportName.toUpperCase();

	EzExecReportParams repParams =new EzExecReportParams();
	EzReportInfoStructure ezRepInfoStruct = null;
	EzReportSelectTable ezRepSelTable = null;
	EzReportSelectRow ezRepSelTableRow = null;
	EzReportValuesTable ezRepValTable= null;
	EzReportValuesRow ezRepValTableRow = null;
	int retSelTabCount=0;
	int retvalTabCount=0;

	repParams.setSysNum(system);
	repParams.setReportName(reportName);
	repParams.setReportNo(repNo);
	repParams.setLanguage("EN");

	Session.prepareParams(repParams);
	try{
		EzReportParams ret=(EzReportParams) reportObj.getReport(repParams);
		ezRepInfoStruct=ret.getReportInfo();
		ezRepSelTable =ret.getReportSelectTable();
		ezRepValTable =ret.getReportValuesTable();
		retSelTabCount =ezRepSelTable.getRowCount();
		retvalTabCount=ezRepValTable.getRowCount();
	}catch(Exception e){}

%>

