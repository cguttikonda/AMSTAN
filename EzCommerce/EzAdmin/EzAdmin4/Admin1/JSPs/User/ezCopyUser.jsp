<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%@ include file="../../../Includes/JSPs/User/iCopyUser.jsp"%>

<html>
<head>

<script language="JavaScript" src="../../../Includes/Lib/JavaScript/Users.js">
</script>


<Title>Copy User</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad = "document.myForm.NewUser.focus()">


<form name=myForm method=post action="ezConfirmCopyUser.jsp">

<br>
   <%
int userRows = retuser.getRowCount();
String userName = null;
String userType = null;
String userValue = null;
	if ( userRows > 0 ) {

%>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader"> Copy User</Td>
  </Tr>
</Table>

  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Th width="43%" class="labelcell">
        <div align="right">Target User:</div>
      </Th>
      <Td width="57%">
        <input type=text class = "InputBox" name="NewUser" size="10" maxlength="10">
      </Td>
    </Tr>
    <Tr>
      <Th width="43%" class="labelcell">
        <div align="right">Source User:</div>
      </Th>
      <Td width="57%">
	  <div id = "listBoxDiv0">
        <select name="BusUser">
        <option value="sel">Select Source User</option>
          <%
		for ( int i = 0 ; i < userRows ; i++ ){
			userName = (String)retuser.getFieldValue(i,USER_ID);
			userType = retuser.getFieldValueString(i,"EU_TYPE");
			if (userName != null){
				userName = userName.trim();
				userType = userType.trim();
				userValue = userType+";"+userName;
			}
		%>
          <option value="<%=userValue%>"><%=userName%></option>
          <%
}// end for loop
%>
        </select>
		</div>
        <%

}// end of if condition
%>
      </Td>
    </Tr>
  </Table>
<%
if ( userRows > 0 ) {
%>

<br>
<div id="buttons" align = center>
<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/copy.gif" name="Submit" value="Copy" onClick="checkCopyAll('CopyUser');return document.returnValue">
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();document.myForm.NewUser.focus()" ></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</div>
</form>
<script language="JavaScript">
	document.forms[0].NewUser.focus();
</script>
<%
}//end if users > 0
else{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Td class="displayheader">There are no users to Copy</Td>
	  </Tr>
	</Table><br>
	<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


<% }%>

</body>
</html>