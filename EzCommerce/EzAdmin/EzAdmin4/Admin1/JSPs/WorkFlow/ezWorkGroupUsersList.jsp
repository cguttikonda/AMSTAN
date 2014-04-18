<%@ page import="java.util.*,java.text.*" %>
<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsList.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupUsersList.jsp"%>
<%
	String groupDesc = "";
%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
	<script>
	function funAddWGUser()
	{
		document.myForm.action = "ezAddWorkGroupUsers.jsp"
		document.myForm.submit();
	}
	function funGetUsers()
	{
		if(document.myForm.groups.selectedIndex!=0)
		{
			document.myForm.action="ezWorkGroupUsersList.jsp"
			document.myForm.submit();
		}
	}
	function funSubmit()
	{
		if(document.myForm.groups.selectedIndex!=0)
		{
<%
			if("N".equals(myFlag))
			{
%>		
				document.myForm.groupDesc.value = "<%=groupid%>";
				return goForSubmit(document.myForm)
<%
			}
			else
			{
%>
				document.myForm.groupDesc.value = document.myForm.groups.options[document.myForm.groups.selectedIndex].text
				return goForSubmit(document.myForm)
<%
			}
%>		
		}
		else
		{
			alert("Please Select Work Group.")
			document.myForm.groups.focus();
			return false
		}
		return false
	}
	</script>

	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
	<Script src="../../Library/JavaScript/ezSubmitFormMultipleEdit.js"></Script>
</Head>

<Body onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Br>
<Form name=myForm method="post" onSubmit="return funSubmit()">
	<input type = "hidden" name = "groupDesc" value = "">
	<input type = "hidden" name = "areaFlag" value = "<%=areaFlag%>">
<%
	if(listRet.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Work Groups To List Work Group Users.
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddWorkGroups.jsp')">
		</center>
<%
		return;
	}
