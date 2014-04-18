<%@ include file="../../../Vendor2/Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iPassword_Labels.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iPassword.jsp"%> 

<html>   
<head>  
<%
	minPassLen_L = "Password Length should be 6-20 Characters";
	passOneNum_L = "Password should be Alpha Numeric";
%>
<script language="JavaScript">
var userid 		= '<%=((String)Session.getUserId()).toUpperCase()%>'
var passCantBeUsid_L 	= '<%=passCantBeUsid_L%>';
var minPassLen_L 	= '<%=minPassLen_L%>';
var passSplChar_L 	= '<%=passSplChar_L%>';
var passOneNum_L 	= '<%=passOneNum_L%>';
var passOneCaps_L 	= '<%=passOneCaps_L%>';
var passSHNotPrev_L 	= '<%=passSHNotPrev_L%>';
function fun1(){
	var pword = '<%=mypwd%>';
	if (pword !=''){
		document.forms[0].password1.focus();
	}
	else{
		document.forms[0].oldpasswd.focus();
	}
}


function clearPasswordFields()
{
	document.forms[0].elements['password1'].value=""
	document.forms[0].elements['password2'].value=""
	document.forms[0].elements['password1'].focus
}

function passContinue()
{
	top.document.location.href="../Misc/ezSelectSoldTo.jsp";	

}

function VerifyEmptyFields() 
{
	
	specChrsStr = "~!@#$%^&*()";
	numChrsStr = "0123456789";
	alphaChrsStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	
	password1 = document.forms[0].elements['password1'].value;
	
	var passwordLength = password1.length
	var checkContinue = true
	if(password1.toUpperCase() == userid)
	{
		alert(passCantBeUsid_L);
		checkContinue = false
	}	
	
	if((passwordLength < 6 || passwordLength > 20) && checkContinue)
	{
		alert(minPassLen_L);
		checkContinue = false
	}
	
	if(!checkContinue)
	{
		clearPasswordFields()
		return false;
	}
	
	
	if(password1!="")
	{

		var nLoop=0;
		var nLength=password1.length;
		sFlag = false;
		nFlag = false;
		aFlag = false;

		for(nLoop=0;nLoop<nLength;nLoop++)
		{
			pChar=password1.charAt(nLoop);
			if (specChrsStr.indexOf(pChar)>0)
			{
				sFlag = true;
				break;
			}
		}
		if(sFlag)
		{
			alert("Please dont enter any special characters like "+specChrsStr);
			clearPasswordFields()
			document.forms[0].password1.focus();
			document.returnValue = false;
			return false;
		}

		for(nLoop=0;nLoop<nLength;nLoop++)
		{
			pChar=password1.charAt(nLoop);
			if (numChrsStr.indexOf(pChar)!=-1)
			{
				nFlag = true;
				break;
			}
		}

		if(nFlag == false)
		{
			alert(passOneNum_L);
			clearPasswordFields()
			document.forms[0].password1.focus();
			document.returnValue = false;
			return false;
		}

		/*
		for(nLoop=0;nLoop<nLength;nLoop++)
		{
			pChar=password1.charAt(nLoop);
			if (alphaChrsStr.indexOf(pChar)!=-1)
			{
				aFlag = true;
				break;
			}
		}

		if(aFlag == false)
		{
			alert(passOneCaps_L);
			clearPasswordFields()
			document.forms[0].password1.focus();
			document.returnValue = false;
			return false;
		}
		*/
	}

	if (document.forms[0].oldpasswd.value == "" || document.forms[0].password1.value == "" || document.forms[0].password2.value == "" ){
		alert("<%=plzOldNewPwds_A%>");
		clearPasswordFields()
		document.returnValue = false;
	}else{
		y=confirmNewpasswd();
		if(eval(y)){
			setMessageVisible();
			document.password.submit();
			document.returnValue = true;
		}else{
			document.returnValue = false;
			return false;
		}
	}

	setMessageVisible();
	document.password.submit();
	document.returnValue = true;
}

function confirmNewpasswd() {
	passwd1 = document.forms[0].elements['password1'].value;
	passwd2 = document.forms[0].elements['password2'].value;
	if (passwd1 != passwd2) {
		alert("<%=newOldNotSame_A%>");
		document.returnValue = false;
		return false
	}else{
		return true;
		document.returnValue = true;
	}
}

function setAction(){
	document.forms[0].action = "../Misc/ezPassword.jsp";
	document.forms[0].submit();
}
function ezBack(event)
{
	document.location.href = event;
}
</script>

