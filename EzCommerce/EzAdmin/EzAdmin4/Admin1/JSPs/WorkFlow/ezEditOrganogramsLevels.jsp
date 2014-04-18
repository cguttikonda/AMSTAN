<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iAddOrganogramsLevels.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iEditOrganogramsLevels.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>
<html>
<head>
<Title>Edit Organogram Level</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src = "../../Library/JavaScript/WorkFlow/ezEditOrganogramLevels.js"></script>
<script>
function mySelect()
{
	if(document.myForm.level!=null)
	{
		for(i=document.myForm.parent.length-1;i>0;i--)
		{
			document.myForm.parent.options[i]=null
		}	

		var value = document.myForm.level.value
		var level = value.split(",")
		var stepNo=1;
<%
		levels.sort(new String[]{"PARTICIPANT"},true);
		int levelsCount = levels.getRowCount();
		for(int i=0;i<levelsCount;i++)
		{
%>
			if((<%=levels.getFieldValue(i,"ORGLEVEL")%>)>level[0])
			{
				if('<%=levels.getFieldValue(i,"PARTICIPANT")%>'=='<%=parent%>')
				{
					document.myForm.parent.options[stepNo]=new Option('<%=levels.getFieldValue(i,"PARTICIPANT")%>','<%=levels.getFieldValue(i,"PARTICIPANT")%>')
					document.myForm.parent.selectedIndex = stepNo;
					stepNo++
				}
				else
				{
					document.myForm.parent.options[stepNo]=new Option('<%=levels.getFieldValue(i,"PARTICIPANT")%>','<%=levels.getFieldValue(i,"PARTICIPANT")%>')
					stepNo++
				}
			}
<%
		}
%>
	}
}
</script>
</head>
<body onLoad="document.myForm.lang.focus();mySelect()">
<br>
<form name=myForm method=post action="">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
    	<Td class="displayheader">Edit Organogram Levels</Td>
  	</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Th align = "right">
		Organogram
	</Th>
    	<Td width = "60%">
    		<input type = "hidden" name = "orgCode"  value = "<%=organogramCode%>">
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
				<%=retSteps.getFieldValueString(i,"STEP_DESC")%>
    				<input type =hidden name = "level" value = "<%=retSteps.getFieldValue(i,"STEP")%>,<%=role%>,<%=retSteps.getFieldValue(i,"OPTYPE")%>">
<%
			}
		}
%>
	</td>
  	</Tr>    
    	<Tr>
	<Th align = "right">
		Participant
	</Th>
	<td width = "60%">
    		<input type = hidden name = "participant" value = "<%=ppt%>">
    		<%=ppt%>
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
			if((langRet.getFieldValueString(i,LANG_ISO)).equals(lang))
			{
%>
				<option value="<%=langRet.getFieldValueString(i,LANG_ISO)%>" selected><%=langRet.getFieldValueString(i,LANG_DESC)%></option>	
<%
			} else {
%>
				<option value="<%=langRet.getFieldValueString(i,LANG_ISO)%>"><%=langRet.getFieldValueString(i,LANG_DESC)%></option>	
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
		<input type = "text" name = "description" class = "InputBox" value = "<%=desc%>" size = "67" maxlength = "100" style = "width:100%">
    	</Td>
  	</Tr>
    	<Tr>
	<Th align = "right">
		Parent
	</Th>
	<td width = "60%">
    		<select name = "parent" style = "width:100%" id = "FullListBox">
    			<option value = "">--Select Parent--</option>
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
