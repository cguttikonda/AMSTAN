<!DOCTYPE html>
<html lang="en">
<head>
<META HTTP-EQUIV="refresh" ><!--CONTENT="<%= session.getMaxInactiveInterval() %>; URL=../Misc/ezLogout.jsp"-->
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


<!--<script type="text/javascript">

   var _gaq = _gaq || [];
   
   _gaq.push(['b._setAccount', 'UA-1115896-1']);
   _gaq.push(['b._trackPageview']);
   

   (function() {
     var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
     ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
     var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
   })();

</script>-->

</head>

<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>

<%
	
	response.setHeader("X-UA-Compatible", "chrome=1");
	
	session.setMaxInactiveInterval(14400);
	//out.println("Inactive Interval: " +session.getMaxInactiveInterval());
	
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
%>

<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->
<!-- Tooltip -->
<link type="text/css" rel="stylesheet" href="../../Library/Styles/tooltip/css-tooltips.css" />

<!-- End of Tooltip -->

<script>

function addToCart_F(num)
{
	
	//document.myFavForm.prodIden.value=num;

	//document.myFavForm.action="../ShoppingCart/ezAddCartItems.jsp";
	//document.myFavForm.submit();
	var catType=document.myFavForm.catType_H.value;
			
	if(catType=='Q')
	{
		alert("Cart contains Quick Ship items. \nPlease remove them to add other items");
		return false;
	}
	else if(catType=='C')
	{
		alert("Cart contains Custom items. \nPlease remove them to add other items");
		return false;
	}
	else
	{
		addToFavHead(num);
	}
	
}
var req
var pcodeh
function addToFavHead(val)
{	
	
	req=Initialize();

	if (req==null)
	{
	alert ("Your browser does not support Ajax HTTP");
	return;
	}			
	
	var url

	var atpfor  = eval("document.myFavForm.prodCode_"+val).value;
	var atpqty  = eval("document.myFavForm.qty_"+val).value;
	var atpdesc = eval("document.myFavForm.prodDesc_"+val).value;
	var atpprice= eval("document.myFavForm.listPrice_"+val).value;
	var atpupc  = eval("document.myFavForm.eanUpc_"+val).value;

	pcodeh=atpfor

	url="../ShoppingCart/ezAddCartItems.jsp";
	url=url+"?atpfor="+atpfor+"&atpqty="+atpqty+"&atpdesc="+atpdesc+"&atpprice="+atpprice+"&atpupc="+atpupc;			

	
	if(req!=null)
	{			
		req.onreadystatechange = Processh;
		req.open("GET", url, true);
		req.send(null);
	}			
}

