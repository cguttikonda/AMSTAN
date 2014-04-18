<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
 <Title>ezPassword</Title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
  <script src="../../Library/JavaScript/CheckFormFields.js"></script>
  <script src="../../Library/JavaScript/User/ezPassword.js"></script>
  </head>
  <body onLoad="document.myForm.oldpassword.focus()">      
<form name=myForm method=post action="" onSubmit="return submitForm()">
  <br>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
  <Tr align="center">
    <Td height="12" class="displayheader">Change Password</Td>
  </Tr>
</Table>
 <Table  border=1 align = center width=50%  borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
      <Tr> 
        <Td width="46%" align="right" valign="middle" class="labelcell">Old Password:*</Td>
        <Td valign="top" width="54%"> 
        <input type = "password" Class = "InputBox"  name="oldpassword"  size="25" maxlength="10">
        </Td>
      </Tr>
      <Tr> 
       <Td width="46%" align="right" valign="middle" class="labelcell">New Password:*</Td>
        <Td width="54%" valign="top"> 
        <input type = "password" Class = "InputBox"  name="newpassword"   size="25" maxlength="10">
        </Td>
      </Tr>
      <Tr > 
        <Td width="46%" align="right" valign="middle" class="labelcell">Confirm Password*:</Td>
        <Td width="54%" valign="top"> 
          <input type = "password" Class = "InputBox"  name="confirmpassword"   size="25" maxlength="10">
        </Td>
      </Tr>
    </Table><br>

    <center>
       <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Update">
       <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
       <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

   </center>
   </body>
  </html>
  
