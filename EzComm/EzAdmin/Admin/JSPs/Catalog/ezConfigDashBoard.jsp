<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Welcome to American Standards web portal</title>
<%@ include file="../../../Includes/Lib/ezCommonHead.jsp"%>
</head>
<body  class=" customer-account-index">
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
<%
	String helpKey	="EZCONFIGDASHBOARD";
%>
<%@ include file="../Misc/ezHeader.jsp"%>
<%@ include file="../Misc/ezMenu.jsp"%>
<%@ include file="../Catalog/ezConfigDashBoardBody.jsp"%>
<%@ include file="../Misc/ezFooter.jsp"%>
</div>
</div>
</body>
</html>