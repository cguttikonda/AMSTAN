<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Arms/iListLanguage.jsp"%>
<%@ include file="../../../Includes/JSPs/Arms/iAddRoleDefinition.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/AdminVal.js"></script>
<script  src="../../Library/JavaScript/Arms/ezAddRoleDefinition.js"></script>
<Script>
	userRoles = new Array();
<%	
	int roleCount = retRoles.getRowCount();
	for(int i=0;i<roleCount;i++)
	{
%>
		userRoles[<%=i%>] = '<%=retRoles.getFieldValueString(i,"ROLE_NR")%>'
<%
	}
%>
function chkRoleExists()
{
	if(chk())
	{
		roleNr = document.myForm.rolenumber.value;
		roleNr = roleNr.toUpperCase();
		for (var i=0;i<userRoles.length;i++)
		{
			if (roleNr==userRoles[i])
			{
				alert("Role already Exists with "+roleNr+" name");
				document.myForm.rolenumber.focus();
				return false;
			}
		}
		return true;
	}
	return false;
}
</Script>
</head>
<body onLoad="document.myForm.rolenumber.focus();">
<form name=myForm method=post action="ezAddSaveRoleDefinition.jsp" onSubmit="return chkRoleExists()">
<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="80%">
  		<Tr align="center">
    			<Td class="displayheader">Add User Role Definition</Td>
  		</Tr>
	</Table>
    	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="80%">
      	<Tr>
        	<Th colspan="2" align="center">Please enter the following Role information</Th>
      	</Tr>
	<Tr>
        	<Td class="labelcell" width="37%" align="right">Role *:</Td>
        	<Td width="63%"><input type=text class = "InputBox" name="rolenumber" maxlength="16"></Td>
      	</Tr>
      	<Tr>
        	<Td class="labelcell" width="37%" align="right">Role Type *:</Td>
        	<Td width="63%">
          	<select name=roleType id = ListBoxDiv>
          		<option value="sel">---Select Role Type---</option>
            		<option value="E">Extranet(System Independent Role)</option>
	            	<option value="C">Internet(System Dependent Role) </option>
            		<option value="S">Supplier(System Independent Role)</option>
          	</select>
        	</Td>
      	</Tr>
      	<!--Tr>
        	<Td class="labelcell" width="37%" align="right">Language*:</Td>
        	<Td width="63%"><%//@include file="../../../Includes/Lib/ListBox/LBLanguage.jsp"%></Td>
      	</Tr -->
      	<Tr>
        	<Td class="labelcell" width="37%" align="right"> Description*:</Td>
        	<Td width="63%"><input type=text class = "InputBox" name=roleDesc maxlength=30></Td>
      	</Tr>
      	<Tr>
        	<Td class="labelcell" width="37%" align="right">Business Domain:</Td>
        	<Td width="63%"><input type=text class = "InputBox" name="busdomain" maxlength=20></Td>
      	</Tr>
    	</Table>
	<br>
	<center>
		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" alt="Click here to Save" >
		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" alt="Click here to Reset"></a>
	        <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none alt="Click here to Back"></a>
	        <input type=hidden name="buscomponent" value = "ROLE">
	</center>
</form>
</body>
</html>