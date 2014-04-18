<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
// Get the input parameters from the User Entry screen
String lang = request.getParameter("Lang");
String SystemNumber = request.getParameter("SystemNumber");
String Code = request.getParameter("Code");
if(Code!= null)
	Code.trim();

String key = SystemNumber + Code;
String desc = request.getParameter("Desc");

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

// Set the Structer Values
in.setExtInfo(SystemNumber);
in.setKey(key);
in.setLang(lang);
in.setDesc(desc);

// System Configuration Class
//ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();// Add System Description
sysManager.addSystemKeyDesc(in);

response.sendRedirect("../Config/ezListSystemKeys.jsp");
%>