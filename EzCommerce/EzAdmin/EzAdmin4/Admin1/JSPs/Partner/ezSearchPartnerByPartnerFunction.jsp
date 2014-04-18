<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iSearchBPByPartnerFunction.jsp"%>
<%
	session.putValue("myAreaFlag",areaFlag);
%>
<html>
<Title>Users By partner Value</Title>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src = "../../Library/JavaScript/ezTrim.js"></Script>
<Script>
function funSubmit(areaLabel)
{
	if(document.myForm.partnerValue.selectedIndex==0)
	{
		alert("Please Select "+areaLabel);
		document.myForm.partnerValue.focus();
	}
	else if(document.myForm.partnerFunction.selectedIndex==0)
	{
		alert("Please Select Partner Function.")
		document.myForm.partnerFunction.focus();
		return false
	}
	else if(funTrim(document.myForm.partnerValue.value)=="")
	{
		alert("Please enter Value.")
		document.myForm.partnerValue.value = "";
		document.myForm.partnerValue.focus();
		return false
	}
	else
	{
		document.myForm.action = "ezSearchPartnerByPartnerFunction.jsp";
		document.myForm.submit();
	}

}
function funFocus()
{
	if(document.myForm.partnerValue!=null)
		document.myForm.partnerValue.focus();
}
function funSelect()
{
	var si = document.myForm.partnerFunction;
<%
	if(partnerFunction!=null)
	{
		if("V".equals(areaFlag))
		{
%>
			if('<%=partnerFunction%>'=='PI')
				si.selectedIndex = 1;
			else if('<%=partnerFunction%>'=='OA')
				si.selectedIndex = 2;
			else
				si.selectedIndex = 3;
<%
		}
		else
		{
%>
			if('<%=partnerFunction%>'=='RE')
				si.selectedIndex = 1;
			else if('<%=partnerFunction%>'=='AF')
				si.selectedIndex = 2;
			else if('<%=partnerFunction%>'=='WE')
				si.selectedIndex = 3;
			else
				si.selectedIndex = 4;
<%
		}
	}
%>
}
</Script>
</head>
<body onLoad = "funFocus();funSelect()" scroll="no">
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
		String mySyskeys=ret.getFieldValueString(0,SYSTEM_KEY);
		for(int i=1;i<syskeyCount;i++)
		{
			mySyskeys+=","+ret.getFieldValueString(i,SYSTEM_KEY);
		}

%>

	<input type = "hidden" name ="sysKey" value = "<%=mySyskeys%>" >
<%
	}
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		<Tr>
		      	<Th width="25%" align = "right">Partner Function:</Th>
		      	<Td width="25%">
        		<Select name="partnerFunction" id = "ListBoxDiv">
        		<Option value="">--Select Partner Function--</Option>
<%
			if("V".equals(areaFlag))
			{
%>
				<Option value = "PI">Billing Party Code (PI)</Option>
				<Option value = "OA">Ordering Address (OA)</Option>
				<Option value = "VN">Pay To Party Code (VN)</Option>
<%
			}
			else
			{
%>
				<%--<Option value = "RE">Invoice To (RE)</Option>
				<Option value = "AF">Sales Office / Sales Employee (AF)</Option>--%>
				<Option value = "WE">Ship To Party Code (WE)</Option>
        			<Option value = "AG">Sold To Party Code (AG)</Option>
<%
			}
%>
			</Select>
			</Td>
<%
			if(partnerValue == null || "null".equals(partnerValue)) partnerValue="";
%>
		      	<Th width="25%" align = "right">Value:</Th>		
			<Td width = "25%" ><input type = "text" name = "partnerValue" class = "InputBox" maxlength = "10" style = "width:100%" value = "<%=partnerValue%>"></Td>
			<Td>
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
				<Th>Please select Partner Function,Value and click on Search.</Th>
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
			      	<Th width="60%">Purchase Area</Th>		
			</Tr>
<%
			for(int i=0;i<userCount;i++)
			{
%>
				<Tr>
					<Td width="15%"><a href = "ezShowBPInfo.jsp?BusPartner=<%=partnersRet.getFieldValueString(i,PARTNER_NO)%>"><%=partnersRet.getFieldValueString(i,PARTNER_NO)%></a></Td>
					<Td width="25%"><a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=partnersRet.getFieldValueString(i,PARTNER_SYS_KEY)%>&Area=<%=areaFlag%>&BusinessPartner=<%=partnersRet.getFieldValueString(i,PARTNER_NO)%>">
					<%=partnersRet.getFieldValueString(i,PARTNER_NAME)%>
					</a>
					</Td>
					
					<Td width="60%">
					<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=partnersRet.getFieldValueString(i,PARTNER_SYS_KEY)%>">
					<%=partnersRet.getFieldValueString(i,SYSTEM_DESC)%> (<%=partnersRet.getFieldValueString(i,PARTNER_SYS_KEY)%>)</a></Td>
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
