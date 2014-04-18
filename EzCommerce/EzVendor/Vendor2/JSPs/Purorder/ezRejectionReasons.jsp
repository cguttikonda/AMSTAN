<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%
String Reason =request.geParameer("Reason");
String PurchaseOrder = request.getParameter("PurchaseOrder");
String line = request.getParameter("line");
%>
<html>
<head>
<title>Reason For Rejection </title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body bgcolor="#FFFFF7">
<br>
<table width="55%" border="0" align="center">
  <tr align="center"> 
	<td class="displayheader">Reason for rejection</td>
  </tr>
<Tr>
	<td>  The Following Are The Reasons For Rejection. </td>
</Tr>
<Tr>
	<td> You may Go Back By <a href="ezPoReceiptDetails.jsp?order=<%=order%>&line=<%=line%>"><b>Clicking Here</b></a> </td>
</Tr>
</table>
<br>
<Div id="MenuSol"></Div>
</body>
</html>
