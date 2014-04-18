<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>
<jsp:useBean id="repObj" class="ezc.client.EzReportManager" scope="page">
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
String sysType = null;

EzSystemConfigManager ezsc = new EzSystemConfigManager();

//Get List Of Systems
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);
retsys = (ReturnObjFromRetrieve)ezsc.getSystemDesc(sparams);

//Get number of Systems
int numSystem = retsys.getRowCount();


//Get Selected System Value
sys_num = request.getParameter("SystemNumber");

if(numSystem > 0)
{
/*	if (sys_num == null)
	{
		int tot=retsys.getRowCount();
		for( int j=0;j<tot; j++)
		{
			String systype=retsys.getFieldValueString(j,"ESD_SYS_TYPE");
			if(systype.trim().equals("100") || systype.trim().equals("110"))
			{
				sys_num = retsys.getFieldValueString(j,SYSTEM_NO);
				break;
			}
		}
	}*/

	if ( sys_num != null && !"sel".equals(sys_num))
	{
		EzExecReportParams reportParams = new EzExecReportParams();
		// Prepare Parameters from Session Object
		Session.prepareParams(reportParams);
		//set Language here********* HARD CODED
		reportParams.setLanguage("EN");
		reportParams.setSystemNo(sys_num);
		reportParams.setSysNum(sys_num); // for fill call
		retrep = (ReturnObjFromRetrieve)repObj.getReportList(reportParams);
	}
	else
	{
		retrep = new ReturnObjFromRetrieve();
	}


}//end if
%>