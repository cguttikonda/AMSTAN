<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<title>
Message
</title>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</script>
</head>
<body bgcolor="#FFFFF7">
<%
	
	String fileName = "../Rfq/ezWFListApprovedQcfs.jsp?Type=APPROVED&EDIT=T";
%>
<%
	String display_header = "";
%>	

<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<br>
<br>
<br>
<table width="50%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
  <tr align="center">
    <th>There is no common Vendor in selected QCFs.</th>
  </tr>
</table>
<br><br>
<center><a href="<%=fileName%>"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none></center>
<Div id="MenuSol"></Div>
</body>
</html>
