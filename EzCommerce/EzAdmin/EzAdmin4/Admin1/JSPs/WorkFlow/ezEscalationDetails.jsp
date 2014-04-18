<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezworkflow.params.*" %>
 
<%@ include file="../../../Includes/JSPs/WorkFlow/iEscalationDetails.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
 
</head>
<body>

<form name=myForm method=post>
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Details Of Escalation</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=right class=labelcell width=50%>Code</Td>
		<Td width=50%><%= detailsRet.getFieldValue("CODE") %>&nbsp;</Td>
	</Tr>

	<Tr>
		<Td align=right class=labelcell width=50%>Description</Td>
		<Td width=50%><%= detailsRet.getFieldValue("DESCRIPTION") %>&nbsp;</Td>
	</Tr>

	<Tr>
		<Td align=right class=labelcell width=50%>Language</Td>
		<Td width=50%><%=detailsRet.getFieldValue("LANGDESC")%>&nbsp;</Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Level</Td>
		<%
			String level=detailsRet.getFieldValueString("ESCLEVEL").trim();
			String level1="";
			if(level.equals("1"))		
				level1="Template Level";
			else if(level.equals("2"))		
				level1="Role Level";
			else if(level.equals("3"))		
				level1="Group Level";
			else if(level.equals("4"))		
				level1="User Level";
			else if(level.equals("5"))		
				level1="Template and Role Level";
			else if(level.equals("6"))		
				level1="Template and Group Level";
		%>	
		<Td width=50%><%=level1%>&nbsp;</Td>
	</Tr>
	<%  
	    if(level.equals("1"))	
	    {
	 %>   
		<Tr>
		<Td align=right class=labelcell width=50%>Template</Td>
		<Td width=50%><%= detailsRet.getFieldValue("TDESC") %>&nbsp;</Td>
		</Tr>
	
	<%
	    }
	    else if(level.equals("2"))	
	    {
	%>
	
		<Tr>
		<Td align=right class=labelcell width=50%>Role</Td>
		<Td width=50%><%= detailsRet.getFieldValue("RDESC") %>&nbsp;</Td>
		</Tr>
		
	<%
	    }
	    else if(level.equals("3"))	
	    {
	%>
			<Tr>
			<Td align=right class=labelcell width=50%>GroupId</Td>
			<Td width=50%><%= detailsRet.getFieldValue("GDESC") %>&nbsp;</Td>
			</Tr>
	<%
	    }
	    else if(level.equals("4"))	
	    {
	%>
	
		<Tr>
		<Td align=right class=labelcell width=50%>User</Td>
		<Td width=50%><%= detailsRet.getFieldValue("ESCUSER") %>&nbsp;</Td>
		</Tr>
	<%
	    }
	    else if(level.equals("5"))	
	    {
	%>
		<Tr>
		<Td align=right class=labelcell width=50%>Template</Td>
		<Td width=50%><%= detailsRet.getFieldValue("TDESC") %>&nbsp;</Td>
		</Tr>
		<Tr>
		<Td align=right class=labelcell width=50%>Role</Td>
		<Td width=50%><%= detailsRet.getFieldValue("RDESC") %>&nbsp;</Td>
		</Tr>
		
	
	<%
	    }
	    else if(level.equals("6"))	
	    {
	%>
		<Tr>
		<Td align=right class=labelcell width=50%>Template</Td>
		<Td width=50%><%= detailsRet.getFieldValue("TDESC") %>&nbsp;</Td>
		</Tr>	
		<Tr>
		<Td align=right class=labelcell width=50%>GroupId</Td>
		<Td width=50%><%= detailsRet.getFieldValue("GDESC") %>&nbsp;</Td>
		</Tr>
		
	<%  
	    }
	%>
	<Tr>
		<Td align=right class=labelcell width=50%>Duration</Td>
		<Td width=50%><%= detailsRet.getFieldValue("DURATION") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Type</Td>
		<%
			String type= detailsRet.getFieldValueString("ESCTYPE"); 
			if(type.equals("A"))
				type="Absolute";
			else if(type.equals("R"))
				type="Relative";
		%>
		<Td width=50%><%=type%>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Move</Td>
		<Td width=50%><%= detailsRet.getFieldValue("ESCMOVE") %>&nbsp;</Td>
	</Tr>
</Table>
<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>

</body>
</html>
