<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iEditOrganogramsLevelsByParticipant.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>
<html>
<head>
<Title>Edit Organogram Level</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src = "../../Library/JavaScript/WorkFlow/ezEditOrganogramLevels.js"></script>
<Script>
function mySelect()
{
	var stepNo=1;
<%
	retList.sort(new String[]{"PARTICIPANT"},true);
	int rowCount = retList.getRowCount();
	for(int i=0;i<rowCount;i++)
	{
%>
		if((<%=retList.getFieldValue(i,"ORGLEVEL")%>)>(<%=retDetails.getFieldValue(0,"ORGLEVEL")%>))
		{
			if('<%=retList.getFieldValueString(i,"PARTICIPANT")%>'=='<%=retDetails.getFieldValueString(0,"PARENT")%>')
			{
				document.myForm.parent.options[stepNo]=new Option('<%=retList.getFieldValue(i,"PARTICIPANT")%>','<%=retList.getFieldValue(i,"PARTICIPANT")%>')
				document.myForm.parent.selectedIndex = stepNo;
				stepNo++
			}
			else
			{
				document.myForm.parent.options[stepNo]=new Option('<%=retList.getFieldValue(i,"PARTICIPANT")%>','<%=retList.getFieldValue(i,"PARTICIPANT")%>')
				stepNo++
			}
		}
<%
	}
%>
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
		<input type = "hidden" name = "orgCode"  value = "<%=retDetails.getFieldValue(0,"CODE")%>">
		<%=retDetails.getFieldValueString(0,"ORG_DEC")%>
    	</Td>
    	</Tr>
    	<Tr>
	<Th align = "right">
		Level
	</Th>
	<td width = "60%">
			<%=retDetails.getFieldValueString(0,"STEP_DESC")%>
    				<input type =hidden name = "level" value = "<%=retDetails.getFieldValue(0,"ORGLEVEL")%>,<%=retDetails.getFieldValue(0,"PARTICIPANT_TYPE")%>">
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
    		<select name = "lang" style = "width:100%" id = "ListBoxDiv">
    			<option value = "">--Select Language--</option>
<%
		int langRows=langRet.getRowCount();
		for(int i=0;i<langRows;i++)
		{
			if((langRet.getFieldValueString(i,LANG_ISO)).equals(retDetails.getFieldValueString(0,"LANG")))
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
		<input type = "text" name = "description" class = "InputBox" value = "<%=retDetails.getFieldValueString(0,"DESCRIPTION")%>" size = "67" maxlength = "100">
    	</Td>
  	</Tr>
    	<Tr>
	<Th align = "right">
		Parent
	</Th>
	<td width = "60%">
    		<select name = "parent" style = "width:100%" id = "ListBoxDiv">
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
<input type = "hidden" name = "organogramCode"  value = "<%=retDetails.getFieldValue(0,"CODE")%>">
<input type = "hidden" name = "templateCode"  value = "<%=retDetails.getFieldValue(0,"TEMPLATE")%>">
<input type = "hidden" name = "myFlag"  value = "<%=myFlag%>">

</form>
</body>
</html>
