<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>

<%
	//-------------REPORT PARAMS----------------------
	// Transfer Structure for the Report Header Info
	EzReportInfoStructure repInfo = new EzReportInfoStructure();

	// Transfer Structure for the Report Rows
	EzReportSelectTable repTable = new EzReportSelectTable();
	EzReportSelectRow repRow = null;

	EzReportParams in = new EzReportParams();

	//-------------END REPORT PARAMS----------------------

	// Get the input parameters
	String SysNum = null;
	String RepName = null;
	String RepDesc = null;

	SysNum = request.getParameter("SysNum");
	RepName = request.getParameter("RepName");
	RepDesc = request.getParameter("RepDesc");

	String[] pFinalFlag = request.getParameterValues("FinalFlag");
	String[] pSetHiddenFlag = request.getParameterValues("FinalHiddenFlag");
	String[] pParamKey = request.getParameterValues("ParamKey");
	String[] pParamDesc = request.getParameterValues("ParamDesc");
	String[] pParamLow = request.getParameterValues("ParamValueFrom");
	String[] pParamHigh = request.getParameterValues("ParamValueTo");
	String[] pParamType = request.getParameterValues("ParamType");

	// Set the Structure Values
	repInfo.setSystemNo(new Integer(SysNum).intValue());
	repInfo.setReportName(RepName);
	repInfo.setReportDesc(RepDesc);
	repInfo.setLanguage("EN");
	repInfo.setReportType(1);

	EzReportManager reportObj = new EzReportManager();

	//check if report exists -- BEGINS 
	EzExecReportParams reportParams1 = new EzExecReportParams();

	// Prepare Parameters from Session Object
	Session.prepareParams(reportParams1);			

	reportParams1.setReportName(RepName);		
	reportParams1.setSystemNo(SysNum);
	reportParams1.setSysNum(SysNum); // the sytem number is used for the fill call
	reportParams1.setLanguage("EN"); 
	//hard coded needs to get from the logon or the system congig

	EzReportParams RepParam = (EzReportParams)reportObj.getReport(reportParams1);

	in.setReportInfo(repInfo);
	if(pFinalFlag!= null)
	{
	for ( int i=0 ;i<pFinalFlag.length;i++ )
	{
		repRow = new EzReportSelectRow();
		repRow.setSystemNo(new Integer(SysNum).intValue());
		repRow.setReportName(RepName);
		repRow.setLanguage("EN");
		repRow.setParameterType(pParamType[i]);
		repRow.setParameterName(pParamKey[i]);
		repRow.setParameterDesc(pParamDesc[i]);
		repRow.setIsCustomer(pFinalFlag[i]);

		repRow.setIsHidden(pSetHiddenFlag[i]);
		repRow.setParameterValueLow(pParamLow[i]);
		repRow.setParameterValueHigh(pParamHigh[i]);

		repTable.appendRow(repRow);
		repRow = null;

	}//End For

	//Add Report
	in.setReportSelectTable(repTable);

	}

	EzExecReportParams reportParams = new EzExecReportParams();

	// Prepare Parameters from Session Object
	Session.prepareParams(reportParams);
	reportParams.setSysNum(SysNum);	//used for fill call
	reportParams.setReportParams(in);
	reportObj.addReport(reportParams);



response.sendRedirect("../Reports/ezReportsList.jsp?SystemNumber=" + SysNum);

%>
