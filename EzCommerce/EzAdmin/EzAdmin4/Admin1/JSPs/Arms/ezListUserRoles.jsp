<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Arms/iListUserRoles.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Arms/ezListUserRoles.js"></script>
<script src="../../Library/JavaScript/Status.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<form name="myForm" method="post" onSubmit="return chkForSubmit()" >
<%
	if(retRoles.getRowCount()==0)
	{
%>		
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width = "80%">
	    	<Tr>
			<Th align = "center">There are no roles to List.</Th>
		</Tr>
		</Table>
		<br>
		<center>
  			<a href="ezAddRoleDefinition.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>	
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
  		</center>
<%	}
	else
	{
%>
		<br>
		<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>	    
			<Td colspan=4 class="displayheader" align="center">List of User Roles</Td>
		</Tr>
		</Table>
		<div id="theads">
		<Table  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th  width=5%>&nbsp;</Th>
			<Th  width=25%>Role Number</Th>
			<Th  width=50%>Description</Th>
			<Th  width=20%>Role Type</Th>
		</Tr>
		</Table>
		</div>
		<DIV id="InnerBox1Div">
		<Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
			retRoles.sort(new String[]{"DESCRIPTION"},true);
			String roleType=new String();
			for(int i=0;i<retRoles.getRowCount();i++)
			{
				if(((String)retRoles.getFieldValue(i,"DELETE_FLAG")).equals("N"))
				{
%>
					<Tr>
						<label for="cb_<%=i%>">
						<Td width=5% align=center><input type=checkbox name="RoleNr" id = "cb_<%=i%>" value="<%=retRoles.getFieldValue(i,"ROLE_NR")%>#<%=retRoles.getFieldValue(i,"DESCRIPTION")%>"></Td>
						<Td valign="center" width=25%><a style="text-decoration:none" href="ezDetailRoleDefinition.jsp?RoleNr=<%=retRoles.getFieldValue(i,"ROLE_NR")%>" target="display"><%=retRoles.getFieldValue(i,"ROLE_NR")%></a></Td>
						<Td valign="center" width=50%><%=retRoles.getFieldValue(i,"DESCRIPTION")%>&nbsp;</Td>
<%
						roleType=(String)retRoles.getFieldValue(i,"ROLE_TYPE");
						if(roleType.equals("C"))
							roleType="Internet";
						else if(roleType.equals("S"))
							roleType="Supplier";
						else if(roleType.equals("E"))
							roleType="Extranet";
%>
						<Td valign="center" width=20%><%=roleType%></Td>
						</label>
					</Tr>
<%
			    	}
			}
%>
		</Table>
		</div>
		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	   	     	<a href="ezAddRoleDefinition.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>	
	 	     	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/edit.gif" onClick="checkFun('Edit')">
	 	     	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/disable.gif" onClick="checkFun('Del')">
	 	</div>
<%
	}
%>
</form>
</body>
</html>