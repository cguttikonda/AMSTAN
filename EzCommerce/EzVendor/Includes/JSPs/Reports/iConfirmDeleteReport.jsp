<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>

<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>

<jsp:useBean id="reportObj" class="ezc.client.EzReportManager" scope="page">
</jsp:useBean>

<%
//String Jndi_Name = "EzcReport.EzcReportHome";
//EzcReport reportObj = (EzcReport)Session.ezcFind(Jndi_Name);
//EzReportManager reportObj = new EzReportMAnager();


String SysNum = null; 

String CheckBox = null; 
String RepName = null; 

String pCheckBox = null; 
String pRepName = null; 

String strTcount =  request.getParameter("TotalCount");
SysNum =  request.getParameter("SysNum");

if ( strTcount != null ){
int totCount = (new Integer(strTcount)).intValue();  
int selCount =  0;

for ( int i = 0 ; i < totCount; i++ ) {
	CheckBox = "CheckBox_"+i;
	RepName = "RepName_"+i;

	pCheckBox = request.getParameter(CheckBox);

	// Check For Selection
	if ( pCheckBox != null ){
		if ( pCheckBox.equals("Selected"))	{
		// Get the Report Name
		pRepName = request.getParameter(RepName);
		//AdminObject.deleteReport(servlet, SysNum, pRepName);
		EzExecReportParams reportParams = new EzExecReportParams();

		// Prepare Parameters from Session Object
		Session.prepareParams(reportParams);			
		
		reportParams.setReportName(pRepName);
		reportParams.setSystemNo(SysNum);
		reportParams.setSysNum(SysNum);  // used for fill call
		reportParams.setLanguage("EN");
		Boolean retvalue = (Boolean)reportObj.deleteReport(reportParams);
		}
	}
}// End For
}//End if

response.sendRedirect("../Reports/ezDeleteReport.jsp?SystemNumber=" + SysNum);
%>