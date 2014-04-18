<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iChangeStyleSheet.jsp"%>
<%
	String styleKey = "";
	String styleDesc = "";
	int defRows = retStyle.getRowCount();
	if ( defRows > 0 )
	{
		for ( int i = 0 ; i < defRows; i++ )
		{
			String defKey = (String)retStyle.getFieldValue(i,"EUD_KEY");
			String defValue = (String)(retStyle.getFieldValue(i,"EUD_VALUE"));
			defKey = defKey.trim();
			if (defKey.equals("STYLE"))
			{
				styleKey = defKey;
				styleDesc = defValue;
			}//End if
		}
	}
%>

<html>
<head>
<Title>Change Style Sheet</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
function mySelect()
{
	if("<%=styleDesc%>"=="YELLOW")
		document.myForm.DefValue.selectedIndex = 1;
	else if("<%=styleDesc%>"=="LAVENDER")
		document.myForm.DefValue.selectedIndex = 2;
	else 
		document.myForm.DefValue.selectedIndex = 0;
}
function funSubmit()
{
	if(document.myForm.DefValue.selectedIndex==0)
	{
		alert("Please Select Style.");
		document.myForm.DefValue.focus();
		return false;
	}
	return true;
}
</Script>
</head>
<body onLoad = "document.myForm.DefValue.focus();mySelect()">
<br>
<form name=myForm method=post onSubmit ="return funSubmit()" action="ezSaveChangeStyleSheet.jsp" target = "_top">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="40%">
	<Tr>
	<Th >
		<%=styleKey%>
		<input type = hidden  name = "DefKey" value = <%=styleKey%>>
	</Th>
	<Td>
	<select name="DefValue" id = "ListBoxDiv">
		<option value="">--Select Style--</option>
		<option value="YELLOW">YELLOW</option>
		<option value="LAVENDER">LAVENDER</option>
    	</select>
	</Td>
	</Tr>
</Table>
<br>
<center>
    	<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" value="Save">
    	<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" value="Back" Style = "Cursor:hand" onClick = "JavaScript:history.go(-1)">
</center>
</form>
</body>
</html>