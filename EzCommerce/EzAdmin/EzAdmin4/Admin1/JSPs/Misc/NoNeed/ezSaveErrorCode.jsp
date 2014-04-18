<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezcommon.EzErrorHandlerDB" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<%
// Get the input parameters from the User Entry screen
String lang = request.getParameter("Lang");
String errorCode = request.getParameter("Code");
String errorDesc = request.getParameter("Desc");

Object[] error_data = new Object[3];

error_data[0] = errorCode;
error_data[1] = lang;
error_data[2] = errorDesc;

// Error Handler Class
EzErrorHandlerDB errordb = new EzErrorHandlerDB();

// Add Error Description
errordb.insertErrors(error_data);

response.sendRedirect("../Misc/ezAddErrorCode.jsp");
%>
<html>
<body>
</body>
</html>