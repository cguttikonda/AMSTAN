
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<html>
<head>
<title>ezPassword</title>
 <%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<SCRIPT language="JavaScript">

function funSubmit()
{
	if(document.myForm.userid.value == "")
	{
		alert("Please Enter User Id");
		document.myForm.userid.focus();
	}
	else
	{
		document.myForm.action="ezUnLockPassword.jsp";
		document.myForm.submit();
	}	
}

function funBack()
{
	document.myForm.action="../Config/ezListSystems.jsp";
	document.myForm.submit();
}
</SCRIPT>
</head>

<body  scroll=no onLoad="document.myForm.userid.focus()">
<form method="post" name="myForm" >


<%
	String PwdFlg = request.getParameter("PwdFlg");
%>

<input type="hidden" name="PwdFlg"  value="<%=PwdFlg%>" >

<br>
<div align="center">
<br><br>

    <table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="40%">
    <tr>
    	<th align="center" valign="middle" colspan=2>
<%    
	if("L".equals(PwdFlg))	
	{
%>    	
		Lock the User
<%
	}
	else
	{
%>
		Unlock the User

<%
	}
%>
    	 </th>   
    </tr>    
      <tr >
        <th align="right" valign="middle">Enter User Id</th>
        <td valign="top">
          <input type="text" class=InputBox name="userid" size="15" value="" maxlength=10>
        </td>
      </tr>
      </Table>
      
      <br><br><br><br>
      
      
      
      <Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
          <tr>
          	<td align="center" valign="middle" colspan=2><Font size=3>
<%    
      	if("L".equals(PwdFlg))	
      	{
%>    	
      		Please enter the User Id to Lock the Password.
<%
      	}
      	else
      	{
%>
      		Please enter the User Id to  Unlock the Password.
      
<%
      	}
%>
		</Font>	
          	 </td>   
          </tr>    
      </Table>
      
      
      
      
      
      
      
       <br><br><br><br>
	<Table  align="center">
	<Tr><Td class="blankcell" align="center">
    	<a href="JavaScript:funSubmit()" style="text-decoration:none;"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border="none"   title="Click to Unlock" alt="Click to Unlock"  ></a>
	<a href="JavaScript:funBack()"  style="text-decoration:none;"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border="none"  style="cursor:hand"   valign=center  title="Go to Back" alt="Go to Back"></a>
	</Td></TR>
	</Table>
</div>
</form>
</body>
</html>