<title><%=changePwd_L%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body onLoad="fun1()" scroll=no>
<form method="post" action="../Misc/ezSavePassword.jsp" name="password">

<%
	String str=request.getParameter("Flag");
	String updtFlag=request.getParameter("updtFlag");
	
	if(updtFlag==null)
		updtFlag = "";
	
	if (str!=null){
		out.println("<input type=hidden name=Flag value=X>");
	}
%>
	<input type=hidden name="updtFlag" value="<%=updtFlag%>">

  <%
  	String display_header = changePwd_L;
  %>	 
  
<%@ include file="ezDisplayHeader.jsp"%>
<BR>
<TABLE align=center style="background:#ffffff;BORDER-RIGHT: #4374a6 1px solid; BORDER-TOP: #4374a6 1px solid; BORDER-LEFT: #4374a6 1px solid; BORDER-BOTTOM: #4374a6 1px solid" cellSpacing=0 cellPadding=0 width="80%"  height=65% border=0>
<TR>
	<TD  style="background:#ffffff" width="40%" align=center valign=top>
		<img src="../../Images/Others/chgpass.jpg">
	</TD>
	<TD style="background:#ffffff" width="60%" align=left valign=middle>
		<Table height=100% width="100%" border="0" cellspacing="0" cellpadding="0">
		<Tr>
			<Td  style="background:#ffffff" align=center  width=100%>
				<Table id="header" width="80%" border="0" cellspacing="0" cellpadding="0">
					<Tr class=trclass>
						<Td style="background:#ffffff" colspan=2 width=100%><font color="#FF0000" size=1>
						<ul>
							<li><nobr><%=passCantBeUsid_L%></nobr></li>
							<li><nobr><%=minPassLen_L%></nobr></li>
							<li><nobr><%=passOneNum_L%></nobr></li>
						</ul>
						</font></Td>
					</Tr>
				</Table>
			</Td>
		</Tr>
		<TR>
			<Td  style="background:#ffffff" align=center valign=top   width=100%>
			<TABLE width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
			      <tr> 
				<th width="45%" align="left"><%=currPwd_L%></th>
				<td valign="top" width="55%"> 
				  <input type="password" tabindex=1 name="oldpasswd"  class="Inputbox"  style="width:100%" size="10" maxlength="20" onChange="setAction()" value="<%=mypwd%>" >
				</td>
			      </tr>
			      <tr> 
				<th width="45%" align="left"><%=newPwd_L%></th>
				<td width="55%" valign="top"> 
				  <input type="password" class="Inputbox" tabindex=2 name="password1" size="10"  style="width:100%"  maxlength="20" >
				</td>
			      </tr>
			      <tr> 
				<th width="45%" align="left"><%=confPwd_L%></th>
				<td width="55%" valign="top"> 
				  <input type="password" class="Inputbox" tabindex=3 name="password2" size="10" maxlength="20"  style="width:100%" >
				</td>
			      </tr>
			    </table>
			   </td> 
		</tr>
		</table>
	</td>
</table>		

    <!-- <div align="center"> -->
    <Div id="ButtonDiv" align="center">
    <br>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
	
	buttonName.add("Submit");
	buttonMethod.add("VerifyEmptyFields()");
	
	buttonName.add("Continue");
	buttonMethod.add("passContinue()");

	buttonName.add("Clear");
	buttonMethod.add("document.password.reset()");

	String offline = (String)session.getValue("OFFLINE");
	if("Y".equals(offline))
	{
		buttonName.add("Logout");
		buttonMethod.add("ezBack(\"../Misc/ezOfflineLogout.jsp\")");
	}
	out.println(getButtonStr(buttonName,buttonMethod));	

%>
<input type="hidden" name="ErrFlag" size="5" value="<%=error%>">
<input type="hidden" name="oldPswd" value="<%=oldPwd%>">
</br>
</form>
  <SCRIPT language="JavaScript">
<!--
	errorFlag = document.forms[0].elements['ErrFlag'].value;
	//alert(errorFlag);
	if (errorFlag == "E" ){
		alert("<%=wrongPwd_L%>");
		document.forms[0].elements['oldpasswd'].focus();
	} else {
		if (errorFlag == "S") {
			document.forms[0].elements['password1'].focus();
		}else{
			if (errorFlag == "W") {
				document.forms[0].elements['oldpasswd'].focus();
			} else {
				document.forms[0].elements['password1'].focus();
			}
		}//end if
	}//end if
-->
</SCRIPT>
</div>
<%@ include file="../Misc/AddMessage.jsp" %>
<Div id="MenuSol">
</Div>	
</body>
</html>