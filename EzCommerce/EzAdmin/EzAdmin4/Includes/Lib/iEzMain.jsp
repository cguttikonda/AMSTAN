<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="cmanager" class="ezc.ezlm.client.EzLeadManagementManager" />
<jsp:useBean id="cmanager1" class="ezc.ezsfa.client.EzSFAManager" />
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezlm.params.*" %>
<%@ page import="ezc.ezsfa.params.*" %>
<%@ page import="java.util.*" %>
<%
	//response.setHeader("Pragma", "No-cache");
	//response.setDateHeader("Expires", 0);
	//response.setHeader("Cache-Control", "no-cache");
%>
