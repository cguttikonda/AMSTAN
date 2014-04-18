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
<body class=" customer-account-index">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-mainwide">

	<%
	// example URL http://my.averittexpress.com/servlet/pubLTLtrack?ProNumber=1080004844&PROBOL=PN&&actualLTLStatus=DC
	String urlWithReplacedString	= request.getParameter("url");
	URL url = new URL(urlWithReplacedString);
	//out.println(url);
	InputStreamReader in = new InputStreamReader(url.openStream());
	URLConnection connection = url.openConnection();
	int length = connection.getContentLength();

	Reader reader = new InputStreamReader(connection.getInputStream());
	StringBuffer sbuf = new StringBuffer();
	    while (true) {
	      int ch = reader.read();
	      if (ch==-1) {
		break;
	      }
	      //out.println((char)ch);
	      sbuf.append((char)ch);
	}
	//out.println(sbuf.toString());

	//out.println("<iframe src=\" "+urlWithReplacedString+"\" width=800px height=800px > </iframe>");
	%>	
	<div id="test" ><%=sbuf.toString()%></div>

</div>
</div>
</div>
</body>
</html>