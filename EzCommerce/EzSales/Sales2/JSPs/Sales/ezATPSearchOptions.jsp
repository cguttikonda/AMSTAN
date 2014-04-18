<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<html>
<head>
<title>ATP Search</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=70
	var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script>
	function check()
	{
		var len=document.myForm.searchBy.length;
		var myVal="";
		var myAction="";
		for(i=0;i<len;i++){
			if(document.myForm.searchBy[i].checked)
			myVal=document.myForm.searchBy[i].value;
		}
		if("P"==myVal){
			myAction="../Sales/ezATPMaterialSearch.jsp";
		}else if("B"==myVal){
			myAction="../DrillDownCatalog/ezDrillDownCatalog.jsp";
		}else{
			myAction="../MaterialSearch/ezSearchMaterials.jsp";
		}
		document.myForm.action=myAction;
		document.myForm.submit();
		
	}
</Script>
</head>
  
<body  scroll=NO >
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" align="center" class="displayheaderback"  width="40%">ATP Search&nbsp;</td>
</tr>
</table>
<form method="post" name="myForm" >
<Div id='inputDateDiv' style='position:relative;align:center;top:10%;width:100%;'>
	<Table width="35%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
	<Tr>
		<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
		<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
		<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'F3F3F3'" valign=middle>
			<Table border="0" align="center" valign=middle width="100%" cellpadding=0 cellspacing=0 class=welcomecell>
			<Tr>
				<td rowspan=3  style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='45%' align=center valign=center> ATP From</td>
				<td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='45%' align=left valign=center>
					<input type="radio"  name="searchBy"  value="P" checked>Product Search<br>
					<input type="radio"  name="searchBy"  value="B">Browse General<br>
					<input type="radio"  name="searchBy"  value="C">Characteristics<br>
				</td>
				<Td rowspan=2  style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;align:center' width='45%' align=center>
					<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" onClick="check()" style="cursor:hand" border="none" onMouseover="window.status=''; return true" onMouseout="window.status=' '; return true">
				</Td>
			</Tr>
			
			</Table>
		</Td>
		<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
	</Tr>
	</Table>
</Div>
	
<div id="buttonDiv"  align="center" style="visibility:visible;position:absolute;top:50%;width:100%"></div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>