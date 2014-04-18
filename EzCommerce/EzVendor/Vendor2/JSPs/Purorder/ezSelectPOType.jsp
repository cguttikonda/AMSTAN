<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>
</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body bgcolor="#FFFFF7">
<br>
<br>
<br>
<table width="75%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr align="center">
  <td><br><a href="../PurOrder/ezListAcknowledgedPOs.jsp?type=Acknowledged">View Rejected Purchase Orders</a><br></td>
  </tr>
  <tr align="center">
  <td><br><a href="../PurOrder/ezListAcknowledgedPOs.jsp?type=NotAcknowledged">View To Be Acknowledged Purchase Orders</a><br></td>
  </tr>
</table>

<Div id="MenuSol"></Div>
</body>
</html>
