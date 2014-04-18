<%@ page import="ezc.client.EzUserAdminManager" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>

<jsp:useBean id="UserAdminBean" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<%
/*

// Get the Servlet Context 			
ServletContext context = getServletConfig().getServletContext();
EzsAdminServlet servlet = null;

servlet = (EzsAdminServlet) context.getServlet("ezc.ezadmin.EzsAdminServlet");
if (servlet == null) {
	servlet = (EzsBAdminServlet) context.getServlet("ezc.ezadmin.EzsBAdminServlet");
}
if (servlet == null) {
	servlet = (EzsOAdminServlet) context.getServlet("ezc.ezadmin.EzsOAdminServlet");
}
*/
%>