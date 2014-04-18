<%@ include file="../../../Includes/JSPs/Misc/iMethods.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Welcome Page</title>
<script type="text/javascript" src="../../Library/Script/LightBox.js"></script>
<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
<link rel="stylesheet" href="../../../../../LoginFiles/css/flexslider.css">
<!--<script src="../../../../../LoginFiles/js/vendor/jquery-1.8.3.min.js"></script>-->
<script src="../../../../../LoginFiles/js/vendor/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="../../Library/JavaScript/Cart/ezCartAlerts.js"></script>
<script>
	$.getJSON("http://jsonip.appspot.com?callback=?",function (data) 
	{ 
		//alert(data.ip);
		document.myForm.ipaddr.value=data.ip;	
	});
	jQuery(document).ready( function(jQuery) {		
	jQuery(".fancybox").fancybox({closeBtn:true});
	} );
</script>
<script>
function submitenter(myfield,e)
{
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (e) keycode = e.which;
	else return true;

	if (keycode == 13)
	{
		addToCart();
		return false;
	}
	else
		return true;
}
function submitenterpostatus(myfield,e)
{
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (e) keycode = e.which;
	else return true;

	if (keycode == 13)
	{
		$("#PONUMBER").val($("#PONO").val());
		console.log($("#PONUMBER").val());
		//alert($("#PONUMBER").val());
		toPoStatusResult($("#PONUMBER").val());
		return false;
	}
	else
		return true;
}
function validatePO()
{
	var poNum = trim(document.myForm.PONO.value);
	if(poNum!="")
	{
		if(poNum.indexOf("*")!=-1 || poNum.indexOf("%")!=-1)
		{
			alert("Special Characters '*' and '%' are not all allowed in PO search");
			document.myForm.PONO.value = poNum.replace(/[%*]/gi,'');//[^a-z0-9] [&\/\\#,+()$~%.'":*?<>{}]
		}
	}
}
function toPoStatus()
{
	document.myForm.action="../Search/ezQuickSearchMain.jsp";
	document.myForm.submit();
}
function toPoStatusResult(val)
{
	if(trim(document.myForm.PONO.value) == "")
	{
		alert("Please Enter PO# to check Status");
		return;
	}
	else
	{
		/*var poNum = trim(document.myForm.PONO.value);
		if(poNum.length<3)
		{
			alert("Please Enter Minimum 3 characters to check PO Status");
			return;
		}
		else*/
		{
			document.myForm.action="../Search/ezQuickSearchDetailsMain.jsp";
			Popup.showModal('modal');
			document.myForm.submit();
		}
	}
}
function funClick(actionPage)
{
	Popup.showModal('headermodal');
	document.myForm.action = actionPage;
	document.myForm.submit();
}
function trim(str)
{
	str = str.toString();
	var begin = 0;
	var end = str.length - 1;
	while (begin <= end && str.charCodeAt(begin) < 33) { ++begin; }
	while (end > begin && str.charCodeAt(end) < 33) { --end; }
	return str.substr(begin, end - begin + 1);
}

/*function addToCart()
{	
	document.myForm.action="../ShoppingCart/ezAddCartQuickEntry.jsp";
	document.myForm.submit();
}*/

