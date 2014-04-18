<HTML>
<HEAD>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/checkFormFields.js"></script>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
</HEAD>
<BODY onLOad="scrollInit()" onResize="scrollInit()" scroll="no">
<form  name='myForm'  method=post action="ezSendR3Mail.jsp">
<br>

<div id="theads">
<TABLE id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<TR>
	<td class = "displayheader" align=center colspan=4>Send R3 Mail</td>
</Tr>
</Table>
</div>
<div id="InnerBox1Div" style="position;absolute;top:12%;width:100%">
<TABLE id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<Tr>
	<Th width="20%" align = "right">Name</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=name value="WEBORDER">
	<Th width="20%" align = "right">Description</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=description value="SO Posted">
</Tr>
<Tr>
	<Th width="20%" align = "right">Message Type</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=messageType value="RAW">
	<Th width="20%" align = "right">Put Inbox</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=ext1 value=" ">
</Tr>
<Tr>
	<Th width="20%" align = "right">Sort On</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=sortValue value="WEBORDER">
	<Th width="20%" align = "right">Changable</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=changable value="X">
</Tr>
<Tr>
	<Th width="20%" align = "right">Client</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=client value="900">
	<Th width="20%" align = "right">System</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=system value="QA1">
</Tr>
<Tr>
	<Th width="20%" align = "right">Command</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=execCommand value="VA02">
	<Th width="20%" align = "right">Exec. Type</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=execType value="T">
</Tr>
<Tr>
	<Th width="20%" align = "right">Parameter Name</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=parameterName value="AUN">
	<Th width="20%" align = "right">Parameter Value</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=parameterValue value="70289444">
</Tr>
<Tr>
	<Th width="20%" align = "right">User Name</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=userName value="NATRAJANM">
	<Th width="20%" align = "right">User Type</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=userType value="B">
</Tr>
<Tr>
	<Th width="20%" align = "right">Mail Type</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=mailType value="RAW">
	<Th width="20%" align = "right">Mail Priority</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=mailPriority value="">
</Tr>
<Tr>
	<Th width="20%" align = "right">Mail Date</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=mailDate value="20030803">
	<Th width="20%" align = "right">Sensitivity</Th>
	<Td width="30%"><input type = "text" class = "InputBox" style = "width:100%" name=sensitivity value="P">
</Tr>
<Tr>
	<Th width="20%" align = "right" valign = "top">Mail Text</Th>
	<Td colspan=3>
	<Textarea rows=5 cols=65 name=mailText style="overflow:auto;border:0;width:100%">Sales Order has been created by   for Testing</TextArea>
	</Td>
</Tr>
</Table>
</div>
<br>
<div id="ButtonDiv" style="position;absolute;top:80%;width:100%">
<center>
	<input type=image src="../../Images/Buttons/<%=ButtonDir%>/send.gif" border=none>
	<img src = "../../Images/Buttons/<%=ButtonDir%>/back.gif" style = "cursor:hand" onClick = "javascript:history.go(-1)">

</center>
</div>
</form>
</BODY>
</HTML>
