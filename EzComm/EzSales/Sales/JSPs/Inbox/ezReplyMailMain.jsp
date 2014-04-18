<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%
	
	String content = "<Table align=center leftMargin=5 topMargin=0 marginwidth=5 marginheight=0><Tr><Td align=center><textarea  cols=110 rows=25 readonly=readonly >YOU EXPRESSLY AGREE THAT THE USE OF THIS SITE IS AT YOUR OWN RISK. YOU (AND NOT ECOMMERCE ORGANIZATION) ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION. YOU EXPRESSLY AGREE THAT NEITHER ECOMMERCE OPTIMIZATION, NOR ITS AFFILIATED OR RELATED ENTITIES,YOU EXPRESSLY AGREE THAT THE USE OF THIS SITE IS AT YOUR OWN RISK. YOU (AND NOT ECOMMERCE OPTIMIZATION) ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION. YOU EXPRESSLY AGREE THAT NEITHER ECOMMERCE OPTIMIZATION, NOR ITS AFFILIATED OR RELATED ENTITIES,NOR ANY OF THEIR RESPECTIVE EMPLOYEES, OR AGENTS, NOR ANY PERSON OR ENTITY INVOLVED IN THE CREATION, PRODUCTION, AND DISTRIBUTION OF THIS WEB SITE ARE RESPONSIBLE OR LIABLE TO ANY PERSON OR ENTITY WHATSOEVER FOR ANY LOSS, DAMAGE (WHETHER ACTUAL, CONSEQUENTIAL, PUNITIVE OR OTHERWISE), INJURY, CLAIM, LIABILITY OR OTHER CAUSE OF ANY KIND OR CHARACTER WHATSOEVER BASED UPON OR RESULTING FROM THE USE OF THIS SITE OR ANY OTHER ECOMMERCE OPTIMIZATION OWNED SITE. ECOMMERCE OPTIMIZATION WILL NOT BE LIABLE FOR ANY DAMAGES OF ANY KIND ARISING FROM THE USE OF THIS SITE, INCLUDING, BUT NOT LIMITED TO DIRECT, INDIRECT, INCIDENTAL, PUNITIVE, AND CONSEQUENTIAL DAMAGES. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT ECOMMERCE OPTIMIZATION IS NOT LIABLE OR RESPONSIBLE FOR ANY DEFAMATORY, OFFENSIVE OR ILLEGAL CONDUCT OF OTHER SUBSCRIBERS OR THIRD PARTIES. All Rights Reserved</textarea></td></tr></table>";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" async="true" src="../../Library/Script/plusone.js" gapi_processed="true"></script>

<title>Reply to Personal Message</title>

<meta name="description" content="Default Description">
<meta name="keywords" content="Magento, Varien, E-commerce">
<meta name="robots" content="INDEX,FOLLOW">
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
<script type="text/javascript">
// Black overlay element
var darkbox;
// Content box
var content;

// FUNCTIONS
function init(disFlag)
{
   // Set "onScroll" event handler

   window.onscroll = scroll_box;
   if(disFlag=='N')
   {
   	open()
   }   	
}

function open()
{
   // Create elements
   darkbox = document.createElement('div');
   content = document.createElement('div');

   // Style them with the existing ids
   darkbox.id = 'darkbox';
   content.id = 'content';

   // FILL CONTENT BOX

   // Have the close button
   
   // The main content

    //content.innerHTML = '<a style="position: absolute; top: 133px; left: 70px; text-decoration: none;" href="javascript:close();"><input type="button" name="Close" value="Close"></a>';
      // The main content
   
   content.innerHTML = '<div id="main_content"><h1><font size=3px align=center>Disclaimer</font></h1><p><%=content%></p><input type="button" name="OK" value="I Agree" onClick="agree()">&nbsp;&nbsp;&nbsp;<a  href="javascript:close();"><input type="button" name="Close" value="Disagree"></a>';
   // Add these elements to the body

   document.body.appendChild(darkbox);
   document.body.appendChild(content);

   // Calciulate coordinates and such
   var pos_top = document.documentElement.scrollTop
   var pos_left = document.documentElement.scrollLeft;
   var screen_width = document.documentElement.clientWidth;
   var screen_height = document.documentElement.clientHeight;

   // Place the "darkbox" element and give it the size

   darkbox.style.top = pos_top + 'px';
   darkbox.style.left = pos_left + 'px';
   darkbox.style.height = screen_height + 'px';
   darkbox.style.width = screen_width + 'px';

   // Now place the content box at the center
   content.style.left = (pos_left + (screen_width / 2.0) - (content.offsetWidth / 2.0)) + 'px';
   content.style.top = (pos_top + (screen_height / 2.0) - (content.offsetHeight / 2.0)) + 'px';
}
function agree()
{
	document.body.removeChild(darkbox);
   	document.body.removeChild(content);
}

function scroll_box ()
{
   // If "Darkbox" open
   if(darkbox != null)
   {
      // Find new topmost, leftmost position w.r.t the current viewport
      // Also find new window size

      var pos_top = document.documentElement.scrollTop
      var pos_left = document.documentElement.scrollLeft;
      var screen_width = document.documentElement.clientWidth;
      var screen_height = document.documentElement.clientHeight;

      // Positions elements accordingly
      darkbox.style.top = pos_top + 'px';
      darkbox.style.left = pos_left + 'px';
      darkbox.style.height = screen_height + 'px';
      darkbox.style.width = screen_width + 'px';

      content.style.left = (pos_left + (screen_width / 2.0) - (content.offsetWidth / 2.0)) + 'px';
      content.style.top = (pos_top + (screen_height / 2.0) - (content.offsetHeight / 2.0)) + 'px';
   }
}


function close()
{
   // Delete elements
   document.myForm.action="../Misc/ezLogout.jsp"
   document.myForm.submit();
   
}
</script>

<style>
#darkbox {
   position: absolute;
   top: 0px;
   left: 0px;
   opacity: 0.6;
   filter:alpha(opacity=60);
   background: #000;
}

#content {
   position: absolute;
   z-index: 1001;
   background: #fff;
   border: 10px solid #FFF;
   width: 500px;
   height: 300px;
}
#content #main_content {
   overflow: auto;
   width: 500px;
   height: 300px;
}

</style>

<style type="text/css">.tk-proxima-nova{font-family:"proxima-nova",sans-serif;}</style>

<!--<link href="../../Styles/css" rel="stylesheet" type="text/css">-->

<!-- **** END FONTS **** -->

<link rel="stylesheet" type="text/css" href="../../Library/Styles/style0.css">
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style1.css" media="all">
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style2.css" media="print">

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

</head>

<body class=" customer-account-index">
<div style="visibility: hidden; height: 1px; width: 1px; position: absolute; z-index: 100000; " id="_atssh">
<iframe id="_atssh888" title="AddThis utility frame" style="height: 1px; width: 1px; position: absolute; z-index: 100000; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; border-image: initial; left: 0px; top: 0px; " src="../../Library/Script/sh72.htm"></iframe></div>
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
<%
	String helpKey	="EZREPLYMAILMAIN";
%>
<%@ include file="../Misc/ezHeader.jsp"%>
<%@ include file="../Misc/ezMenu.jsp"%>
<%@ include file="ezReplyPersMsg.jsp"%>
<%@ include file="../Misc/ezFooter.jsp"%>

</div>
</div>
</body>
</html>