<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>

<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>

<jsp:useBean id="rObj" class="ezc.client.EzReportManager" scope="page">
</jsp:useBean>


<%!
// Start Declarations

final String REP_SYSTEM_NO = "ERI_SYSTEM_NO";
final String REP_NAME = "ERI_REPORT_NAME";
final String REP_TYPE = "ERI_REPORT_TYPE";
final String REP_LANG = "ERI_LANG";
final String REP_DESC = "ERI_REPORT_DESC";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve retsys = null;
ReturnObjFromRetrieve retrep = null;

//-------------REPORT PARAMS----------------------
EzReportParams RepParam = null;
EzReportInfoStructure repInfo = null;
EzReportSelectTable repTable = null;
EzReportSelectRow repRow = null;
//-------------END REPORT PARAMS----------------------

//RsparamsTable RetParam = null;
String sys_num = null;
String sys_name = null;
String rep_name = null;

//Get Selected System Value
sys_num = request.getParameter("SysNum");
sys_name = request.getParameter("SysName");

//Get Report Name
rep_name = request.getParameter("RepName");
rep_name = rep_name.toUpperCase();

//--RepParam = AdminObject.getReport(servlet, sys_num, rep_name);
//String Jndi_Name = "EzcReport.EzcReportHome";
//EzcReport rObj = (EzcReport)Session.ezcFind(Jndi_Name);
//EzReportManager rObj = new EzReportManager();


EzExecReportParams reportParams = new EzExecReportParams();

// Prepare Parameters from Session Object
Session.prepareParams(reportParams);			

reportParams.setReportName(rep_name);		
reportParams.setSystemNo(sys_num);
reportParams.setSysNum(sys_num); // for fill call
reportParams.setLanguage("EN"); //hard coded needs to get from the logon or the system congig

//Object testObj = rObj.getReport(reportParams);

RepParam = (EzReportParams)rObj.getReport(reportParams);


 
repInfo = RepParam.getReportInfo();


repTable = RepParam.getReportSelectTable();

%>