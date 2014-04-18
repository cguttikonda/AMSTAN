<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iDisplayPassword.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
	<title>Password</title> 
</head>
<Body  scroll="no">
<Form name="myForm" method=post action="">

<%
	if(usrId!=null&&usrId.length()>0&&userDetCount==0)
	{
%>
		<Div align = "center" style="position:absolute;top:45%;width:100%">
		<table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="40%">
		<tr>
			<td class =" labelcell" align="center">
				No User exists with this user Id.
			</td>
		</tr>
		</table>
		</Div>
<%
	}
	else
	if(userDetCount>0)
	{
%>
		<Div align = "center" style="position:absolute;top:20%;width:100%">
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr align="center">
				<Td class="displayheader" nowrap>User Details</Td>
			</Tr>
		</Table>
		<Table  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
			<Th width="50%" ><nobr>User Id</nobr></Th><Td width="50%" ><%=userDet.getFieldValueString("EU_ID")%></Td>
		</Tr>
		<Tr>
			<Th width="50%" >Password</Th><Td width="50%" ><%=(myCipher.ezDecrypt(userDet.getFieldValueString("EU_PASSWORD"))).trim()%></Td>
		</Tr>
		</Table>
		</Div>
<%
	}
%>
		<Div align = "center" style="position:absolute;top:60%;width:100%">
		<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr align="center">
				<Td class='blankcell' align='center'><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" border=none style="cursor:hand" border=none onClick="JavaScript:window.close()"></Td>
			</Tr>
		</Table>
		</Div>

</Form>
</Body>
</Html>
		
		