var req
var stat 
var pcode
function addToCart()
{		
	req=Initialize();

	if (req==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}			

	pcode	 = document.myForm.atpfor.value;
	var pqty = document.myForm.atpqty.value;
	var url
	stat = "C";
	if(stat=="C")
	{	
		if(pcode=="" || pcode=="Search")
		{
			alert("Please enter Product code to add to cart");
			return false;
		}
		if(pqty<=0)
		{
			alert("Please enter Quantity 1 or more.");
			return false;
    		}
		Popup.showModal('modal');
		url="../ShoppingCart/ezAddCartQuickEntry.jsp";
		url=url+"?atpfor="+pcode+"&atpqty="+pqty;
	}

	if(req!=null)
	{
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);
	}
}
function Process()
{
	if (req.readyState == 4)
	{
		var resText     = req.responseText;
		if (req.status == 200)
		{
			if(stat=="C")
			{
				var alertCode	
				var reasonCode	
				//var barCol = '#4F4F4F'; //'#eb593c'
				//var textCol = '#66CC33';
				var flag = true;

				for(i=0;i<myKeys.length;i++)
				{
					var chkKey = myKeys[i].helpKey;

					if(resText.indexOf(chkKey)!=-1)
					{
						alertCode = '';
						reasonCode = myKeys[i].helpText;
						alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
						flag = false;
						break;
					}
				}

				if(flag)
				{
					alertCode='has been successfully added to Cart'
					reasonCode=''
					//barCol = '#71c6aa'
					alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
					var currentC = $('#cartcount').text();
					var newC =parseInt(currentC)+1;
					$('#cartcount').text(newC);

					document.myForm.atpfor.value = "";
					document.myForm.atpqty.value = "1";
				}

				new HelloBar( '<span>'+ alertIcon +' Product ' +pcode+ ' '+alertCode+ ' ' +reasonCode+  '.</span><a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>',
				{
					showWait: 1000,
					positioning: 'sticky',
					fonts: 'Arial, Helvetica, sans-serif',
					forgetful: true,
					helloBarLogo : false,
					height : 30
				}, 1.0 );
			}
		}
		else
		{
			if(req.status == 500)
			{
				//alert("Error in adding product(s) to Favorites");
				var alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				//var barCol = '#4F4F4F'; //'#eb593c'
				//var textCol = '#66CC33';

				new HelloBar( ' <span>'+ alertIcon +' Product ' +pcode+ ' '+alertCode+ ' added ' +reasonCode+  '.</span><a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>',
				{
					showWait: 1000,
					positioning: 'sticky',
					fonts: 'Arial, Helvetica, sans-serif',
					forgetful: true,
					helloBarLogo : false,
					height : 30
				}, 1.0 );
			}
		}
		Popup.hide('modal');
	}
}
function Initialize()
{
	if (window.XMLHttpRequest)
	{
		return new XMLHttpRequest();
	}
	if (window.ActiveXObject)
	{
		return new ActiveXObject("Microsoft.XMLHTTP");
	}

	return null;	
}
function clrtxt()
{
	if(document.myForm.atpfor.value=="Search")
	{
		document.myForm.atpfor.value="";
	}
}
function enttxt()
{
	if(document.myForm.atpfor.value=="")
	{
		document.myForm.atpfor.value="Search";
	}
	//$('#suggestions').hide();
}
</script>
<!-- Fancybox ATP -->
<script>

function wait(msecs)
{
	var start = new Date().getTime();
	var cur = start
	while(cur - start < msecs)
	{
		cur = new Date().getTime();
	}
}

var xmlhttp

function loadContent(ind)
{
	var atpfor = document.myForm.atpfor.value;
	var atpqty = document.myForm.atpqty.value;
	if(atpfor=="" || atpfor=="Search")
	{
		alert("Please enter Product code to check Availability");
		return false;
	}
	if(atpqty<=0)
	{
		alert("Please enter Quantity 1 or more.");
		return false;
	}
	var atpon=document.myForm.atpon.value;
	var stAtp=document.myForm.stAtp.value;

	xmlhttp=GetXmlHttpObject();

	if (xmlhttp==null)
	{
		alert ("Your browser does not support Ajax HTTP"); 
		return;
	}

	var url="../ShoppingCart/ezATPAjaxLightBoxHome.jsp";
	url=url+"?atpfor="+atpfor+"&atpon="+atpon+"&atpqty="+atpqty+"&stAtp="+stAtp;

	xmlhttp.onreadystatechange=getOutput;
	xmlhttp.open("GET",url,true);
	xmlhttp.send(null);
}
function getOutput()
{
	if (xmlhttp.readyState==4)
	{
		document.getElementById("ajaxid").innerHTML=xmlhttp.responseText;
	}
}
function GetXmlHttpObject()
{
	if (window.XMLHttpRequest)
	{
		return new XMLHttpRequest();
	}
	if (window.ActiveXObject)
	{
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
	return null;
}
</script>
<!-- End of Fancybox ATP -->
<style>

a {color:#333; text-decoration:none}
a:hover {color:#ccc; text-decoration:none}

#mask {
	position:absolute;
	left:0;
	top:0;
	z-index:9000;
	background-color:#000;
	display:none;
}

#boxes .window {
	position:absolute;
	left:0;
	top:0;
	width:980px;
	height:530px;
	display:none;
	z-index:9999;
	padding:20px;
}

#boxes #dialog {
	width:980px;
	height:545px;
	padding:10px;
	background-color:#000;
}
</style>
<!-- auto complete STARTS-->
<script type="text/javascript">
jQuery(function(){
	var atpforTxt=$("#atpfor").val();
	$("#atpfor").autocomplete("../ShoppingCart/list.jsp");
});
</script>

<style type="text/css">

