<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>

<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsDetails.jsp"%>

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
		<Td class="displayheader" align=center>Details Of WorkGroup</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=left class=labelcell width=50%>Role No</Td>
		<Td width=50%><%= detailsRet.getFieldValue("ROLEDESCRIPTION") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>Work Group</Td>
		<Td width=50%><%= detailsRet.getFieldValue("GROUP_ID") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>Language</Td>
		<Td width=50%><%= detailsRet.getFieldValue("LANG") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>Description</Td>
		<Td width=50%><%= detailsRet.getFieldValue("DESCRIPTION") %>&nbsp;</Td>
	</Tr>
	<%
		String wtype=detailsRet.getFieldValueString("WGTYPE");
		if("VN".equals(wtype))
			wtype = "Vendor";
		else if("IV".equals(wtype))
			wtype = "Internal Vendor";
		else if("AG".equals(wtype))
			wtype = "Customer";
		else
			wtype = "Internal Customer";		
	%>
	<Tr>
		<Td align=left class=labelcell width=50%>Type</Td>
		<Td width=50%><%=wtype  %>&nbsp;</Td>
	</Tr>
</Table>
<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
