<%@ page language="java" isErrorPage="true"%>
<%@ page import = "ezc.ezcommon.EzJSPExceptionHandler" %>
<html>
<head>

<%
//Exception e = (Exception)request.getAttribute("javax.servlet.jsp.jspException");
//EzJSPExceptionHandler exHandler = new EzJSPExceptionHandler();
//Object Message  = exHandler.handleException(e);
%>

<Title>Welcome to abc EzWeb</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body bgcolor="#FFFFFF">
<Table  width="102%" border="0" align="center" height="515">
  <Tr align="center"> 
    <Td class="displayheader"> WARNING!!! </Td>
  </Tr>
  <Tr align="center"> 
    <Td height="461"> <font face="Trebuchet MS" size="5" color="#CC0000"><%
	out.println(request.getParameter("Message"));
%> </font> <br>
      <br>
      Contact your administrator for further assistance</Td>
  </Tr>
</Table>
<div align="center"></div>
</body>
</html>