<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iPassword_Lables.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>



<%
String str=request.getParameter("Flag");
String error = "";
String mypwd = null;
mypwd = request.getParameter("oldpasswd");

//ReturnObjFromRetrieve ret = null;

EzcUserParams uparams= new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
ezcUserNKParams.setPassword(mypwd);
uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

if ((!(mypwd == null)) || (error.equals("O"))) 
{
	boolean ret = UserManager.validateUserPassword(uparams);
	if (ret)
	{
		error = "";
	}
	else
	{
		error = "E";
		mypwd = "";
	}
}
else
{
	mypwd="";
	error = "W";
}//end if
%>
<html>
<head>
<title>ezPassword</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<SCRIPT language="JavaScript">
var userid = '<%=((String)Session.getUserId()).toUpperCase()%>'
var passCantBeUsid_L = 'Password cannot be same as your userid';
var minPassLen_L = 'Password Length should be 6-20 Characters';
var passOneNum_L = 'Password should be Alpha Numeric';
var passOneCaps_L = 'Minimum One Caps should be in Paaword';

function clearPasswordFields()
{
	document.forms[0].elements['password1'].value=""
	document.forms[0].elements['password2'].value=""
	document.forms[0].elements['password1'].focus();
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

		for(nLoop=0;nLoop<nLength;nLoop++)
		{
			pChar=password1.charAt(nLoop);
			if (alphaChrsStr.indexOf(pChar)!=-1)
			{
				aFlag = true;
				break;
			}
		}

		/*if(aFlag == false)
		{
			alert(passOneCaps_L);
			clearPasswordFields()
			document.forms[0].password1.focus();
			document.returnValue = false;
			return false;
		}*/
	}

	if (document.forms[0].oldpasswd.value == "" || document.forms[0].password1.value == "" || document.forms[0].password2.value == "" ){
		alert("<%=plzEntONPwd_A%>");
		clearPasswordFields()
		document.returnValue = false;
		return false;
	}else{
		document.returnValue = true;
	}
	confirmNewpasswd();
	
}








function setValidForEqual()
{
	oldpasswd = document.forms[0].elements['oldpasswd'].value;
	passwd1   = document.forms[0].elements['password1'].value;
	if(oldpasswd=="")
	{
		alert("Please enter Old Password");
		document.forms[0].elements['oldpasswd'].value="";
		document.forms[0].elements['oldpasswd'].focus();
		return;
	}
	else if (oldpasswd == passwd1)
	{
		alert("Old password and New password should not be same");
		document.forms[0].elements['password1'].value="";
		document.forms[0].elements['password1'].focus();
	}	

}

function confirmNewpasswd()
{
	passwd1   = document.forms[0].elements['password1'].value;
	passwd2   = document.forms[0].elements['password2'].value;	
	
	if (passwd1 != passwd2)
	{
		alert("New password and Confirm password should be same");
		document.forms[0].elements['password2'].select();
		document.forms[0].elements['password2'].focus();
		document.returnValue = false;
		return false;
	}
	else
	{
            if(document.password.onceSubmit.value!=1)
            {
            
   		 document.password.onceSubmit.value=1
  		 document.body.style.cursor="wait"
		 document.password.submit();
		 document.returnValue = true;
             }
	}
}

function setAction()
{
	document.forms[0].action = "../SelfService/ezPassword.jsp";
	document.forms[0].submit();
}
function gotoHome()
{
	<% if (str == null){ %>
		document.location.href="../Misc/ezWelcome.jsp";
	<%}else{%>
		top.document.location.href="../Misc/ezDisclamerframeset.jsp";
	<%}%>
}

function fieldFocus()
{
	errorFlag = document.forms[0].elements['ErrFlag'].value;	
	if (errorFlag == "E" )
	{
		alert("<%=wrongPWD_A%>");
		document.forms[0].elements['oldpasswd'].focus();
	}
	else
	{
		if (errorFlag == "W") 
		{
			document.forms[0].elements['oldpasswd'].focus();
		}
		else 
		{
			document.forms[0].elements['password1'].focus();
		}
	}
}
function Continue()
{
top.document.location.href="../Misc/ezSelectSoldToFrameset.jsp";
}

</SCRIPT>
</head>

<body onLoad="fieldFocus()" scroll=no>
<form method="post" action="../SelfService/ezSavePassword.jsp" name="password">
<%
	
	if (str!=null){
		out.println("<input type=hidden name=Flag value=X>");
	}
%>

<%
	String display_header = changePwd_L;
	
%>	
  
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<br>
<div align="center">
<br>
<TABLE align=center style="background:#ffffff;BORDER-RIGHT: #4374a6 1px solid; BORDER-TOP: #4374a6 1px solid; BORDER-LEFT: #4374a6 1px solid; BORDER-BOTTOM: #4374a6 1px solid" cellSpacing=0 cellPadding=0 width="80%"  height=65% border=0>
   <TR>
   	<TD  style="background:#ffffff" width="40%" align=center valign=middle>
   		<img src="../../Images/Others/chgpassNew.JPG">
   
   	</TD>
   	<TD style="background:#ffffff" width="60%" align=left valign=middle>
   		<Table height=100% width="100%" border="0" cellspacing="0" cellpadding="0">
   		<Tr>
   			<Td  style="background:#ffffff" align=center  width=100%>
   				<Table id="header" width="80%" border="0" cellspacing="0" cellpadding="0">
   					<Tr class=trclass>
   						<Td style="background:#ffffff" colspan=2 width=100%><font color="#FF0000" size=1>
   						<ul>
   							<li><nobr>Password cannot be same as your userid </nobr></li>
   							<li><nobr>Password Length should be 6-20 Characters</nobr></li>
   							<li><nobr>Password should be Alpha Numeric</nobr></li>
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
   				<th width="45%" align="left"><%=oldPwd_L%></th>
   				<td valign="top" width="55%"> 
   				  <input type="password" class=InputBox name="oldpasswd" size="10" maxlength="20" style="width:100%"  onChange="setAction()" value="<%=mypwd%>" >
   				</td>
   			      </tr>
   			      <tr> 
   				<th width="45%" align="left"><%=newPwd_L%></th>
   				<td width="55%" valign="top"> 
   				  <input type="password" class=InputBox name="password1" size="10" maxlength="20" style="width:100%" onBlur="setValidForEqual()">
   				</td>
   			      </tr>
   			      <tr> 
   				<th width="45%" align="left"><%=confPwd_L%></th>
   				<td width="55%" valign="top"> 
   				  <input type="password" class=InputBox name="password2" size="10" style="width:100%" maxlength="20">
   				</td>
   			      </tr>
   			    </table>
   			   </td> 
   		</tr>
   		</table>
   	</td>
   </table>		

  <br><br>
	<Table  align="center">
	<Tr><Td class="blankcell" align="center">
	
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		if("X".equals(str))
		{
		buttonName.add("Continue");
		buttonMethod.add("Continue()");
		}
		
		buttonName.add("Save");
		buttonMethod.add("VerifyEmptyFields()");
		
		/*buttonName.add("Back");
		buttonMethod.add("gotoHome()");*/
		
		out.println(getButtonStr(buttonName,buttonMethod));
%>

	</Td></TR>
	</Table>
	<input type="hidden" name="onceSubmit" value=0>
	<input type="hidden" name="ErrFlag" size="5" value="<%=error%>">
    </form>

</div>
<Div id="MenuSol"></Div>
</body>
</html>
