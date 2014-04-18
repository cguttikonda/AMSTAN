<%
	String areaFlag = (String)session.getValue("myAreaFlag");
	String partyType = (areaFlag.equals("C") )?"Sold":"Pay";
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Title>Search For Users By Name--Powered by EzCommerce Gloabl Solutions</Title>
<script>
	function fun1(obj)
	{
		if(obj==2)
		{
			window.returnValue = null
			window.close()
		}
		else
		{
			if(document.myForm.partnerValue.value == "")
			{
				alert("Please enter <%=partyType%> To Value.")
				document.myForm.partnerValue.focus()
			}
			else
			{
				myVal=document.myForm.partnerValue.value;
				window.returnValue=myVal;
				window.close()
			}	
		}	
	}
	function funFocus()
	{
		document.myForm.partnerValue.focus()
	}
</script>

</head>
<body onLoad = "funFocus()">

<form name=myForm method=post onSubmit="return false;">
<br><br>
<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
	<Td colspan = 2 class = "displayheader" align = "center">Search User By <%=partyType%> To</Td>
</Tr>
<Tr>
	<Th align=right><%=partyType%> To</Th>
	<Td><input type=text class = "InputBox" size=15  maxlength = "10" name="partnerValue"></Td>
</Tr>
</Table>
</form>
<br>
<Center>
	<input type=image src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none onClick="fun1(1)">
	<input type=image src="../../Images/Buttons/<%= ButtonDir%>/cancel.gif" border=none onClick="fun1(2)">
</Center>
</body>
</html>