.suggestionsBox {
	position: absolute;
	left: 30px;
	top: 300px;
	margin: 0px 0px 0px 0px;
	width: 450px;
	height: 200px;
	overflow:auto;
	background-color: #DCDCDC;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border: 2px solid #CCC;
	color: #000;
}
.suggestionList {
	margin: 0px;
	padding: 0px;
}
.suggestionList li {
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}
.suggestionList li:hover {
	background-color: #555757;
	color: #8B0000;
}
.search_img{
	background:#ffffff url(../../Library/images/btn-search.png) no-repeat right;
	text-align:left;
}
</style>
<!-- auto complete ENDS-->
<!-- <link href="../../Library/Styles/dd.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../../Library/Styles/jquery.dd.js"></script> -->
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
</head>
<form method=post name="myForm" method ="post">
<input type="hidden" name="ipaddr" value="">
<div class="main-container col2-left-layout middle account-pages">
<div class="main" >
<div class="col3-set">
	<div class="col-1 roundedCorners" style="width:26% !important;background: #FFF;padding-top: 15px; height:410px;">
	<div class="block">
		<div class="block-title">
			<strong><span>My Account</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<li class="current"><strong>Account Dashboard</strong></li>
<%
			if(unreadNewsCnt>0)
			{
%>
				<!--<li><a href="../News/ezListNewsDash.jsp?newsFilter=<%//=newsFromDashCat%>" title="">News [<%=unreadNewsCnt%>]</a></li>-->
				<li><a href="javascript:funClick('../News/ezListNewsDash.jsp')" title="List of Published News"> News [<%=unreadNewsCnt%>]</a></li>
<%
			}
			else 
			{
%>
				<li><a href="javascript:funClick('../News/ezListNewsDash.jsp')" title="List of Published News">News</a></li>
<%
			}

			if(messageCnt>0)
			{
%>
				<li><a href="javascript:funClick('../Inbox/ezListPersMsgsMain.jsp')" title="Mails regarding Orders">Messages [<%=messageCnt%>]</a></li>
<%
			}
			else 
			{
%>
				<li><a href="javascript:funClick('../Inbox/ezListPersMsgsMain.jsp')" title="Mails regarding Orders"">Messages</a></li>
<%
			}
%>
				<!-- <li><a href="../SwitchAccount/ezChangeSoldTo.jsp" title="">Address Information</a></li> -->
<%
			if(countMisCM>0 && "CM".equals(userRole))
			{
%>
				<li><a href="javascript:funClick('../Sales/ezNegotiatedOrders.jsp?negotiateType=INPROCESS&ORDERTYPE=N&displayOrder=N')" title="Orders In ASB Queue">Orders In ASB Queue [<%=countMisCM%>]</a></li>
				<li><a href="javascript:funClick('../Sales/ezNegotiatedOrders.jsp?negotiateType=INPROCESS&ORDERTYPE=N&displayOrder=Y')" title="Orders In ASB Queue">Display Orders in Queue [<%=countDispCM%>]</a></li>
<%			
			}
			if (countMisc3>0 && "CU".equals(userRole))
			{
%>
				<li><a href="javascript:funClick('../Sales/ezNegotiatedOrders.jsp?negotiateType=INPROCESS&ORDERTYPE=N&displayOrder=N')" title="Orders In ASB Queue">Orders In ASB Queue [<%=countMisc3%>]</a></li>
<%
			}
			if (countMisc2>0 && "CU".equals(userRole))
			{
%>
				<li><a href="javascript:funClick('../Sales/ezNegotiatedOrders.jsp?negotiateType=ACCEPTED&ORDERTYPE=N&displayOrder=N')" title="Orders In Customer Queue">Orders In Customer Queue [<%=countMisc2%>]</a></li>
<%
			}
			if (isFOCUser && "CM".equals(userRole) && focOrdCnt>0) 
			{
%>
				<li><a href="javascript:funClick('../Sales/ezOrdersForApproval.jsp?negotiateType=FORAPPROVAL&ORDERTYPE=A')" title="Free Of Charge Orders For Approval">FD Orders For Approval [<%=focOrdCnt%>]</a></li>
<%
			}
			if (canReqCnt>0)
			{
%>
				<li><a href="javascript:funClick('../Sales/ezCancellationRequestsMain.jsp')" title="Pending Cancellation Request in ASB Queue">Open Cancellations [<%=canReqCnt%>]</a></li>
<%
			}
			else if (canReqCnt>0 && "CU".equals(userRole))
			{
%>
				<!-- <li><a href="../Sales/ezProcessedRequestsMain.jsp" title="Approved Cancellation Request" title="Cancel Requests in Customer Queue">Approved Cancellations [<%=canReqCnt%>]</a></li> -->
<%
			}
			if("CM".equals(userRole) && canReqCntCM>0)
			{
%>
				<!--<li><a href="javascript:funClick('../Sales/ezProcessedRequestsMain.jsp?rType=ACR')" title="Approved Cancellation Request">Approved Cancellations [<%=canReqCntCM%>]</a></li>-->
<%
			}			
			if(rgaCMCnt>0 && "CM".equals(userRole))
			{
%>
				<li><a href="javascript:funClick('../Sales/ezCancellationRequestsMain.jsp?rType=RGA')" title="RGAs in ASB Queue">RGAs in ASB Queue [<%=rgaCMCnt%>]</a></li>
				<li><a href="javascript:funClick('../Sales/ezProcessedRequestsMain.jsp?rType=RGA')" title="RGA Requests in Customer Queue">Open RGAs [<%=rgaReqCnt%>]</a></li>
<%
			}
			else if("CU".equals(userRole))
			{
				if(rgaCount>0)
				{
%>
				<li><a href="javascript:funClick('../Sales/ezCancellationRequestsMain.jsp?rType=RGA')" title="RGAs in ASB Queue">RGAs in ASB Queue [<%=rgaCount%>]</a></li>
<%
				}
				if(rgaReqCnt>0)
				{
%>
				<li><a href="javascript:funClick('../Sales/ezProcessedRequestsMain.jsp?rType=RGA')" title="RGA Requests in Customer Queue">Open RGAs [<%=rgaReqCnt%>]</a></li>
<%
				}
			}

			if(SalQCnt>0)
			{
%>
				<li><a href="javascript:funClick('../Quotes/ezExpiringJobQuotes.jsp')" title="Expiring Quotes">Expiring Job Quotes [<%=SalQCnt%>]</a></li>
<%
			}
			else  
			{
%>
				<li><a href="javascript:funClick('../Quotes/ezExpiringJobQuotes.jsp')" title="Expiring Quotes">Expiring Job Quotes</a></li>
<%
			}
