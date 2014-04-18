<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>

<script>
function initCart()
{
   window.onscroll = scroll_box;
   
   openCart();
     	
}
function openCart()
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
   var Y = 'Y';
   var N = 'N';
   content.innerHTML = '<div id="main_content"><h2><font size=4px align=center>YOU HAVE ITEM(S) LEFT IN YOUR CART SINCE YOUR LAST LOGIN</font></h2><br>Click on the <strong>Add to Cart</strong> button to continue order previously started OR click on the <strong>Discard</strong> button to delete all items added to Cart from the previous login session.<br><br><span style=" margin: 0 auto; display: block; width: 165px;"><input type="button" name="addCart" value="Add to Cart" onClick="addPerCart(\''+Y+'\')">&nbsp;&nbsp;<input type="button" name="discardFromCart" value="Discard" onClick="addPerCart(\''+N+'\')"></span>';
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

function addPerCart(addFlag)
{
   
   document.myFavForm.action="../ShoppingCart/ezGetPersistentCart.jsp?addFlag="+addFlag;
   document.myFavForm.submit();
}
</script>

<%
	String persistentStamp = (String)session.getValue("PERSISTENT");

	if(CartRetPCCnt>0 && !"Y".equals(persistentStamp))
	{
%>
		<script>
		window.onload=initCart ;
		</script>
<%		
	}
	else
	{
		session.putValue("PERSISTENT","Y");
	}

	session.setMaxInactiveInterval(14400);

	EzShoppingCartManager SCManager_H = new EzShoppingCartManager(Session);
	EzcShoppingCartParams params_H 	  = new EzcShoppingCartParams();
	EziShoppingCartParams subparams_H = new EziShoppingCartParams();

	EzShoppingCart Cart_H = null;
	subparams_H.setLanguage("EN");
	params_H.setObject(subparams_H);
	Session.prepareParams(params_H);

	try
	{
		Cart_H = (EzShoppingCart)SCManager_H.getSavedCart(params_H);
	}
	catch(Exception err){}

	String reDirectPage="../Misc/ezDashBoard.jsp";
	String negType = "ACCEPTED";
	if("3".equals((String)session.getValue("UserType")))
	{
		reDirectPage="../Misc/ezDisclaimerMain.jsp";
		negType = "INPROCESS";
	}
	

	String userFNameH = (String)session.getValue("FIRSTNAME");
	String userLNameH = (String)session.getValue("LASTNAME");

	Properties propBP=new Properties();

	try
	{
		String fileNameBP = "ezHeader.jsp";
		String filePathBP = request.getRealPath(fileNameBP);
		filePathBP = filePathBP.substring(0,filePathBP.indexOf(fileNameBP));
		filePathBP +="ezBestPrice.properties";

		propBP.load(new java.io.FileInputStream(filePathBP));
	}
	catch(Exception e){}

	String bestPrice = propBP.getProperty("BESTPRICE");

	String cartName_H = "My Cart";
	String catType_H ="";
	int cartCnt = Cart_H.getRowCount();
	if(Cart_H!=null && Cart_H.getRowCount()>0)
	{
		catType_H = (String)Cart_H.getType(0);
	}

	String currentPageName = request.getServletPath();

	/************************Default Sold To Name && Ship To Name --- Start******************************/

	String sesSysKey = (String)session.getValue("SalesAreaCode");
	String sesSoldTo = (String)session.getValue("AgentCode");
	String sesShipTo = (String)session.getValue("ShipCode");

	String shipToNameHead = "";

	if(sesShipTo!=null && !"null".equalsIgnoreCase(sesShipTo) && !"".equals(sesShipTo))
	{
		if(session.getValue("DISP_SH_NAME")==null)
		{
			ezc.ezparam.ReturnObjFromRetrieve retShipToName = null;
			ezc.ezparam.EzcParams mainParamsShip 		= new ezc.ezparam.EzcParams(false);

			ezc.ezmisc.params.EziMiscParams miscParamsShip 	= new ezc.ezmisc.params.EziMiscParams();

			String query="SELECT A.EC_BUSINESS_PARTNER,B.ECA_NAME FROM EZC_CUSTOMER A,EZC_CUSTOMER_ADDR B WHERE A.EC_NO = B.ECA_NO AND A.EC_PARTNER_NO='"+sesShipTo+"' AND A.EC_PARTNER_FUNCTION IN ('WE')";	//AND A.EC_SYS_KEY='"+sesSysKey+"' 

			miscParamsShip.setIdenKey("MISC_SELECT");
			miscParamsShip.setQuery(query);
			mainParamsShip.setLocalStore("Y");
			mainParamsShip.setObject(miscParamsShip);
			Session.prepareParams(mainParamsShip);	

			try
			{
				retShipToName = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsShip);

				if(retShipToName!=null && retShipToName.getRowCount()>0)
				{
					shipToNameHead = retShipToName.getFieldValueString("ECA_NAME");
					session.putValue("DISP_SH_NAME",shipToNameHead);
				}	
			}
			catch(Exception e){}
		}	
		else
		{
			shipToNameHead = (String)session.getValue("DISP_SH_NAME");
		}
	}

	/*********************Default Sold To Name && Ship To Name --- End**********************/
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<script src="../../Library/Script/jquery-1.8.3.js"></script>
<!--<script src="http://code.jquery.com/jquery-latest.js"></script>-->
<script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8.23.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery-ui-1.8.23.custom.css">
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-1115896-1']);
   _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<script type="text/javascript">

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
	{
		return true;
	}
}
function getProductDetailsHE(code)
{
	document.myFavForm.prodCode_D.value=code;
	document.myFavForm.action="../Catalog/ezProductDetails.jsp";
	document.myFavForm.submit();
}
function getProdDet()
{
	var prdcode = document.myFavForm.atpforHE.value;
	if(prdcode=='')
	{
		alert("Please enter the product code/description");
		return;
	}
	else
	{
		document.myFavForm.prodCode_D.value= prdcode;
		document.myFavForm.action="../Catalog/ezProductDetails.jsp";
		document.myFavForm.submit();
	}
}
function clrtxtHE()
{
	if(document.myFavForm.atpforHE.value=="Product Search")
	{
		document.myFavForm.atpforHE.value="";
	}
}
function enttxtHE()
{
	if(document.myFavForm.atpforHE.value=="")
	{
		document.myFavForm.atpforHE.value="Product Search";
	}
}
function funClick2(actionPage)
{
	document.myFavForm.action = actionPage;
	document.myFavForm.submit();
}
function funLogout(actionPage,cartCount)
{
	if(parseInt(cartCount)>0)
	{
		var r = confirm("You have items left in cart. Click OK if you want to retain for your next login!");
		var msg = 'N';
		if (r == true)
		{
		  msg = "Y";
		}
		else
		{
		  msg = "N";
		}
	}
	document.myFavForm.logoutCart.value= msg;
	document.myFavForm.action = actionPage;
	document.myFavForm.submit();
}

