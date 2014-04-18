<%//@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%> 
<%@ include file="../../../Includes/JSPs/WorkFlow/iRoleConditionsDetails.jsp"%>
 
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
 
</head>
<body>
<form name=myForm method=post>
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Details Of Condition <%=detailsRet.getFieldValueString(0,"CONDITION_ID")%></Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=right class=labelcell width=50%>Role No</Td>
		<Td width=50%><%= detailsRet.getFieldValueString(0,"DOC_NO") %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Auth Key</Td>
		<Td width=50%><%= detailsRet.getFieldValueString(0,"AUTHKEY") %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Condition Id</Td>
		<Td width=50%><%= detailsRet.getFieldValueString(0,"CONDITION_ID") %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Description</Td>
		<Td width=50%><%= detailsRet.getFieldValueString(0,"DESCRIPTION") %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Conditions</Td>
		<Td width=50%><%= detailsRet.getFieldValueString(0,"CONDITIONS") %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Condition Text</Td>
		<Td width=50%><%= detailsRet.getFieldValueString(0,"TEXT") %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Result</Td>
		<Td width=50%><%= detailsRet.getFieldValueString(0,"RESULT") %></Td>
	</Tr>
<%
	if(showExtra)
	{
%>

	<Tr>
		<Td align=right class=labelcell width=50%><%=firstExtraHeader%></Td>
		<Td width=50%><%=firstExtraData%></Td>
	</Tr>

	<Tr>
		<Td align=right class=labelcell width=50%><%=secondExtraHeader%></Td>
		<Td width=50%><%=secondExtraData%></Td>
	</Tr>
<%
	}
%>
</Table>
<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
