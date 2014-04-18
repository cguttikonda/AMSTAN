<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/AdminVal.js"></script>
<script src="../../Library/JavaScript/Arms/ezEditRoleDefinition.js"></script>
<script src="../../Library/JavaScript/Status.js"></script>
</head>
<%
String roleNr = "";
String roleDesc = "";
String role=request.getParameter("RoleNr");
if(role!=null)
{
	roleNr = role.substring(0,role.indexOf("#"));
	roleDesc = role.substring(role.indexOf("#")+1,role.length());
}
%>
<%@ include file="../../../Includes/JSPs/Arms/iListLanguage.jsp"%>
<%@ include file="../../../Includes/JSPs/Arms/iEditRoleDefinition.jsp"%>
<%
if ( retRoleDetails.getRowCount() > 0 )
{
	roleDesc = retRoleDetails.getFieldValueString(0,"DESCRIPTION").trim();
}
else
	{
	roleDesc = "";
}
%>
<body onLoad='document.myForm.roleType.focus()'>
<form name="myForm" method=post action="ezEditSaveRoleDefinition.jsp" onSubmit="return chk()">
<br>
	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td class="displayheader" align = "center">Change Role:<%=roleDesc%></Td>
	</Tr>
	</Table>
	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td class="labelcell" align="right">Role Number:</Td>
	        <Td><%=roleNr%>
	        <input type="hidden" name="roleNr" value='<%=roleNr%>'>
	        </Td>
      	</Tr>
<%
	String roleType=(String)retRoleDetails.getFieldValue(0,"ROLE_TYPE");
	String types[][]={{"E","Extranet(System Independent Role)"},{"C","Internet(System Dependent Role)"},{"S","Supplier(System Independent Role)"}};
%>
      	<Tr>
	        <Td class="labelcell" align="right">Role Type:</Td>
        	<Td>
        	<select name="roleType" id = "ListBoxDiv">
<%
		for (int i=0;i<types.length;i++)
		{
			if (roleType.equals(types[i][0]))
			{
%>
				<option value="<%=types[i][0]%>" selected><%=types[i][1]%></option>
<%
			}
			else
			{
%>
				<option value="<%=types[i][0]%>"><%=types[i][1]%></option>
<%
			}
		}
%>
		</select>
	        </Td>
      	</Tr>
      	<Tr>
        	<!-- Td class="labelcell" align="right">Language:</Td>
        	<Td -->
        	<input type= hidden name="language" value="<%=((String)retRoleDetails.getFieldValue(0,"LANGUAGE")).trim()%>">
<%
		/*String language=new String();
		for(int i=0;i<retlang.getRowCount();i++)
		{
			if(((String)retlang.getFieldValue(i,LANG_ISO)).trim().equals(((String)retRoleDetails.getFieldValue(0,"LANGUAGE")).trim()))
			{
				language=(String)retlang.getFieldValue(i,LANG_DESC);
				break;
			}
		}*/
%>
		<%//=language%>
        	<!-- /Td -->
      	</Tr>
      	<Tr>
        	<Td class="labelcell" align="right">Description *:</Td>
        	<Td><input type=text class = "InputBox" name="roleDesc" value='<%=retRoleDetails.getFieldValue(0,"DESCRIPTION")%>'></Td>
   	</Tr>
      	<Tr>
        	<Td class="labelcell" align="right">Business Domain :</Td>
        	<Td><input type=text class = "InputBox" name="busDom" value='<%=retRoleDetails.getFieldValue(0,"BUSS_DOMAIN")%>'></Td>
      	</Tr>
	</Table>
<%
	String roleDel=(String)retRoleDetails.getFieldValue(0,"DELETED_FLAG");
%>
	<input type=hidden name="roleDel" value="<%=roleDel%>">
	<input type=hidden name="busComp" value="<%=retRoleDetails.getFieldValue(0,"COMPONENT")%>">
	<br>
	<Center>
		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" >
		<a href="#"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</Center>
</form>
</body>
</html>