function Processh() 
{	
	
	if (req.readyState == 4)
	{
		var resText     = req.responseText;	 	        	
		if (req.status == 200)
		{			

			var alertCodeh					
			var barCol = '#eb593c'
			if(resText.indexOf("NA")!=-1)
			{
				alertCodeh='could not be'
			}
			else
			{
				alertCodeh='has been successfully'
				barCol = '#71c6aa'
			}
				
			

			new HelloBar( '<span>Product ' +pcodeh+ ' '+alertCodeh+ ' added to Cart.</span><a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>', {

			showWait: 1000,
			positioning: 'sticky',
			fonts: 'Arial, Helvetica, sans-serif',
			forgetful: true,
			helloBarLogo : false,
			barColor : barCol,
			height : 30

			}, 1.0 );					

		}
		else
		{
			if(req.status == 500)	 
			alert("Error in adding product(s)");
		}
		
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
function delFav_F(num)
{
	//alert("num::::::::::::::::::::::::::"+num)
	document.myFavForm.favDtl.value=num;

	document.myFavForm.action="../Catalog/ezDelFavItems.jsp";
	document.myFavForm.submit();
}
function getProductDetails(code)
{
	document.myFavForm.prodCode_D.value=code;

	document.myFavForm.action="../Catalog/ezProductDetails.jsp";
	document.myFavForm.submit();
}
function getCatDetails(catId)
{
	document.myFavForm.catIte.value=catId;

	document.myFavForm.action="../Catalog/ezProductsDisplay.jsp";
	document.myFavForm.submit();

}
function funClick(actionPage)
{
	document.myFavForm.action = actionPage;
	document.myFavForm.submit();
}

function funHelp()
{
	document.myFavForm.action="../Misc/ezHelp.jsp";
	document.myFavForm.target = "_blank";
	document.myFavForm.submit();
}


</script>
<script type="text/javascript" src="//use.typekit.net/mwb2rov.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>

<%
	String cartName_H = "My Cart";
	String catType_H ="";
	int cartCnt = Cart_H.getRowCount();
	if(Cart_H!=null && Cart_H.getRowCount()>0)
	{
		catType_H = (String)Cart_H.getType(0);
		
	}
%>
<div class="header">
<div class="header-container">
<header>
<body>
<form name="myFavForm" method="post">
<a href="../Misc/ezDashBoard.jsp" title="American Standard" class="logo"><img src="../../Library/Styles/logorevised.png" height="55px" width="237px" alt="American Standard" ></a><!--Images/amstd_logo.bmp-->
<div  class="quick-access noprint" style="width:505px !important; ">
	<ul class="links loggedin" style="z-index:1000;">

<%	if(unreadNewsCnt>0)
	{
%>				
	<li id="uncreadnews" class="first"><a href="javascript:funClick('../News/ezListNewsDash.jsp')">&nbsp;News&nbsp;[&nbsp;<%=unreadNewsCnt%>&nbsp;]</a></li>
<%	}
	else 	{
%>				
	<li id="uncreadnews" class="first"><a href="javascript:funClick('../News/ezListNewsDash.jsp')">&nbsp;News&nbsp;</a></li>
<%	}
%>	   
<%			
	if(messageCnt>0)
	{
%>				
	<li id="uncreadnews"><a href="javascript:funClick('../Inbox/ezListPersMsgsMain.jsp')">&nbsp;Messages&nbsp;[&nbsp;<%=messageCnt%>&nbsp;]</a></li>

<%			
	}
else 
	{
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
		//else
		//{
%>			<!--<div class="block-title">
				<strong><span>You have no items in your shopping cart.</span></strong>
			</div>-->
<%
		//}
%>			
		</div>
	</li>
	
<style>	
	div.block-title p {color:#FFF !important;}
	div.block-title p:hover{color:#50B4B6 !important;}
</style>

	<li class="help">
		<a title="Help" class="util-checkout" href="../Misc/ezFaq.jsp" target="_blank">&nbsp;Help&nbsp;</a>
		<!--<div class="dropdown-cart">
		<div class="block-title" align="right">
		<p><strong>THIS PAGE</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:funHelp();"  target="_blank" style="text-decoration: none;color:#50B4B6;">Click here</a></p></div>
		<p class="tip-below" data-tip=""><strong>THIS PAGE : Help page</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></div>
		<div class="block-title" align="right">
		<p><strong>FREQUENTLY ASKED QUESTIONS</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../Misc/ezFaq.jsp" target="_blank" style="text-decoration: none;color:#50B4B6;">Click here</a></p></div>
		<div class="block-title" align="right">
		<p><strong>HOW TO</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../Misc/ezHowTos.jsp" style="text-decoration: none;color:#50B4B6;">Click here</a></p></div>
		</div>-->
	
	</li>
	
	<li id="logout" ><a title="Log Out" href="../Misc/ezLogout.jsp">&nbsp;&nbsp;&nbsp;Log Out&nbsp;&nbsp;&nbsp;</a></li>
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
						
		/*ReturnObjFromRetrieve retsoldtoHead = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(sesSysKey);
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
		}*/
	
		//UtilManager.setSysKeyAndSoldTo(sesSysKey,sesSoldTo);
		//ReturnObjFromRetrieve  listShipTosHead = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(sesSoldTo);
		//out.println("listShipTosHead"+listShipTosHead.toEzcString());
		String shipToNameHead = "";

		if(sesShipTo!=null && !"null".equalsIgnoreCase(sesShipTo) && !"".equals(sesShipTo))
		{
			ezc.ezparam.ReturnObjFromRetrieve retShipToName = null;
			ezc.ezparam.EzcParams mainParamsShip 		= new ezc.ezparam.EzcParams(false);

			ezc.ezmisc.params.EziMiscParams miscParamsShip 	= new ezc.ezmisc.params.EziMiscParams();

			String query="SELECT A.EC_BUSINESS_PARTNER,B.ECA_NAME FROM EZC_CUSTOMER A,EZC_CUSTOMER_ADDR B WHERE A.EC_NO = B.ECA_NO AND A.EC_PARTNER_NO='"+sesShipTo+"' AND A.EC_PARTNER_FUNCTION IN ('WE')";

			miscParamsShip.setIdenKey("MISC_SELECT");
			miscParamsShip.setQuery(query);
			mainParamsShip.setLocalStore("Y");
			mainParamsShip.setObject(miscParamsShip);
			Session.prepareParams(mainParamsShip);	

			try
			{
				retShipToName = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsShip);

				if(retShipToName!=null && retShipToName.getRowCount()>0)
					shipToNameHead = retShipToName.getFieldValueString("ECA_NAME");
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
			}
		}

		/*if(listShipTosHead!=null)
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
		}*/
		
		//out.println("shipToNameHead"+shipToNameHead);
		//out.println("sesShipTo"+sesShipTo);
			
	/*********************Default Sold To Name && Ship To Name --- End**********************/
	%>
	
<!-- auto complete STARTS-->

<style>
.flipresults {left:51.5% !important;}
</style>

<script type="text/javascript">
jQuery(function(){

jQuery("#atpforHE").autocomplete("../ShoppingCart/listHeader.jsp");

});


/*function submitenterH(myfield,e)
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
}*/

function getProductDetailsHE(code)
{
	document.srchformH.prodCode_D.value=code;
	document.srchformH.action="../Catalog/ezProductDetails.jsp";
	document.srchformH.submit();
}

function getProdDet()
{
	var prdcode = document.srchformH.atpforHE.value;
	if(prdcode=='')
	{
		alert("Please enter the product code/description");
		return;
	}
	else
	{
		document.srchformH.prodCode_D.value= prdcode;
		document.srchformH.action="../Catalog/ezProductDetails.jsp";
		document.srchformH.submit();
	}
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

	
<script type="text/javascript">
/*var typewatch = function(){
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




*/
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
color: #50b4b6; /*8B0000*/
}

.search_imgHS{
background:#ffffff url(../../Library/images/btn-search.png) no-repeat right;
text-align:left;
}
</style>
	
	 
	
<!-- auto complete ENDS-->

<head>
<script>


function funClick2(actionPage){
	
	document.srchformH.action = actionPage;
	document.srchformH.submit();
}


</script>

<!--<script type="text/javascript" src="../../Library/Script/TimeOut/jquery-1.4.1.min.js"></script>-->
  <!--<script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8rc1.custom.min.js"></script> -->
  <script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8.23.custom.min.js"></script>
  <link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery-ui-1.8.23.custom.css">
  <script type="text/javascript" src="../../Library/Script/TimeOut/jquery.idletimer.js"></script>
  <script type="text/javascript">
  
  	
	   
 
	/*var idleTime = 1740000; // number of miliseconds until the user is considered idle
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

	});*/
	
		 
		
  
  </script>

</head>

<body>
<% 
String currentPageName = request.getServletPath();

%>

<form name="srchformH" id="search_mini_form" method="post">
<input type="hidden" name="prodCode_D">
<input type="hidden" currentPage="<%=currentPageName%>">
<div id="noprint" class="form-search">

	<h5 class="block-title" align="left">Hello&nbsp;<a class="username" href="javascript:funClick2('../SelfService/ezChangeAcctInfo.jsp')"><%=userFNameH%> <%=userLNameH%></a></h5> 	
 	
	<h5 class="block-title" style="width:500px !important;" align="left">My Default Ship To : <a class="username" href="javascript:funClick2('../SwitchAccount/ezChangeSoldTo.jsp')" title="Default Ship to Helps to determine default address and state for Availability Checks"><%=shipToNameHead%> (<%=sesShipTo%>)</a></h5> 
                
       <div>
			<script type="text/javascript">
						function flipResults() {
						//alert(document.activeElement.id);
						//alert(jQuery(".ac_results").css("left"))
						//if (document.activeElement.id == "atpforHE") { 

						var length = document.getElementById("atpforHE").value.length;

						if (length > 2 ) {jQuery(".ac_results").css("left","51.4%");}


						//}
						//alert(jQuery(".ac_results").css("left"))
						}
			</script>
       <input type="text" name="atpforHE" id="atpforHE" autocomplete="off" placeholder="Product Search" class="input-text" onKeyUp = "flipResults();" onKeyPress="return submitenterH(this.value,event);"  style="float: none;border: 1px solid grey !important;height: 25px !important"/> 
       &nbsp;<button type="button" class="button" title="Go" onClick="getProdDet()" style="float: none;border: 1px solid grey !important;height: 25px !important"></button>
       </div>
       
       <!--     onkeyup="lookupHE1(this.value)" -->
</div>        
    	<!--<div class="suggestionsBoxHE" id="suggestionsHE" style="display: none;">
       	<div class="suggestionListHE" id="autoSuggestionsListHE">
       	</div>
   	</div>-->
</form>
<div id="sessionTimeoutWarning" style="display: none"></div>
</body>


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