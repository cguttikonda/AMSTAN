<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iRoleConditionsList.jsp"%>


<Html>
<Head>
<meta name="author"  content="EzWorkbench">

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
<script>

	function funReload()
	{
		//document.myForm.submit()
		//document.myForm.action="ezRoleConditionsList.jsp"
		var val=document.myForm.Role.value
		document.location.href="ezRoleConditionsList.jsp?Role="+val
	}
	function funEditCheck()
	{
		
		var counter = 0
		var chkdRow = 0
		var chkLen = document.myForm.chk1.length
		var showAlert = false
		if(!isNaN(chkLen))
		{
			for(i=0;i<chkLen;i++)
			{
				if(document.myForm.chk1[i].checked)
				{
					chkdRow = i;
					counter++;
				}	
			}
			if(counter > 1)
			{
				alert("Please select only 1 Condition to Edit")
				return false;
			}
			if(counter == 0)
			{
				alert("Please select Atleast 1 Condition to Edit")
				return false;
			}
			
			if(document.myForm.checkEditFld[chkdRow].value == "B" || document.myForm.checkEditFld[chkdRow].value == "D")
				showAlert = true
			else
				showAlert = false
		}
		else
		{
			if(document.myForm.checkEditFld.checked)
			{
				if(document.myForm.checkEditFld.value == "B" || document.myForm.checkEditFld.value == "D")
					showAlert = true
			}
			else
			{
				alert("Please select the Condition to Edit");
				return false;
			}
		}
		
		if(showAlert)
			alert("You cannot Edit Delegation Or Bypass Condition");
		else
			funOpt(2,'ezEditRoleConditions.jsp')
	}
</script>
</Head>
<Body onLoad="scrollInit();ezInitSorting();" onResize="scrollInit()" scroll="no" >
<Form name=myForm method="post" onSubmit="return goForSubmit(document.myForm)">
<br>
<%--
<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=60%>
<Tr>
	<Th width=20%>Select Role</Th>
	<Td width=80%>
	<select name="Role" style="width:100%" onChange="funReload()" id=FullListBox>
	<%
		int rolesCount=retRoles.getRowCount();
		for(int i=0;i<rolesCount;i++)
		{
			if(((String)retRoles.getFieldValue(i,"DELETE_FLAG")).equals("N"))
			{
				if(roleId.equals(retRoles.getFieldValueString(i,"ROLE_NR")))
				{
	%>
					<option value="<%=retRoles.getFieldValue(i,"ROLE_NR")%>" selected><%=retRoles.getFieldValue(i,"DESCRIPTION")%></option>
	<%
				} else {
	%>
					<option value="<%=retRoles.getFieldValue(i,"ROLE_NR")%>"><%=retRoles.getFieldValue(i,"DESCRIPTION")%></option>
	<%
				}
			}
		}
	%>
	</select>
	</Td>
</Tr>
</Table>
--%>
<%
	if(listRet.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Role Conditions To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddRoleConditions.jsp')">
		</center>

<%
	}else{
%>
	<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr class=trClass>
			<Td align=center class=displayheader>Role Conditions List </Td>
		</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr class=trClass>
			<Th class=thClass align=center width="5%">&nbsp;</Th>
			<Th class=thClass align=center width="25%" onClick="ezSortElements(1)" style="cursor:hand">Description</Th>
			<Th class=thClass align=center width="40%" onClick="ezSortElements(2)" style="cursor:hand">Condition Text</Th>
			<Th class=thClass align=center width="30%" onClick="ezSortElements(3)" style="cursor:hand">Result</Th>
		</Tr>
		</Table>
		</Div>

	<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
			for(int i=0;i<listRet.getRowCount();i++)
			{
%>
			<Tr class=trClass>
			<label for="cb_<%=i%>">
				<Td class=tdClass align=center width="5%">
					<input type=checkbox name=chk1 id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"CONDITION_ID")%>">
					<input type=hidden name='checkEditFld' value='<%=listRet.getFieldValue(i,"DOC_TYPE")%>'>
				</Td>
			<Td class=tdClass width="25%">
					<a style="text-decoration:none" title="<%=listRet.getFieldValue(i,"DESCRIPTION")%>" href="ezRoleConditionsDetails.jsp?chk1=<%=listRet.getFieldValue(i,"CONDITION_ID")%>"><%=listRet.getFieldValue(i,"DESCRIPTION")%></a>
				</Td>
				<Td class=tdClass width="40%" title="<%=listRet.getFieldValue(i,"TEXT")%>"><input type=text class=DisplayBox size=60 maxsize=60 value="<%=listRet.getFieldValue(i,"TEXT")%>" readonly></Td>
				<Td class=tdClass width="30%"><%=listRet.getFieldValue(i,"RESULT")%>&nbsp;</Td>
	<script>
	//========= Folowing code is for sorting=========================//
		 rowArray=new Array()
		 rowArray[0]=""
		 rowArray[1]= "<%=listRet.getFieldValue(i,"CONDITION_ID")%>"
		 rowArray[2]= "<%=listRet.getFieldValue(i,"TEXT")%>"
		 rowArray[3]= "<%=listRet.getFieldValue(i,"RESULT")%>"
		dataArray[<%=i%>]=rowArray
	</script>
			</label>
			</Tr>
<%
			}
%>
			</Table>
		</Div>

		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  	 alt="Click Here To Add" 	border=no onClick="funOpt(1,'ezAddRoleConditions.jsp')">
			<!--<input type=image  src="../../Images/Buttons/<%//= ButtonDir%>/edit.gif"   alt="Click Here To Edit" 	border=no onClick="funEditCheck()">-->
			<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" alt="Click Here To Delete" 	border=no onClick="funOpt(3,'ezDeleteRoleConditions.jsp')">
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>
