<!DOCTYPE html>
<head>
<title>American Standards Brands Business Portal</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="description" content="Default Description">
<meta name="keywords" content="EzCommerce">
<meta name="robots" content="INDEX,FOLLOW">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
<script type="text/javascript" src="../../../../../DD_roundies.js"></script>
	<script type="text/javascript">
	  DD_roundies.addRule('.roundify', '8px');
	</script>
<![endif]-->
<link rel="icon" href="../../Library/images/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="../../Library/images/favicon.ico" type="image/x-icon"> 

<link rel="stylesheet" type="text/css" href="../../Library/Styles/style0.css"> 
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style1.css" media="all">
<link rel="stylesheet" type="text/css" href="../../Library/Styles/fallr.css"> 
<!--<link rel="stylesheet" type="text/css" href="../../Library/Styles/style2.css" media="print">-->

<!--[if lt IE 7]> 
<script type="text/javascript">
//<![CDATA[ 
    var BLANK_URL = 'https://www.americanstandard.com/js/blank.html';
    var BLANK_IMG = 'https://www.americanstandard.com/js/spacer.gif';    
//]]> 
</script>
<![endif]-->

<!--[if lt IE 8]>
<script defer type="text/javascript" src="../../Library/Styles/pngfix.js"></script>

<![endif]-->
<!-- pngfix - Vimal-->

<!-- **** FONTS **** -->

<!-- <script type="text/javascript" src="EzComm/EzSales/Sales/Library/Script/jquery.js"></script>
<script type="text/javascript" src="../../Library/Script/jqueryeasing.js"></script>
<script type="text/javascript" src="../../Library/Script/jqueryfallr.js"></script>

<script type="text/javascript">
	     //<![CDATA[

	    $(document).ready(function(){
	        
	        var methods = {	        
	            
	            effect : function(){
	                $.fallr('show', {
	                    buttons : {},
	                    duration    : 1000,
                        easingIn    : 'easeOutBounce',
                        easingOut   : 'easeInElastic',
                        icon        : 'info',
                        position    : 'center',
                        height	    : '150px',
	                    content     : '<p><img src="ezLoginAS/ajax-loader.gif"></p><h4>Loading</h4><p>Please wait!</p>'
	                });
	            }
	        };
	        
	        
	        
            $('#login').click(function(e){
                var id = "effect";
                methods[id].apply(this,[this]);
                return false;
            });
	    });

	    //]]>
	</script> -->

<script type="text/javascript">

$.getJSON("http://jsonip.appspot.com?callback=?",function (data) 
{ 
	//alert(data.ip);
	//document.myFavForm.ipaddr.value=data.ip;	
});
 
BASE_URL = 'http://www.myasb2b.com/';
SKIN_URL = 'http://www.myasb2b/skin/';
</script>
<!-- **** END FONTS **** -->
<title>American Standards Brands Business Portal</title>
<link rel="icon" href="ezLoginAS/favicon.ico" type="image/x-icon">
<script type="text/javascript" src="http://remysharp.com/downloads/html5.js"></script>
<script type="text/javascript" src="//use.typekit.net/mwb2rov.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>
<Script src="ezLoginAS/popup.js" type="text/javascript"></Script> 
<%

	String offlineReq = request.getParameter("OFFLINE");
	String webOrNo = request.getParameter("webOrNo");
	String soldTo  = request.getParameter("soldTo");
	String sysKey  = request.getParameter("sysKey");
	String docStat = request.getParameter("docStatus");
	String urlLink = request.getParameter("urlLink");

	String salesOrder = request.getParameter("salesOrder");
	String shipTo = request.getParameter("shipTo");

	ezc.ezcommon.EzLog4j.log(">>>>>>>offlineReq in LOGIN >>>>>>>>>>>>>>>>>>>>>"+offlineReq,"D");
	/*ezc.ezcommon.EzLog4j.log(">>>>>>>webOrNo in LOGIN >>>>>>>>>>>>>>>>>>>>>"+webOrNo,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>soldTo in LOGIN >>>>>>>>>>>>>>>>>>>>>"+soldTo,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>sysKey in LOGIN >>>>>>>>>>>>>>>>>>>>>"+sysKey,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>docStat in LOGIN >>>>>>>>>>>>>>>>>>>>>"+docStat,"D");*/
	
%>
<script type="text/javascript">
	function checkFields()
	{
		if((document.loginform.username.value=='')||(document.loginform.password.value== ''))
		{
			if(document.loginform.username.value=='')
			{
				alert("Enter UserID");
				document.loginform.username.focus();
				return false;
			}
			if(document.loginform.password.value== '')
			{
				alert("Enter Password");
				document.loginform.password.focus();
				return false;
			}
		}
		return true;
	}
	function wait_animation()
	{
		document.getElementById("loading_image").style.visibility='visible'
	}
	
	function funSubmit()
	{
		if(checkFields())
		{
			var userName=document.loginform.username.value
			var userPass=document.loginform.password.value
			
			Popup.showModal('modal1');
			//window.parent.location.href="../EzCommerce/EzCommon/JSPs/ezApplicationAreas.jsp?username="+userName+"&password="+userPass
			//document.loginform.action="EzCommerce/EzCommon/JSPs/ezApplicationAreas.jsp?username="+userName+"&password="+userPass+"&offlineReq=<%=offlineReq%>&webOrNo=<%=webOrNo%>&soldTo=<%=soldTo%>&sysKey=<%=sysKey%>&docStat=<%=docStat%>";
			document.loginform.action="EzCommerce/EzCommon/JSPs/ezApplicationAreas.jsp";
			document.loginform.target="_top"
			document.loginform.submit()
			//return true;
		}
		
	}
	function KeySubmit()
	{
		if (event.keyCode==13)
			funSubmit()
	}         
	function browserCheck()
	{
		window.open("EzCommerce/EzCommon/JSPs/ezBrowserCheck.jsp","BrowserCheck","resizable=no,left=0,top=10,height=600,width=800,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes");
	}
</script>
</head>
<body onLoad="document.loginform.username.focus();" class=" catalog-category-view">
<script type="text/javascript"  src="CFInstall.js"></script>
	<style>
	/* 
	CSS rules to use for styling the overlay:
	.chromeFrameOverlayContent
	.chromeFrameOverlayContent iframe
	.chromeFrameOverlayCloseBar
	.chromeFrameOverlayUnderlay
	*/
	</style> 
	<script>
	// You may want to place these lines inside an onload handler
	CFInstall.check({
	mode: "overlay",
	destination: "http://answerthink.americanstandard.com"
	});
	</script>
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
<div class="header">
<header>
<form name="myFavForm" method="post">
	<input type=hidden name='ipaddr' value=''>
	<a href="ezLogin.jsp" title="American Standard" class="logo">
	<img src="../../../../../logorevised.png" alt="American Standard" height="55px" width="237px">
	</a><!--Images/amstd_logo.bmp-->
</form>
</header>
</div>
<%@ include file="ezInnerHelp.jsp"%>
<%@ include file="ezLoginfooter.jsp"%>
</div>
</div>
</body>
</html>  