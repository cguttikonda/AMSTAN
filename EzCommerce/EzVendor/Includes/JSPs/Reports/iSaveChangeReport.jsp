<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>

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

String SetFlag = null; 
String pSetFlag = null; 
String pFinalFlag = null; 

String SetHiddenFlag = null; 
String pSetHiddenFlag = null; 
String pFinalHiddenFlag = null;

String ParamKey = null; 
String pParamKey = null; 
String ParamDesc = null; 
String pParamDesc = null; 
String ParamValueFrom = null; 
String pParamValueFrom = null;
String ParamValueTo = null; 
String pParamValueTo = null;

String strTcount =  request.getParameter("TotalCount");
SysNum = request.getParameter("SysNum");	
RepName = request.getParameter("RepName");	
RepDesc = request.getParameter("RepDesc");	

// Set the Structure Values
repInfo.setSystemNo(Integer.parseInt(SysNum));
repInfo.setReportName(RepName);
repInfo.setReportDesc(RepDesc);
repInfo.setLanguage("EN");
repInfo.setReportType(1);

if ( strTcount != null ){
int TotalCount = (new Integer(strTcount)).intValue();  

	in.setReportInfo(repInfo);
	for ( int j = 0  ; j < TotalCount; j++ ){

		SetFlag = "SetFlag_"+j;
		ParamKey = "ParamKey_"+j;
		ParamDesc = "ParamDesc_"+j;
		//added new -SP
		SetHiddenFlag = "SetHiddenFlag_"+j;
		ParamValueFrom = "ParamValueFrom_"+j;
		ParamValueTo = "ParamValueTo_"+j;

		pSetFlag = request.getParameter(SetFlag);
		pParamKey = request.getParameter(ParamKey);
		pParamDesc = request.getParameter(ParamDesc);
		//added --SP
		pSetHiddenFlag = request.getParameter(SetHiddenFlag);
		pParamValueFrom = request.getParameter(ParamValueFrom);
		pParamValueTo = request.getParameter(ParamValueTo);

		// Check For Selection
		if ( pSetFlag != null ){
			pFinalFlag = "Y";
		} else {
			pFinalFlag = "N";
		}
		
		//added -- SP
		// Check For Hidden
		if ( pSetHiddenFlag != null ){
			pFinalHiddenFlag = "Y";
		} else {
			pFinalHiddenFlag = "N";
		}

		repRow = new EzReportSelectRow();
		repRow.setSystemNo(new Integer(SysNum).intValue());
		repRow.setReportName(RepName);
		repRow.setLanguage("EN");
		repRow.setParameterName(pParamKey);
		repRow.setParameterDesc(pParamDesc);
		repRow.setIsCustomer(pFinalFlag);
		repRow.setIsHidden(pFinalHiddenFlag);
		repRow.setParameterValueHigh(pParamValueTo);
		repRow.setParameterValueLow(pParamValueFrom);
		
		repTable.appendRow(repRow);
		repRow = null;

	}//End For

		//Add Report
		in.setReportSelectTable(repTable);

		//--AdminObject.changeReport(servlet, in);
		//String Jndi_Name = "EzcReport.EzcReportHome";
		//EzcReport rObj = (EzcReport)Session.ezcFind(Jndi_Name);
		EzReportManager rObj = new EzReportManager();

		EzExecReportParams reportParams = new EzExecReportParams();

		// Prepare Parameters from Session Object
		Session.prepareParams(reportParams);			
		
		reportParams.setReportParams(in);
		reportParams.setSysNum(SysNum);

		rObj.changeReport(reportParams);


}// End if TotalCount not null

response.sendRedirect("../Reports/ezChangeReport.jsp");
%>

