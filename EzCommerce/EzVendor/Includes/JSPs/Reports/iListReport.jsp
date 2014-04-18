<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>

<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%> 
<%@ include file="../../../Includes/Lib/Systems.jsp"%>
<jsp:useBean id="reportObj" class="ezc.client.EzReportManager" scope="page">
</jsp:useBean>

<%
	int retListRows=0;
	int sysRows=0;
	ReturnObjFromRetrieve retList = null;
	ReturnObjFromRetrieve retsys = null;
	ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();
	String system = request.getParameter("system");
	String reportDomain =request.getParameter("reportDomain");
///out.println(reportDomain);
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	try{
		retsys = (ReturnObjFromRetrieve)ezsc.getSystemDesc(sparams);
		retsys.check();
		sysRows = retsys.getRowCount();
     }catch(Exception e)
	{}

	if(system != null && sysRows > 0)
	{
		EzExecReportParams repParams =new EzExecReportParams();
		repParams.setSysNum(system);
		repParams.setExecType("A','B','O");
        	repParams.setVisibilityLevel("A','I','B");
		repParams.setReportStatus("A','I");
		repParams.setBusinessDomain(reportDomain);
      		repParams.setLanguage("EN");
	      Session.prepareParams(repParams);
		  try{
	        retList=(ReturnObjFromRetrieve)reportObj.getReportList(repParams);
			retListRows=retList.getRowCount();
	         }catch(Exception e){}
	}

%>
