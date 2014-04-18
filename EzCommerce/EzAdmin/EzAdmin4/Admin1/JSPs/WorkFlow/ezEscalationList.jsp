<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
 
<%@include file="../../../Includes/JSPs/WorkFlow/iEscalationList.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</Head>
<Body onLoad="scrollInit();ezInitSorting()" onresize="scrollInit()" scroll=no >
<Br>
<Form name=myForm method="post" onSubmit="return goForSubmit(document.myForm)">
<%
	java.util.Hashtable escHash = new java.util.Hashtable();
	escHash.put("G","GROUP");
	escHash.put("R","ROLE");
	escHash.put("U","USER");
	
	if(listRet.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Escalations To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%=ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddEscalation.jsp')">
		</center>

<%
	}else{
%>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th align=center colspan=6 class=displayheader>Escalation List</Th>
		</Tr>	
		<Tr class=trClass>
			<Th class=thClass align=center width="5%">&nbsp;</Th>
			<Th class=thClass align=center width="10%" onClick="ezSortElements(1)" style="cursor:hand">Code</Th>
			<Th class=thClass align=center width="40%" onClick="ezSortElements(2)" style="cursor:hand">Description</Th>
			<Th class=thClass align=center width="10%" onClick="ezSortElements(3)" style="cursor:hand">Level</Th>
			<Th class=thClass align=center width="15%" onClick="ezSortElements(4)" style="cursor:hand">Move</Th>
			<Th class=thClass align=center width="20%" onClick="ezSortElements(5)" style="cursor:hand">Document Type</Th>
		</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
<%
	
			for(int i=0;i<listRet.getRowCount();i++)
			{
%>
			<Tr class=trClass>
				<Td class=tdClass align=center width="5%"><input type=checkbox name=chk1 value="<%=listRet.getFieldValue(i,"CODE")%>"></Td>
				<Td class=tdClass align=center width="10%"><a style="text-decoration:none" href="ezEscalationDetails.jsp?chk1=<%=listRet.getFieldValue(i,"CODE")%>"><%=listRet.getFieldValue(i,"CODE")%></a></Td>
				<Td class=tdClass align=left width="40%"><%=listRet.getFieldValue(i,"DESCRIPTION")%>&nbsp;</Td>
				<Td class=tdClass align=center width="10%"><%=(String)escHash.get(listRet.getFieldValueString("ESCLEVEL").trim())%>&nbsp;</Td>
				<Td class=tdClass align=center width="15%"><%=listRet.getFieldValue(i,"MOVE")%>&nbsp;</Td>
				<Td class=tdClass align=center width="20%"><%=listRet.getFieldValue(i,"DOC_TYPE")%>&nbsp;</Td>
				<script>
				//========= Folowing code is for sorting=========================//
					 rowArray=new Array()
					 rowArray[0]=""
					 rowArray[1]= "<%=listRet.getFieldValue(i,"CODE")%>"
					 rowArray[2]= "<%=listRet.getFieldValue(i,"DESCRIPTION")%>"
					 rowArray[3]= "<%=listRet.getFieldValue(i,"ESCLEVEL")%>"
					 rowArray[4]= "<%=listRet.getFieldValue(i,"MOVE")%>"
					dataArray[<%=i%>]=rowArray
				</script>
			</Tr>
<%
			}
%>
			</Table>
		</Div>
		<Div align=center id="ButtonDiv" style="position:absolute;top:92%;width:100%">
			<input type=image  src=../../Images/Buttons/<%=ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddEscalation.jsp')">
			<input type=image  src=../../Images/Buttons/<%=ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteEscalation.jsp')">
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>
