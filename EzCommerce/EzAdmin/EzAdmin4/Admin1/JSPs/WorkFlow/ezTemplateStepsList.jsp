<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateStepsList.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
</Head>
<Body onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
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
			No TemplateSteps To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddTemplateSteps.jsp')">
		</center>

<%
	}else{
%>
	<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr class=trClass>
			<Td align=center class=displayheader>Template Steps List (Template : <%=tDesc%>) </Td>
		</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr class=trClass>
			<Th class=thClass align=center width="5%">&nbsp;</Th>
			<Th class=thClass align=center width="10%">Step</Th>
			<Th class=thClass align=center width="30%">Description</Th>
			<Th class=thClass align=center width="30%">Default Participant</Th>
			<Th class=thClass align=center width="10%">Type</Th>
		</Tr>
		</Table>
		</Div>

	<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
			String opType = "";
			for(int i=0;i<listRet.getRowCount();i++)
			{
				if(listRet.getFieldValue(i,"OPTYPE").equals("G"))
					opType = "Group";
				else if(listRet.getFieldValue(i,"OPTYPE").equals("R"))
					opType = "Role";
				else
					opType = "User";
%>
			<Tr class=trClass>
			<label for="cb_<%=i%>">
				<Td class=tdClass align=center width="5%">
					<input type=radio name=chk1 id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"TCODE")%>,<%=listRet.getFieldValue(i,"STEP")%>">
				</Td>
				<Td class=tdClass align=center width="10%"><a style="text-decoration:none" href="ezTemplateStepsDetails.jsp?chk1=<%=listRet.getFieldValue(i,"TCODE")%>,<%=listRet.getFieldValue(i,"STEP")%>"><%=listRet.getFieldValue(i,"STEP")%></a></Td>
				<Td class=tdClass align=left width="30%"><%=listRet.getFieldValue(i,"STEP_DESC")%>&nbsp;</Td>
				<Td class=tdClass align=left width="30%"><%=removeNull(listRet.getFieldValue(i,"OWNERPARTICIPANT"))%>&nbsp;</Td>
				<Td class=tdClass align=left width="10%"><%=opType%>&nbsp;</Td>
			</Tr>
<%
			}
%>
			</Table>
		</Div>

		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddTemplateSteps.jsp')">
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/edit.gif"  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditTemplateSteps.jsp')">
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/delete.gif"  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteTemplateSteps.jsp')">
			<a href="ezTemplateCodeList.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none ></a>	
		</Div>
<%
	}
%>
		<input type=hidden name=tempCode value="<%=tCode%>">
		<input type=hidden name=tempDesc value="<%=tDesc%>">
</Form>
</Body>
</Html>