%>
			<li><a href="javascript:funClick('../SelfService/ezChangeAcctInfo.jsp')" title="To Change Your Acc. Info ">Account Profile</a></li>
			<!--<li><a href="javascript:funClick('../SelfService/ezChangePassword.jsp')">Change Password</a></li>
			<li><a href="javascript:funClick('../SelfService/ezAddSubUser.jsp')">Add Sub User</a></li>
			<li><a href="javascript:funClick('../SelfService/ezListSubUsers.jsp')">List Sub Users</a></li>
			<li><a href="javascript:funClick('../News/ezListNewsDash.jsp?newsFilter=PA')">Promotions</a></li> -->
			</ul>
		</div>
		</div>
	</div> <!-- col-1 end -->
	<div class="col-2 roundedCorners" style="width:38% !important;background: #FFF;padding: 15px; height:410px; padding-bottom:0; margin-left:1.5%;">
	<div class="my-account">
	<div class="dashboard">
<%
		String userEmail = (String)session.getValue("USEREMAIL");
		String userFName = (String)session.getValue("FIRSTNAME");
		String userLName = (String)session.getValue("LASTNAME");
		String sysKey 	 = (String)session.getValue("SalesAreaCode");
		String selSoldTo = (String)session.getValue("AgentCode");
		String selShipTo = (String)session.getValue("ShipCode");
		String userType  = (String)session.getValue("UserType");
		String userId	 = Session.getUserId();
		String bussPart  = (String)session.getValue("BussPart");

		String atpon   = request.getParameter("atpon");
		if(atpon==null || "null".equalsIgnoreCase(atpon)) atpon = cMonth_S+"/"+cDate_S+"/"+cYear;
