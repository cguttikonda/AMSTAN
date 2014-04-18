<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->

<title>Welcome to American Standards web portal</title>

<meta name="description" content="Default Description">
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
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style1.css" media="all">
<!--<link rel="stylesheet" type="text/css" href="../../Library/Styles/style2.css" media="print">-->

<!--[if lt IE 7]>
<script type="text/javascript" src="../../Library/Script/magentojscript-rbsitelink.js"></script>
<![endif]-->

<script type="text/javascript">
//<![CDATA[
Mage.Cookies.path     = '/';
Mage.Cookies.domain   = '.americanstandard.com';
//]]>
</script>
<script type="text/javascript">
//<![CDATA[
optionalZipCountries = [];
//]]>
</script>

<script type="text/javascript">var Translator = new Translate({"Please enter a valid email address. For example johndoe@domain.com.":"Please enter a valid e-mail address.","Please use only letters (a-z or A-Z), numbers (0-9) or underscore(_) in this field, first character should be a letter.":"Please use only letters (a-z or A-Z), numbers (0-9) or underscores (_) in this field, first character must be a letter."});</script>
<script type="text/javascript" async="" src="../../Library/Script/ga.js"></script>
<Script src="../../Library/Script/popup.js"></Script>
</head>
<%@ include file="../../../Includes/JSPs/Misc/iWelcomeAlerts.jsp"%>
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

<%@ include file="../Misc/ezHeader.jsp"%>
<%@ include file="../Misc/ezMenu.jsp"%>
<%@ include file="ezChangePasswordBySysKeyBody.jsp"%>
<%@ include file="../Misc/ezFooter.jsp"%>
</div>
</div>

</body>
</html>