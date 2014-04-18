<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iSelectSalesEmp.jsp"%>
<html>
<head>
<script>
	function changeUser()
	{
		document.myForm.action="ezSelectSalesEmp.jsp";
		document.myForm.submit();
	}
	function VerifyEmptyFields()
	{
		if (document.myForm.NEWEMP.value==""){
			alert("Please Enter New Field Executive Number")
			return false;
		}
		else{
			document.myForm.action="ezUpdateSalesEmp.jsp";
			document.myForm.submit();
		}
	}
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body onLoad="JavaScrit:document.forms[0].NEWEMP.focus()">
<br>
<%
	if ("Y".equals(alert)){
		%><script>
		alert("Field Executive has been changed successfully");
		</script>
	<%}
%>
<table width="35%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellpadding=2 cellspacing=0>
  <tr align="center">
    <td class="displayheader">Change Field Executive</td>
  </tr>
</table>

<form name=myForm method=post action="" onSubmit='return false'>

	<input type="hidden" name="CustNo" value="<%=cust%>" >
	<input type="hidden" name="BP" value="<%=bp%>" >
  <table width="35%" align="center" border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellpadding=2 cellspacing=0>
    <tr>
      <td width="50%" class="labelcell" align="right">User:</td>
      <td width="57%">
	 <%
	int userRows = retuser.getRowCount();
	if ( userRows > 0 )
	{

	%>
		<div id="ListBoxDiv">
		<select name="UserID" onChange= "changeUser()" >
		<%
		for ( int i = 0 ; i < userRows ; i++ )
	        	{
			String user=retuser.getFieldValueString(i,"EU_ID").trim();
			if (user.equals(user_id.trim())){
			%>
			<option value="<%=user%>" selected> <%=user%></option>
			<%}else{%>
			<option value="<%=user%>"> <%=user%></option>
			<%}%>
	            <%}
		out.println("</select></div>");
	}%>
           	</td>
	</tr>
  </table>
	<br>
	<table width="35%" align="center" border="1" bordercolorlight=#000000 bordercolordark=#ffffff cellpadding=2 cellspacing=0>

	<Tr>
		<Td class=labelcell>Old Field Executive</Td>
		<Td>
		<%if (retEmp.getRowCount()>0){%>
		<input type=text class = "InputBox" name="OLDEMP" value="<%=retEmp.getFieldValueString(0,"EC_PARTNER_NO")%>" readonly size=12>
		<%}else{%>
		<input type=text class = "InputBox" name="OLDEMP" value="Not Assigned" readonly size=12>
		<%}%>
		</Td>
	</Tr><Tr>
		<Td class=labelcell>New Field Executive</Td>
		<Td>
		<input type=text class = "InputBox" name="NEWEMP"  maxlength=8 size=12>
		</Td>
	</Tr>
	</Table>

	<br>
             <center>
	<!--<input type="submit" name="Submit" value="Update" onClick="VerifyEmptyFields()">-->
	<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif" onClick="VerifyEmptyFields()">
	</center>
</body>
</html>