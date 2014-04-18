<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>

<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>


<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />  
<jsp:useBean id="EzCatalogManager" class="ezc.client.EzCatalogManager"/> 
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	String user=Session.getUserId();	
	String userRole=(String)session.getValue("UserRole");	
	String LAST_LOGIN_DATE=(String)session.getValue("LAST_LOGIN_DATE");
	String LAST_LOGIN_TIME=(String)session.getValue("LAST_LOGIN_TIME"); 
	String agentCode=(String)session.getValue("AgentCode");
	String salesAreaCode=(String)session.getValue("SalesAreaCode");
	String userFNameH = (String)session.getValue("FIRSTNAME");
	String userLNameH = (String)session.getValue("LASTNAME");	
%>


<!DOCTYPE html>
<html lang="en">
<head>
<META HTTP-EQUIV="refresh" CONTENT="<%= session.getMaxInactiveInterval() %>; URL=../Misc/ezLogout.jsp" />
<!--<script type="text/javascript" src="../../Library/Script/jquery.qtip.js"></script> 
<style src="../../Library/Script/jquery.qtip.css"></style> 

<script>
jQuery(document).ready(function(jQuery)
 {
     jQuery('a').qtip({
         show: {
             delay: 100
         }
     }).click(function(event) {
         clearTimeout(jQuery(this).qtip('api').timers.show);
     });
 });
 </script>-->
</head>
</html>
<div class="header">
<div class="header-container">
<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->

<script type="text/javascript" src="//use.typekit.net/mwb2rov.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>

<header>
<body>
<form name="myFavForm" method="post">
<a href="../Catalog/ezConfigDashBoard.jsp" title="American Standard" class="logo"><img src="../../Library/Styles/logorevised.png" height="55px" width="237px" alt="American Standard" ></a><!--Images/amstd_logo.bmp-->
<div  class="quick-access">
	<ul class="links loggedin">
	<li id="help" class="first"><a title="Help" class="util-checkout" href="../Misc/shipping.html" target="_blank">&nbsp;Help&nbsp;</a></li>
	<li id="logout" ><a title="Log Out" href="../../../../EzSales/Sales/JSPs/Misc/ezLogout.jsp">&nbsp;&nbsp;&nbsp;Log Out&nbsp;&nbsp;&nbsp;</a></li>
	</ul>
</form>
</body>	

	<%
	
	/************************Default Sold To Name && Ship To Name --- Start******************************/
		
		String sesSysKey = (String)session.getValue("SalesAreaCode");
		String sesSoldTo = (String)session.getValue("AgentCode");
		String sesShipTo = (String)session.getValue("ShipCode");
		
		//out.println("sesSysKey::"+sesSysKey);
		//out.println("sesSoldTo::"+sesSoldTo);
		//out.println("sesShipTo::"+sesShipTo);
						
		ReturnObjFromRetrieve retsoldtoHead = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(sesSysKey);
		String soldToNameHead = "";
	
		if(retsoldtoHead!=null)
		{
			for(int i=0;i<retsoldtoHead.getRowCount();i++)
			{
				String soldToCode_A 	= retsoldtoHead.getFieldValueString(i,"EC_ERP_CUST_NO");
				
				if(sesSoldTo.equals(soldToCode_A))
				{
					soldToNameHead 	= retsoldtoHead.getFieldValueString(i,"ECA_NAME");
					soldToNameHead 	= (soldToNameHead==null || "null".equals(soldToNameHead)|| "".equals(soldToNameHead))?"":soldToNameHead;
				}
			}
		}
	
		UtilManager.setSysKeyAndSoldTo(sesSysKey,sesSoldTo);
		ReturnObjFromRetrieve  listShipTosHead = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(sesSoldTo);
		//out.println("listShipTosHead"+listShipTosHead.toEzcString());
		String shipToNameHead = "";
	
		if(listShipTosHead!=null)
		{		
			for(int l=0;l<listShipTosHead.getRowCount();l++)
			{
				String shipToCode = listShipTosHead.getFieldValueString(l,"EC_PARTNER_NO");
	
				if(sesShipTo.equals(shipToCode))
				{
					shipToNameHead 	= listShipTosHead.getFieldValueString(l,"ECA_NAME");					
					shipToNameHead 	= (shipToNameHead==null || "null".equals(shipToNameHead)|| "".equals(shipToNameHead))?"":shipToNameHead;					
				}
										
			}
				if(shipToNameHead==null || "null".equals(shipToNameHead)|| "".equals(shipToNameHead))
					shipToNameHead 	= listShipTosHead.getFieldValueString(0,"ECA_NAME");					
		}
		
		//out.println("shipToNameHead"+shipToNameHead);
		//out.println("sesShipTo"+sesShipTo);
			
	/*********************Default Sold To Name && Ship To Name --- End**********************/
	%>
