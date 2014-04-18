<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iPassword_Lables.jsp" %>
<%
	String str=request.getParameter("Flag");
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
	function gotoHome()
	{
		<% if (str==null){ %>
			document.location.replace("../Misc/ezWelcome.jsp");
		<%}else{%>
			top.document.location.replace("../Misc/ezSelectSoldToFrameset.jsp");
		<%}%>
	}
</script>
</head>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>



<%
EzcUserParams preParams= new EzcUserParams();
EzcUserNKParams preNKParams = new EzcUserNKParams();

String mypwd = request.getParameter("oldpasswd");
preNKParams.setPassword(mypwd);
preParams.setObject(preNKParams);

if ((!(mypwd == null))) {
	Session.prepareParams(preParams);
	boolean ret = UserManager.validateUserPassword(preParams);
	//boolean ret = AdminObject.validateUserPassword(servlet, mypwd);
	if (ret) {
		String newpwd = request.getParameter("password1");
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

	if (str!=null){
		ezc.ezshipment.client.EzShipmentManager shipManager= new ezc.ezshipment.client.EzShipmentManager();
		EzcUserParams newParams = new EzcUserParams();
		EzcUserParams uparams= new EzcUserParams();
		uparams.setUserId(Session.getUserId());
		newParams.setObject(uparams);
		Session.prepareParams(newParams);
		shipManager.ezPutDisclaimerStamp(newParams);
}
%>
<body><br><br><br><br><br>
<Table  align=center >
<Tr><Td align=center class=displayalert>

<%=urPwdSucc_L%>
</Td></Tr></Table>
<br><br>
<Table align="center">
<Tr><Td align=center class="blankcell">
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		
		/*buttonName.add("Ok");
		buttonMethod.add("gotoHome()");*/
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</Td></Tr></Table>
<Div id="MenuSol"></Div>
</body>
</html>
