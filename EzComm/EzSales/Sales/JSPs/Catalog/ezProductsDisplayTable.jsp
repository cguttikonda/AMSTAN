<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Welcome to American Standards web portal</title>

<%@ include file="../../../Includes/Lib/ezCommonHead.jsp"%>
</head>

<body class=" catalog-category-view categorypath-flatware-casual-stainless-flatware category-casual-stainless-flatware">
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
	String helpKey	="EZPRODUCTDISPLAYTABLE";
%>
<%@ include file="../Misc/ezHeader.jsp"%>
<%@ include file="../Misc/ezMenu.jsp"%>
<%@ include file="../Catalog/ezProductsDisplayBodyTable.jsp"%>
<%@ include file="../Misc/ezFooter.jsp"%>
</div>
</div>
</body>
</html>