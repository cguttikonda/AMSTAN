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
		<Th width="60%" align=center>Category and Features</Th>
	</Tr>
	<Tr>
		<Th width="60%" align=left>PRINCETON BATH AMERICAST LHO ARCTIC -- 2390202.011</Th>
	</Tr>
	</Table><br>
	<Table width="70%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Td width="15%" align="right">Product Category</Td>
		<Td width="35%" align="left">
		<select style="width:30%">
			<option>Bathing</option>
		</select>
		</Td>
		</tr>
	</Table>

	<Table width="70%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width="30%" align="center">Attribute Name</Th>
		<Th width="30%" align="center">Attribute Style</th>
		<Th width="40%" align="center">Options</th>
	</Tr>
	</Table>
	<Table width="70%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Td width="30%" align="left" valign='top'>ADA Compliant</Td>
		<Td width="30%" align="left" valign='top'>Single Choice</Td>
		<Td width="40%" align="left">
		<input type=radio name=rd value='Active'>No<br>
		<input type=radio name=rd value='Inactive'>Yes
		</Td>
		</tr>
		<Tr>
		<Td width="30%" align="left" valign='top'>Finish/ Color</Td>
		<Td width="30%" align="left" valign='top'>Multiple Select</Td>
		<Td width="40%" align="left">
		<input type=checkbox name=ch1 value=''>Antique Cherry<br>
		<input type=checkbox name=ch1 value=''>Antique Nickel<br>
		<input type=checkbox name=ch1 value=''>Bamboo<br>
		<input type=checkbox name=ch1 value=''>Blackend Bronze<br>
		<input type=checkbox name=ch1 value=''>Brushed Chrome<br>
		<input type=checkbox name=ch1 value=''>Diamond<br>
		<input type=checkbox name=ch1 value=''>Ebony<br>
		<input type=checkbox name=ch1 value=''>Italian Cherry<br>
		<input type=checkbox name=ch1 value=''>Light Cherry<br>
		<input type=checkbox name=ch1 value=''>Mahogany
		</Td>
		</tr>
	</Table>
	<br><br><br><br>

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