%>
<%
	if(listRet.getRowCount()>0)
	{
		if(!myFlag.equals("N"))
		{
%>
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="60%">
		<Tr>
		<Th width=25%> Work Groups</Th>
		<Td width=75%>
		<select name="groups" style="width:100%" id=FullListBox onChange="funGetUsers()">
		<option value="">--Select Group--</option>
<%
		for(int i=0;i<listRet.getRowCount();i++)
		{
			if(groupid!=null)
			{
				if(groupid.equals(listRet.getFieldValueString(i,"GROUP_ID")))
				{
					groupDesc = listRet.getFieldValueString(i,"DESCRIPTION");
%>
					<option value="<%=listRet.getFieldValueString(i,"GROUP_ID")%>" selected><%=groupDesc%></option>
<%
				}
				else
				{
%>
					<option value="<%=listRet.getFieldValueString(i,"GROUP_ID")%>"><%=listRet.getFieldValueString(i,"DESCRIPTION")%></option>
<%
				}
			}
			else
			{
%>
					<option value="<%=listRet.getFieldValueString(i,"GROUP_ID")%>"><%=listRet.getFieldValueString(i,"DESCRIPTION")%></option>
<%
			}
		}
%>
		</select>
		</Td>
		</Tr>
		</Table>

<%
		}
		else
		{
%>
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
		<Th width=40%> Work Group</Th>
		<Td width=60%>
<%
		for(int i=0;i<listRet.getRowCount();i++)
		{
			if(groupid!=null)
			{
				if(groupid.equals(listRet.getFieldValueString(i,"GROUP_ID")))
				{
					groupDesc = listRet.getFieldValueString(i,"DESCRIPTION");
%>
					<%=groupDesc%> (<%=groupid%>)
<%
				}
			}
		}
%>
			<input type = "hidden" name="groups" value = "<%=groupid%>" >
 		</Td>

		</Tr>
		</Table>
<%
		}
	}


	if(listRet1!=null)
	{

		if(listRet1.getRowCount()==0)
		{
%>
			<br><br><br>
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
			<Tr>
				<Th width="100%" align=center>
					No Work Group Users In <%=groupDesc%>
				</Th>
			</Tr>
			</Table><br><center>
			<img  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" Style = "Cursor:hand" onClick="funAddWGUser()">
			</center>
	<%
		}
		else
		{
	%>

			<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr class=trClass>
			<Td align=center class=displayheader>Work Group Users List </Td>
			</Tr>
			</Table>
			<Div id="theads">
			<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<Tr class=trClass>
			<Th class=thClass align=center width="5%">&nbsp;</Th>
			<Th class=thClass align=center width="15%" >User Id</Th>
			<%
			    if("IC".equals(groupType) || "IV".equals(groupType))
			    {
			%>
				<Th class=thClass align=center width="30%">User Name</Th>
				<Th class=thClass align=center width="30%" >Business Area</Th>
			<%
			    }
			    else
			    {
			%>
				<Th class=thClass align=center width="20%" >User Name</Th>
				<Th class=thClass align=center width="30%" >Business Area</Th>
				<Th class=thClass align=center width="30%" >Sold To</Th>
			<%
			    }
			%>
			</Tr>
			</Table>
			</Div>
			<DIV id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
			String fName="",mName="",lName="",userName="";
			for(int i=0;i<listRet1.getRowCount();i++)
			{
%>
			<Tr class=trClass>
			<label for="cb_<%=i%>">
			<Td class=tdClass align=center width="5%">
				<input type=radio name=chk1 id="cb_<%=i%>" value="<%=listRet1.getFieldValue(i,"GROUP_ID")%>,<%=listRet1.getFieldValue(i,"USERID")%>,<%=listRet1.getFieldValue(i,"SYSKEY")%>,<%=listRet1.getFieldValue(i,"SOLDTO")%>">
			</Td>
<%
			fName=listRet1.getFieldValueString(i,"FIRSTNAME");
			if(fName == null || "null".equals(fName))
				fName="";
			mName=listRet1.getFieldValueString(i,"MIDDLENAME");
			if(mName == null || "null".equals(mName))
				mName="";
			lName=listRet1.getFieldValueString(i,"LAST_NAME");
			if(lName == null || "null".equals(lName))
				lName="";
			userName = fName+" "+mName+" "+lName;
			if("IC".equals(groupType) || "IV".equals(groupType))
			{
%>
				<Td class=tdClass align=left width="15%"><a href = "../User/ezViewIntranetUserData.jsp?UserID=<%=listRet1.getFieldValueString(i,"USERID")%>&WebSysKey=<%=listRet1.getFieldValue(i,"SYSKEY")%>"><%=listRet1.getFieldValue(i,"USERID")%></a>&nbsp;</Td>
				<Td width="30%"><%=userName%></Td>
				<Td class=tdClass align=left width="30%">
					<a href = "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=listRet1.getFieldValue(i,"SYSKEY")%>">
					<%=listRet1.getFieldValue(i,"SYSKEYDESC")%> (<%=listRet1.getFieldValue(i,"SYSKEY")%>)
					</a>&nbsp;
				</Td>
<%
			}
			else
			{
%>
				<Td class=tdClass align=left width="15%"><a href = "../User/ezUserDetails.jsp?UserID=<%=listRet1.getFieldValueString(i,"USERID")%>&WebSysKey=<%=listRet1.getFieldValue(i,"SYSKEY")%>"><%=listRet1.getFieldValue(i,"USERID")%></a>&nbsp;</Td>				
				<Td class=tdClass align=left width="20%"><%=userName%></Td>
				<Td class=tdClass align=left width="30%">
				<a href = "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=listRet1.getFieldValue(i,"SYSKEY")%>">
					<%=listRet1.getFieldValue(i,"SYSKEYDESC")%> (<%=listRet1.getFieldValue(i,"SYSKEY")%>)
				</a>&nbsp;</Td>
				<Td class=tdClass align=left width="30%">
				<a href = "../User/ezSearchUserBySoldTo.jsp?Area=<%=areaFlag%>&sysKey=<%=listRet1.getFieldValue(i,"SYSKEY")%>&soldTo=<%=listRet1.getFieldValue(i,"SOLDTO")%>"><%=listRet1.getFieldValue(i,"CUSTNAME")%> (<%=listRet1.getFieldValue(i,"SOLDTO")%>)</a>&nbsp;</Td>
<%
			}
%>
			</label>
			</Tr>
<%
			}
%>
			</Table>
		</Div>

		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddWorkGroupUsers.jsp')">
			<!--<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditWorkGroupUsers.jsp')">-->
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteWorkGroupUsers.jsp')">
			<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style = "cursor:hand" onClick = "JavaScript:history.go(-1)">
		</Div>
<%
	}
	}
	else
	{
%>
		<br><br><br>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				Please select Group To Continue
			</Th>
		</Tr>
		</Table>
		<br>
		<Center>
			<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style = "cursor:hand" onClick = "JavaScript:history.go(-1)">
		</Center>
<%
	}
%>

</Form>
</Body>
</Html>
