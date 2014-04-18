<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iListOrganograms.jsp"%>
<%
	int orgCount = listRet.getRowCount();
%>
<html>
<head>
<Title>Pre Organogram Levels</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src = "../../Library/JavaScript/WorkFlow/ezOrganogramLevelsByLevel.js"></script></head>
<body onLoad="funFocus()">
<br>
<form name=myForm method=post>
<%
if(orgCount>0)
{
%>	
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr align="center">
    		<Td class="displayheader">Organogram Levels By Level</Td>
  	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
	<Th align = "right">
		Organogram*
	</Th>
    	<Td width = "60%">
    		<select name = "orgCode" style = "width:100%" id = "FullListBox">
    			<option value = "">--Select Organogram--</option>
<%
		listRet.sort(new String[]{"DESCRIPTION1"},true);
		for(int i=0;i<orgCount;i++)
		{
%>	
			<option value = "<%=listRet.getFieldValue(i,"CODE")%>" >
				<%=listRet.getFieldValueString(i,"DESCRIPTION1")%>
			</option>
<%
		}
%>
		</select>
    	</Td>
    	</Tr>
    	<Tr>
	<Th align = "right">
		Participant*
	</Th>
	<td width = "60%">
    		<input type = "text" class = "InputBox" Style = "width:100%" name = "participant" value = "" size = "20" maxlength = "20">
	</td>
  	</Tr>  	
</Table>
<br>
<center>
    	<a href="javascript:funSave()"><img src="../../Images/Buttons/<%= ButtonDir%>/continue.gif" border = "none"></a>
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
}
else
{
%>

		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				No Organograms To List.
			</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddOrganogramLevels.jsp')">
		</center>
<%
}
%>
</form>
</body>
</html>
