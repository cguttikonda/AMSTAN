<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iListBusAreas.jsp"%>
<%
	
	String value[] = request.getParameter("BusinessUser").split("¥");
	String userId=value[0];
	String userName=value[1];
%>
<html>
<head>
<Script language="JavaScript" src="../../Library/JavaScript/Misc/ezTrim.js"></Script>

<Script>
function navigateBack(obj)
{
	document.myForm.action=obj;
	document.myForm.submit();
	
}
function savePassword()
{

	if(funTrim(document.myForm.password1.value) == "")
	{

		alert("Please enter new password");
		document.myForm.password1.focus();
		return ;
	}
	if(funTrim(document.myForm.password2.value) == "")
	{

		alert("Please enter confirm password");
		document.myForm.password2.focus();
		return ;
	}

	if (funTrim(document.myForm.password1.value) != funTrim(document.myForm.password2.value))
	{
		alert("New Password and Confirm Password are not same. Please re-enter the password");
		document.myForm.password2.focus();
		return ;
	}
	document.myForm.action="ezSaveResetPassword.jsp";
	document.myForm.submit();
}
</Script>
<%
String userType = null;
String userValue =null; 
%>
<Title>Reset Password</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body onLoad="document.myForm.password1.focus()">

<form name=myForm method=post  onSubmit="VerifyEmptyFields(); return document.returnValue">


<% 
    if(ret.getRowCount()==0)
     {
%>
	<br><br><br>
	<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td class="displayheader">
			<div align="center">No <%=areaLabel%> To List Users</div>
			</Td>
		</Tr>
	</Table> 
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
	<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type ="hidden" name="flag" value="1">

<%  
      return; 
    } 

%>
<%
  String display_header = "Reset Password"; 
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>
<Table  width="80%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">

		<Th width="15%" >User ID:</Th>
		<Td width="15%"><%=userId%></Td>
		<Th width="15%" >User Name:</Th>
		<Td width="55%"><%=userName%></Td>	
	</Tr>
</Table>
 

<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Th width="45%" align="right" valign="middle" >New Password:*</Th>
		<Td width="55%" valign="top">
		<input type="password" class = "InputBox" name="password1" size="10" maxlength="10">
		</Td>
	</Tr>
	<Tr>
		<Th width="45%" align="right"  valign="middle" >Confirm Password:*</Th>
		<Td width="55%" valign="top">
		<input type="password"  class = "InputBox" name="password2" size="10" maxlength="10">
		</Td>
	</Tr>
	<input type="hidden" name="ErrFlag" size="5" value="">
</Table>

<br>
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Save");
	buttonMethod.add("savePassword()");

	buttonName.add("Reset");
	buttonMethod.add("document.myForm.reset()");

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezListSubUsers.jsp\")");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<script>
	document.myForm.password1.focus()
</script>

	<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type=hidden name=BusUser value="<%=userId%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>