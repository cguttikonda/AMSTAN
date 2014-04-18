<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iListOrganograms.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
	<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
</head>
<Body onLoad="scrollInit()" onresize="scrollInit()" scroll="no" >
<Br>
<Form name=myForm method="post" onSubmit="return goForSubmit(document.myForm)">
<%
	if(listRet.getRowCount()==0)
	{
%>
	<br><br><br><br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="100%" align=center>
			No Organograms To List
		</Th>
	</Tr>
	</Table>
	<br>
	<center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddOrganogram.jsp')">
	</center>

<%
	}	else
		{
%>
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr class=trClass>
				<Td align=center class=displayheader>Organograms List</Td>
			</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<Tr class=trClass>
				<Th class=thClass align=center width="5%">&nbsp;</Th>
				<Th class=thClass align=center width="10%">Code</Th>
				<Th class=thClass align=center width="30%">Description</Th>
				<Th class=thClass align=center width="25%">Business Area</Th>
				<Th class=thClass align=center width="25%">Template</Th>			
			</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
		int orgCount = listRet.getRowCount(); 
			for(int i=0;i<orgCount;i++)
			{
%>
				<Tr class=trClass>
				<label for="cb_<%=i%>">
					<Td class=tdClass align=center width="5%">
						<input type=checkbox name=chk1 id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"CODE")%>,<%=listRet.getFieldValue(i,"TEMPLATE")%>,<%=listRet.getFieldValue(i,"DESCRIPTION1")%>">
					</Td>
					<Td class=tdClass align=left width="10%">
					<%=listRet.getFieldValue(i,"CODE")%>
					</Td>
					<Td class=tdClass align=left width="30%"><%=listRet.getFieldValue(i,"DESCRIPTION1")%>&nbsp;</a>
					</Td>
					<Td class=tdClass align=left width="25%" title = "<%=listRet.getFieldValue(i,"SYSTEM_DESC")%> (<%=listRet.getFieldValue(i,"SYSKEY")%>)">
					<input type = "text" class= "DisplayBox" value = "<%=listRet.getFieldValue(i,"SYSTEM_DESC")%> (<%=listRet.getFieldValue(i,"SYSKEY")%>)" readonly size = "30">
					</Td>
					<Td class=tdClass align=left width="25%"><%=listRet.getFieldValue(i,"TEMP_DESC")%>&nbsp;</Td>

				</label>
				</Tr>
<%
			}
%>
		</Table>
		</Div>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddOrganogram.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditOrganogram.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteOrganograms.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/levels.gif  alt="Click Here to View Organogram Levels" border=no onClick="funOpt(5,'ezListOrganogramsLevels.jsp')">
			<!-- input type=image  src=../../Images/Buttons/<%= ButtonDir%>/structure.gif  alt="Click Here to View Organogram Structure" border=no onClick="funOpt(6,'ezOrganogramStructure.jsp')" -->
		</Div>
<%
		}
%>
</Form>
</body>
</html>
