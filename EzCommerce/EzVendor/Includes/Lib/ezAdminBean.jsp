
<%System.out.println("Start Report Bean&&&&&&*****************");%>
<%@ page import="ezc.ezparam.*" %>

<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>


<%
//Refresh Page EveryTime: Nothing in the Cache
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");

System.out.println("Start Report End Bean&&&&&&*****************");

// Get the Servlet Context 			
//ServletContext context = getServletConfig().getServletContext();
//EzsAdminServlet servlet = null;

//servlet = (EzsAdminServlet) context.getServlet("ezcom.ezadmin.EzsAdminServlet");
//if (servlet == null) {
//	servlet = (EzsBAdminServlet) context.getServlet("ezcom.ezadmin.EzsBAdminServlet");
//}
//if (servlet == null) {
//	servlet = (EzsOAdminServlet) context.getServlet("ezcom.ezadmin.EzsOAdminServlet");
//}
%>