%>
<%@ include file="../../../Includes/JSPs/Misc/iStatesRetObj.jsp"%>
<input type="hidden"  id="atpon" name="atpon" value="<%=atpon%>" />
<%
		if(stateRetRes!=null && stateRetRes.getRowCount()>0)
			session.putValue("retAtpStateObj_ses",stateRetRes);

		String selSoldName 	= "";
		String selSoldAddr1	= "";
		String selSoldCity 	= "";
		String selSoldState 	= "";
		String selSoldCountry 	= "";
		String selSoldZipCode	= "";
		String selSoldPhNum 	= "";
		String selSoldEmail 	= "";

		/********* These values are now set in Confirm page ************/
		/*
		ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)UtilManager.getUserCatalogAreas();
		String allSalesAreas = sysKey;
		if(retcatarea!=null && retcatarea.getRowCount()>0)
		{
			for(int a=0;a<retcatarea.getRowCount();a++)
			{
				String retSysKey = retcatarea.getFieldValueString(a,"ESKD_SYS_KEY");

				if(a==0)
					allSalesAreas = retSysKey;
				else
					allSalesAreas = allSalesAreas+"','"+retSysKey;
			}
		}*/

		//ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(sysKey);
		//ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)getUserCustomers(userType,allSalesAreas,userId,bussPart,Session);
		//ezc.ezcommon.EzLog4j.log("retsoldto_A in ezWelcome.jsp>>"+retsoldto_A.toEzcString(),"I");

		ReturnObjFromRetrieve  retsoldto_A = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");

		String soldStr = "";
		String tempSoldTo = "";
		String tempShipTo = "A";
		if(retsoldto_A!=null)
		{
			//session.putValue("retsoldto_A_Ses",retsoldto_A);

			Vector assSoldTo = new Vector();
			for(int ss=0;ss<retsoldto_A.getRowCount();ss++)
			{
				String blockCode_A 	= retsoldto_A.getFieldValueString(ss,"ECA_EXT1");
				if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

				if(!"BL".equalsIgnoreCase(blockCode_A))
				{
					String soldToCode = retsoldto_A.getFieldValueString(ss,"EC_ERP_CUST_NO");
					if(assSoldTo.contains(soldToCode))
						continue;
					else
						assSoldTo.add(soldToCode);

					if("".equals(tempSoldTo))
						tempSoldTo = soldToCode;
					else
						tempSoldTo = tempSoldTo+"$$"+soldToCode;

					if("".equals(soldStr))
						soldStr = soldToCode;
					else
						soldStr = soldStr+"','"+soldToCode;
				}
			}
		}

		if("CU".equals(userRole))
		{
			ezc.ezparam.ReturnObjFromRetrieve retShipTo_W	= null;
			ezc.ezparam.EzcParams mainParamsMisc_W 		= new ezc.ezparam.EzcParams(false);

			ezc.ezmisc.params.EziMiscParams miscParams_W 	= new ezc.ezmisc.params.EziMiscParams();
			ezc.ezmisc.client.EzMiscManager ezMiscManager_W	= new ezc.ezmisc.client.EzMiscManager();

			miscParams_W.setIdenKey("MISC_SELECT");

			String appendQry="";
			if("Y".equals((String)session.getValue("IsSubUser")) || "3".equals(userType) )
				appendQry = "AND EC_BUSINESS_PARTNER='"+bussPart+"'";

			String query_WS = "SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME,ECA_ACCOUNT_GROUP,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO IN ('"+soldStr+"') AND EC_PARTNER_FUNCTION='WE' AND EC_NO=ECA_NO "+appendQry;

			miscParams_W.setQuery(query_WS);
			mainParamsMisc_W.setLocalStore("Y");
			mainParamsMisc_W.setObject(miscParams_W);
			Session.prepareParams(mainParamsMisc_W);	

			try
			{
				retShipTo_W = (ReturnObjFromRetrieve)ezMiscManager_W.ezSelect(mainParamsMisc_W);
			}
			catch(Exception e){}

			if(retShipTo_W!=null && retShipTo_W.getRowCount()>0)
			{
				if("Y".equals((String)session.getValue("IsSubUser")))
				{
					if(retShipTo_W!=null)
					{
						Vector delShips = (Vector)getListOfShipTos(Session.getUserId(),Session);
						for(int i=retShipTo_W.getRowCount()-1;i>=0;i--)
						{
							String toBeDel = retShipTo_W.getFieldValueString(i,"EC_PARTNER_NO");
							String blockCode_A = retShipTo_W.getFieldValueString(i,"ECA_EXT1");
							if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
							{
								retShipTo_W.deleteRow(i);
							}
							else
							{
								if(!delShips.contains(toBeDel))
									retShipTo_W.deleteRow(i);
							}
						}
					}
				}
				else
				{
					if(retShipTo_W!=null)
					{
						Vector delShips = new Vector();
						for(int i=retShipTo_W.getRowCount()-1;i>=0;i--)
						{
							String toBeDel = retShipTo_W.getFieldValueString(i,"EC_PARTNER_NO");
							String blockCode_A = retShipTo_W.getFieldValueString(i,"ECA_EXT1");
							if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
							{
								retShipTo_W.deleteRow(i);
							}
							else
							{
								if(delShips.contains(toBeDel))
									retShipTo_W.deleteRow(i);
								else
									delShips.add(toBeDel);
							}
						}
					}
				}
			}
			if(retShipTo_W!=null && retShipTo_W.getRowCount()>0)
			{
				for(int s=0;s<retShipTo_W.getRowCount();s++)
				{			
					String shipToCode = retShipTo_W.getFieldValueString(s,"EC_PARTNER_NO");

					if("".equals(tempShipTo))
						tempShipTo = shipToCode;
					else
						tempShipTo = tempShipTo+"$$"+shipToCode;
				}
			}
		}

		/********** These values are now set in Confirm page ************/
		//UtilManager.setSysKeyAndSoldTo(sysKey,selSoldTo);
		//ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(selSoldTo);
		//out.println("selSoldTo:::"+selSoldTo);
		//session.putValue("listShipTos_entSes",listShipTos_ent);
		/********** These values are now set in Confirm page ************/

		ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)session.getValue("listShipTos_entSes");

		String shipToName = "";
		String shipAddr1 = "";
		String shipAddr2 = "";
		String shipState = "";
		String shipCountry = "";
		String shipZip = "";
		String shipPhNum = "";

		if(listShipTos_ent!=null)
		{		
			for(int l=0;l<listShipTos_ent.getRowCount();l++)
			{
				String shipToCode = listShipTos_ent.getFieldValueString(l,"EC_PARTNER_NO");
	
				if(selShipTo.equals(shipToCode))
				{
	
					shipToName 	= listShipTos_ent.getFieldValueString(l,"ECA_NAME");
					shipAddr1  	= listShipTos_ent.getFieldValueString(l,"ECA_ADDR_1"); //Street
					shipAddr2  	= listShipTos_ent.getFieldValueString(l,"ECA_CITY");
					shipState  	= listShipTos_ent.getFieldValueString(l,"ECA_STATE");
					shipCountry  	= listShipTos_ent.getFieldValueString(l,"ECA_COUNTRY");
					shipZip    	= listShipTos_ent.getFieldValueString(l,"ECA_PIN");
					shipPhNum    	= listShipTos_ent.getFieldValueString(l,"ECA_PHONE");
	
					shipToName 	= (shipToName==null || "null".equals(shipToName)|| "".equals(shipToName))?"":shipToName;
					shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
					shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
					shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
					shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
					shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
					shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;
				}
			}				

			if(shipToName==null || "null".equals(shipToName)|| "".equals(shipToName))
				shipToName = listShipTos_ent.getFieldValueString(0,"ECA_NAME");
			if(shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))
				shipAddr1  	= listShipTos_ent.getFieldValueString(0,"ECA_ADDR_1");
			if(shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))
				shipAddr2  	= listShipTos_ent.getFieldValueString(0,"ECA_CITY");
			if(shipState==null || "null".equals(shipState) || "".equals(shipState))
				shipState  	= listShipTos_ent.getFieldValueString(0,"ECA_STATE");
			if(shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))
				shipCountry  	= listShipTos_ent.getFieldValueString(0,"ECA_COUNTRY");
			if(shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))
				shipZip    	= listShipTos_ent.getFieldValueString(0,"ECA_PIN");
			if(shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))
				shipPhNum    	= listShipTos_ent.getFieldValueString(0,"ECA_PHONE");
	       }
