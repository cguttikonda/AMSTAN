<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<%
       String roleNr=request.getParameter("RoleNr");
%>
<%@ include file="../../../Includes/JSPs/Arms/iListLanguage.jsp"%>
<%@ include file="../../../Includes/JSPs/Arms/iEditRoleDefinition.jsp"%>
<%
	String language= new String();
	for(int i=0;i<retlang.getRowCount();i++)
	{
		if(((String)retlang.getFieldValue(i,LANG_ISO)).trim().equals(((String)retRoleDetails.getFieldValue(0,"LANGUAGE")).trim()))
		{
			language=(String)retlang.getFieldValue(i,LANG_DESC);
			break;
		}
	}
%>
<body>
<br>
<form name=myForm method=post action="">
	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
	  	<Td class="displayheader" height="23">Details of Role: <%=retRoleDetails.getFieldValue(0,"DESCRIPTION")%></Td>
	</Tr>
	</Table>
    	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
      	<Tr>
        	<Td class="labelcell" width="45%" align="right">Role Number:</Td>
        	<Td width="55%"><%=roleNr%></Td>
      	</Tr>
      	<Tr>
        	<Td class="labelcell" width="45%" align="right">Role Description:</Td>
        	<Td width="55%"><%=retRoleDetails.getFieldValue(0,"DESCRIPTION")%> </Td>
      	</Tr>
      	<Tr>
        	<Td class="labelcell" width="45%" align="right">Role Type:</Td>
<%
		String roleTypeDesc=(String)retRoleDetails.getFieldValue(0,"ROLE_TYPE");
		if(roleTypeDesc.equals("C"))
			roleTypeDesc="Internet";
		else if(roleTypeDesc.equals("S"))
			roleTypeDesc="Supplier";
		else if(roleTypeDesc.equals("E"))
			roleTypeDesc="Extranet";
%>
        	<Td width="55%"><%=roleTypeDesc%></Td>
      	</Tr>
      	<!-- Tr>
        	<Td class="labelcell" width="45%" align="right">Language:</Td>
        	<Td width="55%"><%//=language%> </Td>
      	</Tr -->
      	<Tr>
        	<Td class="labelcell" width="45%" align="right">Is Disabled:</Td>
<%
		String roleFlag = "No";
		String roleDel=(String)retRoleDetails.getFieldValue(0,"DELETED_FLAG");
		if(roleDel.equals("Y"))
			roleFlag = "Yes";
%>
		        <Td width="55%"><%=roleFlag%></Td>
	</Tr>
      	<Tr>
        	<Td class="labelcell" width="45%" align="right">Business Domain:</Td>
        	<Td width="55%"><%=retRoleDetails.getFieldValue(0,"BUSS_DOMAIN")%>&nbsp;</Td>
      	</Tr>
    	</Table>
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
</form>
</body>
</html>
