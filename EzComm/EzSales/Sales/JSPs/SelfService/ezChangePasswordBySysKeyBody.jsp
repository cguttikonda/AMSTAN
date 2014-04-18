<%@ page import="ezc.ezparam.*" %>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<%
	
	String value[] = request.getParameter("BusinessUser").split("¥");
	String userId=value[0];
	String userName=value[1];
	
	ReturnObjFromRetrieve ret = null;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ret = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	
	String userType = null;
	String userValue =null; 
%>

<Script language="JavaScript" src="../../Library/JavaScript/Misc/Trim.js"></Script>
<script type="text/javascript">
function navigateBack(obj)
{
	document.myForm.action="ezListSubUsers.jsp";
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
<Title>Reset Password</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<body onLoad="document.myForm.password1.focus()">

<form name=myForm method=post  onSubmit="VerifyEmptyFields(); return document.returnValue">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">

<% 
	if(ret.getRowCount()==0)
	{
%>
		<div class="page-title"><h2>No Sales Aread To List Users</h2></div>
		<div><input type="button" value="Back" title="Back" onClick="history.go(-1)" /></div>
		<input type="hidden" name="Area" value="C">
		<input type ="hidden" name="flag" value="1">
<%  
		return; 
	} 
	String display_header = "Reset Password"; 
%>
	<table class="data-table" id="quickatp">
	<tbody>
		<Tr align="center">

			<Th colspan="2">User ID:</Th>
			<Td><%=userId%></Td>
			<Th colspan="2">User Name:</Th>
			<Td><%=userName%></Td>	
		</Tr>
	</tbody>	
	</Table>

	<table class="data-table" id="quickatp">
	<tbody>
		<Tr>
			<Th align="right" valign="middle" >New Password:*</Th>
			<Td valign="top">
			<input type="password" class = "InputBox" name="password1" size="10" maxlength="10">
			</Td>
		</Tr>
		<Tr>
			<Th align="right"  valign="middle" >Confirm Password:*</Th>
			<Td valign="top">
			<input type="password"  class = "InputBox" name="password2" size="10" maxlength="10">
			</Td>
		</Tr>
		<input type="hidden" name="ErrFlag" size="5" value="">
	</tbody>	
	</Table>
	<br>
	<div>
		<input type="button" value="Save" title="Save" onClick="savePassword()" />
		<input type="button" value="Reset" title="Reset Password" onClick="document.myForm.reset()" />
		<input type="button" value="Back" title="Back" onClick="navigateBack()" />
	</div>

<script>
	document.myForm.password1.focus()
</script>

	<input type="hidden" name="Area" value="C">
	<input type=hidden name=BusUser value="<%=userId%>">
</div>
</div>
</div>
</form>
</body>
