<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>

<%@ include file="../../Lib/AdminBean.jsp"%>
<%@ include file="../../Lib/ServerFunctions.jsp"%>

<%
	//-------------REPORT PARAMS----------------------
	EzReportInfoStructure repInfo = new EzReportInfoStructure();
	EzReportSelectTable repTable = new EzReportSelectTable();
	EzReportSelectRow repRow = null;

	EzReportTable selectTable = new EzReportTable();
	EzReportTableRow selectRow = null;
	EzReportAsciiTable outTable = null;
	EzExecReportParams repParams = null;

	EzExecReportParams in = new EzExecReportParams();

	// Prepare Parameters from Session Object
	Session.prepareParams(in);	
	//-------------END REPORT PARAMS----------------------

	// Get the input parameters
	String SysNum = null;
	String RepName = null;
	String RepDesc = null; 

	String[] pSetFlag = request.getParameterValues("SetFlag");
	String[] pParamKey = request.getParameterValues("ParamKey");
	String[] pParamValueFrom = request.getParameterValues("ParamValueFrom");
	String[] pParamValueTo = request.getParameterValues("ParamValueTo");
	String[] pParamType = request.getParameterValues("ParamType");

	try
	{
		RepName = request.getParameter("RepName");	
		SysNum = request.getParameter("SysNum");	
out.println("pParamType="+pParamType);
		if ( pSetFlag != null )
		{
			for (int i = 0;i<pSetFlag.length;i++ )
			{
				selectRow = new EzReportTableRow();
				selectRow.setSelname(pParamKey[i]);
				selectRow.setLow(pParamValueFrom[i]);
				selectRow.setHigh(pParamValueTo[i]);
				selectRow.setKind(pParamType[i]);
				selectTable.appendRow(selectRow);
				selectRow = null;
			}
			in.setIsWithCustomer(false);
			in.setReportName(RepName.trim());
			in.setSelTable(selectTable);
			in.setSystemNo(SysNum);
			in.setSysNum(SysNum);	// for fill call
			EzReportManager rprtObj = new EzReportManager();
			outTable = (EzReportAsciiTable)rprtObj.executeReport(in);
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
		//response.sendRedirect("../Htmls/Error.htm");
	}
%>