%>
		<div class="block" style="padding-left: 0px; width:100%;">
			<div class="block-title">
				<strong><span>Order Status </span></strong>
			</div>
		</div>	
		<!--<h2 class="sub-title"> Order Status </h2>
		<p > Key in PO Number and hit enter, or choose Check/Search</p> -->
		<div class="col1-set" style="padding-bottom:15px; margin-top:20px;">
		<div class="info-box">
			<table id="quickstatus">
			<tbody>
			<tr>
<%
			String fromDate   = request.getParameter("fromDate");
			String toDate 	  = request.getParameter("toDate"); 	
			if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = "01"+"/"+"01"+"/"+"2012";
			if(toDate==null   || "null".equalsIgnoreCase(toDate)) toDate = "12"+"/"+"31"+"/"+"9999";	
%>
			<input type="hidden" name="selSoldTo" id="selSoldTo" value="<%=selSoldTo%>">
			<input type="hidden" name="fromDate" value="<%=fromDate%>">
			<input type="hidden" name="toDate" value="<%=toDate%>">
			<input type="hidden" name="orderType" value="A">
			<input type="hidden" name="ordStat" value="A">
			<input type="hidden" name="proCodeDesc" value="">
			<input type="hidden" name="SAPSO" value="">
			<input type="hidden" name="UPC" value="">
			<input type="hidden" name="salesOrder" value="">
			<input type="hidden" name="soldTo">
			<input type="hidden" name="fromPage" id="fromPage" value="Welcome">
			<input type="hidden" name="parentSol" value="">
			<input type="hidden" name="shipTo" value="A">
			<input type="hidden" name="ORDERTYPE" id="ORDERTYPE" value="N">
			<input type="hidden" name="PONUMBER" id="PONUMBER" value="">
			<input type="hidden" name="orderinforadio" value="Orders">
			<input type="hidden" name="tempSoldTo" value="<%=tempSoldTo%>">
			<input type="hidden" name="tempShipTo" value="<%=tempShipTo%>">

			<input type="hidden" name="webSrch" value="Y">
			<td width="2%" style="vertical-align:middle;"><input style=" height: 30px; background: none; " placeholder="PO Number/ID" size="20" type="text" name="PONO" id="PONO" class="input-text" value="" onkeypress="return submitenterpostatus(this,event)" onkeyup="return validatePO()"></td>
			<td width="20%"><button type="button" title="Check Status" class="button btn-update" onclick="javascript:toPoStatusResult()"><span>Check Status</span></button></td>
			<!--<td width=8%><button type="button" title="Advanced Search" class="button btn-update" onClick="javascript:toPoStatus()"><span>Advanced Search</span></button></td> -->

			</tr>
			</tbody>
			</table>
		</div>
		</div>
		<br>
		<div class="block" style="padding-left: 0px; width:100%;">
			<div class="block-title" style=" margin-top: 35px; ">
				<strong><span>Quick Availability</span></strong>
			</div>
		</div>
		<div class="col1-set">
		<div class="info-box">
			<table id="quickatp">
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td style=" background: #fff; width: 205px;">
				
				<select name="stAtp">
