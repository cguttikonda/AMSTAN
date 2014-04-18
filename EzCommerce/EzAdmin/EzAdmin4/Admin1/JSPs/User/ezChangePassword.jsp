<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iChangePassword.jsp"%>

<html>
<head>

<script language = "javascript">
function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "BusUser=" + document.myForm.BusUser.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function confirmNewpasswd() {
	 passwd1 = document.myForm.password1.value;
	 passwd2 = document.myForm.password2.value;
	if (passwd1 != passwd2) {
		alert("New Password and Confirm Password are not same. Please re-enter the password");
	}
	return true;
}

function VerifyEmptyFields() {
	if (document.forms[0].password1.value == "" || document.forms[0].password2.value == "" ){
		alert("Please enter the Password Values");
		document.returnValue = false;
	}
	else
		document.returnValue = true;
}
</script>

<Title>Change Password</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>
<Table  width="35%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Change Password</Td>
  </Tr>
</Table>


<form name=myForm method=post action="ezSavePassword.jsp">

  <Table  width="50%" align="center">
    <Tr> 
      <Td width="50%" class="labelcell" align="right">Business User:</Td>
      <Td width="57%"> <% 
int userRows = retuser.getRowCount();
String userName = null;
	if ( userRows > 0 ) {
        out.println("<select name=\"BusUser\" onChange= \"myalert()\">"); 
		for ( int i = 0 ; i < userRows ; i++ ){		
		String val = (String)(retuser.getFieldValue(i,USER_ID));	
		if(bus_user.equals(val.trim())){
	        out.println("<option selected value="+retuser.getFieldValue(i,USER_ID)+">"); 
			userName = (String)retuser.getFieldValue(i,USER_ID);
			if (userName != null){
				out.println(userName);
			}
	        out.println("</option>"); 
		}else{
	        out.println("<option value="+retuser.getFieldValue(i,USER_ID)+">"); 
			userName = (String)retuser.getFieldValue(i,USER_ID);
			if (userName != null){
				out.println(userName);
			}
	        out.println("</option>"); 
		}
		}//End for
        out.println("</select>"); 
	}
%> </Td>
    </Tr>
  </Table>
  <br>
  <div align="center"><font face="Tw Cen MT" size="3">Please enter the new password:<br>
    </font> </div>
  <Table  width="50%" height="38" align="center">
    <Tr> 
      <Td width="50%" align="right" valign="middle" height="36" class="labelcell">New 
        Password:</Td>
      <Td height="36" width="46%" valign="top">
        <input type="password" name="password1" size="10" maxlength="10">
        </Td>
    </Tr>
    <Tr> 
      <Td width="50%" align="right" valign="middle" height="36" class="labelcell">Confirm 
        Password:</Td>
      <Td height="36" width="46%" valign="top">
        <input type="password" name="password2" size="10" maxlength="10" onChange="confirmNewpasswd()">
        </Td>
    </Tr>
    <input type="hidden" name="ErrFlag" size="5" value="<%=error%>">
  </Table>
  <p align="center"> 
    <input type="submit" name="Submit" value="Save Password" onClick="VerifyEmptyFields(); return document.returnValue">
  </p>
</form>
<SCRIPT language="JavaScript">
<!--
	errorFlag = document.myForm.ErrFlag.value;
	if (errorFlag == "E" ){
		alert("Wrong password. please enter again");
	}
-->
</SCRIPT>
</body>
</html>