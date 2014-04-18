<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateCodeList.jsp"%>
 
<Html>
<Head>
<meta name="author"  content="EzWorkbench">

	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
	<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
	<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</Head>
<Body onLoad="scrollInit()" onresize="scrollInit()" scroll=no >
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
			No Templates To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddTemplateCode.jsp')">
		</center>
<%
	}else
	{
%>
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr class=trClass>
				<Td align=center class=displayheader>Templates List </Td>
			</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<Tr class=trClass>
				<Th align=center width="5%">&nbsp;</Th>
				<Th align=center width="20%">Code</Th>
				<Th align=center width="50%">Description</Th>
				<Th align=center width="25%">Transaction</Th>
			</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
			for(int i=0;i<listRet.getRowCount();i++)
			{
%>
			<Tr class=trClass>
			<label for="cb_<%=i%>">
				<Td class=tdClass align=center width="5%">
					<input type=checkbox name=chk1 id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"TCODE")%>,<%=listRet.getFieldValue(i,"DESCRIPTION")%>,<%=listRet.getFieldValue(i,"LANG")%>">
				</Td>
			<Td class=tdClass width="20%">
					<%=listRet.getFieldValue(i,"TCODE")%>
				</Td>
				<Td class=tdClass align=left width="50%"><%=listRet.getFieldValue(i,"DESCRIPTION")%>&nbsp;</Td>
				<Td class=tdClass align=left width="25%"><%=listRet.getFieldValue(i,"AUTHDESC")%>&nbsp;</Td>
	<script>
	//========= Folowing code is for sorting=========================//
		 rowArray=new Array()
		 rowArray[0]=""
		 rowArray[1]= "<%=listRet.getFieldValue(i,"TCODE")%>"
		 rowArray[2]= "<%=listRet.getFieldValue(i,"LANG")%>"
		 rowArray[3]= "<%=listRet.getFieldValue(i,"DESCRIPTION")%>"
		 rowArray[4]= "<%=listRet.getFieldValue(i,"AUTHDESC")%>"
		dataArray[<%=i%>]=rowArray
	</script>
			</label>
			</Tr>
<%
			}
%>
		</Table>
		</Div>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddTemplateCode.jsp')">
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/edit.gif"  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditTemplateCode.jsp')">
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/delete.gif"  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteTemplateCode.jsp')">
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/steps.gif"  alt="Click Here To Steps" border=no onClick="funOpt(4,'ezTemplateStepsList.jsp')">
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>
