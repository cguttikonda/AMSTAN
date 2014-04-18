<%@ include file="../../../Includes/JSPs/WorkFlow/iWFDocHistory.jsp"%>
<html>
<head>

</head>
<body>
<br>
	<Table  align=center width=80% >
	<Tr>
		<Th>DOCID</Th>
		<Th>STATUS</Th>
		<Th>NEXTPART</Th>
		<Th>PARTTYPE</Th>
	</Tr>
<%
	for(int i=0;i<listRet.getRowCount();i++)
	{
%>
		<Tr>
			<Td><%=listRet.getFieldValue(i,"DOCID")%></Td>
			<Td><%=listRet.getFieldValue(i,"STATUS")%></Td>
			<Td><%=listRet.getFieldValue(i,"NEXTPARTICIPANT")%></Td>
			<Td><%=listRet.getFieldValue(i,"PARTICIPANTTYPE")%></Td>
		</Tr>
<%
	}
%>
	</Table>
</body>
</html>