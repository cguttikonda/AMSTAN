<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateCodeList.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iAddOrganogram.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iEditOrganogram.jsp"%>
<html>
<head>
<Title>Edit Organogram</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src = "../../Library/JavaScript/WorkFlow/ezEditOrganogram.js"></script>
</head>
<body onLoad="document.myForm.syskey.focus()">
<br>
<form name=myForm method=post action="">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
    	<Td class="displayheader">Edit Organogram</Td>
  	</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Th align = "right">
		Code
	</Th>
    	<Td width = "60%">
    		<%=orgCode%>
	</td>
	</tr>
	<tr>
	<Th align = "right">
		Business Area*
	</Th>
    	<Td width = "60%">
    		<select name = "syskey" style = "width:100%" id = "FullListBox">
    			<option value = "">--Select Business Area--</option>
<%
		int sysCount = retsyskey.getRowCount();
		for(int i=0;i<sysCount;i++)
		{
			if(retsyskey.getFieldValue(i,"ESKD_SYS_KEY").equals(syskey))
			{
%>	
				<option value = "<%=retsyskey.getFieldValue(i,"ESKD_SYS_KEY")%>" selected>
					<%=retsyskey.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%> (<%=retsyskey.getFieldValue(i,"ESKD_SYS_KEY")%>)
				</option>
<%
			}
			else
			{
%>
				<option value = "<%=retsyskey.getFieldValue(i,"ESKD_SYS_KEY")%>">
					<%=retsyskey.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%> (<%=retsyskey.getFieldValue(i,"ESKD_SYS_KEY")%>)
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
		Language*
	</Th>
    	<Td width = "70%">
    		<select name = "lang" style = "width:100%" id = "FullListBox">
    			<option value = "">--Select Language--</option>
<%
		int langCount = langRet.getRowCount();
   		for(int i=0;i<langCount;i++)
   		{
   			if(langRet.getFieldValue(i,LANG_ISO).equals(lang))
   			{
%>   
				<option value="<%=langRet.getFieldValue(i,LANG_ISO)%>" selected>
					<%=langRet.getFieldValue(i,LANG_DESC)%>
		      		</option>
<% 
			}
			else
			{
%>			
				<option value="<%=langRet.getFieldValue(i,LANG_ISO)%>" >
					<%=langRet.getFieldValue(i,LANG_DESC)%>
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
			if(listRet.getFieldValueString(i,"TCODE").equals(template))
			{
%>	
			<option value = "<%=listRet.getFieldValue(i,"TCODE")%>" selected>
				<%=listRet.getFieldValueString(i,"DESCRIPTION")%>
			</option>
<%
			}
			else
			{
%>
			<option value = "<%=listRet.getFieldValue(i,"TCODE")%>" >
				<%=listRet.getFieldValueString(i,"DESCRIPTION")%>
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
		<input type = "text" class = "InputBox" name = "description" value = "<%=description%>" size = "67" maxlength = "100" Style = "width:100%">
    	</Td>
  	</Tr>
</Table>
<br>
<center>
    	<a href="javascript:funUpdate()"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border = "none"></a>
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<input type = "hidden" name = "code" value = "<%=orgCode%>" >
</form>
</body>
</html>
