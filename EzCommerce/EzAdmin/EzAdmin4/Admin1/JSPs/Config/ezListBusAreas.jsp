
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Config/ezListBusAreas.js"></script>

<script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad='scrollInit();' onresize='scrollInit()' scroll="no">
<form name="myForm" method=post action="">
<br>
 <%
int sysRows = ret.getRowCount();
if ( sysRows > 0 )
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
  <Tr align="center">
    <Td class="displayheader" nowrap>List of <%=areaLabel%></Td>
  </Tr>
</Table>
<div id="theads">
<Table  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
  <Tr>
    <Th width="33%" ><nobr>System</nobr></Th>
    <Th width="15%" ><nobr><%=areaLabel.substring(0,areaLabel.length()-1)%></nobr></Th>
    <Th width="40%" ><nobr>Description</nobr></Th>
    <Th width="12%" ><nobr>Synchronize</nobr></Th>
  </Tr>
 </Table>
 </div>
<div id="InnerBox1Div">

<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

<%
	for ( int i = 0 ; i < sysRows; i++ )
	{
		String systemDesc = "";
		int systemCount = retSystems.getRowCount();
		for(int j=0;j<systemCount;j++)
		{
			if(ret.getFieldValueString(i,SYSTEM_NUMBER).equals(retSystems.getFieldValueString(j,SYS_KEY)))
				systemDesc = retSystems.getFieldValueString(j,SYSTEM_DESC);
		}
%>
  		<Tr>
  		<Td align="left" width="33%">
			<%=ret.getFieldValue(i,SYSTEM_NUMBER)%>&nbsp;(<%=systemDesc%>)
		</Td>
		<Td align="left" width="15%">
<%
			String sysDescription = (String)ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION);
%>
				<%=ret.getFieldValue(i,SYSTEM_KEY)%>
		</Td>
<%
			if ( sysDescription == null)
			{
				sysDescription="";
			}
%>
		<Td align="left"  width="40%" title="<%=sysDescription%>">
			<a href = "ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=ret.getFieldValue(i,SYSTEM_KEY)%>">
				<input type=text class=DisplayBox value="<%=sysDescription%>" size=40 readonly Style = "Cursor:hand;text-decoration:underline">
			</a>
		</Td>
<%
		String syncFlag = "Yes";
		if(ret.getFieldValue(i,"ESKD_SYNC_FLAG").equals("N"))
			syncFlag = "No";
%>
		<Td align="left"width="12%">
			<%=syncFlag%>
		</Td>
		</Tr>
<%
	}//End for

%>

</Table>
</div>

<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<a href="javascript:funAdd('<%=areaFlag%>')"> <img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none></a>
      <a href="javascript:funEdit('<%=areaFlag%>')"> <img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif"   border=none></a>
</div>


<%
}//End If
else
{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Th>There are no <%=areaLabel%> to List</Th>
  </Tr>
</Table>
<br>
<center>
	<a href="javascript:funAdd('<%=areaFlag%>')"> <img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none></a>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<% 
}
%>
</form>
</body>
</html>
