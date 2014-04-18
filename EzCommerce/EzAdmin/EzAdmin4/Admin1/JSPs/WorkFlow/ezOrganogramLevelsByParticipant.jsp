<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iListOrganograms.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iOrganogramLevelsByParticipant.jsp"%>
<html>
<head>
<Title>Pre Organogram Levels</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src = "../../Library/JavaScript/WorkFlow/ezOrganogramLevelsByParticipant.js"></script>
<script src = "../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad="scrollInit();funFocus()" onresize="scrollInit()" scroll=no>
<br>
<form name=myForm method=post action="">
<%
	int orgCount = listRet.getRowCount();
	if(orgCount==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				No Organograms To List.
			</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="ezAddOrganogram.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no > </a><!--onClick="funOpt(1,'ezAddOrganogramLevels.jsp')"-->
		</center>
<%
	}
	else
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr align="center">
			<Td class="displayheader">Organogram Levels By Participant</Td>
			</Tr>
		</Table>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
			<Th align = "right">
				Organogram
			</Th>
			<Td width = "60%">
			<select name = "orgCode" style = "width:100%" id = "FullListBox" onChange = "funSelect()">
				<option value = "">--Select Organogram--</option>
<%
			listRet.sort(new String[]{"DESCRIPTION1"},true);
			for(int i=0;i<orgCount;i++)
			{
				if(orgCode!=null && orgCode.equals(listRet.getFieldValueString(i,"CODE")))
				{
%>	
					<option value = "<%=listRet.getFieldValue(i,"CODE")%>" selected>
						<%=listRet.getFieldValueString(i,"DESCRIPTION1")%>
					</option>
<%
				}
				else
				{
%>
					<option value = "<%=listRet.getFieldValue(i,"CODE")%>">
						<%=listRet.getFieldValueString(i,"DESCRIPTION1")%>
					</option>
<%
				}
			}
%>
			</select>
    			</Td>
    			</Tr>
		</Table>
<%
		if(orgCode!=null)
		{
			int levelCount = levelRet.getRowCount();
			if(levelCount>0)
			{
%>
					<div id="theads">
					<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
					<Tr class=trClass>
						<Th class=thClass align=center width="5%">Participant</Th>
					</Tr>
					</Table>
					</Div>
					<div id="InnerBox1Div">		
					<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
					for(int i=0;i<levelCount;i++)
					{
						String parent = levelRet.getFieldValueString(i,"PARENT");
						if(parent.equals("") || parent.equals("null") || "null".equals(parent))
						{
%>
							<Td class=tdClass align=left width="25%"><a href = ezNextOrganogramLevelsByParticipant.jsp?participant=<%=levelRet.getFieldValue(i,"PARTICIPANT")%>&orgCode=<%=orgCode%>&level=<%=levelRet.getFieldValue(i,"ORGLEVEL")%> ><%=levelRet.getFieldValue(i,"PARTICIPANT")%></a>
							</Td>
							</Tr>
<%
						}
					}
%>
					</Table>
					</Div>
					<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
						<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style = "cursor:hand" onClick = "JavaScript:history.go(-1)">
					</Div>
<%
			}
			else
			{
%>
				<br>
				<br>
				<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
				<Tr>
					<Th width="100%" align=center>
						No Organogram Levels to list.
					</Th>
				</Tr>
				</Table>
				<br>
				<center>
					<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				</center>
<%
			}
		}
		else
		{
%>
				<br>
				<br>
				<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
				<Tr>
					<Th width="100%" align=center>
						Select Organogram to Continue.
					</Th>
				</Tr>
				</Table>
				<br>
				<center>
					<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				</center>			
<%
		}
	}
%>
</form>
</body>
</html>
