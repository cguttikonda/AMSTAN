<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>
Message
</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</script>
</head>
<body bgcolor="#FFFFF7">
<%
	String msgTxt=request.getParameter("Msg");
%>
<br>
<br>
<br>
<table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr align="center">
    <th>Purchase Order Has Been Created Successfully.</th>
  </tr>
</table>
<br><br>
<center><a href="../Misc/ezSBUWelcome.jsp"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none></center>
<Div id="MenuSol"></Div>
</body>
</html>
