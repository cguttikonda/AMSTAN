<%@ include file="../../../Includes/JSPs/WorkFlow/iDeleteWorkGroups.jsp"%>
<html>
<head>
<Title></Title>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</head>
<Body onLoad="scrollInit();ezInitSorting()" onresize="scrollInit()" scroll=no >
<form name="myForm">
<%
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");
	String role = request.getParameter("role");
	String flag="";
	if(retObj!=null)
	{
		if(!retObj.isError())
		{
			response.sendRedirect("ezWorkGroupsList.jsp?role="+role);
		}
		else
		{
%>
		<br>
		<br>
	<Table  align=center cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Td align=center class=blankCell><font color=red><b>Unable to Delete Selected WorkGroups since they have Users</b></font></Td>
		</Tr>
		</Table>
		<br>
					<Div id="theads">
					<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
					<Tr>
					<Th width="50%">GroupId</Th>
					<Th width="50%">UserId</Th>
					</Table>
					</div>
					<DIV id="InnerBox1Div">

					<Table id="InnerBox1Tab" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
					for(int i=0;i<retObj.getRowCount();i++)
					{

%>
						<Tr>
							<Td width="50%"><%=retObj.getFieldValueString(i,"GROUP_ID")%></Td>
							<Td width="50%"><%=retObj.getFieldValueString(i,"USERID")%></Td>
						</Tr>


<%					}
%>
			</Table>
		</Div>
			<Div align=center id="BuutonDiv" style="position:absolute;top:92%;width:100%">
				<a href="ezWorkGroupsList.jsp?role=<%=role%>&searchcriteria=<%=mySearchCriteria%>" ><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
			</Div>
<%
		}
	}
	else
	{
		response.sendRedirect("ezWorkGroupsList.jsp?role="+role+"&searchcriteria="+mySearchCriteria);
	}
%>
</form>
</body>
</html>