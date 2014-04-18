<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%
	
	String value[] = request.getParameterValues("cust");
	String soldTo = "";
	String userId = "";
	String userName="";
	for(int i=0;i<value.length;i++)
	{
		if(value[i]!=null)
		{
			soldTo = value[i];
			break;
		}
	}
	
	ezc.ezparam.EzcUserParams uparams = null;
	EzcUserNKParams ezcUserNKParams = null;
	
	EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
	adminUtilsParams.setSyskeys((String)session.getValue("SalesAreaCode"));
	adminUtilsParams.setPartnerValueBy(soldTo);

	EzcParams mainParams_A = new EzcParams(false);
	mainParams_A.setObject(adminUtilsParams);
	Session.prepareParams(mainParams_A);

	ReturnObjFromRetrieve partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams_A);

	if(partnersRet!=null && partnersRet.getRowCount()>0)
	{
		MAINLOOP:
		for(int l=0;l<partnersRet.getRowCount();l++)
		{
			uparams= new ezc.ezparam.EzcUserParams();
			ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setSys_Key("0");
			uparams.createContainer();
			uparams.setUserId(partnersRet.getFieldValueString(l,"EU_ID"));
			uparams.setObject(ezcUserNKParams);
			Session.prepareParams(uparams);
			ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));
			
			for(int i=0;i<retobj.getRowCount();i++)
			{
				if("ISSUBUSER".equals(retobj.getFieldValueString(i,"EUD_KEY")) && !"Y".equals(retobj.getFieldValueString(i,"EUD_VALUE").trim()))
				{
					userId = partnersRet.getFieldValueString(l,"EU_ID");
					userName = partnersRet.getFieldValueString(l,"EU_FIRST_NAME");
					break MAINLOOP;
				}
			}
		}
	}	
	
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
	document.myForm.action="ezChangeCustomerPwd.jsp";
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
  String display_header = "Reset Customer Password"; 
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>
<Table  width="60%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">

		<Th width="45%" align="right">User ID&nbsp;</Th>
		<Td width="55%" align="left">&nbsp;<%=userId%></Td>
	</Tr>
	<Tr>
		<Th width="45%" align="right">User Name&nbsp;</Th>
		<Td width="55%" align="left">&nbsp;<%=userName%></Td>	
	</Tr>
</Table>
 

<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Th width="45%" align="right" valign="middle" >New Password *&nbsp;</Th>
		<Td width="55%" valign="top">
		<input type="password" class = "InputBox" name="password1" size="10" maxlength="10">
		</Td>
	</Tr>
	<Tr>
		<Th width="45%" align="right"  valign="middle" >Confirm Password *&nbsp;</Th>
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
	buttonMethod.add("navigateBack(\"../SelfService/ezCustomerList.jsp\")");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<script>
	document.myForm.password1.focus()
</script>
	<input type=hidden name=BusUser value="<%=userId%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>