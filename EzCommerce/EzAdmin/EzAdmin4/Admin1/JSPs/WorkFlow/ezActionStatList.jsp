<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ include file="../../../Includes/JSPs/WorkFlow/iActionStatList.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%> 
 
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
	<Script>
	  var tabHeadWidth=80;
	</Script>


	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
	<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
</Head>
<Body onLoad="scrollInit()" onresize="scrollInit()" scroll=no >
<Br>
<Form name=myForm method="post" onSubmit="return goForSubmit(document.myForm)">
<%
	if(listStatRet.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No ActionStats To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddActionStat.jsp')">
		</center>

<%
	}else
	{
%>
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr class=trClass>
				<Td align=center class=displayheader>WorkFlow Action Result Status</Td>
			</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
			<Tr class=trClass>
				<Th class=thClass align=center width="5%">&nbsp;</Th>
				<Th class=thClass align=center width="31%" >WF Action</Th>
				<Th class=thClass align=center width="31%" >Result Status</Th>
				<Th class=thClass align=center width="31%" >Transaction</Th>
			</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
			listStatRet.sort(new String[]{"ACTDESC"},true);
			int listStatCount = listStatRet.getRowCount();
			for(int i=0;i<listStatCount;i++)
			{
%>
			<Tr class=trClass>
			<label for="cb_<%=i%>">
				<Td class=tdClass align=center width="5%"><input type=checkbox name=chk1 id="cb_<%=i%>" value="<%=listStatRet.getFieldValue(i,"ACTION")%>,<%=listStatRet.getFieldValue(i,"AUTH_KEY")%>"></Td>
				<Td class=tdClass align=left width="31%"><%=listStatRet.getFieldValue(i,"ACTDESC")%></Td>
				<Td class=tdClass align=left width="31%"><%=listStatRet.getFieldValue(i,"STATDESC")%>&nbsp;</Td>
				<Td class=tdClass align=left width="31%"><%=listStatRet.getFieldValue(i,"AUTHDESC")%>&nbsp;</Td>
			</label>
			</Tr>
<%
			}
%>
		</Table>
		</Div>
		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddActionStat.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditActionStat.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteActionStat.jsp')">
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>
