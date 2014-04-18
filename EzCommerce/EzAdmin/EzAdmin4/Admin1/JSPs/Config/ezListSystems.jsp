<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListSystems.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Config/ezListSystems.js">
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/ezSortTableData.js"></script>
</head>
<BODY onLoad="scrollInit()" onResize = "scrollInit()" scroll="no">
<form name=myForm method=post>
<%
int sysRows = ret.getRowCount();
if ( sysRows > 0 ) 
{
%>
	<br>
	<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" ellPadding=2 cellSpacing=0  width="89%">
  	<Tr align="center">
    		<Td class="displayheader">List of Systems</Td>
  	</Tr>
	</Table>
	<div id="theads" >
	<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
  	<Tr align="left">
    		<Th width="19%" align='center'> System </Th>
    		<Th width="44%" align='center'> Description </Th>
    		<Th width="37%" align='center'> System Type </Th>
  	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div">
	<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%	
	for ( int i = 0 ; i < sysRows; i++ )
	{		
%>
  	<Tr align="left">
    		<Td width="19%">
<%
			String sysDescription = (String)ret.getFieldValue(i,SYSTEM_NO_DESCRIPTION);
%>
			<%=ret.getFieldValue(i,SYSTEM_NO)%>
    		</Td>
	    	<Td width="44%">
<%
			if ( sysDescription == null)
			{
				sysDescription="";
			}
%>
		     	<%=sysDescription%>&nbsp;
    		</Td>
    		<Td width="37%">
			<%=ret.getFieldValue(i,SYSTEM_TYPE_DESC)%>
    		</Td>
  	</Tr>
<%
	}//End for
%>
	</Table>
	</div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
    		<a href="javascript:funAdd()"> <img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none ></a>
      		<a href="javascript:funEdit()"> <img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif"   border=none></a>
	</div>
<%
	String savedY = request.getParameter("saved");
	String skey = request.getParameter("skey");
	if ( savedY != null && savedY.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('System <%=skey%> created successfully');
		</script>
<%
	}
	if ( savedY != null && savedY.equals("N") )
	{
%>
		<script language="JavaScript">
			alert('Problems Creating System <%=skey%>! Please Check');
		</script>
<%
	}
}//End If
else
{
%>
	<br><br><br><br><br>
	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	 <Tr align="center">
    		<Th>There are No Systems Created Currently.Click on Add to Add System.</Th>
  	</Tr>
	</Table>
	<br>
	<center>
	    	<a href="javascript:funAdd()"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none ></a>
	</center>
<% 
}
%>
</form>
</body>
</html>