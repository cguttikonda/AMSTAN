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
			if(document.myForm.criteria.value == "")
			{
				alert("Please enter criteria")
				document.myForm.criteria.focus()
			}
			else
			{
			
				myVal="SW"
				for(i=0;i<document.myForm.chk1.length;i++)
				{
					if(document.myForm.chk1[i].checked)
					{
						myVal=document.myForm.chk1[i].value
						break;
					}
				}
				if(myVal=="SW")
				{
					myVal=document.myForm.criteria.value+"*";
				}
				else if(myVal=="EW")
				{
					myVal="*"+document.myForm.criteria.value;
				}
				else
				{
					myVal=document.myForm.criteria.value;
				}

				window.returnValue=myVal;
				window.close()
			}	
		}	
	}
	function funFocus()
	{
		document.myForm.criteria.focus()
	}
</script>

</head>
<body onLoad = "funFocus()">

<form name=myForm method=post onSubmit="return false;">
<br><br>
<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
	<Th><input type=radio name=chk1 value="SW" onClick = funFocus() checked>Starts With</Td>
	<Th><input type=radio name=chk1 value="EW" onClick = funFocus()>Ends With</Td>
	<Th><input type=radio name=chk1 value="EQ" onClick = funFocus()>Equals To</Td>
</Tr>
</Tr>
<Tr>
	
	<Th>User Name</Th>
	<Td colspan=2>
			<input type=text class = "InputBox" size=15   name="criteria">
	</Td>
</Tr>
</Table>
</form>

<Table align=center>
<Tr>
<Td class=blankcell>
	<input type=image src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none onClick="fun1(1)">
	<input type=image src="../../Images/Buttons/<%= ButtonDir%>/cancel.gif" border=none onClick="fun1(2)">
</Td>
</Tr>
</Table>

</body>