<%
				if(stateRetRes!=null)
				{
					for(int i=0;i<stateRetRes.getRowCount();i++)
					{
						String shipToStateCode 	= stateRetRes.getFieldValueString(i,"STATECODE");
						String shipToStateName 	= stateRetRes.getFieldValueString(i,"STATENAME");

						String selected_A = "selected";

						if(shipState.equals(shipToStateCode))
						{
%>
							<option value="<%=shipToStateCode%>" <%=selected_A%>><%=shipToStateCode%> - <%=shipToStateName%></option>
<%
						}
						else
						{
%>
							<option value="<%=shipToStateCode%>" ><%=shipToStateCode%> - <%=shipToStateName%></option>
<%
						}
					}
				}
%>
				</select>
				
				</td>
				<td style="line-height:30px; vertical-align:middle;">ShipTo State</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td style=" background: #fff; width: 205px; "><input style=" width: 200px; " size="3" type="text" name="atpqty" id="atpqty" class="input-text" value="1" onKeyPress="return submitenter(this,event)" onfocus="javascript:$('#suggestions').hide()"/></td>
				<td style="line-height:30px; vertical-align:middle;">Quantity</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td style=" background: #fff; width: 205px;">
				<!--<input size="20" type="text" name="atpfor" id="atpfor" autocomplete="off" value="Search"  class="input-text" onkeyup="lookup(this.value);" onblur="fill();" />-->
				<input placeholder="Product ID" size="20" type="text" name="atpfor" autocomplete="off" value="" id="atpfor"   class="input_text"/>
				</td>
				<td style="line-height:30px; vertical-align:middle;">Product ID or UPC</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td style=" background: #fff;" colspan="2">
				<!--<label for="qty">Qty:</label>
				<input type="text" size=2 name="atpqty" id="atpqty" maxlength="5" value="1" title="Qty" onfocus="javascript:$('#suggestions').hide()"/> -->
				<a class="fancybox" href="#ajaxid" onclick="javascript:loadContent('1')" >
				<button class="button btn-black" title="Availability" style=" margin-left: 25px; margin-top: 5px; ">AVAILABILITY</button></a>
				<!-- <a href="#dialog" name="modal"><button onClick="iframeDisplay()" class="button btn-black">ATP</button></a>-->
				<button style=" float:right; margin-right: 25px; margin-top: 5px; " type="button" title="Add To Cart" class="button btn-update" onClick="javascript:addToCart()"><span>Add to Cart</span></button></td>
			</tr>
			</table>
			<div id="ajaxid" style="width: 980px; height:320px; display: none; ">
			<div align=center  style="padding-top:10px;">
				<ul>
					<li>&nbsp;</li>
					<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
					<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
				</ul>
			</div>
			</div>
			<div class="suggestionsBox" id="suggestions" style="display: none;">
			<div class="suggestionList" id="autoSuggestionsList">
			</div>
			</div>
		<!--<div id="boxes">
		<div id="dialog" class="window">
			<a href="#" class="close"/><font color=white>[x] Close</font></a>
			<iframe id="atpIFrame" width="980" height="530"></iframe>
		</div>
		<div id="mask"></div>
		</div>-->
		<br>
		</div> <!-- infobox -->
		</div> <!-- col set-->
<%
	session.putValue("shipState",shipState); 
	session.putValue("shipAddr2",shipAddr2);
