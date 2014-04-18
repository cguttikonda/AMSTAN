<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.forums.params.*" %>
<%@ page import="ezc.messaging.params.*" %>
<%@ page import="ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*" %>
<%@ page import = "ezc.ezparam.*" %>


<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session">
</jsp:useBean>
<jsp:useBean id="ForumsManager" class="ezc.client.EzForumsManager" scope="session">
</jsp:useBean>
<jsp:useBean id="TransManager" class="ezc.client.EzTransactionManager" scope="session">
</jsp:useBean>

<%
//Refresh Page EveryTime: Nothing in the Cache
/* response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
*/
/*
//-------------Commented By Ranjith-----------
// Get the Servlet Context 			

ServletContext context = getServletConfig().getServletContext();
EzsInboxServlet servlet = null;

servlet = (EzsInboxServlet) context.getServlet("ezc.discussion.groups.EzsInboxServlet");
*/
%>