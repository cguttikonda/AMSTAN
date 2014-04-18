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
	int sysSize=v1.size();
	if(sysSize==0)
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
<%

		if(sysKey!=null)
		{
			if("All".equals(sysKey))
			{
%>
				<option value="All" selected>All</option>
<%
			}
			else
			{
%>
				<option value="All" >All</option>
<%
			}
		}
		else
		{
%>
			<option value="All" >All</option>
<%
		}
%>
<%
		for(int i=0;i<sysSize;i++)
		{
			if((v1.elementAt(i)).equals(sysKey))
			{
%>
				<option value="<%=v1.elementAt(i)%>" selected><%=v3.elementAt(i)%> (<%=v1.elementAt(i)%>)</option>
<%
			}
			else
			{
%>
				<option value="<%=v1.elementAt(i)%>"><%=v3.elementAt(i)%> (<%=v1.elementAt(i)%>)</option>
<%
			}
		}
%>
		</select>
		</Td>
		<Th><nobr>Synch Key</nobr></Th>
		<Td width = "30%">
		<select name=masskey style = "width:100%" id = "FullListBox" onChange="showVals()">
		<option value="">--Select--</option>
<%
			if(sysKey!=null)
			{
				if("All".equals(massKey))
				{
			%>

				<option value="All" selected>All</option>
			<%	}
				else
				{
			%>
				<option value="All" >All</option>
			<%
				}
			}
				else
				{
			%>
				<option value="All" >All</option>
			<%
				}
			%>
<%
			int masSize=v2.size();

			for(int i=0;i<masSize;i++)
			{
				if((v2.elementAt(i)).equals(massKey))
				{
%>
					<option value="<%=v2.elementAt(i)%>" selected><%=v2.elementAt(i)%></option>
<%
				} else {
%>
					<option value="<%=v2.elementAt(i)%>"><%=v2.elementAt(i)%></option>
<%
				}
			}
%>
			</select>
		</Td>
	</Tr>
	</Table>

<%
	if(rs2 == null)
	{
%>
		<br><br><br>
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
	while(rs2.next())
	{
	String userId = rs2.getString("EMS_USERID");
	if(userId==null || userId.equals(""))
		userId = "";
	String soldTo = rs2.getString("EMS_SOLDTO");
	if(soldTo==null || soldTo.equals(""))
		soldTo = "";
	String value = rs2.getString("EMS_VALUE");
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
	try
	{

		rs2.close();
		con.close();
	}
	catch(Exception e){}
%>
	</Table>
	</div>

	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style="cursor:hand" onClick="javascript:history.go(-1)">
	</div>
</form>
</body>
</html>
