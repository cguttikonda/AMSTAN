<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>

<%@ include file="../../../Includes/JSPs/WorkFlow/iActionsList.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">


	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
	<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
	<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</Head>
<Body onLoad="scrollInit()" onresize="scrollInit()" scroll="no" >
<Br>
<Form name=myForm method="post" onSubmit="return goForSubmit(document.myForm)">
<%
	if(listRet.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Actions To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddActions.jsp')">
		</center>

<%
	}
	else
	{
%>
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr class=trClass>
				<Td align=center class=displayheader>WorkFlow Actions / Statuses List</Td>
			</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr class=trClass>
				<Th class=thClass align=center width="5%">&nbsp;</Th>
				<Th class=thClass align=center width="15%" >Code</Th>
				<Th class=thClass align=center width="40%" >Description</Th>
				<Th class=thClass align=center width="25%" >WF Action/Status</Th>
				<Th class=thClass align=center width="15%" >Direction</Th>
			</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
		for(int i=0;i<listRet.getRowCount();i++)
		{
%>
			<Tr class=trClass>
			<label for="cb_<%=i%>">
				<Td class=tdClass align=left width="5%">
					<input type=checkbox name=chk1  id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"CODE")%>">
				</Td>
				<Td class=tdClass align=left width="15%">
					<a style="text-decoration:none" href="ezActionsDetails.jsp?chk1=<%=listRet.getFieldValue(i,"CODE")%>"><%=listRet.getFieldValue(i,"CODE")%></a>
				</Td>
				<Td class=tdClass align=left width="40%"><%=listRet.getFieldValue(i,"DESCRIPTION")%></a>
				</Td>

<% 			String act=listRet.getFieldValueString(i,"STAT_OR_ACTION");
			if(act.equals("A"))
			{
			   act="Action";
			}
			else if(act.equals("S"))
			{
			   act="Status";
			}
			else if(act.equals("B"))
			{
			   act="Both";
			 }
%>
			
				<Td class=tdClass align=left width="25%"><%=act%>&nbsp;</Td>
<% 
			String direction=listRet.getFieldValueString("DIRECTION");
			if(direction.equals("F"))
			{
			   direction="Forward";
			}
			else if(direction.equals("B"))
			{
			   direction="Backward";
			}
			else if(direction.equals("N"))
			{
			   direction="None";
			}  
%>
		
				<Td width=15%><%=direction%>&nbsp;</Td>				
	<script>
	//========= Folowing code is for sorting=========================//
	rowArray=new Array()
	rowArray[0]=""
	rowArray[1]= "<%=listRet.getFieldValue(i,"CODE")%>"
	rowArray[2]= "<%=listRet.getFieldValue(i,"DESCRIPTION")%>"
	rowArray[3]= "<%=listRet.getFieldValue(i,"STAT_OR_ACTION")%>"
	rowArray[4]= "<%=listRet.getFieldValue(i,"DIRECTION")%>"
	dataArray[<%=i%>]=rowArray
	</script>
				</label>
				</Tr>
<%
			}//End Of For
%>
			</Table>
			</Div>
	
			<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddActions.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditActions.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteActions.jsp')">
			</Div>
<%
	}
%>
</Form>
</Body>
</Html>
