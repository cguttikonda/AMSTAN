<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%
// Get the input parameters from the User Entry screen
String lang = request.getParameter("Lang");
String key = request.getParameter("key");
String desc = request.getParameter("Desc");
String short_text = request.getParameter ("ShortDesc");

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

// Set the Structer Values
in.setKey(key);
in.setLang(lang);
in.setDesc(desc);

// System Configuration Class
//ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();// Add Currency Description
sysManager.addCurrencyDesc(in , short_text);

response.sendRedirect("../Config/ezListCurrency.jsp");
%>