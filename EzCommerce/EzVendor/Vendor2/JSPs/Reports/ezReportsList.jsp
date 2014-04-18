<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iReportsList.jsp"%>
<html>
<head>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/Reports/ezReportsList.js">
</script>
<Title>Reports List</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form name=myForm method=post action="">
<br>
<%
	if(numSystem > 0)
		{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
    	<Tr>
      	<Th width="46%" class="labelcell">System:</Th>
      	<Td width="54%"  >
<%
	int sysRows = retsys.getRowCount();
	String sysName = null;
	if ( sysRows > 0 ) 
		{
%>
		<div id = listBoxDiv0>
	        <select name="SysNum" >
	    	<option value="sel" >--Select System--</option>
<%
		for ( int i = 0 ; i < sysRows ; i++ )
			{
			if(((retsys.getFieldValue(i,"ESD_SYS_TYPE").toString())).equals("100") || ((retsys.getFieldValue(i,"ESD_SYS_TYPE").toString())).equals("110") || ((retsys.getFieldValue(i,"ESD_SYS_TYPE").toString())).equals("111"))
				{
				String val = (retsys.getFieldValue(i,SYSTEM_NO)).toString();
				sysName = (String)retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION);
				if(sys_num!=null && !"sel".equals(sys_num))
					{
					if(sys_num.equals(val.trim()))
						{
%>
						<option selected value=<%=val%> >
						<%=val%>(<%=sysName%>)
		    				</option>
<%
						}
					else
						{
%>
		    				<option value=<%=val%> >
						<%=val%>(<%=sysName%>)
		    				</option>
<%
						}//End If
					}
				else
					{
%>
		    			<option value=<%=val%> >
					<%=val%>(<%=sysName%>)
		    			</option>
<%
					}
				}
			}
%>
			</select>
			</div>
<%
			}
%>
      		</Td>
      		<Td width="10%" align="center">
		<img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" style="cursor:hand" onClick="myalert()">
		</Td>
    		</Tr>
  	</Table>
<%
	if(sys_num!=null && !"sel".equals(sys_num))
		{
%>
<%
		int repRows;
		if (retrep != null) 
			{
		 	repRows = retrep.getRowCount();
			}
		else 
			{
			repRows = 0; 
			}
		String repName = null;
		String repDescription = null;
		if ( repRows < 1 ) 
			{
%>
		<br><br><br><br>
  		<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		    	<Tr align="center">
		      	<Th >No Reports to List</Th>
		    	</Tr>
		</Table>		    	
			<br>
			<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

			</center>		
<%
			}
		else 
			{
%>
	  		<br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr align="center">
			    	<Td class="displayheader">List Of Reports</Td>
			  	</Tr>
			</Table>  		
			<Div id="theads">
			<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		    	<Tr align="left">
		      	<Th width="45%" align = "center">Report Name</Th>
		      	<Th width="55%" align = "center">Report Description</Th>
		    	</Tr>
			</Table>
			</Div>
			<DIV id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">

<%
			for ( int i = 0 ; i < repRows; i++ )
				{
%>
		    	<Tr align="left">
		      	<Td width="45%">
<%
			repName = (String)(retrep.getFieldValue(i,REP_NAME));
%>
			<a href="ezPreExecuteReport.jsp?SysNum=<%=sys_num%>&RepName=<%=repName%>&SysName=<%=sysName%>" >
<%
			if (repName != null)
				{
%>
				<%=repName%>
<%
				}
%>
			<input type="hidden" name="RepName_<%=i%>" value=<%=(retrep.getFieldValue(i,REP_NAME))%> >
			</a>
			</Td>	
      			<Td width="55%" >
<%
			repDescription = (String)retrep.getFieldValue(i,REP_DESC);
			if (repDescription != null)
				out.println(repDescription);
%>
			</Td>
    			</Tr>
<%
			}//End for
%>
			<input type="hidden" name="TotalCount" value=<%=repRows%> >
<%
		}//End If
%>
</Table>
</div>

<br>
<Div id="ButtonDiv" align = "center" style="position:absolute;top:85%;width:100%;visibility:hidden">
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</div>
</form>
<%
	}
else
	{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Th>
		Please Select System and press Show to continue.
	</Th>
	</Tr>
</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
	}
}
else
	{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Th>
		There are No Systems.
	</Th>
	</Tr>
</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
}//end if Systems >0
%>
</body>
</html>