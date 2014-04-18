<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iAddOrganogramsLevels.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>
<%
	int levelsCount = levels.getRowCount();
%>
<html>
<head>
<Title>Add Organogram</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src = "../../Library/JavaScript/WorkFlow/ezAddOrganogramLevels.js"></script>
<script>
function mySelect()
{
	document.myForm.description.value = document.myForm.participant.options[document.myForm.participant.selectedIndex].text;
}
</script>
</head>
<body >
<br>
<form name=myForm method=post action="">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
    	<Td class="displayheader">Add Organogram Levels</Td>
  	</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Th align = "right">
		Organogram
	</Th>
    	<Td width = "60%">
    		<input type = "hidden" name = "orgCode" value = "<%=orgCode%>" >
		<%=orgDesc%>
    	</Td>
    	</Tr>
    	<Tr>
	<Th align = "right">
		Level
	</Th>
	<td width = "60%">
<%
		int stepCount = retSteps.getRowCount();
		for(int i=0;i<stepCount;i++)
		{
			if(level.equals(retSteps.getFieldValueString(i,"STEP")))
			{
%>
    				<input type = "hidden" name = "level" value = "<%=level%>,<%=role%>,<%=retSteps.getFieldValue(i,"OPTYPE")%>">
				<%=retSteps.getFieldValueString(i,"STEP_DESC")%>
<%
			}
		}
%>
	</td>
  	</Tr>
    	<Tr>
	<Th align = "right">
		Participant*
	</Th>
	<td width = "60%">
    		<select name = "participant" style = "width:100%" id = "FullListBox" onChange = "mySelect()">
    			<option value = "">--Select Participant--</option>
<%
		if(opType.equals("U"))
		{
			retGroups.sort(new String[]{"DESCRIPTION"},true);
			int groupCount = retGroups.getRowCount();
			for(int i=0;i<groupCount;i++)
			{
%>
				<Option value = "<%=retGroups.getFieldValue(i,"GROUP_ID")%>" ><%=retGroups.getFieldValue(i,"DESCRIPTION")%></Option>
<%
			}		
		}
		else if(opType.equals("R"))
		{
			retRoles.sort(new String[]{"DESCRIPTION"},true);
			int roleCount = retRoles.getRowCount();
			for(int i=0;i<roleCount;i++)
			{
				if("N".equals(retRoles.getFieldValueString(i,"DELETE_FLAG")))
				{
%>
					<Option value = "<%=retRoles.getFieldValue(i,"ROLE_NR")%>"><%=retRoles.getFieldValue(i,"DESCRIPTION")%></Option>
<%
				}
			}
		}
		else if(opType.equals("G"))
		{
			retGroups.sort(new String[]{"DESCRIPTION"},true);
			int groupCount = retGroups.getRowCount();
			for(int i=0;i<groupCount;i++)
			{
%>
				<Option value = "<%=retGroups.getFieldValue(i,"GROUP_ID")%>" ><%=retGroups.getFieldValue(i,"DESCRIPTION")%></Option>
<%
			}
		}
%>
		</select>
	</td>
  	</Tr>
    	<Tr>
	<Th align = "right">
		Language*
	</Th>
    	<Td width = "70%">
    		<select name = "lang" style = "width:100%" id = "FullListBox">
 		<option value = "">--Select Language--</option>
<%
		int langRows=langRet.getRowCount();
		for(int i=0;i<langRows;i++)
		{
			if(langRet.getFieldValueString(i,LANG_ISO).equals("EN"))
			{
%>
				<option value="<%=langRet.getFieldValueString(i,LANG_ISO)%>" selected>
					<%=langRet.getFieldValueString(i,LANG_DESC)%>
				</option>	
<%			
			}
			else
			{
%>
				<option value="<%=langRet.getFieldValueString(i,LANG_ISO)%>">
					<%=langRet.getFieldValueString(i,LANG_DESC)%>
				</option>	
<%
			}
		}
%>
		</select>
	</Td>
    	</Tr>
    	<Tr>
	<Th align = "right">
		Description*
	</Th>
    	<Td width = "70%">
		<input type = "text" class = "InputBox" name = "description" value = "" size = "67" maxlength = "100" style = "width:100%">
    	</Td>
  	</Tr>
    	<Tr>
	<Th align = "right">
		Parent
	</Th>

	<td width = "60%">
    		<select name = "parent" style = "width:100%" id = "FullListBox">
    			<option value = "">--Select Parent--</option>
<%
			levels.sort(new String[]{"PARTICIPANT"},true);
			for(int i=0;i<levelsCount;i++)
			{
				if((Integer.parseInt(level))<(Integer.parseInt(levels.getFieldValueString(i,"ORGLEVEL"))))
				{
%>
					<option value = "<%=levels.getFieldValue(i,"PARTICIPANT")%>" ><%=levels.getFieldValue(i,"PARTICIPANT")%></Option>
<%
				}
			}
%>
		</select>
	</td>
  	</Tr>
</Table>
<br>
<center>
    	<a href="javascript:funSave()"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border = "none"></a>
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<input type = "hidden" name = "templateCode" value = "<%=templateCode%>">
<input type = "hidden" name = "organogramCode" value = "<%=orgCode%>">
<input type = "hidden" name = "orgDesc" value = "<%=orgDesc%>">
</form>
</body>
</html>
