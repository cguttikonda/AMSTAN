<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/MailGroups/iListMailGroups.jsp" %>

<html>
<head>
	    <%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	    <script src="../../Library/JavaScript/MailGroups/ezListMailGroups.js"></script>    
	    <script src="../../Library/JavaScript/chkEditAndDelete.js"></script>
    
	    <Script src="../../Library/JavaScript/ezTabScroll.js"></script>
	    <script>
		function init()
	 	{
<%

	 		if (mailGroupObj.getRowCount() > 0)
	 		{
%>
				myInit(2)
					if(getposition())
					{
						ScrollBox.show()
					}
<%
			}
%>
}
	  </script>
</head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll="no">
<br>
<form name=myForm method=post onSubmit="return checkField()">

<%
	if(mailGroupObj.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Mail Groups To List.
			</Th>
		</Tr>
		</Table><br><center>
		<a href="javascript:addGroup()"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none ></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>

<%
	}
	else
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr>
				      <Td class="displayheader">
				       <div align="center">List Of Mail Groups</div>
				     </Td>
			</Tr>
		</Table>
		<div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
				<Tr>
					<Th width="4%">&nbsp;</Th>
					<Th width="15%">GroupId</Th>
					<Th width="25%">Description</Th>
					<Th width="20%">Host</Th>
					<Th width="20%">From</Th>
					<Th width="16%">Type</Th>

				</Tr>
			</Table>
		</div>
		
			<DIV id="InnerBox1Div">
				<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
	for(int i=0;i<mailGroupObj.getRowCount();i++)
	{
%>
				<Tr>
					<label for="cb_<%=i%>">
					<Td width="4%"><input type=checkbox name=chk1  id="cb_<%=i%>"
 value='<%=mailGroupObj.getFieldValueString(i,"GROUPID")%>'></Td>
					<Td width="15%"><a style="text-decoration:none" href="ezMailGroupDetails.jsp?chk1=<%=mailGroupObj.getFieldValueString(i,"GROUPID")%>"><%=mailGroupObj.getFieldValueString(i,"GROUPID")%></a></Td>
					<Td width="25%" title="<%=mailGroupObj.getFieldValueString(i,"GROUPDESC")%>"><input type=text class=DisplayBox value="<%=mailGroupObj.getFieldValueString(i,"GROUPDESC")%>" readonly size=25></Td>
					<Td width="20%" title="<%=mailGroupObj.getFieldValueString(i,"HOST")%>"><input type=text class=DisplayBox value="<%=mailGroupObj.getFieldValueString(i,"HOST")%>" readonly size=20></Td>
					<Td width="20%" title="<%=mailGroupObj.getFieldValueString(i,"FROM1")%>"><input type=text class=DisplayBox value="<%=mailGroupObj.getFieldValueString(i,"FROM1")%>" readonly size=20></Td>
					<Td width="16%">
<%			
		if("Y".equals(mailGroupObj.getFieldValueString(i,"JMSENABLED")))			
		{
%>
                           Asynchronous
<%
 		}
 		else
 		{
%>
                           Synchronous
<%
                }
%>                                   
			
					</Td>
				</label>
				</Tr>
<%
	}
%>
				</Table>
			</Div>
				<div id=ButtonDiv align="center" style="position:absolute;top:90%;width:100%">
					<a href="javascript:addGroup()"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none ></a>
					<input type=image src="../../Images/Buttons/<%= ButtonDir%>/edit.gif" border=none onClick="setOpt(1)">
					<input type=image src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" border=none onClick="setOpt(2)">
					<!-- a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a -->
	
				</div>

<%
	}
%>
</form>
</body>
</html>
