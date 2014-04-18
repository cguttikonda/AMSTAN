<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
   String[] pcodes = request.getParameterValues("chk1");
   String productCodes[] = new String[pcodes.length];
   String plantCodes[] = new String[pcodes.length];
   java.util.StringTokenizer myStk = null;
   for(int i=0;i<pcodes.length;i++)
   {
   	myStk = new java.util.StringTokenizer(pcodes[i],"¥");
   	productCodes[i] = myStk.nextToken();
   	plantCodes[i] = myStk.nextToken();
   }
%>
<%@ include file="../../../Includes/JSPs/SalesDocMails/iDeleteSalesDocMails.jsp" %>