<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>


<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1">
<div class="page-title">

	
<%
EzcUserParams preParams= new EzcUserParams();
EzcUserNKParams preNKParams = new EzcUserNKParams();

String mypwd = request.getParameter("oldPassword");
preNKParams.setPassword(mypwd);
preParams.setObject(preNKParams);

if ((!(mypwd == null))) {
	Session.prepareParams(preParams);
	boolean ret = UserManager.validateUserPassword(preParams);
	//boolean ret = AdminObject.validateUserPassword(servlet, mypwd);
	if (ret) {
		String newpwd = request.getParameter("newPassword");
		preNKParams.setPassword(newpwd);
		//boolean result_flag = uparams.setObject(ezcUserNKParams);

            EzcUserParams postParams = new EzcUserParams();
            EzcUserNKParams postNKParams = new EzcUserNKParams();
            postNKParams.setPassword(newpwd);
            postParams.setObject(postNKParams);
		Session.prepareParams(postParams); 
		UserManager.changeLoginUserPassword(postParams);

		//AdminObject.changeLoginUserPassword(servlet, newpwd);
  	}//End if	
}//End if

	
%>

<h2>Password Change is successfull</h2> 	

</div>


  <div class="buttons-set form-buttons">
        <p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go Home</a></p>
    </div>
	

<div class="col1-set">
<div class="info-box">


	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->