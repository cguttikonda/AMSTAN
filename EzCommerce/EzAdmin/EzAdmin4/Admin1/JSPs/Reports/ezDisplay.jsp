<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
      String autoNo=request.getParameter("autoNo");
%>
<html>
<head>
	<title>Message Display</title>

</script>
</head>
<body scroll="auto" >
<br><br><br>
<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
 <tr>
    <th align="center" class="displayheader">
       Your is request is being Processed in the Back End .You Can track the Status with <font color="red"><%=autoNo%></font>.
    </th>
</tr>
</table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>	
</body>
</html>
