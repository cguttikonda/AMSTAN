<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>
<jsp:useBean id="reportObj" class="ezc.client.EzReportManager" scope="page"></jsp:useBean>
<%
	EzReportReturnStructure RetParam = null;
	EzExecReportParams reportParams = new EzExecReportParams();
	int paramRows = 0;
	reportName=reportName.toUpperCase();
	reportParams.setReportName(reportName);
	reportParams.setLanguage("EN");
	reportParams.setSystemNo(system);
	reportParams.setSysNum(system);
	Session.prepareParams(reportParams);
	try
	{
		RetParam = (EzReportReturnStructure)reportObj.getRptSelectTable(reportParams);
		//RetParam.toEzcString();
      		paramRows = RetParam.getRowCount();
      		//out.println(RetParam.toEzcString());
	}
	catch(Exception e)
	{ 
	}
%>
