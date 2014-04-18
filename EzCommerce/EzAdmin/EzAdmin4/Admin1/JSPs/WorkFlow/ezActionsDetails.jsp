<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
 
<%@ include file="../../../Includes/JSPs/WorkFlow/iActionsDetails.jsp"%>
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
		<Td class="displayheader" align=center>Details Of Actions</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=right class=labelcell width=50%>Code</Td>
		<Td width=50%><%=detailsRet.getFieldValue("CODE") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Description</Td>
		<Td width=50%><%=detailsRet.getFieldValue("DESCRIPTION") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Direction</Td>
<%
		    String direction=detailsRet.getFieldValueString("DIRECTION");
		    if(direction.equals("F"))
		    {
		    	direction="Forward";
		    }
		    else if(direction.equals("B"))
		    {
		    	direction="Backward";
		    }
		    else if(direction.equals("N"))
		    {
		    	direction="None";
		    }

		 %>

		<Td width=50%><%=direction%>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Language</Td>
		<Td width=50%><%=detailsRet.getFieldValue("LANGDESC") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>WF Action/Status</Td>
<%
		  String act=detailsRet.getFieldValueString("STAT_OR_ACTION");
		  if(act.equals("A"))
		  {
			 act="Action";
		  }
		  else if(act.equals("S"))
		  {
		         act="Status";
		  }
		  else if(act.equals("B"))
		  {
		    	 act="Both";
		  }
%>
		<Td width=50%><%=act%>&nbsp;</Td>
	</Tr>
</Table>
<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
