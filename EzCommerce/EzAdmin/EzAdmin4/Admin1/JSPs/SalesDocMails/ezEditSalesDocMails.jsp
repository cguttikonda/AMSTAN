<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
  	String pcode = request.getParameter("PCode");
     	String to= request.getParameter("To");
     	String cc = request.getParameter("Cc");
   	String edd = request.getParameter("Edd");
     	String plant = request.getParameter("Plant");
%>
<%@ include file="../../../Includes/JSPs/SalesDocMails/iUpdateSalesDocMails.jsp" %>
<%
if(pcode.equals("centralplanner") || pcode.equals("mktservices"))
	response.sendRedirect("ezUpdateSalesDocMails.jsp?cenplan="+pcode);
else
	response.sendRedirect("ezListPlantPlannerMails.jsp");
%>
