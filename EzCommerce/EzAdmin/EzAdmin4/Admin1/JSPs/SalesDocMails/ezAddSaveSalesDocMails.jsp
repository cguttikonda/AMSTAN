<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
   	String pcode = request.getParameter("PCode");
   	String to = request.getParameter("To");
   	String cc = request.getParameter("Cc");
   	String edd = request.getParameter("Edd");
   	String plant = request.getParameter("Plant");
   	String from=request.getParameter("From");
%>
<%@ include file="../../../Includes/JSPs/SalesDocMails/iAddSaveSalesDocMails.jsp" %>