<%@ page language="java" isErrorPage="true"%>
<%@ page import = "ezc.ezcommon.EzExceptionHandler" %>

<%
Exception e = (Exception)request.getAttribute("javax.servlet.jsp.jspException");
EzExceptionHandler exHandler = new EzExceptionHandler();
//e.printStackTrace(out);
Object Message  = exHandler.handleException(e);
%>