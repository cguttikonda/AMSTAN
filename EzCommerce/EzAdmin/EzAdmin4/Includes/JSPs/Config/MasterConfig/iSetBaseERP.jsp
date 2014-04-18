<%//@ page import = "ezc.ezadmin.EzSystemConfig" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%!
// Start Declarations
//<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
//</jsp:useBean>

final String BASE_ERP = "ESG_BASE_ERP_SYS_NO";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retbasesys = null;

// System Configuration Class
//ezc.client.EzSystemConfigManager ezc = new ezc.client.EzSystemConfigManager();

//Get all Systems
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
        snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ret = (ReturnObjFromRetrieve)sysManager.getSystemDesc(sparams);
	ret.check();

// Get Base ERP System Number
//retbasesys = AdminObject.getBaseErp(servlet);
	EzcSysConfigParams sparams1 = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
        snkparams1.setLanguage("EN");
	sparams1.setObject(snkparams1);
	Session.prepareParams(sparams1);
	retbasesys = (ReturnObjFromRetrieve)sysManager.getBaseErp(sparams1);
	retbasesys.check();
%>