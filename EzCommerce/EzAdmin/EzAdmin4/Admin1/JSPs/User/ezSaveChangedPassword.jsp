<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/iEzMain.jsp" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body>

<form name=myForm method=post action="ezChangePassword.jsp">

<%
  String oldpwd=request.getParameter("oldpassword");
  String newpwd=request.getParameter("newpassword");
  
  //check whether user entered old password is correct or not
  EzcUserParams uparams= new EzcUserParams();
  EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
  ezcUserNKParams.setPassword(oldpwd);
  uparams.createContainer();
  uparams.setObject(ezcUserNKParams);
  Session.prepareParams(uparams);
  boolean isValid = UserManager.validateUserPassword(uparams);
 
 //if user entered  wrong old password
 
  if(!isValid)
  {
  %>
  <br><br><br><br>
  <center>
   <span class=nolabelcell>
     Your old password is invalid please try agian<br>
    <input type="image" src="../../Images/Buttons/ok1.gif"  alt="Ok">  
    
 <%
   }
   else //if old password is correct
   {
        //update user password to new one
        ezcUserNKParams.setPassword(newpwd);
        uparams.createContainer();
        boolean result_flag = uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);
	UserManager.changeLoginUserPassword(uparams);
    
 %>
 <br><br><br><br>
 <center>
  <span class=nolabelcell>
     Your Password has been changed successfully!!<br>
     From next login onwards you can use your new password.
  </span>
 </center>   

<%
  }
%>

</body>
</html>
  

  
