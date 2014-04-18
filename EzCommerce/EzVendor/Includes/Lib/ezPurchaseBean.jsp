<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	//Refresh Page EveryTime: Nothing in the Cache
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>