<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Arms/iListUserRoles.jsp"%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script src="../../Library/JavaScript/Arms/ezDeleteUserRoles.js"></script>
</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezEnableUserRoles.jsp">
<br>
<%
int myRoleCount = retRoles.getRowCount();

int enabledRows = retRoles.getRowId("DELETE_FLAG","Y");
	if(myRoleCount==0 || enabledRows ==-1)
	{
%>
		<br><br><br><br>
		<Table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
			<Td class="labelcell">
				No Disabled Roles to List.
			</Td>
		</Tr>
		</Table>
		<br>
		<Center>
			<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  onClick='JavaScript:history.go(-1)' style = "cursor:hand">
		</Center>
<%
	}
	else
	{
%>
		<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td colspan=4 class="displayheader" align="center">Disabled User Roles</Td>
		</Tr>
		</Table>
		<div id="theads">
	 	<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
			<Th  width=5%>&nbsp;</Th>
			<Th  width=28%>Role Number</Th>
			<Th  width=38%>Description</Th>
			<Th  width=22%>Role Type</Th>
		</Tr>
		</Table>
		</div>
		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
		retRoles.sort(new String[]{"DESCRIPTION"},true);
		String roleType=new String();
		for(int i=0;i<retRoles.getRowCount();i++)
		{
		    	if(((String)retRoles.getFieldValue(i,"DELETE_FLAG")).equals("Y"))
		    	{
%>
			<Tr>
				<label for="cb_<%=i%>">
				<Td width=5%><input type=checkbox name="RoleNr" id="cb_<%=i%>" value="<%=retRoles.getFieldValue(i,"ROLE_NR")%>"></Td>
				<Td valign="center" width=28%><a href="ezDetailRoleDefinition.jsp?RoleNr=<%=retRoles.getFieldValue(i,"ROLE_NR")%>" ><%=retRoles.getFieldValue(i,"ROLE_NR")%></a></Td>
				<Td valign="center" width=38%><%=retRoles.getFieldValue(i,"DESCRIPTION")%></Td>
<%
				roleType=(String)retRoles.getFieldValue(i,"ROLE_TYPE");
				if(roleType.equals("C"))
					roleType="Internet";
				else if(roleType.equals("S"))
					roleType="Supplier";
				else if(roleType.equals("E"))
					roleType="Extranet";
%>
				<Td valign="center" width=22%><%=roleType%></Td>
				</label>
			</Tr>
<%
		    	}
		}
%>
		</Table>
		</div>
		<input type=hidden name="checks" value="<%=retRoles.getRowCount()%>">
  		<div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
		   <input type="image" src="../../Images/Buttons/<%= ButtonDir%>/enable.gif" >
		   <a href="#"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  onClick='JavaScript:history.go(-1)' border=no></a>
		</div>
<%
	}
%>
</form>
</body>
</html>
