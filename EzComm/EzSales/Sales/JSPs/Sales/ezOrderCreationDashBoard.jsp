<!DOCTYPE html>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<html lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>Order Dashboard</title>

<meta name="description" content="Default Description">
<meta name="robots" content="INDEX,FOLLOW">
<link rel="icon" href="../../Library/images/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="../../Library/images/favicon.ico" type="image/x-icon">


<style type="text/css">.tk-proxima-nova{font-family:"proxima-nova",sans-serif;}</style>


<!-- **** END FONTS **** -->


<link rel="stylesheet" type="text/css" href="../../Library/Styles/style1.css" media="all">

</head>
<body class=" customer-account-index">
<input type="hidden" name="fromPage" value="<%=request.getParameter("fromPage")%>" >
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
<%@ include file="../Sales/ezOrderCreationDashBoardBody.jsp"%>      
<%@ include file="../Misc/ezFooter.jsp"%>
</div>
</div>

</body>
</html>
