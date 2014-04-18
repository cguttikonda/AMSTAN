<%@ include file="../../Library/Globals/CacheControl.jsp"%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListConnections.jsp"%>

<html>
<head>
<script src="../../Library/JavaScript/ezTabScroll.js" >
</script>

<script src="../../Library/JavaScript/Config/ezListConnections.js" >
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<BODY onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post>

<br>
<%
int sysRows = ret.getRowCount();
if ( sysRows > 0 )
	{
%>
<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
	<Td class="displayheader">ERP Connections</Td>
	</Tr>
</Table>
</div>
<div id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Td >
	
	<Table  width="75%" border="0" cellpadding="0" cellspacing="0">
	<Tr>
	<Td width="4%" height="2">
	<div align="center">
		<img src="../../Images/newimages/greenball.gif" width="12" height="12"></div>
	</Td>
	<Td width="51%" height="2">Active Connection</Td>
	<Td width="4%" height="2">
	<div align="center"><b><img src="../../Images/newimages/redball.gif" width="12" height="12"></div>
	</Td>
	<Td width="41%" height="2">Inactive Connection</Td>
	</Tr>
	</Table>        

	</Td>
	</Tr>
	<Tr>
	<Td class="blankcell">
	<Table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="left">
	<Th width="17%">
	<div align="center"> Group ID </div>
	</Th>
	<Th width="72%">
	<div align="center">Group Name </div>
	</Th>
	<Th width="11%">
	<div align="center">Click</div>
	</Th>
	</Tr>
<%
	String grpDescription = "";
	for ( int i = 0 ; i < sysRows; i++ )
	{
		String[] sortArr = {"EUG_ID"};
		ret.sort(sortArr,true);
		String grpnumber = null;
%>
		<Tr align="left">
		<Td >
<%
		grpDescription = ret.getFieldValueString(i,CONNECTION_DETAILS);
 		grpnumber = ret.getFieldValue(i,GROUP_TYPE)+"";
 		
 		if("999".equals(grpnumber))
 			grpDescription = "Y";
 			
		if(grpDescription.equals("Y"))
		{
%>
			<B><%=grpnumber%></B>
<%
	         }
		 else
		 {
%>
			<%=grpnumber%>
<%
}
%>
		</Td>
		<Td >
<%
		String grDesc = ret.getFieldValueString(i,"EUG_NAME");
		if(grpDescription.equals("Y"))
		{
%>
			<B><%=grDesc%></B>
<%
		}
		else
		{
%>
			<%=grDesc%>
<%
		}
%>
		</Td>
		<Td height="20" width="11%">
		<div align="center">
	
<%
        	if(grpDescription.equals("Y"))
		{
			String paramString = "Y"+grpnumber.trim();
			paramString = "1"+grpnumber;
%>
			<img src="../../Images/newimages/greenball.gif" style = "cursor:hand" onClick="setConnections(<%=paramString.toString()%>)" >
<%
		}
		else
		{
			String paramString = "N"+grpnumber.trim();
			paramString = "2"+grpnumber;
			String Site=(String)session.getValue("Site");
			
			ezc.sapconnection.EzSAPHandler.removeSAPConnectionPool(Site+"~999");
%>
			<img src="../../Images/newimages/redball.gif" style = "cursor:hand" onClick="setConnections(<%=paramString.toString()%>)" >
<%
		}
		//out.println("Site"+(String)session.getValue("Site"));
%>
                </div>
		</Td>
		</Tr>

<%
		}//End for
%>
		<p>
			<input type="hidden" name="changeConnectionFlag" value="T">
        	</p>
        	</Table>

      		</Td>
    		</Tr>

  		</Table>
</div>
  	<div id="ButtonDiv" style="position:absolute;top:90%;width:100%">
		<center>
  			<a href="javascript:funAdd()"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>
  			<a href="javascript:funUpdate()"><img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif" border=none></a>
  			 <a href="javascript:funDelete()"><img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" border=none></a>
 	  	<!-- a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a -->

  	  	</center>
</div>
<%
	}//End If
	else
		{
%>		<br><br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			<Th >
			No ERP Connections Exist.
			</Th>
			</Tr>
		</Table>
		<br>
		<center>
			<img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" style="cursor:hand" onClick = "funAdd()">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>

<%
		}
%>
</form>
<%
String savedY = request.getParameter("saved");
String GName = request.getParameter("GName");
if ( savedY != null && savedY.equals("Y") )
{
%>
	<script language="Javascript">
		alert('Connection Group: <%=GName%> created successfully');
	</script>
<%
}
%>
</body>
</html>
