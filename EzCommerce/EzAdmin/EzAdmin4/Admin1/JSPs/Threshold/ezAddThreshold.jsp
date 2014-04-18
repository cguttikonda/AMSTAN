<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/Threshold/iAddThreshold.jsp"%>
<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=95
	var tabHeight="30%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>

<script>
	function formSubmit()
	{
		var mfr = document.myForm.mfr.value;
		var threshold = document.myForm.threshold.value;
		var manfId = document.myForm.manfId.value;
		
		//alert(mfr);
		//alert(manfId);
		
		if(mfr=='')
		{
			alert("Please select a Manufacture");
			document.myForm.mfr.focus()
			return;
		}
		else if(threshold=='')
		{
			alert("Please enter Threshold");
			document.myForm.threshold.focus()
			return;
		}
		else
		{
			if(isNaN(threshold))
			{
				alert("Please enter valid Threshold");
				document.myForm.threshold.value="";
				document.myForm.threshold.focus();
				return;
			}
			else
			{
				document.myForm.action="ezAddSaveThreshold.jsp";
				document.myForm.submit();
			}
		}
	}
	function mfrSearch()
	{
		var url="ezSelectManufacture.jsp";
		newWindow=window.open(url,"SearchWin","width=550,height=350,left=180,top=180,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
</script>

</Head>
<Body  onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<input type="hidden" name="manfId" value="">
<br><br>

	<Div align=center>
	    <Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr>
			<Th colspan='2'>Add Threshold</Th>
		</tr>	    
		<Tr>
			<Th width = "25%" align="right">Manufacturer *</Th>
			<Td width = "25%"><input type = "text" class = "InputBoxTest" name = "mfr" size = 25 readonly>
			<a href="JavaScript:mfrSearch()"><img src="../../Images/Buttons/<%=ButtonDir%>/search.gif" border=none></a>
			</Td>
		</Tr>
		<Tr>
			<Th width = "25%" align="right">Item Category</Th>
			<Td width = "25%">
<%
			if(retCatCnt>0)
			{
%>
				<select name= "itemCat" id=listBoxDiv style="border:1px solid">
					<option value="">--Select--</option>
<%
				retCat.sort(new String[]{"Description"},true);
				String catID = "",catDesc="";
				
				for(int i=0;i<retCatCnt;i++)
				{
					catID = retCat.getFieldValueString(i,"CatID");
					catDesc = retCat.getFieldValueString(i,"Description");
%>
					<option value="<%=catID%>"><%=catDesc%></option>
<%
				}
%>
				</select>
<%
			}
			else
			{
%>
				No Item Catagories available
<%
			}
%>			
			</Td>
		</Tr>
		<Tr>
			<Th width = "25%" align="right">Threshold *</Th>
			<Td width = "25%"><input type = "text" class = "InputBoxTest" name = "threshold" size = 6 maxlength = "6" style="text-align:right">&nbsp;%</Td>
		</Tr>	
	    </Table>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<!--input type=image src = "../../Images/Buttons/<%= ButtonDir%>/go.gif"  border=no-->
		<a href="JavaScript:formSubmit()"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</Div>
</Form>
</Body>
</Html>