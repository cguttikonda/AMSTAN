<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/Freight/iAddServiceType.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Html>
<Head>
<Script>
	var tabHeadWidth=95
	var tabHeight="30%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>


<script>
sTypeArray = new Array();
<%
	for(int i=0;i<stCnt;i++)
	{
%>
		sTypeArray[<%=i%>] = '<%=(stRet.getFieldValueString(i,"EFS_STYPE_CODE")).trim()%>'
<%
	}
%>
	
	function formSubmit()
	{
		if(document.myForm.serviceTypeCode.value=='')
		{
			alert('Please enter Service Type Code')
			document.myForm.serviceTypeCode.focus()
			return
		}
		if(document.myForm.serviceTypeDesc.value=='')
		{
			alert('Please enter Service Type Desc')
			document.myForm.serviceTypeDesc.focus()
			return
		}
		stCode = document.myForm.serviceTypeCode.value;
		stCode = stCode.toUpperCase();
		stCode=funTrim(stCode);
		if(stCode!="")
		{
			for (var i=0;i<sTypeArray.length;i++)
			{
				if (stCode==sTypeArray[i].toUpperCase())
				{
					alert("Service Type Code already exists");
					document.myForm.serviceTypeCode.focus()
					return
				}
			}
		}		
		document.myForm.action="ezAddSaveServiceType.jsp"
		document.myForm.submit()
		
	
	}
</script>

</Head>
<Body  onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<br><br>

	<Div align=center>
	    <Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th colspan='2' width="100%">Add Service Type</Th>
		</Tr>
	    </Table>
	</Div>
	<Div align=center>
	    <Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

		<Tr>
			<Th width = "40%" align="right">Service Type Code*</Th>
			<Td width = "60%" ><input type = "text" class = "InputBox" name = "serviceTypeCode" size = "5" maxlength = "5"  ></Td>
		</Tr>	
		<Tr>
			<Th width = "40%" align="right">Service Type Desc*</Th>
			<Td width = "60%" ><input type = "text" class = "InputBox" name = "serviceTypeDesc" size = "20" maxlength = "30"  ></Td>
		</Tr>	

	    </Table>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<a href="JavaScript:formSubmit()"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</Div>
</Form>
</Body>
</Html>