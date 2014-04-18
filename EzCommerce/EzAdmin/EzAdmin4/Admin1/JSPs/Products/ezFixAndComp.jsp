<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
	<Script>
		var tabHeadWidth="80";
		var tabHeight="55%";

	function catandfeat()
	{
	   	document.myForm.action="ezCatAndFeat.jsp"
           	document.myForm.submit();
	}
		
	</script>
	<Script src="../../Library/JavaScript/Catalog/ezProcessFile.js"></Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<Body scroll=no onLoad="scrollInit()" onresize="scrollInit()">
<Form name="myForm" method="post">
<Div id="MenuSol_R"></Div> 
<input type="hidden" name="type">
<br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="60%" align=center>Fixtures and Components</Th>
	</Tr>
	<Tr>
		<Th width="60%" align=left>PRINCETON BATH AMERICAST LHO ARCTIC -- 2390202.011 &nbsp;&nbsp;&nbsp;&nbsp; List Price: $2249.00 - $2946.00</Th>
	</Tr>
	</Table><br>

	<Table width="70%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width="10%" align="center">Delete</th>
		<Th width="20%" align="center">Product Code</Th>
		<Th width="40%" align="center">Fixture/ Component Name</th>
		<Th width="30%" align="center">Assignment Type</th>
	</Tr>
	</Table>
	<Table width="70%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="20%" align="left">2390202.011/1</Td>
		<Td width="40%" align="left">PRINCETON BATH AMERICAST LHO ARCTIC -- Component1</Td>
		<Td width="30%" align="left">
		<select>
			<option>Select an Assignment Type</option>
			<option>Main Fixtures</option>
			<option>Add. Fixture/ Component Parts</option>
			<option>Required Components</option>
			<option>Optional Components</option>
			<option>Factory Installed Options</option>
			<option>Discontinued</option>
		</select>
		</Td>
		</tr>
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="20%" align="left">2390202.011/2</Td>
		<Td width="40%" align="left">PRINCETON BATH AMERICAST LHO ARCTIC -- Component2</Td>
		<Td width="30%" align="left">
		<select>
			<option>Select an Assignment Type</option>
			<option>Main Fixtures</option>
			<option>Add. Fixture/ Component Parts</option>
			<option>Required Components</option>
			<option>Optional Components</option>
			<option>Factory Installed Options</option>
			<option>Discontinued</option>
		</select>
		</Td>
		</tr>
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="20%" align="left">2390202.011/3</Td>
		<Td width="40%" align="left">PRINCETON BATH AMERICAST LHO ARCTIC -- Component3</Td>
		<Td width="30%" align="left">
		<select>
			<option>Select an Assignment Type</option>
			<option>Main Fixtures</option>
			<option>Add. Fixture/ Component Parts</option>
			<option>Required Components</option>
			<option>Optional Components</option>
			<option>Factory Installed Options</option>
			<option>Discontinued</option>
		</select>
		</Td>
		</tr>
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="20%" align="left">2390202.011/4</Td>
		<Td width="40%" align="left">PRINCETON BATH AMERICAST LHO ARCTIC -- Component4</Td>
		<Td width="30%" align="left">
		<select>
			<option>Select an Assignment Type</option>
			<option>Main Fixtures</option>
			<option>Add. Fixture/ Component Parts</option>
			<option>Required Components</option>
			<option>Optional Components</option>
			<option>Factory Installed Options</option>
			<option>Discontinued</option>
		</select>
		</Td>
		</tr>
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="20%" align="left">2390202.011/5</Td>
		<Td width="40%" align="left">PRINCETON BATH AMERICAST LHO ARCTIC -- Component5</Td>
		<Td width="30%" align="left">
		<select>
			<option>Select an Assignment Type</option>
			<option>Main Fixtures</option>
			<option>Add. Fixture/ Component Parts</option>
			<option>Required Components</option>
			<option>Optional Components</option>
			<option>Factory Installed Options</option>
			<option>Discontinued</option>
		</select>
		</Td>
		</tr>
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="20%" align="left">2390202.011/6</Td>
		<Td width="40%" align="left">PRINCETON BATH AMERICAST LHO ARCTIC -- Component6</Td>
		<Td width="30%" align="left">
		<select>
			<option>Select an Assignment Type</option>
			<option>Main Fixtures</option>
			<option>Add. Fixture/ Component Parts</option>
			<option>Required Components</option>
			<option>Optional Components</option>
			<option>Factory Installed Options</option>
			<option>Discontinued</option>
		</select>
		</Td>
		</tr>
	</Table>
	<br><br><br><br>
	<Table width="70%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Td width="15%" align="right">Add a Fixture/ Component</Td>
		<Td width="35%" align="left"><input type=text name=productName value=''>
		<img src="../../Images/Buttons/<%=ButtonDir%>/search.gif" border="none" valign=bottom style="cursor:hand" ></Td>
		</tr>
	</Table>

	<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:88%'>
		<span id="EzButtonsSpan">
		<center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" border="none" valign=bottom style="cursor:hand" onclick="deleteProducts()"> 
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
			<img src="../../Images/Buttons/<%=ButtonDir%>/edit.gif" border="none" valign=bottom style="cursor:hand" onclick="catandfeat()"> 
		</center>
		</span>
		<span id="EzButtonsMsgSpan" style="display:none">
			<Table align=center>
				<Tr>
					<Td class="labelcell">Your request is being processed... Please wait</Td>
				</Tr>
			</Table>
		</span>
	</Div>

<Div id="MenuSol"></Div>
</form>
</body>
</html>