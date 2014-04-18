<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iSimulateWFNext.jsp" %>
<html>
<head>

</head>
<body>
<br>
<%
	int rows=ret.getRowCount();
	if(rows>0)
	{
%>
		<Table align=center width=70%>
		<Tr>
			<Td class=displayheader align=center colspan=4>WFSimulation</Td>
		</Tr>
		<Tr>
			<Th>Step</Th><Th>Description</Th><Th>Participant</Th><Th>Type</Th>
		</Tr>
<%
		for(int j=0;j<rows;j++)
		{
%>
			<Tr>
				<Td align=center><%=ret.getFieldValue(j,"STEP")%></Td>
				<Td><%=ret.getFieldValue(j,"DESC")%></Td>
				<Td><%=ret.getFieldValue(j,"PARTICIPANT")%></Td>
				<Td><%=ret.getFieldValue(j,"PTYPE")%></Td>
			</Tr>
<%
		}
%>
		</Table>
<%
	}
	else
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Simulation Data To List
			</Th>
		</Tr>
		</Table>

<%
	}
%>

</body>
</html>