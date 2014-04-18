<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@  include  file= "../../../Includes/JSPs/User/iMassSynch.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script>
function showVals()
{
	if(document.myForm.syskey.selectedIndex!=0 && document.myForm.masskey.selectedIndex!=0)
	{
		document.myForm.action="ezMassSynch.jsp"
		document.myForm.submit()
	}
}
</script>
</head>
<body onLoad='scrollInit()' onresize='scrollInit()' scroll="no">
<form name=myForm method=post >
<input type = "hidden" name = "Area" value = "<%=areaFlag%>">
<%
	int areaCount = massSynchAreas.getRowCount();
	if(areaCount==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  width="80%">
		<Tr align="center">
			<Th>There are no <%=bussArea%>s to List</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
	<br>
	<Table  border=1 align = center width=89%  borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<Tr>
		<Th><nobr><%=bussArea%></nobr></Th>
		<Td width = "50%">
		<select name=syskey style = "width:100%" id = "FullListBox" onChange="showVals()">
		<option value="">--Select <%=bussArea%>--</option>
	 	<option value="All">All</option>
<%
		StringBuffer all=new StringBuffer("");
		//massSynchKeys.sort(new String[]{SYSKEYDESC},true);

		for(int i=0;i<massSynchAreas.getRowCount();i++)
		{
			if(i==0)
			{
				all.append(massSynchAreas.getFieldValueString(i,"SYSKEY"));
			}
			else
			{
				all.append(",");
				all.append(massSynchAreas.getFieldValue(i,"SYSKEY"));
			}

			if(massSynchAreas.getFieldValueString(i,"SYSKEY").equals(sysKey))
			{
%>
			<option selected value="<%=massSynchAreas.getFieldValueString(i,"SYSKEY")%>"><%=massSynchAreas.getFieldValueString(i,"SYSKEYDESC")%> (<%=massSynchAreas.getFieldValueString(i,"SYSKEY")%>)</option>
<%
			}
			else
			{
%>
			<option value="<%=massSynchAreas.getFieldValueString(i,"SYSKEY")%>"><%=massSynchAreas.getFieldValueString(i,"SYSKEYDESC")%> (<%=massSynchAreas.getFieldValueString(i,"SYSKEY")%>)</option>
<%
			}

		}
%>


		</select>
		<script>
			document.myForm.syskey.options[1].value="<%=all.toString()%>"
		</script>

		</Td>
		<Th><nobr>Synch Key</nobr></Th>
		<Td width = "30%">
		<select name=masskey style = "width:100%" id = "FullListBox" onChange="showVals()">
		<option value="">--Select --</option>

<%

		StringBuffer allNew=new StringBuffer("");
		//massSynchKeys.sort(new String[]{"SYSKEYDESC"},true);

		for(int i=0;i<massSynchKeys.getRowCount();i++)
		{
			if(i==0)
			{
				allNew.append(massSynchKeys.getFieldValueString(i,"MASSKEY"));
			}
			else
			{
				allNew.append(",");
				allNew.append(massSynchKeys.getFieldValue(i,"MASSKEY"));
			}

			if(massSynchKeys.getFieldValueString(i,"MASSKEY").equals(request.getParameter("masskey")))
			{
%>
			<option selected value="<%=massSynchKeys.getFieldValueString(i,"MASSKEY")%>"><%=massSynchKeys.getFieldValueString(i,"MASSKEY")%> (<%=massSynchKeys.getFieldValueString(i,"MASSKEY")%>)</option>
<%
			}
			else
			{
%>
			<option value="<%=massSynchKeys.getFieldValueString(i,"MASSKEY")%>"><%=massSynchKeys.getFieldValueString(i,"MASSKEY")%> (<%=massSynchKeys.getFieldValueString(i,"MASSKEY")%>)</option>
<%
			}

		}
%>
		</select>
		</Td>
		<script>
			document.myForm.masskey.options[1].value="<%=allNew.toString()%>"
		</script>

	</Tr>
	</Table>

<%
	if(sysKey == null)
	{
%>
		<br><br><br><br>
		<Table  border=1 align = center width=89%  borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<tr>
			<td class = "labelcell" align = "center">
				Please Select <%=bussArea%> and Synch Key.
			</td>
			</tr>
		</Table>
		<br>
		<center>
			<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style="cursor:hand" onClick="javascript:history.go(-1)">
		</center>
<%
		return;
	}
%>
<%
	int synchDetailsCount=massSynchDetails.getRowCount();
	if(synchDetailsCount == 0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align = center width=89%  borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<tr>
			<td class = "labelcell" align = "center">
				There are no Users to List in selected <%=bussArea%> and Synch Key.
			</td>
			</tr>
		</Table>
		<br>
		<center>
			<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style="cursor:hand" onClick="javascript:history.go(-1)">
		</center>
<%
		return;
	}
%>
	<Table border=1 align = center borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width = "89%">
	<Tr>
		<Td class = "displayHeader" align = "center">View Mass Synchronization</Td>
	</Tr>
	</table>
	<div id="theads">
	<Table id="tabHead" border=1 align = center borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<Tr>
		<Th width = "33%">User Id</Th>
		<Th width = "33%">Sold To</Th>
		<Th width = "33%">Value</Th>
	</Tr>
	</table>
	</div>

	<DIV id="InnerBox1Div">
    	<Table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
	for(int i=0;i<synchDetailsCount;i++)
	{
		String userId = massSynchDetails.getFieldValueString(i,"USERID");
		if(userId==null || ("null").equals(userId))
			userId = "";
		String soldTo = massSynchDetails.getFieldValueString(i,"SOLDTO");
		if(soldTo==null || soldTo.equals(""))
			soldTo = "";
		String value = massSynchDetails.getFieldValueString(i,"VALUE");
		if(value==null || value.equals(""))
			value = "";
%>
		<Tr>
			<Td width = "33%"><%=userId%>&nbsp;</Td>
			<Td width = "33%"><%=soldTo%>&nbsp;</Td>
			<Td width = "33%"><%=value%>&nbsp;</Td>
		</Tr>
<%
	}
%>
	</Table>
	</div>

	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style="cursor:hand" onClick="javascript:history.go(-1)">
	</div>
</form>
</body>
</html>