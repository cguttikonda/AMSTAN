<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListUsersByRole.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<html>
<head>
<script src="../../Library/JavaScript/User/ezListUsersByRole.js"></script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<script>
function reSub()
{
	if(document.myForm.role.selectedIndex != 0 && document.myForm.sysKey.selectedIndex != 0)
	{
		document.myForm.submit()
		document.myForm.action="ezListUsersByRole.jsp"
	}
}
</script>
</head>
<body  bgcolor="#FFFFF7" onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="">
<br>
	<Table  align=center width=89% border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Td width=10% class=labelcell align = "right">Role</Td>
		<Td width=40%>
			<select name=role style="width:100%" id=FullListBox onChange="reSub()">
			<option>--Select Role--</option>
<%
			int rolesCnt=retRoles.getRowCount();
			retRoles.sort(new String[]{"DESCRIPTION"},true);
			for(int i=0;i<rolesCnt;i++)
			{
			 	if(retRoles.getFieldValueString(i,"DELETE_FLAG").equals("N"))
			    	{
			    		if(retRoles.getFieldValueString(i,"ROLE_NR").equals(selRole))
			    	   	{
%>
						<option value="<%=retRoles.getFieldValue(i,"ROLE_NR")%>" selected><%=retRoles.getFieldValue(i,"DESCRIPTION")%></option>
<%
					}
					else
					{
%>
						<option value="<%=retRoles.getFieldValue(i,"ROLE_NR")%>"><%=retRoles.getFieldValue(i,"DESCRIPTION")%></option>
<%
					}
			    	}
			}
%>
			</select>
		</Td>
		<Td width=10% class=labelcell  align = "right"><nobr>Business Area</nobr></Td>
		<Td width=40%>
			<select name=sysKey style="width:100%" id=FullListBox onChange="reSub()">
			<option>--Select Business Area--</option>
<%
			int sysCnt=ret.getRowCount();
			ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
			for(int i=0;i<sysCnt;i++)
			{
			    	if((ret.getFieldValueString(i,SYSTEM_KEY)).equals(selSysKey))
			    	{
%>
					<option value="<%=ret.getFieldValue(i,SYSTEM_KEY)%>" selected><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%></option>
<%
			    	}
			    	else
			    	{
%>
					<option value="<%=ret.getFieldValue(i,SYSTEM_KEY)%>"><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%></option>
<%
			    	}
			}
%>
			</select>
		</Td>
	</Tr>
	</Table>
<%
	if(usersRet == null)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td class = "labelcell" align = "center">
		    	    Please Select Role and Business Area to continue.
		    	</Td>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	}
	else
	{
		int uCnt=usersRet.getRowCount();
		if(uCnt == 0)
		{
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
				<Td class = "labelcell" align="center">
					No Users to List in Selected Role and Business Area.
		    		</Td>
			</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
		}
		else
		{
%>
			<Table  align=center width=89% border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
			<Tr>
				<Td class = "displayheader" align = "center">List of Users By Role</Td>
			</Tr>
			</Table>
			<div id="theads">
			<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
			<Tr>
				<Th width="5%">&nbsp;</Th>
				<Th width="15%">UserId</Th>
				<Th width="70%">User Name</Th>
				<Th width="10%">Type</Th>
			</Tr>
			</Table>
			</div>
			<div id="InnerBox1Div">
			<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
			String uType="",userUrl="",userType="",userName="";
			usersRet.sort(new String[]{USER_FIRST_NAME},true);
			for(int i=0;i<uCnt;i++)
			{
				uType = usersRet.getFieldValueString(i,"EU_TYPE");
				userUrl = "ezUserDetails.jsp?UserID="+(String)usersRet.getFieldValue(i,USER_ID);
				userType = "Business";
				userName=usersRet.getFieldValueString(i,USER_FIRST_NAME);
				if(usersRet.getFieldValue(i,USER_MIDDLE_INIT) != null)
					userName += " "+ usersRet.getFieldValueString(i,USER_MIDDLE_INIT);
				userName += " "+usersRet.getFieldValueString(i,USER_LAST_NAME);
				if ( uType.equals("2") )
				{
					userUrl = "ezViewIntranetUserData.jsp?UserID="+(String)usersRet.getFieldValue(i,USER_ID)+"&Show=Yes";
					userType="Intranet";
				}
%>
				<Tr>
				<label for="cb_<%=i%>">
					<Td align=center width="5%"><input type=checkbox name="chk1" id="cb_<%=i%>" value="<%=usersRet.getFieldValueString(i,USER_ID)%>" >
						<input type=hidden name="U<%=(usersRet.getFieldValueString(i,USER_ID)).trim()%>" value="<%=uType%>">
					</Td>
					<Td width="15%"><a href=<%=userUrl%>><%=usersRet.getFieldValue(i,USER_ID)%></a></Td>
					<Td width="70%"><%=userName%></Td>
					<Td width="10%"><%=userType%></Td>
				</label>
				</Tr>
<%
			}
%>
			</Table>
			</div>
			<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
				<img src="../../Images/Buttons/<%= ButtonDir%>/modify.gif" style="cursor:hand" onClick="funCheckBoxSingleModify()">
				<img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" onClick="funCheckBoxSingleDelete()" style="cursor:hand">
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</div>
			<input type="hidden" name="BusinessUser" value="" >
			<input type="hidden" name="fromListByRole" value="Yes">
<%
		}
	}
%>
</form>
</body>
</html>
