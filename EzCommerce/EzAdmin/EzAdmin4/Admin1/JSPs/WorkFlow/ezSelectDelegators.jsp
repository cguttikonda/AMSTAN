<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iSelectDelegators.jsp" %>
<Html>
<Head>
	<Title>Delegate Condition</Title>
	<base target='_self'>
	<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
	<Script src="../../Library/JavaScript/WorkFlow/ezSelectDelegators.js"></Script>
</Head>
<body>
	<form name='myForm'>
	<input type=hidden name='actionRole' value='<%=actionRole%>'>
	<BR>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=70% style='top:10%'>
	<Tr>
			<Th width=30% align='left'>Delegator Role*</Th>
			<Td>
			<select name='Role' style='width:100%' >
				<option value='-'>--Select--</option>
			<%
				for(int i=0;i<retRolesCount;i++)
				{
					if(actionRole.equals(retRoles.getFieldValueString(i,"ROLE_NR")))
						selected = "selected";
					else
						selected = "";
					
			%>
					<option value='<%=retRoles.getFieldValueString(i,"ROLE_NR")%>' <%=selected%>><%=retRoles.getFieldValueString(i,"DESCRIPTION")%></option>
			<%
				}
			%>
			</select>
			</Td>		
	</Tr>
	
	<Tr>
			<Th width=30% align='left'>Delegated Role*</Th>
			<Td>
			<select name='DelRole' style='width:100%' >
				<option value='-'>--Select--</option>
			<%
				selected = "";
				for(int i=0;i<retRolesCount;i++)
				{
					if(actionDelRole.equals(retRoles.getFieldValueString(i,"ROLE_NR")))
						selected = "selected";
					else
						selected = "";
				
			%>
					<option value='<%=retRoles.getFieldValueString(i,"ROLE_NR")%>' <%=selected%>><%=retRoles.getFieldValueString(i,"DESCRIPTION")%></option>
			<%
				}
			%>
			</select>
			</Td>		
	</Tr>
	
	
	<Tr>
		<Th width=30% align='left'>Level*</Th>
		<Td>
		<select name='Level' style='width:100%' onchange='fillOptions()'>
			<option value='-'>--Select--</option>
			<%
				while(enumLevel.hasMoreElements())
				{
					levelKey	= (String)enumLevel.nextElement();
					levelValue 	= (String)hashLevel.get(levelKey);
					if(levelKey.equals(level))
						selected = "selected";
					else
						selected = "";
			%>
					<option value='<%=levelKey%>' <%=selected%>><%=levelValue%></option>
			<%
				}
			%>
		</select>
		</Td>
	</Tr>
	<Tr>
			<Th width=30% align='left'>Delegator Group*</Th>
			<Td>
			<select name='delSrcLevel' style='width:100%' >
				<option value='-'>--Select--</option>
			<%
				for(int i=0;i<listGroupCount;i++)
				{
					if(delSrcLevel.equals(listGroupRet.getFieldValueString(i,"GROUP_ID")))
					selected = "selected";
					else
					selected = "";
					
			%>
					<option value='<%=listGroupRet.getFieldValueString(i,"GROUP_ID")%>' <%=selected%>><%=listGroupRet.getFieldValueString(i,"DESCRIPTION")%></option>
			<%
				}
			%>
			</select>
			</Td>		
	</Tr>
	<Tr>
			<Th width=30% align='left'>Delegated Group*</Th>
			<Td>
			<select name='delDestLevel' style='width:100%' onchange='fillGroupUsers()'>
				<option value='-'>--Select--</option>
			<%
				for(int i=0;i<listGroupCount1;i++)
				{
					if(delDestLevel.equals(listGroupRet1.getFieldValueString(i,"GROUP_ID")))
						selected = "selected";
					else
						selected = "";
					
			%>
					<option value='<%=listGroupRet1.getFieldValueString(i,"GROUP_ID")%>' <%=selected%>><%=listGroupRet1.getFieldValueString(i,"DESCRIPTION")%></option>
			<%
				}
			%>
			</select>
			</Td>		
	</Tr>
	
	<%
		if("U".equals(level))
		{
	%>
	<Tr>
		<Th width=30% align='left'>Delegator User*</Th>
		<Td>
		<select name='delSrcUser' style='width:100%'>
			<option value='-'>--Select--</option>
		<%
			for(int i=0;i<listUserCount;i++)
			{
		%>
				<option value='<%=listUserRet.getFieldValueString(i,"USERID")%>'><%=listUserRet.getFieldValueString(i,"FIRSTNAME")%></option>
		<%
			}
		%>
		</select>
		</Td>		
	</Tr>	
	<%
		}
	%>
	<Tr>
		<Th width=30% align='left'><%=destLabel%>*</Th>
		<Td>
		<select name='delDstLevel' multiple size=7 style='width:100%' >
			<option value='-'>--Select--</option>
		<%
			if("G".equals(level))
			{
				for(int i=0;i<listGroupCount1;i++)
				{
		%>
						<option value='<%=listGroupRet1.getFieldValueString(i,"GROUP_ID")%>'><%=listGroupRet1.getFieldValueString(i,"DESCRIPTION")%></option>
		<%	
				}
			}
			if("U".equals(level))
			{
				for(int i=0;i<listUserCount1;i++)
				{
		%>	
					<option value='<%=listUserRet1.getFieldValueString(i,"USERID")%>'><%=listUserRet1.getFieldValueString(i,"FIRSTNAME")%></option>		
		<%	
				}			
			}
		%>
			
		</select>
		</Td>		
	</Tr>
	</Table>

	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width=60%>
	<Tr>
	<Td align='center' class='blankcell'><input type=image  src=../../Images/Buttons/<%= ButtonDir%>/ok.gif  alt="Click Here To Select" border=no onClick="saveSelected()"></Td>
	<Td align='center' class='blankcell'><input type=image  src=../../Images/Buttons/<%= ButtonDir%>/close.gif  alt="Click Here To Close" border=no onClick="window.close()"></Td>
	</Tr>
	</Table>
	</Div>

	
	</form>
</dody>
</Html>