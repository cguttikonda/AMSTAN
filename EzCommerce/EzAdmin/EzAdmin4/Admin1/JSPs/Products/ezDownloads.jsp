<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
	<Script>
		var tabHeadWidth="80";
		var tabHeight="55%";

	function fixandcomp()
	{
	   	document.myForm.action="ezFixAndComp.jsp"
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
		<Th width="60%" align=center>Downloads</Th>
	</Tr>
	<Tr>
		<Th width="60%" align=left>PRINCETON BATH AMERICAST LHO ARCTIC -- 2390202.011</Th>
	</Tr>
	</Table><br>

	<Table width="70%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width="10%" align="center">Delete</th>
		<Th width="30%" align="center">Type</Th>
		<Th width="30%" align="center">Name</th>
		<Th width="30%" align="center">Link</th>
	</Tr>
	</Table>
	<Table width="70%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="30%" align="left">Product Install Sheet (en)</Td>
		<Td width="30%" align="left">Installation Instructions</Td>
		<Td width="30%" align="left"><a href="">View</a></Td>
		</tr>
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="30%" align="left">Product Repair Parts Sheet (en)</Td>
		<Td width="30%" align="left">Repair Parts Diagram</Td>
		<Td width="30%" align="left"><a href="">View</a></Td>
		</tr>
		<Tr>
		<Td width="10%" align="center"><input type="checkbox" name="chk1" value=''></Td>
		<Td width="30%" align="left">Product Specification Sheet (en)</Td>
		<Td width="30%" align="left">Spec Sheet</Td>
		<Td width="30%" align="left"><a href="">View</a></Td>
		</tr>
	</Table>
	<br><br><br><br>
	<Table width="70%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Td width="15%" align="right">Upload a Document:</Td>
		<Td width="35%" align="left">
		<select>
			<option>Select a Document Type</option>
			<option>Add an Additional Product Support Document</option>
			<option>Add a Product Install Sheet (en)</option>
			<option>Add a Product Install Sheet (fr)</option>
			<option>Add a Product Repair Parts Sheet (en)</option>
			<option>Add a Product Repair Parts Sheet (fr)</option>
			<option>Add a Product Specification Sheet (en)</option>
			<option>Add a Product Specification Sheet (fr)</option>
		</select>
		</Td>
		<Td width="15%" align="right">Link Label:</Td>
		<Td width="35%" align="left"><input type=text name=productName value=''></Td>
		</tr>
	</Table>

	<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:88%'>
		<span id="EzButtonsSpan">
		<center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" border="none" valign=bottom style="cursor:hand" onclick="deleteProducts()"> 
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
			<img src="../../Images/Buttons/<%=ButtonDir%>/edit.gif" border="none" valign=bottom style="cursor:hand" onclick="fixandcomp()"> 
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