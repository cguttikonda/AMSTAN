<html>
<head>
<title>
</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/Jsps/Labels/iSelectPOType_Labels.jsp" %>
</head>
<body bgcolor="#FFFFF7">

<%
	String display_header = "";
%>	

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>
<br>
<br>
<table width="75%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
  <tr align="center">
  <td><br><a href="../PurOrder/ezListBlockedPOs.jsp">To be Released Orders</a><br></td>
  </tr>
  <tr align="center">
  <td><br><a href="../PurOrder/ezListSubmitPO.jsp">To be Submitted orders</a><br></td>
  </tr>
</table>

<Div id="MenuSol"></Div>
</body>
</html>