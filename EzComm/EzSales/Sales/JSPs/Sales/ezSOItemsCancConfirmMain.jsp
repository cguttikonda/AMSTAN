<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Cancel / Return</title>
<%@ include file="../../../Includes/Lib/ezCommonHead.jsp"%></head>
<body class=" customer-account-index">
<div class="wrapper container" id="top-of-page">
	<noscript>
        &lt;div class="noscript"&gt;
            &lt;div class="noscript-inner"&gt;
                &lt;p&gt;&lt;strong&gt;JavaScript seem to be disabled in your browser.&lt;/strong&gt;&lt;/p&gt;
                &lt;p&gt;You must have JavaScript enabled in your browser to utilize the functionality of this website.&lt;/p&gt;
            &lt;/div&gt;
        &lt;/div&gt;
	</noscript>
<div class="page">
<%@ include file="../../../Includes/JSPs/Misc/iWelcomeAlerts.jsp"%> 
<%@ include file="../Misc/ezHeader.jsp"%> 
<%@ include file="../Misc/ezMenu.jsp"%>  
<% 
	String cancOrRGA = request.getParameter("cancOrRGA");
	String authToCheck = "SO_CANCEL";
	if (cancOrRGA.equals("RGA"))
		authToCheck = "SO_RETURN_CREATE";
	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
	if(userAuth_R.containsKey(authToCheck)) {
%>   
<%@ include file="ezSOItemsCancConfirm.jsp"%> 
<% 	} else { request.setAttribute("authKey",authToCheck); %>
<%@ include file="../Misc/ezNoAuthorization.jsp"%> 
<% 	} %>
<%@ include file="../Misc/ezFooter.jsp"%> 
</div>
</div>   
</body>
</html>  