<!-- auto complete STARTS-->

<!-- <script type="text/javascript" src="../../Library/Script/jquery-1.4.2.js"></script> -->

<script type="text/javascript">
var typewatch = function(){
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    }  
}();


function lookupHE1(atpforTxtHE) 
{  
        typewatch(function(){lookupHE(atpforTxtHE)}, 500 );   
}


function lookupHE(atpforTxtHE) {
if(atpforTxtHE.length < 3) {
jQuery('#suggestionsHE').hide();
} else if(atpforTxtHE.length >=3){
jQuery.post("../Misc/ezMatSearchHeader.jsp", {queryStringH: ""+atpforTxtHE+""}, function(data){
if(data.length >0) {
jQuery('#suggestionsHE').show();
jQuery('#autoSuggestionsListHE').html(data);
}
});
}

}
function fillH(thisValue) {
setTimeout("jQuery('#suggestionsHE').hide();", 30);
getProductDetailsHE(thisValue);

}

function submitenterH(myfield,e)
{

	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (e) keycode = e.which;
	else return true;

	if (keycode == 13)
	   {
	   
	   getProductDetailsHE(myfield);
	   return false;
	   }
	else
	   return true;
}

function getProductDetailsHE(code)
{
	
	document.srchformH.prodCode_D.value=code;

	document.srchformH.action="../Catalog/ezProductDetails.jsp";
	document.srchformH.submit();
}

function clrtxtHE()
{
	if(document.srchformH.atpforHE.value=="Product Search")
	{
		
		document.srchformH.atpforHE.value="";
	}
}
function enttxtHE()
{
	if(document.srchformH.atpforHE.value=="")
	{
		document.srchformH.atpforHE.value="Product Search";
	}
}
</script>
<style type="text/css">

.suggestionsBoxHE {
position: absolute;
left: 250px;
top: 110px;
margin: 0px 0px 0px 0px;
width: 400px;
height: 200px;
overflow:auto;
background-color: #DCDCDC;
-moz-border-radius: 4px;
-webkit-border-radius: 4px;
border: 2px solid #CCC;
color: #000;
}
.suggestionListHE {
margin: 0px;
padding: 0px;
}
.suggestionListHE li {

margin: 0px 0px 3px 0px;
padding: 3px;
cursor: pointer;
}

.suggestionListHE li:hover {
background-color: #555757;
color: #8B0000;
}

.search_imgHS{
background:#ffffff url(../../Library/images/btn-search.png) no-repeat right;
text-align:left;
}
</style>

 

<!-- auto complete ENDS-->

<html>
<head>


