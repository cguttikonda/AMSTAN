
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
<script>
	function checkOption()
	{
		opener.document.myForm.destUser.value="MGR2"
		window.close()
	}
</script>
</head>
<body >
<form name=myForm method=post onSubmit="return checkOption()">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Select Destination User</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>

	<Tr>
		<Td align=left class=labelcell width=50%>SysKey*</Td>
		<Td width=50%><select name=syskey>
				<option>syskey1</option>
				<option>syskey2</option>
				</select>
		</Td>
	</Tr>

	<Tr>
		<Td colspan=2>Available Destination Users</Td>
	</Tr>
	<Tr>
		<Td><input type=radio name=r checked></Td>
		<Td>MGR1</Td>
	</Tr>
	<Tr>
		<Td><input type=radio name=r></Td>
		<Td>MGR2</Td>
	</Tr>
	<Tr>
		<Td><input type=radio name=r></Td>
		<Td>MGR3</Td>
	</Tr>
</Table>
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none onClick="javascript:window.close()"></a>
</center>
</form>
</body>
</html>
