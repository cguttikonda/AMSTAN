<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iSearchBPBySoldTo.jsp"%>
<%
	String myPartnerFunction = "VN";
	String partyType = "Pay To Value";
	if(areaFlag.equals("C"))
	{
		myPartnerFunction = "AG";
		partyType = "Sold To Value";
	}
%>
<html>
<Title>Users By partner Value</Title>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src = "../../Library/JavaScript/ezTrim.js"></Script>
<Script>
function funSubmit(areaLabel)
{
	if(funTrim(document.myForm.partnerValue.value)=="")
	{
		alert("Please enter <%=partyType%> Value.")
		document.myForm.partnerValue.value = "";
		document.myForm.partnerValue.focus();
		return false
	}
	else
	{
		document.myForm.action = "ezSearchBPBySoldTo.jsp";
		document.myForm.submit();
	}
}
function funFocus()
{
	if(document.myForm.partnerValue!=null)
		document.myForm.partnerValue.focus();
}
</Script>
</head>
<body onLoad = "funFocus()" scroll="no">
<form name=myForm method=post action="">
<input type = "hidden" name = "Area" value = "<%=areaFlag%>">
<input type = "hidden" name = "partnerFunction" value = "<%=myPartnerFunction%>">
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
			if(partnerValue == null || "null".equals(partnerValue)) partnerValue="";
%>
		      	<Th width="30%" align = "right"><%=partyType%>:</Th>
			<Td width = "50%" ><input type = "text" name = "partnerValue" class = "InputBox" maxlength = "10" style = "width:100%" value = "<%=partnerValue%>"></Td>
			<Td align = "center">
				<img src = "../../Images/Buttons/<%=ButtonDir%>/search.gif" Style = "Cursor:hand" onClick = "funSubmit('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
			</Td>
		</Tr>
		</Table>
<%
	if(sysKey==null || partnerValue == null)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr align="center">
				<Th>Please enter <%=partyType%> Value and click on Search.</Th>
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
			int rowCount = partnersRet.getRowCount();
			if(rowCount ==0)
			{
%>
				<br><br><br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
					<Tr align="center">
						<Th>There are no Partners to List.</Th>
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
			      	<Th width="15%">Partner No</Th>
			      	<Th width="25%">Partner Name</Th>
			      	<Th width="60%"><%=areaLabel.substring(0,areaLabel.length()-1)%></Th>
			</Tr>
<%
			for(int i=0;i<rowCount;i++)
			{
%>
				<Tr>
					<Td width="15%"><a href = "ezShowBPInfo.jsp?BusPartner=<%=partnersRet.getFieldValueString(i,PARTNER_NO)%>"><%=partnersRet.getFieldValueString(i,PARTNER_NO)%></a></Td>
					<Td width="25%">
					<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=partnersRet.getFieldValueString(i,PARTNER_SYS_KEY)%>&Area=<%=areaFlag%>&BusinessPartner=<%=partnersRet.getFieldValueString(i,PARTNER_NO)%>">
						<%=partnersRet.getFieldValueString(i,PARTNER_NAME)%>
					</a>
					</Td>
					<Td width="60%">
					<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=partnersRet.getFieldValueString(i,PARTNER_SYS_KEY)%>">
						<%=partnersRet.getFieldValueString(i,SYSTEM_DESC)%> (<%=partnersRet.getFieldValueString(i,PARTNER_SYS_KEY)%>)</a>
					</Td>
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
