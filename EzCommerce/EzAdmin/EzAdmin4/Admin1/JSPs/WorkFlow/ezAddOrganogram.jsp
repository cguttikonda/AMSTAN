<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateCodeList.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iAddOrganogram.jsp"%>
<html>
<head>
<Title>Add Organogram</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src = "../../Library/JavaScript/WorkFlow/ezAddOrganogram.js"></script>
<Script>
function funAddTemplate()
{
	document.location.href = "ezAddTemplateCode.jsp"
}
</Script>
</head>
<body >
<form name=myForm method=post action="">
<%
if(retsyskey.getRowCount() == 0)
{
%>
	<br><br><br><br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="100%" align=center>
			No Business Areas to List.
		</Th>
	</Tr>
	</Table>
	<br>
	<center>
		<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  style = "cursor:hand" alt="Click here to go to previous page" border=no onClick="JavaScript:history.go(-1)">
	</center>
<%
		return;
}
else if(listRet.getRowCount() == 0)
{
%>
	<br><br><br><br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="100%" align=center>
			No Templates to List.
		</Th>
	</Tr>
	</Table>
	<br>
	<center>
		<img src="../../Images/Buttons/<%=ButtonDir%>/add.gif"  style = "cursor:hand" alt="Click here to Add Template" onClick="JavaScript:funAddTemplate()">
		<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  style = "cursor:hand" alt="Click here to go to previous page" border=no onClick="JavaScript:history.go(-1)">
	</center>
<%
		return;
}
else 
{
%>
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
    	<Td class="displayheader">Add Organogram</Td>
  	</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Th align = "right">
		Business Area*
	</Th>
    	<Td width = "60%">
    		<select name = "syskey" style = "width:100%" id = "FullListBox">
    			<option value = "">--Select Business Area--</option>
<%
		int sysCount = retsyskey.getRowCount();
		retsyskey.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
		for(int i=0;i<sysCount;i++)
		{
%>	
			<option value = "<%=retsyskey.getFieldValue(i,"ESKD_SYS_KEY")%>" >
				<%=retsyskey.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%> (<%=retsyskey.getFieldValue(i,"ESKD_SYS_KEY")%>)
			</option>
<%
		}
%>
		</select>
    	</Td>
    	</Tr>
    	<Tr>
	<Th align = "right">
		Language*
	</Th>
    	<Td width = "70%">
    		<select name = "lang" style = "width:100%" id = "FullListBox">
		<option>--Select Language--</option>
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
		Template*
	</Th>
    	<Td width = "70%">
    		<select name = "template" style = "width:100%" id = "FullListBox">
    			<option value = "">--Select Template--</option>
<%
		int tempCount = listRet.getRowCount();
		for(int i=0;i<tempCount;i++)
		{
%>	
			<option value = "<%=listRet.getFieldValue(i,"TCODE")%>" >
				<%=listRet.getFieldValueString(i,"DESCRIPTION")%>
			</option>
<%
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
		<input type = "text" class = "InputBox" name = "description" value = "" size = "67" maxlength = "100"  Style = "width:100%">
    	</Td>
  	</Tr>
</Table>
<br>
<center>
    	<a href="javascript:funSave()"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border = "none"></a>
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
}
%>
</form>
</body>
</html>
