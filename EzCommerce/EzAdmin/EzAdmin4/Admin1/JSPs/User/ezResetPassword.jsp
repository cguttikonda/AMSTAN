<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iResetPassword.jsp"%>

<html>
<head>

<script Language = "JavaScript" src="../../../Includes/Lib/JavaScript/Users.js">
</script>

<Title>Reset Password</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="document.myForm.password1.focus()">


<form name=myForm method=post action="ezSaveResetPassword.jsp" onSubmit="VerifyEmptyFields('ChgPassword'); return document.returnValue">

<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
    <Tr>
      <Th width="40%" class="labelcell" align="right">User:</Th>
      <Td width="60%">
<%
		int userRows = retuser.getRowCount();
		String userName = null;
		if ( userRows > 0 )
		{
%>
		        <div id = listBoxDiv0>
		        <select name="BusUser" onChange= "myalert('ChgPassword')">
		        <option value="sel" >Select User</option>
<%
			for ( int i = 0 ; i < userRows ; i++ )
			{
				String val = (String)(retuser.getFieldValue(i,USER_ID));
				if(bus_user.equals(val.trim()))
				{
%>
			   		<option selected value=<%=retuser.getFieldValue(i,USER_ID)%> >
<%
						userName = (String)retuser.getFieldValue(i,USER_ID);
					if (userName != null)
					{
%>
						<%=userName%>
<%
					}
%>
			        	</option>
<%
				}
				else
				{
%>
			        	<option value=<%=retuser.getFieldValue(i,USER_ID)%> >
<%
						userName = (String)retuser.getFieldValue(i,USER_ID);
					if (userName != null)
					{
						out.println(userName);
					}
%>
	        		</option>
<%
				}
			}//End for
%>
			</select></div>
      </Td>
    </Tr>
  </Table>
  <br>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">Reset Password</Td>
  </Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Th colspan = 2>
	Please enter the new password:
	</Th>
	</Tr>
    <Tr>
      <Td width="44%" align="right" valign="middle" class="labelcell">New Password:*</Td>
      <Td width="56%" valign="top">
        <input type="password" name="password1" size="10" maxlength="10">
        </Td>
    </Tr>
    <Tr>
      <Td width="44%" align="right" valign="middle" class="labelcell">Confirm
        Password:*</Td>
      <Td width="56%" valign="top">
        <input type="password" name="password2" size="10" maxlength="10" onChange="confirmNewpasswd('ChgPassword')">
        </Td>
    </Tr>
    <input type="hidden" name="ErrFlag" size="5" value="<%=error%>">
  </Table>
  <br>
<div id="buttons" align = center>
    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Reset" onClick="VerifyEmptyFields('ChgPassword'); return document.returnValue">
    <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();document.myForm.password1.focus()" ></a>
    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>
<%
}
else
{
%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	  <Td class="displayheader">
        <div align="center">There are no users to List</div>
      </Td>
	</Tr>
	</Table>
	<%
}
%>
</form>
<% if ( userRows > 0 ) { %>
<script language="JavaScript">
	document.forms[0].password1.focus();
</script>
<% } %>
</body>
</html>