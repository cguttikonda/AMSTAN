<%@ page import = "ezc.ezcommon.EzJSPExceptionHandler" %>

<%
Exception e = (Exception)request.getAttribute("javax.servlet.jsp.jspException");
EzJSPExceptionHandler exHandler = new EzJSPExceptionHandler();
Object Message  = exHandler.handleException(e);
%>