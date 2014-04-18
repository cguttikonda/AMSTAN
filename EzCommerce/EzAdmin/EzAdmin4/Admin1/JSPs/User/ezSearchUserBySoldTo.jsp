<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iSearchUserBySoldTo.jsp"%>
<%
	String partyType = "Sold";
	if("V".equals(areaFlag))
		partyType = "Pay";
	session.putValue("myAreaFlag",areaFlag);
%>
<html>
<Title>Users By Partner Value</Title>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src = "../../Library/JavaScript/ezTrim.js"></Script>
<Script>
function funSubmit(areaLabel)
{
	if(funTrim(document.myForm.soldTo.value)=="")
	{
		alert("Please enter <%=partyType%> To Value.")
		document.myForm.soldTo.value = "";
		document.myForm.soldTo.focus();
		return false
	}
	else
	{
		document.myForm.action = "ezSearchUserBySoldTo.jsp";
		document.myForm.submit();
	}

}
function funFocus()
{
	if(document.myForm.soldTo!=null)
		document.myForm.soldTo.focus();
}
</Script>
</head>

<body onLoad = "funFocus()" scroll="no">
<form name=myForm method=post action="">
<input type = "hidden" name = "Area" value = "<%=areaFlag%>">
<br>
<%
	int syskeyCount = ret.getRowCount();
	if(syskeyCount == 0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr align="center">
				<Th>There are no <%=areaLabel.substring(0,areaLabel.length()-1)%>s to List.</Th>
			</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
<%
	if(syskeyCount>0)
	{
		String mySyskeys = ret.getFieldValueString(0,SYSTEM_KEY);
		for (int i=1;i<syskeyCount;i++)
		{
			mySyskeys += ","+ret.getFieldValueString(i,SYSTEM_KEY);
		}
%>
		<input type = "hidden" name ="sysKey" value = "<%=mySyskeys%>" >
<%
	}
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
<%
			if(soldTo == null || "null".equals(soldTo)) soldTo="";
%>
		      	<Th width="30%" align = "right"><%=partyType%> To Value:</Th>
			<Td width = "35%" ><input type = "text" name = "soldTo" class = "InputBox" maxlength = "10" style = "width:100%" value = "<%=soldTo%>"></Td>
			<Td align = "center">
				<img src = "../../Images/Buttons/<%=ButtonDir%>/search.gif" Style = "Cursor:hand" onClick = "funSubmit('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
			</Td>
		</Tr>
		</Table>
<%
	if(sysKey==null)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr align="center">
				<Th>Please enter <%=partyType%> To Value and click on Search.</Th>
			</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
<%
		if(partnersRet!=null)
		{
			int userCount = partnersRet.getRowCount();
			if(userCount ==0)
			{
%>
				<br><br><br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
					<Tr align="center">
						<Th>There are no Users to List.</Th>
					</Tr>
				</Table>
				<br>
				<center>
					<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				</center>
<%
				return;
			}
%>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr>
			      	<Th width="25%">User Id</Th>
			      	<Th width="75%">User Name</Th>
			</Tr>
<%
			for(int i=0;i<userCount;i++)
			{
%>
				<Tr>
					<Td width="25%"><a href = ezUserDetails.jsp?UserID=<%=partnersRet.getFieldValueString(i,USER_ID)%>><%=partnersRet.getFieldValueString(i,USER_ID)%></a></Td>
					<Td width="75%"><%=partnersRet.getFieldValueString(i,FIRST_NAME)%> <%=partnersRet.getFieldValueString(i,MIDDLE_NAME)%> <%=partnersRet.getFieldValueString(i,LAST_NAME)%></Td>
				</Tr>
<%
			}
			
%>
			</Table>

<%
		}
%>
</body>
</html>
