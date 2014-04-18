<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
	<Script>
		var tabHeadWidth="80";
		var tabHeight="55%";

	function downloads()
	{
	   	document.myForm.action="ezDownloads.jsp"
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
		<Th width="60%" align=center>Product Information - Edit</Th>
	</Tr>
	<Tr>
		<Th width="60%" align=left>PRINCETON BATH AMERICAST LHO ARCTIC -- 2390202.011 &nbsp;&nbsp;&nbsp;&nbsp; List Price: $2249.00 - $2946.00</Th>
	</Tr>
	</Table><br>

	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="30%" align=right>Product Name &nbsp;&nbsp;</Th>
		<Td width="70%" align=left><input type=text name=productName value='PRINCETON BATH AMERICAST LHO ARCTIC' size=80></Td>
	</Tr>
	<Tr>
		<Th width="30%" align=right valign=top>Product Description &nbsp;&nbsp;</Th>
		<Td width="70%" align=left><textarea name=productDesc value='' rows=10 cols=60></textarea></Td>
	</Tr>
	<Tr>
		<Th width="30%" align=right>Product Publish Status &nbsp;&nbsp;</Th>
		<Td width="70%" align=left><input type=radio name=rd value='Active'>Active
		&nbsp;<input type=radio name=rd value='Inactive'>Inactive
		&nbsp;<input type=checkbox name=ch1 value='Discontinued'>Discontinued</Td>
	</Tr>
	</Table><br>
	<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:88%'>
		<span id="EzButtonsSpan">
		<center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" border="none" valign=bottom style="cursor:hand" onclick="deleteProducts()"> 
			<img src="../../Images/Buttons/<%=ButtonDir%>/edit.gif" border="none" valign=bottom style="cursor:hand" onclick="downloads()"> 
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
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