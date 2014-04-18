<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsList.jsp"%>
<%
	String formObj=request.getParameter("formObj");
	//String role=request.getParameter("role");
	int cnt=listRet.getRowCount();
	int groupCount=0;
	for(int i=0;i<cnt;i++)
	{
		if((listRet.getFieldValueString(i,"ROLE")).equals(role))
		{
			groupCount++;
		}
	}

%>
<html>
<head>
	<Title>EzCommerce Administration Module -- Powered By EzCommerce Global Solutions Inc.</Title>

	<meta name="author"  content="Venkat">
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script>
		function setUser()
		{
			var group="";
			var len=document.myForm.chk1.length;
			if(isNaN(len))
			{
				group=document.myForm.chk1.value
			}
			else
			{
				for(i=0;i<len;i++)
				{
					if(document.myForm.chk1[i].checked)
						group=document.myForm.chk1[i].value
				}
			}
			if("op"=="<%=formObj%>")
				opener.document.myForm.op.value=group
			else
			if("fyi"=="<%=formObj%>")
				opener.document.myForm.fyi.value=group

			window.close();
		}
	</script>
</head>
<body  onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post>


<%

	if(listRet.getRowCount()==0 || groupCount ==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
		     	<Td class = "labelcell">
        		<div align="center"><b>No Groups To List.</b></div>
    		</Td>
		</Tr>
		</Table><br>
		<Center>
			<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  alt="Click Here To Back" style="cursor:hand" border=no onClick="javascript:window.close()">
		</center>
<%
	}
	else
	{
%>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=90%>
		<Tr>
			<Td class="displayheader" align=center>Select Group</Td>
		</Tr>
		</Table>
		<Div id="theads">
		<Table id = "tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
		<Tr>

			<Th>&nbsp;</th><Th width="45%">Group</Th><Th width="45%">Description</Th>
		</Tr>
		</Table>
		</div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
<%
		//int cnt=listRet.getRowCount();
		for(int i=0;i<cnt;i++)
		{
			if((listRet.getFieldValueString(i,"ROLE")).equals(role))
			{

%>
			<Tr>
<%
				if(i==0)
				{
%>
					<Td ><input type=radio name=chk1 value="<%=listRet.getFieldValue(i,"GROUP_ID")%>" checked></Td>
<%
				}
				else
				{
%>
					<Td><input type=radio name=chk1 value="<%=listRet.getFieldValue(i,"GROUP_ID")%>"></Td>
<%
				}
%>
				<Td width="45%"><%=listRet.getFieldValue(i,"GROUP_ID")%></Td>
				<Td width="45%"><%=listRet.getFieldValue(i,"DESCRIPTION")%></Td>
			</Tr>
<%
			}
		}
%>
		</Table>
		</div>

		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
		<img src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Add" style="cursor:hand" border=no onClick="javascript:setUser()">
		<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none onClick="javascript:window.close()"></a>
		</div>
<%
	}
%>
</form>
</body>
</html>
