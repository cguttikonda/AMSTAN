<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iOrganogramLevelsByLevel.jsp"%>
<html>
<head>
<Title>Organogram Levels</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src = "../../Library/JavaScript/WorkFlow/ezOrganogramLevelsByParticipant.js"></script>
<script src = "../../Library/JavaScript/ezTabScroll.js"></script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<br>
<form name=myForm method=post onSubmit="return goForSubmit(document.myForm)">
<%
	int rowCount = desiredUsersRet.getRowCount();
	int count=0;
	for(int i=0;i<rowCount;i++)
	{
		if(!desiredUsersRet.getFieldValueString(i,"STEP").startsWith("-"))	
		{
			count++;		
		}
	}
	if(rowCount==0 || count==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				No Sub-ordinates  for this Participant.
			</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  alt="Back" border=no onClick="JavaScript:history.go(-1)">
		</center>	
<%
	}
	else
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr align="center">
			<Td class="displayheader">Organogram Levels of "<%=participant%>"</Td>
			</Tr>
		</Table>
		<div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<Tr class=trClass>
			<Th class=thClass align=center width="5%">&nbsp;</Th>
			<Th class=thClass align=center width="95%">Participant</Th>
		</Tr>
		</Table>
		</Div>
		<div id="InnerBox1Div">		
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		
<%
		level = String.valueOf(Integer.parseInt(level)-1);
		int l=0;
		for(int i=0;i<rowCount;i++)
		{

%>
	

<%		if("1".equals(desiredUsersRet.getFieldValueString(i,"STEP")))
			{
%>		
		<Tr>

<%
				String participants = desiredUsersRet.getFieldValueString(i,"PARTICIPANTS");
				java.util.StringTokenizer stk1 = new java.util.StringTokenizer(participants,",");
				while(stk1.hasMoreElements())
				{
					participant = stk1.nextToken();
%>
					<label for="cb_<%=l%>">
					<Td class=tdClass align=left width="5%">
						<input type = "checkbox" name = "chk1" id="cb_<%=l%>" value = "<%=orgCode%>#<%=participant%>#<%=level%>#N">
					</td>
					<Td class=tdClass align=left width="95%">
<%
					if(!level.equals("1"))
					{
%>
						<a href = ezNextOrganogramLevelsByParticipant.jsp?participant=<%=participant%>&orgCode=<%=orgCode%>&level=<%=level%> ><%=participant%></a>
<%		
					}
					else
					{
%>
						<a href = ezWorkGroupUsersList.jsp?groups=<%=participant%>&myFlag=N ><%=participant%></a>
<%
					}
%>
					</Td>
				  	</label>
					</Tr>
<%
					l++;
				}
			}
		}
%>
		</Table>
		</Div>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditOrganogramsLevelsByParticipant.jsp')">		
			<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style = "cursor:hand" onClick = "JavaScript:history.go(-1)">
		</Div>
<%
	}
%>
</form>
</body>
</html>
