<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/Freight/iAddServiceType.jsp"%>
<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=50
	var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script>
	function funAdd()
	{
		document.myForm.action="ezAddServiceType.jsp";
		document.myForm.submit();
	}
	function funDelete()
	{
		var len = document.myForm.stId.length;
		var cnt = 0;
		var chkSt = "";

		if(isNaN(len))
		{
			if(document.myForm.stId.checked)
			{
				chkSt = document.myForm.stId.value;
				cnt++;
			}
		}
		else
		{	
			for(i=0;i<len;i++)
			{	
				if(document.myForm.stId[i].checked)
				{
					chkSt = document.myForm.stId[i].value;
					cnt++;
					break;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please Select a Service Type to Delete");
			return
		}
		else
		{
			var y = confirm("Are you sure to Delete?");
			
			if(eval(y))
			{
				document.myForm.action="ezDelServiceType.jsp?chkSt="+chkSt;
				document.myForm.submit();
			}
		}
	}	
	
</Script>
</Head>
<Body  onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<br><br><br>

	<Div align=center>
<%
	if(stCnt>0)
	{
%>
	<div id="theads">
	<Table width="50%" id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
		<Th align="center" valign="middle" width="5%">&nbsp;</Th>
		<Th align="center" valign="middle" width="35%">Code</Th>
		<Th align="center" valign="middle" width="60%">Description</Th>
	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div" style="overflow:auto;position:absolute;width:50%;height:50%">
	<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
		for(int i=0;i<stCnt;i++)
		{
			String stId 	= stRet.getFieldValueString(i,"EFS_STYPE_CODE");
			String desc 	= stRet.getFieldValueString(i,"EFS_STYPE_DESC");
			
%>
		<Tr>
			<Td align="center" valign="top" width="5%"><input type="radio" name="stId" value="<%=stId%>"></Td>
			<Td align="left" valign="top" width="35%"><%=stId%></Td>
			<Td align="left" valign="top" width="60%"><%=desc%></Td>
		</Tr>
<%
		}
%>
	</Table>
	</div>
<%
	}
	else
	{
%>
	<br><br><br><br>
	<Table   width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>No data present. Click on Add to create.</Th>
	</Tr>
	</Table>
<%
	}
%>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<a href="JavaScript:funAdd()"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" border=none></a>
		<a href="JavaScript:funDelete()"><img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif" border=none></a>
	</Div>
</Form>
</Body>
</Html>