jQuery(function(){
	jQuery("#atpforHE").autocomplete("../ShoppingCart/listHeader.jsp");
});

// set options for html5shiv
if(!window.html5){
	window.html5 = {}; 
}
window.html5.shivMethods = false;
</script>

<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->
<!-- Tooltip -->
<link type="text/css" rel="stylesheet" href="../../Library/Styles/tooltip/css-tooltips.css" />

<!-- End of Tooltip -->
<link type="text/css" rel="stylesheet" href="../../Library/Styles/Misc/ezHeader.css" />

<script type="text/javascript" src="../../Library/Script/Misc/ezHeader.js"></script>

<script type="text/javascript" src="//use.typekit.net/mwb2rov.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>

<script type="text/javascript" src="shims/extras/modernizr-custom.js"></script>
<script type="text/javascript" src="shims/polyfiller.js"></script>
<script type="text/javascript" src="shims/webshim.js"></script>


</head>
<body>
<div class="header">
<div class="header-container">
<header>
<form name="myFavForm" method="post">
<input type="hidden" name="logoutCart">
<a href="../Misc/ezDashBoard.jsp" title="American Standard" class="logo"><img src="../../Library/Styles/logorevised.png" height="55px" width="237px" alt="American Standard" ><p style="
    margin-top: -65px;
    margin-left: 235px;
    color: #FFC20E;
    font-weight: bold;
    font-size: 18px;
">TEST</p></a><!--Images/amstd_logo.bmp-->
<div  class="quick-access noprint" style="width:505px !important; ">
	<ul class="links loggedin" style="z-index:1000; float:right;">

<%
	if(unreadNewsCnt>0)
	{
%>
		<li id="uncreadnews" class="first"><a href="javascript:funClick('../News/ezListNewsDash.jsp')">&nbsp;News&nbsp;[&nbsp;<%=unreadNewsCnt%>&nbsp;]</a></li>
<%
	} else {
%>
		<li id="uncreadnews" class="first"><a href="javascript:funClick('../News/ezListNewsDash.jsp')">&nbsp;News&nbsp;</a></li>
<%
	}
	if(messageCnt>0)
	{
%>
		<li id="uncreadnews"><a href="javascript:funClick('../Inbox/ezListPersMsgsMain.jsp')">&nbsp;Messages&nbsp;[&nbsp;<%=messageCnt%>&nbsp;]</a></li>
<%
	} else {
%>
		<li id="uncreadnews"><a href="javascript:funClick('../Inbox/ezListPersMsgsMain.jsp')">&nbsp;Messages&nbsp;</a></li>
<%
	}