%>
	</div>
	</div>
	</div> <!-- Col 2 end -->
	<div class="col-3 roundedCorners" style="width:26.5% !important;background: #FFF;padding: 15px; height:410px; padding-bottom:0;">
	<div class="block" style="padding-left: 0px; width:100%;">
		<div class="block-title">
			<strong><span>What's New? </span></strong>
		</div>
	</div>
	<div class="flexslider" > <!--style=" margin: 20px 50px; "-->
	<ul class="slides">
	<li><a href="http://www.americanstandard-us.com/pressroom/american-standard-named-a-2013-green-good-design-award-recipient/" target="_blank"><img src="../../Images/whatsnew/topic1.jpg" style="max-width:100%;" /></a></li>
	<li><a href="http://www.americanstandard-us.com/pressroom/american-standard-wins-2013-best-of-what-s-new-award-from-popular-science/" target="_blank"><img src="../../Images/whatsnew/topic2.jpg" style="max-width:100%;" /></a></li>
	<li><a href="http://www.americanstandard-us.com/pressroom/american-standard-invisia-soap-dish-named-to-list-of-100-best-new-home-products-by-this-old-house/" target="_blank"><img src="../../Images/whatsnew/topic3.jpg" style="max-width:100%;" /></a></li>
	<li><a href="http://flushforgood.com/" target="_blank"><img src="../../Images/whatsnew/topic4.jpg" style="max-width:100%;" /></a></li>
		<!--<li><img src="../../Images/whatsnew/Houzz_TowerFMA.jpg" /></li>
		<li><a href="http://flushforgood.com/" target="_blank"><img src="../../Images/whatsnew/FlushForGood_TowerFMA.jpg" style="max-width:100%;" /></a></li>
		<li><a href="http://www.americanstandard-us.com/WaterSense/" target="_blank"><img src="../../Images/whatsnew/Watersense_TowerFMA.jpg" /></a></li>
		<li><img src="../../Images/whatsnew/PowerfulThings_TowerFMA.jpg" /></li>-->
	</ul>
	</div><!--end:flexslider-->
	</div> <!-- Col 3 end -->
</div><!-- col set 3 end -->
</div> <!-- main end -->
</div> <!-- main container end -->
</form>
<script language="javascript" type="text/javascript">

function showvalue(arg)
{
	alert(arg);
	//arg.visible(false);
}

$(document).ready(function() {

	try {
		//oHandler = $(".mydds").msDropDown().data("dd");
		//oHandler.visible(true);
		//alert($.msDropDown.version);
		//$.msDropDown.create("body select");
		//$("#ver").html($.msDropDown.version);
	} catch(e) {
		alert("Error: "+e.message);
	}
})
/*
$(document).bind("keydown", function() {
	console.log("document keydown");
})
*/
</script>
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<script>
	$(window).load(function() {
	$('.flexslider').flexslider({
		namespace: "flex-",             //{NEW} String: Prefix string attached to the class of every element generated by the plugin
		selector: ".slides > li",       //{NEW} Selector: Must match a simple pattern. '{container} > {slide}' -- Ignore pattern at your own peril
		animation: "slide",              //String: Select your animation type, "fade" or "slide"
		easing: "swing",               //{NEW} String: Determines the easing method used in jQuery transitions. jQuery easing plugin is supported!
		direction: "vertical",        //String: Select the sliding direction, "horizontal" or "vertical"
		reverse: true,                 //{NEW} Boolean: Reverse the animation direction
		animationLoop: true,             //Boolean: Should the animation loop? If false, directionNav will received "disable" classes at either end
		smoothHeight: false,            //{NEW} Boolean: Allow height of the slider to animate smoothly in horizontal mode
		startAt: 0,                     //Integer: The slide that the slider should start on. Array notation (0 = first slide)
		slideshow: true,                //Boolean: Animate slider automatically
		slideshowSpeed: 7000,           //Integer: Set the speed of the slideshow cycling, in milliseconds
		animationSpeed: 600,            //Integer: Set the speed of animations, in milliseconds
		initDelay: 0,                   //{NEW} Integer: Set an initialization delay, in milliseconds
		randomize: false,               //Boolean: Randomize slide order

		// Usability features
		pauseOnAction: true,            //Boolean: Pause the slideshow when interacting with control elements, highly recommended.
		pauseOnHover: false,            //Boolean: Pause the slideshow when hovering over slider, then resume when no longer hovering
		useCSS: true,                   //{NEW} Boolean: Slider will use CSS3 transitions if available
		touch: true,                    //{NEW} Boolean: Allow touch swipe navigation of the slider on touch-enabled devices
		video: false,
		
		controlNav: true,
		directionNav: false
	});
	})
</script>