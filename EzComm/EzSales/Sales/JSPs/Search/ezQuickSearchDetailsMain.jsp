<%
	long start = System.currentTimeMillis();
%>
 <%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
 <%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
 <%
 	String search_Type    = request.getParameter("SearchType");
 	String searchPattern = request.getParameter("searchPatern");
 	//out.println("searchType:::::::::::::::"+searchType+"::::searchPattern:::::"+searchPattern);
 
 %>
 
 
 <!DOCTYPE html>
 <html lang="en">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
 <script type="text/javascript" async="true" src="../../Library/Script/plusone.js" gapi_processed="true"></script>
 
 <title>PO Adv Search Result</title>
 
 <meta name="description" content="Default Description">
 <meta name="keywords" content="E-commerce">
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
 
</head>
 <body class=" customer-account-index">
 <input type="hidden" name="SearchType" value ="<%=search_Type%>">
 <input type="hidden" name="searchPatern" value ="<%=searchPattern%>">
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
	long finish = System.currentTimeMillis();
	ezc.ezcommon.EzLog4j.log("Time taken to execute iWelcomeAlerts.jsp in ezQuickSearchDetailsMain.jsp>>>"+(finish-start)/1000+" secs","F");
%>
 <%@ include file="../Misc/ezHeader.jsp"%>
 <%@ include file="../Misc/ezMenu.jsp"%>   
 <%@ include file="../Search/ezQuickSearchDetails.jsp"%> 
 <%@ include file="../Misc/ezFooter.jsp"%>
 </div>
 </div>   
 </body>
</html>
