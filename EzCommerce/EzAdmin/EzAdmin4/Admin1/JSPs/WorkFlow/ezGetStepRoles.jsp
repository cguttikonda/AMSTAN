<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetStepRoles.jsp"%>

<html>
<head>
	<Title>EzCommerce.....The Next Generatio eBusiness Solutions </Title>
	<meta name="author"  content="Venkat">

	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
	<script>
		function setUser()
		{
			var user="";
			var len=document.myForm.chk1.length;
			if(isNaN(len))
			{
				user=document.myForm.chk1.value
			}
			else
			{
				for(i=0;i<len;i++)
				{
					if(document.myForm.chk1[i].checked)
						user=document.myForm.chk1[i].value
				}
			}
			if("op"=="<%=formObj%>")
				opener.document.myForm.op.value=user
			else
			if("fyi"=="<%=formObj%>")
				opener.document.myForm.fyi.value=user

			window.close();
		}
		function resubThis()
		{
			document.myForm.submit()
			document.myForm.action="ezGetStepRoles.jsp"
		}
	</script>
</head>
<body  onLoad="scrollInit();ezInitSorting();" onResize="scrollInit()" >
<form name=myForm method=post>



		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
		<Tr>
			<Td class=labelcell>Role</Td>
			<Td>
				<select name=roles>
					<option value="All">All</option>
<%
				for(int i=0;i<rolesCount;i++)
				{
				    if("N".equals(rolesRet.getFieldValueString(i,"DELETE_FLAG")))
		    		    {
		    		    	if(selRole.equals("'"+rolesRet.getFieldValueString(i,"ROLE_NR")+"'"))
		    		    	{
%>
						<option value="<%=rolesRet.getFieldValue(i,"ROLE_NR")%>" selected><%=rolesRet.getFieldValue(i,"DESCRIPTION")%></option>
<%
					} else {
%>
						<option value="<%=rolesRet.getFieldValue(i,"ROLE_NR")%>"><%=rolesRet.getFieldValue(i,"DESCRIPTION")%></option>
<%
					}
				    }
				}
%>
				</select>
			</Td>
			<Td class=labelcell>Business Area</Td>
			<Td>
				<select name=sysKey>
					<option value="All">All</option>
<%

				for(int i=0;i<sysCount;i++)
				{
				    if(selSysKey.equals("'"+sysRet.getFieldValueString(i,SYSTEM_KEY)+"'"))
				    {
%>
					<option value="<%=sysRet.getFieldValue(i,SYSTEM_KEY)%>" selected><%=sysRet.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%></option>
<%
				    } else {
%>
					<option value="<%=sysRet.getFieldValue(i,SYSTEM_KEY)%>"><%=sysRet.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%></option>
<%
				    }
				}
%>
				</select>
			</Td>
			<Td>
				<img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" style="cursor:hand" onClick="resubThis()">
			</Td>
		</Tr>
		</Table><br>
<%
	if(usersRet.getRowCount()==0)
	{
%>
		<br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
		     	<Td class = "labelcell">
        		<div align="center"><b>No Users To List in Selected Criteria.</b></div>
    		</Td>
		</Tr>
		</Table><br>
		<center>
		<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  alt="Click Here To Back" style="cursor:hand" border=no onClick="javascript:window.close()">
		</center>
<%
	}
	else
	{
%>
		<Div id="theads">
		<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=90%>
		<Tr>
			<Th>&nbsp;</Th><Th width="45%">User Id</Th><Th width="45%">User Name</Th>
		</Tr>
		</Table>
		</div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
<%
		int cnt=usersRet.getRowCount();
		String userName=null;
		for(int i=0;i<cnt;i++)
		{
			userName=usersRet.getFieldValueString(i,USER_FIRST_NAME);
			if(usersRet.getFieldValue(i,USER_MIDDLE_INIT) != null)
				userName += " "+usersRet.getFieldValueString(i,USER_MIDDLE_INIT);
			userName +=" "+	usersRet.getFieldValueString(i,USER_LAST_NAME);
%>
			<Tr>
<%
			if(i==0)
			{
%>
				<Td><input type=radio name=chk1 value="<%=usersRet.getFieldValue(i,USER_ID)%>" checked></Td>
<%
			} else {
%>
				<Td><input type=radio name=chk1 value="<%=usersRet.getFieldValue(i,USER_ID)%>"></Td>
<%
			}
%>
				<Td width="45%"><%=usersRet.getFieldValue(i,USER_ID)%></Td>
				<Td width="45%"><%= userName %></Td>
			</Tr>
<%
		}
%>
		</Table>
		</div>

		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
		<img src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Add" style="cursor:hand" border=no onClick="javascript:setUser()">
		<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  alt="Click Here To Back" style="cursor:hand" border=no onClick="javascript:window.close()">
		</div>
<%
	}
%>
</form>
</body>
</html>
