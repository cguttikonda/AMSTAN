<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 1);
	response.setHeader("Cache-Control", "no-cache");
%>
<jsp:useBean id="EzGlobal" class="ezc.ezbasicutil.EzGlobal" scope="session" /> 
