<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>

<%@ include file="../../../Includes/JSPs/WorkFlow/iDelegationInfoList.jsp"%>
<%@ page import="java.util.Date,java.text.*" %>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</Head>
<Body onLoad="scrollInit();ezInitSorting()" onresize="scrollInit()" scroll=no >
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
			No Delegations To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddDelegationInfo.jsp')">
		</center>

<%
	}else{
%>
	<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
		<Tr class=trClass>
			<Td align=center class=displayheader>Delegations List </Td>
		</Tr>
		</Table>
		<Div id="theads">
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
		<Tr class=trClass>
			<Th class=thClass align=center width="5%">&nbsp;</Th>
			<Th class=thClass align=center width="15%" onClick="ezSortElements(1)" style="cursor:hand">Delegation Id</Th>
			<Th class=thClass align=center width="15%" onClick="ezSortElements(2)" style="cursor:hand">Template Code</Th>
			<Th class=thClass align=center width="15%" onClick="ezSortElements(3)" style="cursor:hand">Source User</Th>
			<Th class=thClass align=center width="15%" onClick="ezSortElements(4)" style="cursor:hand">Destination User</Th>
			<Th class=thClass align=center width="15%" onClick="ezSortElements(5,'_DATE')" style="cursor:hand">Valid From</Th>
			<Th class=thClass align=center width="15%" onClick="ezSortElements(6,'_DATE')" style="cursor:hand">Valid To</Th>
		</Tr>
		</Table>
		</Div>

	<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
			for(int i=0;i<listRet.getRowCount();i++)
			{
				SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy");
				SimpleDateFormat sdf1=new SimpleDateFormat("MM/dd/yyyy");
				Date fd=(Date)listRet.getFieldValue(i,"VALIDFROM");
				Date td=(Date)listRet.getFieldValue(i,"VALIDTO");
				
				String fromdate=sdf.format(fd);
				String todate=sdf1.format(td);
			
				
%>
			<Tr class=trClass>
				<Td class=tdClass align=center width="5%">
					<input type=checkbox name=chk1 value="<%=listRet.getFieldValue(i,"DELEGATIONID")%>">
				</Td>
				<Td class=tdClass align=left width="15%"><a style="text-decoration:none" href="ezDelegationInfoDetails.jsp?chk1=<%=listRet.getFieldValue(i,"DELEGATIONID")%>"><%=listRet.getFieldValue(i,"DELEGATIONID")%>&nbsp;</Td></a>
				<Td class=tdClass align=left width="15%"><%=listRet.getFieldValue(i,"DESCRIPTION")%></Td>
				<Td class=tdClass align=left width="15%"><%=listRet.getFieldValue(i,"SOURCEUSER")%>&nbsp;</Td>
				<Td class=tdClass align=left width="15%"><%=listRet.getFieldValue(i,"DESTUSER")%>&nbsp;</Td>
				<Td class=tdClass align=left width="15%"><%=fromdate%>&nbsp;</Td>
				<Td class=tdClass align=left width="15%"><%=todate%>&nbsp;</Td>
	<script>
	//========= Folowing code is for sorting=========================//
		 rowArray=new Array()
		 rowArray[0]=""
		 rowArray[1]= "<%=listRet.getFieldValue(i,"DELEGATIONID")%>"
		 rowArray[2]= "<%=listRet.getFieldValue(i,"DESCRIPTION")%>"
		 rowArray[3]= "<%=listRet.getFieldValue(i,"SOURCEUSER")%>"
		 rowArray[4]= "<%=listRet.getFieldValue(i,"DESTUSER")%>"
		 rowArray[5]= "<%=fromdate%>"
		 rowArray[6]= "<%=todate%>"
		dataArray[<%=i%>]=rowArray
	</script>
			</Tr>
<%
			}
%>
			</Table>
		</Div>
		<Div align=center id="ButtonDiv" style="position:absolute;top:92%;width:100%">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddDelegationInfo.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditDelegationInfo.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteDelegationInfo.jsp')">
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>
