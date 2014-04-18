<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateStepsDetails.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%> 
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
 
</head>
<body>
<form name=myForm method=post>
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Details Of Template Step</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=right class=labelcell width=50%>Code</Td>
		<Td width=50%><%= detailsRet.getFieldValue("TCODE") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Step</Td>
		<Td width=50%><%= detailsRet.getFieldValue("STEP") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Step Desc</Td>
		<Td width=50%><%= detailsRet.getFieldValue("STEP_DESC") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Owner Participant</Td>
		<Td width=50%><%=removeNull(detailsRet.getFieldValue("OWNERPARTICIPANT")) %>&nbsp;</Td>
	</Tr>
<%
	String opType = "";
 	if(detailsRet.getFieldValue("OWNER_PARTICIPANT_TYPE").equals("R"))
		opType = "Role";
	else if(detailsRet.getFieldValue("OWNER_PARTICIPANT_TYPE").equals("G"))
		opType = "Group";
	else
		opType = "User";

%>
	<Tr>
		<Td align=right class=labelcell width=50%>Owner Participant Type</Td>
		<Td width=50%><%=opType%>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>FYI Participant</Td>
		<Td width=50%><%=removeNull(detailsRet.getFieldValue("FYIPARTICIPANT")) %>&nbsp;</Td>
	</Tr>
<%
	String fyiType = "";
 	if(detailsRet.getFieldValue("FYITYPE").equals("R"))
		fyiType = "Role";
	else if(detailsRet.getFieldValue("FYITYPE").equals("G"))
		fyiType = "Group";
	else
		fyiType = "User";
%>
	<Tr>
		<Td align=right class=labelcell width=50%>FYI Participant Type</Td>
		<Td width=50%><%=fyiType%>&nbsp;</Td>
	</Tr>
<%
	String mandatory = "No";
	if(detailsRet.getFieldValue("ISMANDATORY").equals("Y"))
		mandatory = "Yes";
%>
	<Tr>
		<Td align=right class=labelcell width=50%>Is Mandatory</Td>
		<Td width=50%><%=mandatory%>&nbsp;</Td>
	</Tr>
</Table>
<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
