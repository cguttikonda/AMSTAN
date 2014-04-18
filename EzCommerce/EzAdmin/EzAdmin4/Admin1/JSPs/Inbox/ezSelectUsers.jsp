<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ include file="../../../Includes/JSPs/Inbox/iSelectUsers.jsp"%>
<html>
<head>
	<Title>List of Users</Title>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

	<script language="javascript">

	function CheckSelect()
	{
		var selCount=0;
		var vals="";

		var len=document.myForm.to.length
		if(isNaN(len))
		{
			if(document.myForm.to.checked)
			{
				selCount=1
				vals=document.myForm.to.value
			}
		}
		else
		{
			for(var i=0;i<len;i++)
			{
				if(document.myForm.to[i].checked)
				{
					selCount++
					vals += document.myForm.to[i].value+",";
				}
			}
			vals= vals.substring(0,vals.length-1)
		}

		if(selCount == 0)
		{
			alert("Select User(s) Before Submitting");
			return false
		}
		else
		{

			opener.document.myForm.toUser.value=vals
			window.close()
			return true
		}
	}
	function reSubmitForm()
	{

		if(document.myForm.SysKey.selectedIndex != 0)
		{
			document.myForm.action="ezSelectUsers.jsp"
			document.myForm.submit()
		}
	}

	</script>
</head>

<body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post onSubmit="return CheckSelect()">
<!--action="javascript:Update()">-->

<%
	int sysCount=sysKeysList.getRowCount();
	if(sysCount == 0)
	{
%>
		<br><br><br><br>
		<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
			<Th>No Business Areas to List Users</Th>
		</Tr>
		</Table>
		<br><center><img src = "../../Images/Buttons/<%= ButtonDir%>/close.gif"  onClick="window.close()" style="cursor:hand"></center>
<%
		return;
	}
	else
	{
%>
		<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width = "30%">Business Area</Th>
			<Td  width = "70%">
				<Select name=SysKey onChange="reSubmitForm()" style = "width:100%">
				<option value="">--Select Business Area--</option>
<%
				sysKeysList.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
				for(int i=0;i<sysCount;i++)
				{
					if((sysKeysList.getFieldValueString(i,SYSTEM_KEY)).equals(selSysKey))
					{
%>
						<option value="<%=sysKeysList.getFieldValueString(i,SYSTEM_KEY)%>" selected><%=sysKeysList.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION)%></option>
<%
					} else {
%>
						<option value="<%=sysKeysList.getFieldValueString(i,SYSTEM_KEY)%>" ><%=sysKeysList.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION)%></option>
<%
					}
				}
%>
				</Select>
			</Td>

		</Tr>
		</Table>
<%
		if(retUser == null)
		{
%>
			<br><br><br>
			<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr align="center">
				<Th>Please select Business Area to Continue</Th>
			</Tr>
			</Table>
			<br><center><img src = "../../Images/Buttons/<%= ButtonDir%>/close.gif"  onClick="window.close()" style="cursor:hand"></center>
<%
			return;
		}
		else
		{
			int userRows = retUser.getRowCount();
			String userName = null;
			String fName="",mName="",lName="";
			if ( userRows > 0 )
			{
%>
				<div id="theads">
				<Table id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr align="center" valign="middle">
					<Th width="10%">&nbsp;</Th>
					<Th width="30%">UserId </Th>
					<Th width="60%">User Name</Th>
				</Tr>
				</Table>
				</div>
				<div id="InnerBox1Div">
				<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

<%

				retUser.sort(new String[]{"EU_FIRST_NAME"},true);
				for (int i = 0 ; i < userRows; i++)
				{
					fName = (String)retUser.getFieldValue(i,"EU_FIRST_NAME");
					mName = (String)retUser.getFieldValue(i,"EU_MIDDLE_INITIAL");
					lName = (String)retUser.getFieldValue(i,"EU_LAST_NAME");

					if(fName == null || "null".equals(fName))
						fName="";
					if(mName == null || "null".equals(mName))
						mName="";
					if(lName == null || "null".equals(lName))
						lName="";

					userName = fName +" "+mName+" "+lName;
%>

					<Tr align="center">
					<label for="cb_<%=i%>">
						<Td width="10%" ><input type="checkbox" name= "to" id="cb_<%=i%>" value=<%=retUser.getFieldValueString(i,USER_ID)%> ></Td>
						<Td width="30%" align = "left"><%=retUser.getFieldValueString(i,USER_ID)%></Td>
						<Td width="60%"  align = "left"><%=userName%></Td>

					</label>
					</Tr>
<%

				}//End for
%>
				</Table>
				</div>
				<input type="hidden" name="userStr" value="">
				<br>
				<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
					<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/select.gif" >
					<img src = "../../Images/Buttons/<%= ButtonDir%>/close.gif"  onClick="window.close()" style="cursor:hand">
				</div>
<%
	 		}//End if
			else
			{
 %>
				<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr align="center">
					<Td>No Users To List</Td>
				</Tr>
				</Table>
				<br><br><br><br><center><img src = "../../Images/Buttons/<%= ButtonDir%>/close.gif"  onClick="window.close()" style="cursor:hand"></center>
<%
			}
		}
	}
%>

</form>
</body>
</html>