<!--<script type="text/javascript" src="../../Library/Script/TimeOut/jquery-1.4.1.min.js"></script>-->
  <!--<script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8rc1.custom.min.js"></script> -->
  <script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8.23.custom.min.js"></script>
  <link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery-ui-1.8.23.custom.css">
  <script type="text/javascript" src="../../Library/Script/TimeOut/jquery.idletimer.js"></script>
  <script type="text/javascript">
  
  	
	   
 
	var idleTime = 1740000; // number of miliseconds until the user is considered idle
	var initialSessionTimeoutMessage = 'Your session will expire in <span id="sessionTimeoutCountdown"></span>&nbsp;seconds.<br/><br />Click on <b>OK</b> to continue your session.';
	var sessionTimeoutCountdownId = 'sessionTimeoutCountdown';
	var redirectAfter = 30; // number of seconds to wait before redirecting the user
	var redirectTo = '../Misc/ezLogout.jsp'; // URL to relocate the user to once they have timed out
	var keepAliveURL = 'sessionValidate.jsp'; // URL to call to keep the session alive
	var expiredMessage = 'Your session has expired.  You are being logged out for security reasons.'; // message to show user when the countdown reaches 0
	var running = false; // var to check if the countdown is running
	var timer; // reference to the setInterval timer so it can be stopped
	jQuery(document).ready(function(jQuery) {
		// create the warning window and set autoOpen to false
		var sessionTimeoutWarningDialog = jQuery("#sessionTimeoutWarning");
		jQuery(sessionTimeoutWarningDialog).html(initialSessionTimeoutMessage);
		jQuery(sessionTimeoutWarningDialog).dialog({
			title: 'Session Expiration Warning',
			autoOpen: false,	// set this to false so we can manually open it
			closeOnEscape: false,
			draggable: false,
			width: 460,
			minHeight: 50,
			modal: true,
			beforeclose: function() { // bind to beforeclose so if the user clicks on the "X" or escape to close the dialog, it will work too
				// stop the timer
				clearInterval(timer);

				// stop countdown
				running = false;

				// ajax call to keep the server-side session alive
				jQuery.ajax({
				  url: keepAliveURL,
				  async: false
				});
			},
			buttons: {
				OK: function() {
					// close dialog
					jQuery(this).dialog('close');
				}
			},
			resizable: false,
			open: function() {
				// scrollbar fix for IE
				jQuery('body').css('overflow','hidden');
			},
			close: function() {
				// reset overflow
				jQuery('body').css('overflow','auto');
			}
		}); // end of dialog


		// start the idle timer
		jQuery.idleTimer(idleTime);

		// bind to idleTimer's idle.idleTimer event
		jQuery(document).bind("idle.idleTimer", function(){
			// if the user is idle and a countdown isn't already running
			if(jQuery.data(document,'idleTimer') === 'idle' && !running){
				var counter = redirectAfter;
				running = true;

				// intialisze timer
				jQuery('#'+sessionTimeoutCountdownId).html(redirectAfter);
				// open dialog
				jQuery(sessionTimeoutWarningDialog).dialog('open');

				// create a timer that runs every second
				timer = setInterval(function(){
					counter -= 1;

					// if the counter is 0, redirect the user
					if(counter === 0) {
						jQuery(sessionTimeoutWarningDialog).html(expiredMessage);
						jQuery(sessionTimeoutWarningDialog).dialog('disable');
						window.location = redirectTo;
					} else {
						jQuery('#'+sessionTimeoutCountdownId).html(counter);
					};
				}, 1000);
			};
		});

	});
	
		 
		
  
  </script>
</head>
<body>
<form name="srchformH" id="search_mini_form" action="../Catalog/ezProductDetails.jsp" method="post">
<input type="hidden" name="prodCode_D">
<div id="noprint" class="form-search">

	<h5 class="block-title" align="left">Hello&nbsp;<a href="javascript:void(0)"><%=userFNameH%> <%=userLNameH%></a></h5>
 	<!-- <h5 class="block-title" align="left">Default Sold To : <a href="../SwitchAccount/ezChangeSoldTo.jsp"><%=soldToNameHead%> (<%=sesSoldTo%>)</a></h5> -->
 	
	<!--<h5 class="block-title" align="left">My Default Ship To : <a href="../SwitchAccount/ezChangeSoldTo.jsp" title="What is def. shipto"><%=shipToNameHead%> (<%=sesShipTo%>)</a></h5>-->
	<!--<h5 class="block-title" align="left">Default Ship To : <a href="../SwitchAccount/ezChangeShipTo.jsp"><%=shipToNameHead%> (<%=sesShipTo%>)</a></h5> -->
        <!--<h5 class="block-title" align="left">Welcome : <%=userFNameH%> <%=userLNameH%></a></h5>-->
                
       <!--<input type="text" name="atpforHE" autocomplete="off" value="Product Search"  onfocus='clrtxtHE()' onblur='enttxtHE()' id="atpforHE" class="search_imgHS"  onKeyPress="return submitenterH(this.value,event)"  onkeyup="lookupHE1(this.value)" />-->
</div>        
    	<div class="suggestionsBoxHE" id="suggestionsHE" style="display: none;">
       	<div class="suggestionListHE" id="autoSuggestionsListHE">
       	</div>
   	</div>
</form>
<div id="sessionTimeoutWarning" style="display: none"></div>
</body>
</div>

</header>
</div>
</div>
<%!
	public String nullChk(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
		return ret;
	}
	
	public String eliminateDecimal(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>