<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>

<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*,java.net.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,java.util.regex.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>


<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />  
<jsp:useBean id="EzCatalogManager" class="ezc.client.EzCatalogManager"/> 
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
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
//]]>
</script>

</head>
<body class=" customer-account-index" style="background-color:white;width:500px">
<form name="myForm" id="myForm">
<!-- <div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners" style="width:500px">
<div class="page-title"> -->
	<%	
	String currentPageName = request.getParameter("currentPage");
	//out.println(" Track for following Info "+ trackingNumber + "---"+shipper +"------"+dlvBolNumber);
	%>
	<h2> HELP FOR <%=currentPageName%></h2>
	<script>
	function goToTrackingSite(url)
	{	
		window.open(url,'_blank');
	}
</script>
	<% if (!currentPageName.trim().equals("")) { %>
	<button type="button" title="Click" class="button" onclick="javascript:window.open('<%=currentPageName%>','_blank')"><span>Click Here to Track</span></button>
	<% } %>
<!-- </div>
</div>
</div>
</div> -->
</form>
</body>
</html>