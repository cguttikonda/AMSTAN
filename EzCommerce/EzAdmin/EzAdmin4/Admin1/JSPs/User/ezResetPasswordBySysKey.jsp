<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iResetPasswordBySysKey.jsp"%>
<%
	String userName = request.getParameter("userName");
%>
<html>
<head>
<script Language = "JavaScript" src="../../Library/JavaScript/User/ezResetPasswordBySysKey.js"></script>
<script Language = "JavaScript" src="../../Library/JavaScript/CheckFormFields.js"></script>
<%
String userType = null;
String userValue =null;
%>
<Title>Reset Password</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="document.myForm.password1.focus()">

<form name=myForm method=post action="ezSaveResetPassword.jsp" onSubmit="VerifyEmptyFields(); return document.returnValue">


<%
    if(ret.getRowCount()==0)
     {
%>
   <br><br><br>
    <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
     <Td class="displayheader">
      <div align="center">No <%=areaLabel%> To List Users</div>
    </Td>
     </Tr></Table>
     <center>
       <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

     </center>
	<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type ="hidden" name="flag" value="1">

<%
      return;
    }

%>
<br>
	  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Td class="displayheader">Reset Password</Td>
	  </Tr>
	</Table>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">
<!--
	<Th width="20%" class="labelcell">
        <div align="right"><%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:
        </div>
      </Th>
<Td width="20%">
<%
		String wsk=null;
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
			{

				wsk=ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);

			}
		}
%>
	<%=wsk%>
</Td>
-->
      	<Th width="15%" class="blankcell">User ID:</Th>
      	<Td width="15%"><%=bus_user%></Td>
      	<Th width="15%" class="blankcell">User Name:</Th>
      	<Td width="55%"><%=userName%></Td>	
	</Tr></Table>
<%
  if(bus_user==null || "null".equals(bus_user))
   {

%>
     <input type="hidden" name="Area" value="<%=areaFlag%>">
     <br>
     <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
     <Tr>
     <Td class = "labelcell">
       <div align="center"><b>No User Present Under This <%=areaLabel.substring(0,areaLabel.length()-1)%></b></div>
     </Td>
    </Tr>
  </Table>
<%
         return;
  }
%>

  <%
  	if(websyskey!=null && !"sel".equals(websyskey) )
  	{
  		if( !"sel".equals(bus_user))
  		{

  %>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
		<Th colspan = 2>
		Please enter the new password:
		</Th>
		</Tr>
	    <Tr>
	      <Td width="44%" align="right" valign="middle" class="labelcell">New Password:*</Td>
	      <Td width="56%" valign="top">
		<input type="password" class = "InputBox" name="password1" size="10" maxlength="10">
		</Td>
	    </Tr>
	    <Tr>
	      <Td width="44%" align="right"  valign="middle" class="labelcell">Confirm
		Password:*</Td>
	      <Td width="56%" valign="top">
		<input type="password"  class = "InputBox" name="password2" size="10" maxlength="10">
		</Td>
	    </Tr>
	    <input type="hidden" name="ErrFlag" size="5" value="<%=error%>">
	  </Table>
	  <br>
	<div id="buttons" align = center>
	    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Reset">
	    <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();document.myForm.password1.focus()" ></a>
	   <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	  </div>
     <script>
       document.myForm.password1.focus()
     </script>

<%
      }
 	else
	{
%>
		<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Please Select User to continue.</b></div>
				</Td>
			</Tr>
		</Table><br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
		}
	}
	else
	{
%>
		<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and User to continue.</b></div>
				</Td>
			</Tr>
		</Table><br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
	}
%>
	<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type=hidden name=BusUser value="<%=bus_user%>">
	</form>
</body>
</html>