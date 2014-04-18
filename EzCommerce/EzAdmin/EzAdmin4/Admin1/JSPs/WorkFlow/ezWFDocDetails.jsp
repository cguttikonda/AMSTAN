<%@ include file="../../../Includes/JSPs/WorkFlow/iWFDocDetails.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	//out.println("Got The ReturnObj"+listRet);
	//out.println("dkf"+listRet.getRowCount());
	//out.println(listRet.toHTML());
%>

<html>
<head>

</head>
<body>
<br>
<%
	if(listRet.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Docs To Show Details 
			</Th>
		</Tr>
		</Table>
<%
	}
	else
	{
%>
	<Table  align=center width=80%>
	<Tr>
		<Th>KEY</Th>
		<Th>STATUS</Th>
		<Th>ACTION</Th>
		<Th>COMMENTS</Th>
	</Tr>
<%
	for(int i=0;i<listRet.getRowCount();i++)
	{
%>
		<Tr>
			<Td><%=listRet.getFieldValue(i,"KEY")%></Td>
			<Td><%=listRet.getFieldValue(i,"STATUS")%></Td>
			<Td><%=listRet.getFieldValue(i,"ACTION")%></Td>
			<Td><%=listRet.getFieldValue(i,"COMMENTS")%></Td>
		</Tr>
<%
	}
%>
	</Table>
<%
	}
%>
</body>
</html>