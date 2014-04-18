<%@page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>

<%@ include file="../../../Includes/JSPs/WorkFlow/iAttributesList.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

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
			No Attributes To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddAttributes.jsp')">
		</center>

<%
	}else{
%>
	<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr class=trClass>
			<Td align=center class=displayheader>Attributes  List </Td>
		</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr class=trClass>
			<Th class=thClass align=center width="5%">&nbsp;</Th>
			<Th class=thClass align=center width="20%" >AttributeId</Th>
			<Th class=thClass align=center width="50%" >Description</Th>
			<Th class=thClass align=center width="25%" >Type</Th>
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
					<input type=checkbox name=chk1 id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"ATTRIBUTE")%>">
				</Td>
				<Td class=tdClass align=left width="20%">
					<a style="text-decoration:none" href="ezAttributesDetails.jsp?chk1=<%=listRet.getFieldValue(i,"ATTRIBUTE")%>"><%=listRet.getFieldValue(i,"ATTRIBUTE")%></a>

				</Td>
				<Td class=tdClass align=left width="50%"><%=listRet.getFieldValue(i,"DESCRIPTION")%>&nbsp;</Td>
				<Td class=tdClass align=left width="25%"><%=listRet.getFieldValue(i,"TYPE")%>&nbsp;</Td>
	<script>
	//========= Folowing code is for sorting=========================//
		 rowArray=new Array()
		 rowArray[0]=""
		 rowArray[1]= "<%=listRet.getFieldValue(i,"ATTRIBUTE")%>"
		 rowArray[1]= "<%=listRet.getFieldValue(i,"ATTRIBUTE")%>"
		 rowArray[2]= "<%=listRet.getFieldValue(i,"DESCRIPTION")%>"
		 rowArray[3]= "<%=listRet.getFieldValue(i,"TYPE")%>"
		dataArray[<%=i%>]=rowArray
	</script>
			</label>
			</Tr>
<%
			}
%>
			</Table>
		</Div>
		<Div align=center id="ButtonDiv" style="position:absolute;top:92%;width:100%">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddAttributes.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditAttributes.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteAttributes.jsp')">
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>
