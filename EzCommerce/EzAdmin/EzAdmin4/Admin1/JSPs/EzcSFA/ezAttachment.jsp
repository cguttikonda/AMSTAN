<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	String[] attachedFiles=request.getParameterValues("attachedFiles");
	String attwin = request.getParameter("attachWindow");
%>
<html>
<head>
<Title>Mail Attachments</Title>
<script src="../../Library/JavaScript/Components/ezAddComponentsVersionHistory.js"></script>
<script language="JavaScript">
function setDefaults()
{
<%
	if(attachedFiles != null)
	{
		for(int i=0;i<attachedFiles.length;i++)
		{
%>
		document.myForm.attachList.options[<%=i%>]=new Option("<%=attachedFiles[i]%>","<%=attachedFiles[i]%>")
<%
		}
	}
%>
}
</script>
</head>
<body onLoad="setDefaults()" scroll=no>
<form name="myForm" ENCTYPE="multipart/form-data" method="POST">

<Table border="0" cellpadding="0" cellspacing="0">
<Tr>
	<Th colspan=2>
		Attach File
	</Th>
</Tr>
<Tr>
	<Td colspan=2>
		<hr>
	</Td>
</Tr>
<Tr>
	<Td width=60%>
		<Table  border=0 cellspacing=0 cellpadding=0 width=40%>
		<Tr>
			<Td>
				1.Find A File<br><br>Click on the 'Browse' button to select the file.<br><br>
				<input type="file"  name="attachFile" id="attFbutton" tabindex="1">
				<br><br><br>
			</Td>
		</Tr>
		<Tr>
			<Td>
				2.Attach File<br><br>Click on the 'Attach' button. Please wait till you get confirmation<br><br>
			</Td>
		</Tr>
		<Tr>
			<Td align=right>
				<a href="javascript:doAttachFile()"><img src = "../../Images/Buttons/<%=ButtonDir%>/attach.gif" border=none></a>
			</Td>
		</Tr>
		</Table>
	</Td>
	<Td>
		<Table  border=0 cellspacing=0 cellpadding=0 width=40%>
		<Tr><Td>
		<select  name="attachList" tabindex="4" size="10%" width="50%" height="70%" multiple >
		</select>
		</Td></Tr>
		</Table>

	</Td>
</Tr>
<Tr>
	<Td colspan=2>
		<hr>
	</Td>
</Tr>


<Tr>
	<Td colspan=2>
		<center>
		<a href="javascript:doAttach()"><img src = "../../Images/Buttons/<%=ButtonDir%>/done.gif" style="cursor:hand" border=none"></a>
		<a href="javascript:doRemove()"><img src = "../../Images/Buttons/<%=ButtonDir%>/delete.gif" style="cursor:hand" border=none"></a>
		<a href="javascript:window.close()"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" border=none ></a>
	</Td>
</Tr>
</Table>
</form>
</body>
</html>
