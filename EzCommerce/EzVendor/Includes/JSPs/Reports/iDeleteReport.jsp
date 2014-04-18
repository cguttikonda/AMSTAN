<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>
<%@ page import = "ezc.ezparam.ReturnObjFromRetrieve" %>


<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>

<jsp:useBean id="reportObj" class="ezc.client.EzReportManager" scope="page">
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



String sys_num = null;
sys_num = request.getParameter("SystemNumber");

ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();//Get


//Get List Of Systems
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);


retsys = (ReturnObjFromRetrieve)ezsc.getSystemDesc(sparams);
retsys.check();
//Get number of Systems
int numSystem = retsys.getRowCount();
if(numSystem > 0)
{
/*	if (sys_num == null)
	{
		int tot=retsys.getRowCount();
		for( int j=0;j<tot; j++)
		{
			String systype=retsys.getFieldValue(j,"ESD_SYS_TYPE").toString();
			if(systype.equals("100") || systype.equals("110"))
			{
				sys_num = (retsys.getFieldValue(j,SYSTEM_NO)).toString();
				break;
			}
		}
	}*/

	if ( sys_num != null && !"sel".equals(sys_num))
	{
		//Get the Reports for the System
		//retrep = AdminObject.getReportList(servlet, sys_num);
		EzExecReportParams reportParams = new EzExecReportParams();
		// Prepare Parameters from Session Object
		Session.prepareParams(reportParams);
		reportParams.setSystemNo(sys_num);
		reportParams.setSysNum(sys_num);	// for fill call
		reportParams.setLanguage("EN");
		retrep = (ReturnObjFromRetrieve)reportObj.getReportList(reportParams);
		retrep.check();
	}
	else
	{
		retrep = new ReturnObjFromRetrieve();
	}

}//end if
%>