<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
String key = request.getParameter("BaseErp");

// System Configuration Class
ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();if(key != null){
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
snkparams.setBaseErpNumber(key);
sparams.setObject(snkparams);
Session.prepareParams(sparams);
sysManager.updateBaseErp(sparams);
}

response.sendRedirect("../Config/ezSetBaseERP.jsp");
%>