<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreasByDefaults.jsp"%>
<%
	String areaLabel = "Sales Area";
	if(areaFlag.equals("V"))
		areaLabel = "Purchase Area";
%>
<html>
<Title>Users By partner Value</Title>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src = "../../Library/JavaScript/ezTrim.js"></Script>
<Script>
function funSubmit()
{
	if(document.myForm.defKey.selectedIndex==0)
	{
		alert("Please select Defaults Key.")
		document.myForm.defKey.value = "";
		document.myForm.defKey.focus();
		return false
	}
	else if(funTrim(document.myForm.defValue.value)=="")
	{
		alert("Please enter Defaults Value.")
		document.myForm.defValue.value = "";
		document.myForm.defValue.focus();
		return false
	}
	else
	{
		document.myForm.action = "ezListBusAreasByDefaults.jsp";
		document.myForm.submit();
	}
}
function funFocus()
{
	if(document.myForm.defKey!=null)
		document.myForm.defKey.focus();
}
</Script>
</head>
<body onLoad = "scrollInit();funFocus()"  onresize="scrollInit()"  scroll="no">
<form name=myForm method=post action="">
<input type = "hidden" name = "Area" value = "<%=areaFlag%>">
<%
	int myRowCount = ret.getRowCount();
	if(myRowCount==0)
	{
%>	
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr align="center">
				<Th>There are no Defaults to List.</Th>
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
<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
<%
	if(defKey == null || "null".equals(defKey)) defKey="";
	if(defValue == null || "null".equals(defValue)) defValue="";
%>
	      	<Th width="20%" align = "right">Defaults Key:</Th>
		<Td width = "30%" >
		<Select name = "defKey" id = "FullListBox" style = "width:100%">
			<Option value = "">--Select Defaults Key--</Option>
<%
			String myDefKey = "";
			for(int i=0;i<myRowCount;i++)
			{
				myDefKey = ret.getFieldValueString(i,"DEFKEY");
				if(defKey.equals(myDefKey))
				{
%>
					<Option value = "<%=myDefKey%>" selected><%=ret.getFieldValueString(i,"DEFDESC")%></Option>
<%
				}
				else
				{
%>
					<Option value = "<%=myDefKey%>"><%=ret.getFieldValueString(i,"DEFDESC")%></Option>
<%
				}
			}
%>
		</Select>
		</Td>
	      	<Th width="20%" align = "right">Value:</Th>
		<Td width = "30%" ><input type = "text" name = "defValue" class = "InputBox" style = "width:100%" value = "<%=defValue%>"></Td>
		<Td>
			<img src = "../../Images/Buttons/<%=ButtonDir%>/show.gif" Style = "Cursor:hand" onClick = "funSubmit()">
		</Td>
		</Tr>
		</Table>
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
						<Th>There are no <%=areaLabel%>s to List.</Th>
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
			<Div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellspacing=0 cellpadding=2>
			<Tr>
			      	<Th width="25%">System Key</Th>
			      	<Th width="75%">Description</Th>
			</Tr>
			</Table>
			</div>
			<DIV id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellspacing=0 cellpadding=2>
<%
			for(int i=0;i<rowCount;i++)
			{
%>
				<Tr>
					<Td width="25%">
							<%=partnersRet.getFieldValueString(i,SYSTEM_KEY)%>
					</Td>
						
					<Td width="75%">
						<a href = "ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=partnersRet.getFieldValueString(i,SYSTEM_KEY)%>">
							<%=partnersRet.getFieldValueString(i,SYSTEM_DESC)%>
						</a>
					</Td>
				</Tr>
<%
			}
%>
			</Table>
			</Div>
			<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>			
			</div>
<%
		}
		else
		{
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr align="center">
					<Th>Please select Default Key and enter Value and Press Show.</Th>
				</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
		}
%>		
</form>		
</body>
</html>
