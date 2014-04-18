<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%

	String Hour=request.getParameter("Hour");
	String Users=request.getParameter("Users");
%>

<html>
<head>  
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Title>EzWebTimeStats--Powered by EzCommerce Inc</Title>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<BODY onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<div id="theads">
<Table id="tabHead" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
<Td class=displayHeader align = "center">Users Logged in between <%=Integer.parseInt(Hour)%> and  <%=Integer.parseInt(Hour)+1%></Td>
	
</Tr>
</Table>
</div>
<%
	java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(Users,",");
%>
<div id="InnerBox1Div"> 
<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
while(tokenizer.hasMoreTokens())
{
%>

	<Tr>
		<Td><%=tokenizer.nextToken()%>
	</Tr>
<%
}
%>
</Table>
</div>
<br>


<div id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%">
	<img src = "../../Images/Buttons/<%=ButtonDir%>/close.gif" style = "cursor:hand" onClick = "JavaScript:window.close()">
</div>

</body>
</html>
