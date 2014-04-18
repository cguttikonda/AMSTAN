<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/JSPs/Misc/iPreWelcome.jsp"%> 
<%@ include file="../../../Includes/JSPs/Misc/iAddWebStats.jsp"%>
<%
	//Call the Welcome Page
	session.putValue("welcome","1");
	String browser = request.getParameter("chkBrowser");
	if(browser!=null)
		session.putValue("BROWSER",browser);
	
	
	/*if(!"127.0.0.1".equals(request.getRemoteAddr())){
		response.sendRedirect("ezMain.jsp");
	}else{*/
		response.sendRedirect("ezPortalWelcome.jsp"); 
	//}
%>

</head>
<body>

<form name=ezHelpForm>  
	<input type=hidden name=ezHelpKeyword value="ezPageHelp">
</form>

<Div id="MenuSol"></Div>   
</body>
</html>
