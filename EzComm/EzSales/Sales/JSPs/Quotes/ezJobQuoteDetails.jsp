<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">



<title>Job Quote Details</title>
<link rel="icon" href="../../Library/images/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="../../Library/images/favicon.ico" type="image/x-icon"> 
<!--[if lt IE 7]>
<script type="text/javascript">
//<![CDATA[
    var BLANK_URL = 'https://www.americanstandard.com/js/blank.html';
    var BLANK_IMG = 'https://www.americanstandard.com/js/spacer.gif';
//]]>
</script>
<![endif]-->
<!-- **** FONTS **** -->
<script type="text/javascript">
BASE_URL = 'http://www.americanstandard.com/';
SKIN_URL = 'http://www.americanstandard.com/skin/frontend/1/2/';
</script>
<style type="text/css">.tk-proxima-nova{font-family:"proxima-nova",sans-serif;}</style>
<!--<link href="../../Styles/css" rel="stylesheet" type="text/css">-->
<!-- **** END FONTS **** -->
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style0.css">
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style1.css" media="screen">
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style2.css" media="print">
<!-- <script type="text/javascript" src="../../Library/Script/prototype17.js"></script> -->
<script type="text/javascript" src="../../Library/Script/sizzle.js"></script>
<!-- <script type="text/javascript" src="../../Library/Script/validation.js"></script> -->
<!-- <script type="text/javascript" src="../../Library/Script/scriptaculous.js"></script> -->
<!-- <script type="text/javascript" src="../../Library/Script/jscript1-5.js"></script> -->
<!-- <script type="text/javascript" src="../../Library/Script/effects.js"></script> -->

<!-- <script type="text/javascript" src="../../Library/Script/controls.js"></script> -->
<script type="text/javascript" src="../../Library/Script/selectivizr102.js"></script>
<script type="text/javascript" src="../../Library/Script/contentloaded.js"></script>
<script type="text/javascript" src="../../Library/Script/modernizr.js"></script>
<script type="text/javascript" src="../../Library/Script/jscript1-11.js"></script>
<script type="text/javascript" src="../../Library/Script/jscript1-12.js"></script> 
<script type="text/javascript" src="../../Library/Script/uniformjs175.js"></script>
<!-- <script type="text/javascript" src="../../Library/Script/jscript1-14.js"></script>
<script type="text/javascript" src="../../Library/Script/jscript1-15.js"></script> -->
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<Script src="../../Library/Script/popup.js"></Script> 
<!--[if lt IE 7]>
<script type="text/javascript" src="../../Library/Script/magentojscript-rbsitelink.js"></script>
<![endif]-->
</script>
</head>
<body class=" customer-account-index"><div style="visibility: hidden; height: 1px; width: 1px; position: absolute; z-index: 100000; " id="_atssh">
</div>
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
<% ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
    if(userAuth_R.containsKey("VIEW_QUOTATION")) {
 %>   
 <%@ include file="../Quotes/ezSalesQuoteDetails.jsp"%> 
 <% } else { request.setAttribute("authKey","VIEW_QUOTATION"); %>
 <%@ include file="../Misc/ezNoAuthorization.jsp"%> 
 <% } %>

<%@ include file="../Misc/ezFooter.jsp"%>
</div>
</div>
</body>
</html>