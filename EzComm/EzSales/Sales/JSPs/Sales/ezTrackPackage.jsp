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


<script type="text/javascript">
 
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-35953021-1']);
  _gaq.push(['_setDomainName', 'myasb2b.com']);
  _gaq.push(["_set", "title", "Tracking"]);
  _gaq.push(['_trackPageview']);
 
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
 
</script>

</head>
<body class=" customer-account-index" style="background-color:white;width:500px">
<form name="myForm" id="myForm">
<!-- <div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners" style="width:500px">
<div class="page-title"> -->
	<%	
	String salesdoc	= request.getParameter("salesDocNo");
	String lineno = request.getParameter("lineNo");
	String trackingNumber	= request.getParameter("trackingNumber");
	//trackingNumber = trackingNumber.replaceFirst("^0+(?!$)", "");
	String poNum = request.getParameter("PurchaseOrder");
	String CarrierDesc = request.getParameter("CarrierDesc");
		
	String shipper = request.getParameter("shippingPartner");
	String dlvBolNumber = request.getParameter("dlvBolNumber");
	//out.println(" Track for following Info "+ trackingNumber + "---"+shipper +"------"+dlvBolNumber);
	%>
	<h2> Tracking Information for PO# <%=poNum%></h2>
	<table id="tracktable" class="data-table" width="75%">
	<tbody>
	<tr>
	<th> ASB Ref. Document </th><td><%=salesdoc%>/<%=lineno%></td>
	</tr>
	<tr>
	<th> ASB Bill of Lading </th><td><%=dlvBolNumber%></td>
	</tr>
	<tr>
	<th> Carrier Name </th><td><%=CarrierDesc%> [<%=shipper%>]</td>
	</tr>
	<tr>
	<th> Carrier Tracking </th><td><%=trackingNumber%></td>
	</tr>
	</tbody>
	</table>
	<br>
	<h3>Please Contact American Standard Customer Service or Carrier if you believe information received is incorrect</h3>
	<br><br>	
	<%	
	

	//Read Value Map

	EzcParams valueMapParamsMisc = new EzcParams(false);
	EziMiscParams valueMapParams = new EziMiscParams();

	ReturnObjFromRetrieve carrierDescValMapRetObj = null;

	valueMapParams.setIdenKey("MISC_SELECT");

	String queryVM= "SELECT * "+ "FROM EZC_VALUE_MAPPING "+ " WHERE MAP_TYPE='CARRIERURL'";

	valueMapParams.setQuery(queryVM);

	valueMapParamsMisc.setLocalStore("Y");
	valueMapParamsMisc.setObject(valueMapParams);
	Session.prepareParams(valueMapParamsMisc);	

	try
	{
		carrierDescValMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(valueMapParamsMisc);
	}
	catch(Exception e){}	

		
	/**ReturnObjFromRetrieve carrierURLValMapRetObj = null;

	ezc.ezparam.EzcParams mainParams_CURLVM = new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams_CURLVM = new EziMiscParams();

	miscParams_CURLVM.setIdenKey("VALUE_MAP"); // Mandatory 

	miscParams_CURLVM.setExt3("CARRIERURL"); // NEWSVALMAP is the map_type in the table and it is optional should pass the blank parameter
	//miscParams_NVM.setExt3("");

	mainParams_CURLVM.setLocalStore("Y");
	mainParams_CURLVM.setObject(miscParams_CURLVM);
	Session.prepareParams(mainParams_CURLVM);	
	try{		
		carrierURLValMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_CURLVM);
	}
	catch(Exception e){out.println("Exception in Getting Data"+e);}

	//out.println(carrierURLValMapRetObj.toEzcString());
	*/
	String mapType = "";
	String value1 = "";
	String value2 = "";
	
	String urlWithReplacedString = "";
	/**
	if(carrierURLValMapRetObj!=null)
	{
		for(int a=0;a<carrierURLValMapRetObj.getRowCount();a++)
		{
			
			mapType = carrierURLValMapRetObj.getFieldValueString(a,"MAP_TYPE");
			value1 = carrierURLValMapRetObj.getFieldValueString(a,"VALUE1");
			value2 = carrierURLValMapRetObj.getFieldValueString(a,"VALUE2");
			if (value1.equals(shipper)){
				//out.println ( "URL for Tracking from DB for Shipper "+ shipper+ " is "+value2);
				Pattern pat = Pattern.compile("%trackingnum%");   
				Matcher mat = pat.matcher(value2);  
				//out.println(mat.replaceAll(trackingNumber));   
				mat.reset();  
				urlWithReplacedString = mat.replaceAll(trackingNumber);
				//out.println("Click here to track with Carrier "+ urlWithReplacedString);   
				//out.println("<iframe src=\" "+urlWithReplacedString+"\" width=800px height=800px > </iframe>");
				break;
			}
		}
	}	
	*/
	if(carrierDescValMapRetObj!=null)
		{
			for(int a=0;a<carrierDescValMapRetObj.getRowCount();a++)
			{
				
				mapType = carrierDescValMapRetObj.getFieldValueString(a,"MAP_TYPE");
				value1 = carrierDescValMapRetObj.getFieldValueString(a,"VALUE1");
				value2 = carrierDescValMapRetObj.getFieldValueString(a,"VALUE2");
				if (shipper!=null && value1.equals(shipper.trim())){
					//out.println ( "URL for Tracking from DB for Shipper "+ shipper+ " is "+value2);
					Pattern pat = Pattern.compile("%trackingnum%");   
					Matcher mat = pat.matcher(value2);  
					//out.println(mat.replaceAll(trackingNumber));   
					mat.reset();  
					urlWithReplacedString = mat.replaceAll(trackingNumber);
					//out.println("Click here to track with Carrier "+ urlWithReplacedString);   
					//out.println("<iframe src=\" "+urlWithReplacedString+"\" width=800px height=800px > </iframe>");
					break;
				}
			}
	}
	
	%>	
	<script>
	function goToTrackingSite(url)
	{	
		//alert(encodeURI(url));
		//document.myForm.action=url;
		//document.myForm.target="_blank";
		//document.myForm.submit();
		window.open(url,'_blank');
	}
</script>
	<% if (!urlWithReplacedString.trim().equals("")) { %>
	<button type="button" title="Click" class="button" onclick="javascript:window.open('<%=urlWithReplacedString%>','_blank')"><span>Click Here to Track</span></button>
	<p style="color:red"> Clicking on Link would take you to 3rd Party Website not controlled or managed by American Standard</p>
	<% } else { %>
	<p style="color:red"> Currently American Standard does not have Tracking Links to this Carrier or the Carrier does not provide such online service. 
	Please contact AS Customer Service or Carrier directly.</p>
	<% } %>
<!-- </div>
</div>
</div>
</div> -->
</form>
</body>
</html>