%>
	<input type="hidden" name="catType_H" value='<%=catType_H%>'>
	<li class="my-cart">
		<a title="Cart" href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')">&nbsp;&nbsp;&nbsp;<%=cartName_H%>&nbsp;[&nbsp;<span id="cartcount"><%=cartCnt%></span>&nbsp;]&nbsp;&nbsp;<span id="cart-count"></span></a>
		<div class="dropdown-cart">
<%
		if(Cart_H!=null && Cart_H.getRowCount()>0)
		{
%>
			<div class="block-title" align="right"><strong><span>Chinaware,Toilets,Cast Iron</span></strong>
<%
				int zero=0;
				if(session.getValue("Chinaware")!=null && !"null".equals(session.getValue("Chinaware")))
				{
%>
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					<%=session.getValue("Chinaware")%>&nbsp;points&nbsp;</a>
<%
				}
				else 
				{
%>
					<%=zero%>&nbsp;points&nbsp;
<%
				}
%>	
			</div>
			<div class="block-title" align="right"><strong><span>Americast & Acrylics(Excludes Acrylux)</span></strong>
<%				
				if(session.getValue("Americast & Acrylics (Excludes Acrylux)")!=null && !"null".equals(session.getValue("Americast & Acrylics (Excludes Acrylux)")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Americast & Acrylics (Excludes Acrylux)")%>&nbsp;points&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>&nbsp;points&nbsp;
				
<%				}
%>			
			
				
			</div>
			<div class="block-title" align="right"><strong><span>Acrylux</span></strong>
<%				
				if(session.getValue("Acrylux")!=null && !"null".equals(session.getValue("Acrylux")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Acrylux")%>&nbsp;points&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>&nbsp;points&nbsp;
				
<%				}
%>			
			
				
			</div>
			<div class="block-title" align="right"><strong><span>Enamel Steel</span></strong>
<%				
				if(session.getValue("Enamel Steel")!=null && !"null".equals(session.getValue("Enamel Steel")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Enamel Steel")%>&nbsp;points&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>&nbsp;points&nbsp;
				
<%				}
%>			
			
				
			</div>
			<div class="block-title" align="right"><strong><span>Marble</span></strong>
<%				
				if(session.getValue("Marble")!=null && !"null".equals(session.getValue("Marble")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Marble")%>&nbsp;points&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>&nbsp;points&nbsp;
				
<%				}
%>			
			
				
			</div>
			<div class="block-title" align="right"><strong><span>Shower Doors( Standard/Custom Points)</span></strong>
<%				
				if(session.getValue("Shower Doors-Standard")!=null && !"null".equals(session.getValue("Shower Doors-Standard"))
					&& session.getValue("Shower Doors-Custom")!=null && !"null".equals(session.getValue("Shower Doors-Custom")))
				

				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Shower Doors-Standard")%>/<%=session.getValue("Shower Doors-Custom")%>&nbsp;&nbsp;</a>
				
<%				}

				else if((session.getValue("Shower Doors-Standard")==null || "null".equals(session.getValue("Shower Doors-Standard")))
					&& session.getValue("Shower Doors-Custom")!=null && !"null".equals(session.getValue("Shower Doors-Custom")))


				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=zero%>/<%=session.getValue("Shower Doors-Custom")%>&nbsp;&nbsp;</a>
				
<%				}
				else if((session.getValue("Shower Doors-Custom")==null || "null".equals(session.getValue("Shower Doors-Custom")))
					&& session.getValue("Shower Doors-Standard")!=null && !"null".equals(session.getValue("Shower Doors-Standard")))


				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Shower Doors-Standard")%>/<%=zero%>&nbsp;&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>/<%=zero%>&nbsp;&nbsp;
				
<%				}
%>			
			
				
			</div>
			<div class="block-title" align="right"><strong><span>Walk-In-Bath</span></strong>
<%				
				if(session.getValue("Walk In Baths")!=null && !"null".equals(session.getValue("Walk In Baths"))
					&& !"".equals(session.getValue("Walk In Baths")) && !"0.00".equals(session.getValue("Walk In Baths")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Walk In Baths")%>&nbsp;Pcs&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>&nbsp;Pcs&nbsp;
				
<%				}
%>			
			
				
			</div>
			<div class="block-title" align="right"><strong><span>Faucets (Non Luxury/ Luxury)</span></strong>
<%				
				if(session.getValue("Faucets(incl. Flush Valves)-Non Luxury")!=null  
					&& session.getValue("Faucets(incl. Flush Valves)-Luxury")!=null
					&& !"null".equals(session.getValue("Faucets(incl. Flush Valves)-Non Luxury"))
					&& !"null".equals(session.getValue("Faucets(incl. Flush Valves)-Luxury")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Faucets(incl. Flush Valves)-Non Luxury")%>/<%=session.getValue("Faucets(incl. Flush Valves)-Luxury")%>&nbsp;&nbsp;</a>
				
<%				}
				
				else if((session.getValue("Faucets(incl. Flush Valves)-Non Luxury")==null  
					|| "null".equals(session.getValue("Faucets(incl. Flush Valves)-Non Luxury"))) &&
					session.getValue("Faucets(incl. Flush Valves)-Luxury")!=null					
					&& !"null".equals(session.getValue("Faucets(incl. Flush Valves)-Luxury")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=zero%>/<%=session.getValue("Faucets(incl. Flush Valves)-Luxury")%>&nbsp;&nbsp;</a>
				
<%				}
				else if((session.getValue("Faucets(incl. Flush Valves)-Luxury")==null  
					|| "null".equals(session.getValue("Faucets(incl. Flush Valves)-Luxury"))) &&
					session.getValue("Faucets(incl. Flush Valves)-Non Luxury")!=null					
					&& !"null".equals(session.getValue("Faucets(incl. Flush Valves)-Non Luxury")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Faucets(incl. Flush Valves)-Non Luxury")%>/<%=zero%>&nbsp;&nbsp;</a>
				
<%				}

				else
				{
%>				
					<%=zero%>/<%=zero%>&nbsp;&nbsp;
				
<%				}
%>			
			
			</div>
			<div class="block-title" align="right"><strong><span>Repair Parts</span></strong>
<%				
				if(session.getValue("Repair Parts")!=null && !"null".equals(session.getValue("Repair Parts")) && !"0.00".equals(session.getValue("Repair Parts")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Repair Parts")%>&nbsp;&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>&nbsp;&nbsp;
				
<%				}
%>			
			
				
			</div>
			<div class="block-title" align="right"><strong><span>Jado</span></strong>
<%				
				if(session.getValue("JADO")!=null && !"null".equals(session.getValue("JADO")) && !"0.00".equals(session.getValue("JADO")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("JADO")%>&nbsp;&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>&nbsp;&nbsp;
				
<%				}
%>			
			
				
			</div>
			<div class="block-title" align="right"><strong><span>Fiat</span></strong>
<%				
				if(session.getValue("FIAT")!=null && !"null".equals(session.getValue("FIAT")) && !"0.00".equals(session.getValue("FIAT")))
				{
%>				
					<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')" style="text-decoration: none;color:#50B4B6;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("FIAT")%>&nbsp;&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<%=zero%>&nbsp;&nbsp;
				
<%				}
%>							
			</div>
			
<%
		}
%>			
		</div>
	</li>
	<style>	
		div.block-title p {color:#FFF !important;}
		div.block-title p:hover{color:#50B4B6 !important;}
		.flipresults {left:51.5% !important;}
	</style>
	<li class="help"><a title="Help" class="util-checkout" href="../Misc/ezFaq.jsp" target="_blank">&nbsp;Help&nbsp;</a></li>
	<li id="logout" ><a title="Log Out" href="javascript:funLogout('../Misc/ezLogout.jsp','<%=cartCnt%>')" >&nbsp;&nbsp;&nbsp;Log Out&nbsp;&nbsp;&nbsp;</a></li>
	</ul>

	<input type="hidden" name="prodCode_D">
	<input type="hidden" currentPage="<%=currentPageName%>">

	<div id="noprint" class="form-search">
	<h5 class="block-title" align="left">Hello&nbsp;<a class="username" href="javascript:funClick2('../SelfService/ezChangeAcctInfo.jsp')"><%=userFNameH%> <%=userLNameH%></a></h5>
	<h5 class="block-title" style="width:500px !important;" align="left">My Default Ship To : <a class="username" href="javascript:funClick2('../SwitchAccount/ezChangeSoldTo.jsp')" title="Default Ship to Helps to determine default address and state for Availability Checks"><%=shipToNameHead%> (<%=sesShipTo%>)</a></h5>
		<div style="float:right;">
		<script type="text/javascript">
			function flipResults() {
				var length = document.getElementById("atpforHE").value.length;
				if (length > 2 ) {jQuery(".ac_results").css("left","51.4%");}
			}
		</script>
		<input type="text" name="atpforHE" id="atpforHE" autocomplete="off" placeholder="Product Search" class="input-text" onKeyUp = "flipResults();" onKeyPress="return submitenterH(this.value,event);"  style="float: none;border: 1px solid grey !important;height: 25px !important"/>
		&nbsp;<button type="button" class="button" title="Go" onClick="getProdDet()" style="float: none;border: 1px solid grey !important;height: 25px !important"></button>
		</div>
	</div>        

</form>
</header>
</div>
</div>
</body>
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