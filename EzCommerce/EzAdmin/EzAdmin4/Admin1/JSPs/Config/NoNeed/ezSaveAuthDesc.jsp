<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<html>
<body>

<%
// Get the input parameters from the User Entry screen
String lang = request.getParameter("Lang");
String key = request.getParameter("key");
String desc = request.getParameter("Desc");

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

// Set the Structer Values
in.setKey(key);
in.setLang(lang);
in.setDesc(desc);

// System Configuration Class
EzsSystemConfig ezsc = new EzsSystemConfig();

// Add System Description
ezc.addAuthDesc(in);



response.sendRedirect("../Config/ezListAuth.jsp");
%>
</body>
</html>