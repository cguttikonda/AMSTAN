<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
 
<%@ include file="../../../Includes/JSPs/WorkFlow/iDelegationInfoDetails.jsp"%>
 
<Html>
<Head>
<meta name="author"  content="kp">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
 
</head>
<body>
<form name=myForm method=post>
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Details Of Delegation Info</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=right class=labelcell width=50%>Template Code</Td>
		<Td width=50%><%= detailsRet.getFieldValue("TCODE") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Delegation Id</Td>
		<Td width=50%><%= detailsRet.getFieldValue("DELEGATIONID") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Source User</Td>
		<Td width=50%><%= detailsRet.getFieldValue("SOURCEUSER") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Destination User</Td>
		<Td width=50%><%= detailsRet.getFieldValue("DESTUSER") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Valid From</Td>
		<Td width=50%><%= fromdate %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Valid To</Td>
		<Td width=50%><%= todate %>&nbsp;</Td>
	</Tr>
</Table>
<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
