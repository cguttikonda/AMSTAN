<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<Html>
<Head>
	<Title>Add Component----Powered by EzCommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
	<script src="../../Library/JavaScript/Components/ezAddComponent.js"></script>
</Head>
<Body onLoad="document.myForm.desc.focus()">
<Form name="myForm" method="post"><Br>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th class="displayheader" align=center><b>Add Component</b></Th>
		</Tr>
	</Table>

	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Td class="labelcell">Description:*</Td>
			<Td width=75%><input type=text class=InputBox name="desc" maxlength=100 style="width:100%"></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Version:*</Td>
			<Td width=75%><input type=text class=InputBox name="version" maxlength=5 style="width:100%"></Td>
		</Tr>
	</Table>

	<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
	<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
		<Tr>
			<Td class="blankcell" align=center>
				<a href="javascript:checksubmit()"><img src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  alt="Save" border=no></a>
			</Td>
			<Td class="blankcell" align=center>
				<a href="javascript:document.myForm.reset()"><img src="../../Images/Buttons/<%=ButtonDir%>/reset.gif"  alt="Reset" border=no style="cursor:pointer;cursor:hand"></a>
			</Td>
			<Td class="blankcell" align=center>
				<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no></a>
			</Td>
		</Tr>
	</Table>
	</Div>
</Form>
</Body>
</Html>
