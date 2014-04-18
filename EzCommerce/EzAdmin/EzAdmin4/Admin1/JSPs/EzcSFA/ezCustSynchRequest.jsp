
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcSFA/iUserList.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcSFA/iCustSynchRequest.jsp"%>

<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script>
	function checkFields()
	{
		/*if(document.myForm.UserID.selectedIndex == -1 || document.myForm.UserID.selectedIndex == 0)
		{
			alert("Please select User Name");
			document.myForm.UserID.focus()
			return;
		}*/
		document.myForm.action='ezSaveSynchRequest.jsp'
		document.myForm.submit()
	}
	function getSectors()
	{
		document.myForm.submit()
	}
	</Script>
</head>
<body topmargin=0 leftmargin=0 rightmargin=0 onresize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<input type="hidden" name="synchtype" value="CS">
<br><br><br><br>
<Table width="20%" border=1 align="center" borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr>
<Th width="40%" align="left">User </th>
<Td width="60%">
	<select name="UserId" style="width:100%" id="FullListBox" onchange="getSectors()">
	<option value="">--Select--</option>
<%
 		String selected = "";
 		for(int i=0;i<userCount;i++)
 		{
 			if(user_id.equals(userList[i]))
 				selected = "selected";
 			else
 				selected = "";
 			
%>
			<option value="<%=userList[i]%>" <%=selected%>><%=userList[i]%></option>			
<%
 		}
%>
	</select>
</Td>
</Tr>
<Tr>
<Th width="40%" align="left">Sector</th>
<Td width="60%">
	<select name="Sector" style="width:100%" id="FullListBox">
	<option value="">--Select--</option>
<%
		if(sectorData.size() > 0)
		{
	 		for(int i=0;i<sectorData.size();i++)
 			{
%>
				<option value="<%=sectorData.get(i)%>"><%=sectorData.get(i)%></option>			
<%
	 		}
	 	}	
%>
	</select>
</Td>
</Tr>

</Table>

<br><br>

<Table width="50%" border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr align="center" valign="middle">
		<Td class='blankcell' align="center">
				<a href='javascript:checkFields()'><img src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif"  border="none" valign="center"></a>
		</Td>
	<Tr>
<Table>
</form>
</body>
</html>



