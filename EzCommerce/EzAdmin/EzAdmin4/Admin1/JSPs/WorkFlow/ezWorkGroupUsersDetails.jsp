<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupUsersDetails.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

</head>
<body>
<form name=myForm method=post>
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Details Of WorkGroupUsers</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=left class=labelcell width=50%>GroupId</Td>
		<Td width=50%><%= detailsRet.getFieldValue("GROUP_ID") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>UserId</Td>
		<Td width=50%><%= detailsRet.getFieldValue("USERID") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>EffectiveFrom</Td>
		<Td width=50%><%=effectivefrom %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>EffectiveTo</Td>
		<Td width=50%><%=effectiveto %>&nbsp;</Td>
	</Tr>
</Table>
<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
