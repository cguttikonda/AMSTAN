<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=95
	var tabHeight="30%"
</Script>
<Script src="http://code.jquery.com/jquery-latest.js"></Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script src="../../Library/Script/popup.js"></Script>

<script>
	function formSubmit()
	{
		var soldto = document.myForm.soldTo.value;
		var division = document.myForm.division.value;
		var dchannel = document.myForm.dchannel.value;
		var salesorg = document.myForm.salesorg.value;
		
		if(soldto ==''){
			alert("Please enter Sold To value");
			document.myForm.soldTo.focus()
			return;
		}
		if(division == ''){
			alert("Please enter Division value");
			document.myForm.division.focus()
			return;
		}
		else if(dchannel == ''){
			alert("Please enter Distribution Channel value");
			document.myForm.dchannel.focus()
			return;
		}
		else if(salesorg == ''){
			alert("Please enter Sales Organization value");
			document.myForm.salesorg.focus()
			return;
		}
		else
		{
			Popup.showModal('modal');
			document.myForm.action="ezQuickAddUser.jsp";
			document.myForm.submit();
		}
	}
</script>
<Style>
ul
{
    list-style-type: none;
}
</Style>

</Head>
<Body  onLoad="scrollInit();document.myForm.soldTo.focus()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<div id="modal" style="z-index:100;position:absolute;left:280px; top:140px; border:1px solid #EEEDE7; border-radius:7px; background-color:#ffffff; padding:1px; font-size:10;width:330px;height:150px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="80" height="80" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<br><br>

	<Div align=center>
	    <Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr>
			    <Th colspan='2'>Quick Add User</Th>
		</tr>	    
		<Tr>
			<Th width = "25%" align="right">Sold To*</Th>
			<Td width = "25%"><input type = "text" class = "InputBoxTest" name = "soldTo" size = 11 maxlength = "10" ></Td>
		</Tr>
		<Tr>
			<Th width = "25%" align="right">Division*</Th>
			<Td width = "25%"><input type = "text" class = "InputBoxTest" name = "division" size = 2 maxlength = "2"></Td>
		</Tr>
		<Tr>
			<Th width = "25%" align="right">Distribution Channel*</Th>
			<Td width = "25%"><input type = "text" class = "InputBoxTest" name = "dchannel" size = 2 maxlength = "2"></Td>
		</Tr>	
		<Tr>
			<Th width = "25%" align = "right">Sales Organization*</Th>
			<Td width = "25%"><input type = "text" class = "InputBoxTest" name = "salesorg" size = 4 maxlength = "4"></Td>	

		</Tr>
		<Tr>
			<Th width = "25%" align = "right">Hierarchy Code</Th>
			<Td width = "25%"><input type = "text" class = "InputBoxTest" name = "hiercode" size = 7 maxlength = "10"></Td>			
		</Tr>
	    </Table>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<!--input type=image src = "../../Images/Buttons/<%= ButtonDir%>/go.gif"  border=no-->
		<a href="JavaScript:formSubmit()"><img src="../../Images/Buttons/<%=ButtonDir%>/go.gif" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</Div>
</Form>
</Body>
</Html>   