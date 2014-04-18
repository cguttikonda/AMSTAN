<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<html>
<head>
<Title>Vendor Synchronizion Configuration</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/User/ezMassSynch.js"></script>
<Script>
function funFocus()
{
	if(document.myForm.syskey!=null)
		document.myForm.syskey.focus();
}
</Script>
</head>
<body onLoad = "funFocus()">
<%
	String syskey=request.getParameter("syskey");
	String prop=request.getParameter("prop");
	String from=request.getParameter("from");
	String to=request.getParameter("to");

	syskey=(syskey==null || "null".equals(syskey))?"":syskey;
	prop=(prop==null || "null".equals(prop))?"":prop;
	from=(from==null || "null".equals(from))?"":from;
	to=(to==null || "null".equals(to))?"":to;
%>
<form name=myForm method=post onSubmit = "return checkAll()"  action="ezMassVendSynch.jsp">
<%
int retCount = ret.getRowCount();
if(retCount==0)
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  	<Tr align="center">
    	<Th>There are no Purchase Areas to List</Th>
  	</Tr>
	</Table>
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</center>
<%
	return;
}
%>
	<br>
        <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td class = "displayheader" align = "center">Mass Vendor Synchronization</Td>
	</Tr>
	</Table>
        <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th align="right" width = "30%">Business Area</Th>
		<Td>
		<Select name = "syskey" id = "FullListBox" Style = "width:100%">
<%
		ret.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
		for(int i=0;i<retCount;i++)
		{
%>
			<Option value="<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>"><%=ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>  (<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>)</Option>
<%
		}
%>
		</Select>
		</Td>
	</Tr>
	<Tr>
		<Th align="right">Property File*</Th>
		<Td><input type=text class = "InputBox" name=prop value="<%=prop%>"></Td>
	</Tr>
	<Tr>
		<Th align="right">From*</Th>
		<Td><input type=text class = "InputBox" name=from value="<%=from%>"></Td>
	</Tr>
	<Tr>
		<Th align="right">To*</Th>
		<Td><input type=text class = "InputBox" name=to value="<%=to%>"></Td>
	</Tr>
	</Table>
	<br>
	<center>
	 	<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" name="Submit">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
</form>
</html>