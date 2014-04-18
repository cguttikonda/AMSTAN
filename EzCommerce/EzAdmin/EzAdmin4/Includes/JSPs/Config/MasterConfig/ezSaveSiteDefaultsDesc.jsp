<%@ page import = "ezc.ezparam.EzKeyValueStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<html>
<body>

<%
// Get the input parameters from the User Entry screen
String syskey = request.getParameter("SysKey");

String systype = request.getParameter("SysType");
String lang = request.getParameter("Lang");
String key = request.getParameter("key");
String desc = request.getParameter("Desc");
String deftype = request.getParameter("DefType");

// Transfer Structure for the Descriptions
EzKeyValueStructure in = new EzKeyValueStructure();

// Set the Structer Values
in.setPKey(systype.trim());
in.setKey(key.trim());
in.setValue(deftype.trim());

// System Configuration Class
EzMasterDB ezdb = new EzMasterDB();

// Add Defaults Description
ezdb.addSysTypeDefaults(in, lang, desc);

response.sendRedirect("../Config/MasterConfig/ezListSiteDefaults.jsp?SysType=" + systype);
%>
</body>
</html>