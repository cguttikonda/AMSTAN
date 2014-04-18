<!DOCTYPE html>
<html lang="en">
<head>
<META HTTP-EQUIV="refresh" CONTENT="<%= session.getMaxInactiveInterval() %>; URL=../Misc/ezLogout.jsp">


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



<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%
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
<div class="header">
<div class="header-container">
<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->


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
</script>
<script type="text/javascript" src="//use.typekit.net/mwb2rov.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>

<header>
<body>
<form name="myFavForm" method="post">
<a href="../Misc/ezDashBoard.jsp" title="American Standard" class="logo"><img src="../../Library/Styles/logorevised.png" height="55px" width="237px" alt="American Standard" ></a><!--Images/amstd_logo.bmp-->
<div  class="quick-access">
	<ul class="links loggedin">

	<%	if(unreadNewsCnt>0)
				{
	%>				
		<li id="uncreadnews" class="first"><a href="../News/ezListNewsDash.jsp?newsFilter=OM">&nbsp;News&nbsp;[&nbsp;<%=unreadNewsCnt%>&nbsp;]</a></li>
	<%			}
				else 
				{
	%>				
		<li id="uncreadnews" class="first"><a href="../News/ezListNewsDash.jsp?newsFilter=OM">&nbsp;News&nbsp;</a></li>
	<%			}
	%>	   
	<%			
	if(messageCnt>0)
		{
	%>				
		<li id="uncreadnews"><a href="../Inbox/ezListPersMsgsMain.jsp">&nbsp;Messages&nbsp;[&nbsp;<%=messageCnt%>&nbsp;]</a></li>

	<%			
	}
	else 
	{
	%>				
		<li id="uncreadnews"><a href="../Inbox/ezListPersMsgsMain.jsp">&nbsp;Messages&nbsp;</a></li>
	<%			
				}
	%>

	
	

<!--	<li id="selfservice"><a title="Self Service" href="http://www.answerthink.com/sales/selfservice/">Self Service</a></li> -->
<!--	<li id="myaccount" class="my-alerts"><a title="My Account" href="../Misc/ezDashBoard.jsp">&nbsp;&nbsp;&nbsp;My Alerts&nbsp;&nbsp;&nbsp;</a> -->
		<div class="dropdown-cart">
			<div class="block-title">
				<strong><span>Alerts</span></strong>
			</div>
			<div class="block-title" align="right">
				
				
				
<%				if(countMisc>0)
				{
%>				
				<a href="../Sales/ezNegotiatedOrders.jsp?negotiateType=INPROCESS&ORDERTYPE=N" 
				style="text-decoration: none;color:#66CC33;"><strong><span>Orders in Review</span></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=countMisc%>&nbsp;&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<strong><span>Orders in Review</span></strong><%=countMisc%>&nbsp;&nbsp;
				
<%				}
%>
				
			</div>
			<div class="block-title" align="right">
				
				
<%				if(countMisc1>0)
				{
%>				
				<a href="../Sales/ezSavedOrders.jsp" style="text-decoration: none;color:#66CC33;"><strong><span>Saved Orders</span></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=countMisc1%>&nbsp;&nbsp;</a>
				
<%				}
				else 
				{
%>				
					<strong><span>Saved Orders</span></strong><%=countMisc1%>&nbsp;&nbsp;				
<%				}
%>					

				
				
			</div>
			<div class="block-title" align="right">
			
<%				if(1>0)
				{
%>														
					<a href="../Invoices/ezOpenInvoices.jsp" style="text-decoration: none;color:#66CC33;"><strong><span>Open Invoices</span></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TBD&nbsp;&nbsp;</a>				
				
<%				}
				else 
				{
%>				
					<strong><span>Open Invoices</span></strong>TBD&nbsp;&nbsp;
				
<%				}
%>	
				
				
				
			</div>
			<div class="block-title" align="right">
				
				
<%				if(SalQCnt>0)
				{
%>				
					<a href="../Quotes/ezExpiringJobQuotes.jsp" style="text-decoration: none;color:#66CC33;"><strong><span>Expiring Job Quotes</span></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=SalQCnt%>&nbsp;&nbsp;</a>
					
<%				}
				else  
				{
%>				
					<strong><span>Expiring Job Quotes</span></strong><%=SalQCnt%>&nbsp;&nbsp;
				
<%				}
%>					
				
				
				
			</div>
			<div class="block-title" align="right">				
<%				if(messageCnt>0)
				{
%>				
					<a href="../Inbox/ezListPersMsgsMain.jsp" style="text-decoration: none;color:#66CC33;"><strong><span>Unread Messages</span></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=messageCnt%>&nbsp;&nbsp;</a>
<%				}
				else  
				{
%>				
					<strong><span>Unread Messages</span></strong><%=messageCnt%>&nbsp;&nbsp;

<%				}
%>					
			</div>
			<div class="block-title" align="right">
				
				
				
<%				if(unreadNewsCnt>0)
				{
%>				
					<a href="../News/ezListNewsDash.jsp" style="text-decoration: none;color:#66CC33;"><strong><span>Unread News</span></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=unreadNewsCnt%>&nbsp;&nbsp;</a>
<%				}
				else  
				{
%>				
					<strong><span>Unread News</span></strong><%=unreadNewsCnt%>&nbsp;&nbsp;
				
<%				}
%>					
			</div>
			
			
			<div class="block-title" align="right">
				<a href="javascript:void(0)" style="text-decoration: none;color:#66CC33;"><strong><span>Active Promotions</span></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;&nbsp;</a>
			</div>
			
			
			<div class="block-title" align="right">
				<a href="javascript:void(0)" style="text-decoration: none;color:#66CC33;"><strong><span>Open RGA Claims</span></strong>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4&nbsp;&nbsp;</a>
			</div>
		</div>
<!--	</li> -->
	
	<!--<li class="wishlist"><a title="Favorites" href="../Catalog/ezGetFavProdMain.jsp">My Favorites</a>
		<div class="dropdown-wishlist">-->
<%
		
		
		/*		
		if(catalogProductsRetObj_F!=null && catalogProductsRetObj_F.getRowCount()>0)
		{
			int favCnt = catalogProductsRetObj_F.getRowCount();
			if(favCnt>5)favCnt=4;
%>
			<div class="block-title">
				<strong><span>Products</span></strong>
			</div>
			<div class="block-content">
<%
			
			for(int h=0;h<favCnt;h++)
			{
				String prodDesc = nullChk(catalogProductsRetObj_F.getFieldValueString(h,"PROD_DESC"));
				String webSKU   = catalogProductsRetObj_F.getFieldValueString(h,"EZP_WEB_SKU");
				String categoryId = catalogProductsRetObj_F.getFieldValueString(h,"EPF_ITEMCAT");
				String currPrice = eliminateDecimal(catalogProductsRetObj_F.getFieldValueString(h,"EZP_CURR_PRICE"));
				String eanUpc = catalogProductsRetObj_F.getFieldValueString(h,"EZP_UPC_CODE");
				String prodCode = catalogProductsRetObj_F.getFieldValueString(h,"EZP_PRODUCT_CODE");
				String favDtl = prodCode+"~~"+categoryId+"~~CNET";
				String prodLinkH = catalogProductsRetObj_F.getFieldValueString(h,"EZA_LINK");
				
				if(prodLinkH==null || "null".equals(prodLinkH) || "".equals(prodLinkH)) 
				{
					prodLinkH="../../Images/noimage.gif";								
				}
%>			
				<ol class="mini-products-list" id="wishlist-sidebar">
				<li class="item">
				
				<a href="javascript:getProductDetails('<%=prodCode%>')" title='<%=prodDesc%>' class="product-image"><img src="<%=prodLinkH%>" width="80" height="89" alt='<%=prodDesc%>'></a>
					<div class="product-details">
					<!--<p class="product-name"><a href="javascript:getCatDetails('<%=categoryId%>')" title='<%=categoryId%>'  ><%=categoryId%></a></p>-->
					
					<p class="set-config"><%=prodDesc%></p>
					<p class="cat-num">Item #<%=webSKU%></p>
					<p class="cat-num">List Price: $<%=currPrice%></p>
							<div class="grid-qty-cont">
								<label class="grid-qty-label">Qty:</label>
								<input type="text" name="qty_<%=h%>" id="qty_<%=h%>" value="1" class="grid-qty-input">
							</div>
							<button type="button" title="Add to Cart" class="button btn-cart" onclick="addToCart_F('<%=h%>')">
							<span><span>Add to Cart</span></span></button>
							<a href="#" onClick="delFav_F('<%=favDtl%>')"><img style="valign:bottom" src="../../Images/Common/delete_icon.gif" height="20" width="20" border=0  style='cursor:hand' title="Delete Item."></a>
							<input type="hidden" name="prodDesc_<%=h%>" value='<%=prodDesc%>'>
							<input type="hidden" name="prodCode_<%=h%>" value="<%=webSKU%>">
							<input type="hidden" name="listPrice_<%=h%>" value="<%=currPrice%>">
							<input type="hidden" name="eanUpc_<%=h%>" value="<%=eanUpc%>">
							<input type="hidden" name="categoryID_<%=h%>" value="<%=categoryId%>">							
					
				</li>
				</ol>
<%
			}
			if(catalogProductsRetObj_F.getRowCount()>5)
			{
%>			
				<div class="block-title">
					<a href="../Catalog/ezGetFavProdMain.jsp">More..</a>
				</div>
<%
			}
%>			

			<input type="hidden" name="prodIden">
			<input type="hidden" name="favDtl">
			<input type="hidden" name="prodCode_D">
			<input type="hidden" name="catIte">
			</div>
<%
		}
		else
		{
%>			<div class="block-title">
				<strong><span>No Products</span></strong>
			</div>
<%
		}
		*/
%>		
		<!--</div>
		
	</li>-->
<%
	String cartName_H = "My Cart";
	String catType_H ="";
	int cartCnt = Cart_H.getRowCount();
	if(Cart_H!=null && Cart_H.getRowCount()>0)
	{
		catType_H = (String)Cart_H.getType(0);

		if("Q".equals(catType_H)) cartName_H = "QS Cart";
		else if("FOC".equals(catType_H)) cartName_H = "FOC Cart";
		else if("C".equals(catType_H)) cartName_H = "Custom Cart";
	}
%>
<input type="hidden" name="catType_H" value='<%=catType_H%>'>
	<li class="my-cart">
		<a title="Cart" href="../ShoppingCart/ezViewCart.jsp">&nbsp;&nbsp;&nbsp;<%=cartName_H%>&nbsp;[&nbsp;<span id="cartcount"><%=cartCnt%></span>&nbsp;]&nbsp;&nbsp;<span id="cart-count"></span></a>
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Shower Doors-Standard")%>/<%=session.getValue("Shower Doors-Custom")%>&nbsp;&nbsp;</a>
				
<%				}

				else if((session.getValue("Shower Doors-Standard")==null || "null".equals(session.getValue("Shower Doors-Standard")))
					&& session.getValue("Shower Doors-Custom")!=null && !"null".equals(session.getValue("Shower Doors-Custom")))


				{
%>				
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=zero%>/<%=session.getValue("Shower Doors-Custom")%>&nbsp;&nbsp;</a>
				
<%				}
				else if((session.getValue("Shower Doors-Custom")==null || "null".equals(session.getValue("Shower Doors-Custom")))
					&& session.getValue("Shower Doors-Standard")!=null && !"null".equals(session.getValue("Shower Doors-Standard")))


				{
%>				
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">

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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=session.getValue("Faucets(incl. Flush Valves)-Non Luxury")%>/<%=session.getValue("Faucets(incl. Flush Valves)-Luxury")%>&nbsp;&nbsp;</a>
				
<%				}
				
				else if((session.getValue("Faucets(incl. Flush Valves)-Non Luxury")==null  
					|| "null".equals(session.getValue("Faucets(incl. Flush Valves)-Non Luxury"))) &&
					session.getValue("Faucets(incl. Flush Valves)-Luxury")!=null					
					&& !"null".equals(session.getValue("Faucets(incl. Flush Valves)-Luxury")))
				{
%>				
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=zero%>/<%=session.getValue("Faucets(incl. Flush Valves)-Luxury")%>&nbsp;&nbsp;</a>
				
<%				}
				else if((session.getValue("Faucets(incl. Flush Valves)-Luxury")==null  
					|| "null".equals(session.getValue("Faucets(incl. Flush Valves)-Luxury"))) &&
					session.getValue("Faucets(incl. Flush Valves)-Non Luxury")!=null					
					&& !"null".equals(session.getValue("Faucets(incl. Flush Valves)-Non Luxury")))
				{
%>				
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
					<a href="../ShoppingCart/ezViewCart.jsp" style="text-decoration: none;color:#66CC33;">
					
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
		else
		{
%>			<div class="block-title">
				<strong><span>You have no items in your shopping cart.</span></strong>
			</div>
<%
		}
%>			
		</div>
	</li>
	<li class="checkout-link">
<%
	if("FOC".equals(catType_H))
	{
%>
	<a title="Checkout" class="util-checkout" href="../Sales/ezPrepareFOCOrder.jsp">Checkout</a>
<%
	}
	else
	{
%>
	<!--<a title="Checkout" class="util-checkout" href="../Sales/ezPrepareSalesOrder.jsp">Checkout</a>-->
<%
	}
%>
	</li>
	
	<li class="checkout-link">
		<a title="Help" class="util-checkout" href="../Misc/shipping.html" target="_blank">&nbsp;Help&nbsp;</a>
	
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

	<h5 class="block-title" align="left">Hello&nbsp;<a href="../SelfService/ezChangeAcctInfo.jsp"><%=userFNameH%> <%=userLNameH%></a></h5> 	
 	<!-- <h5 class="block-title" align="left">Default Sold To : <a href="../SwitchAccount/ezChangeSoldTo.jsp"><%=soldToNameHead%> (<%=sesSoldTo%>)</a></h5> -->
 	
	<h5 class="block-title" align="left">My Default Ship To : <a href="../SwitchAccount/ezChangeSoldTo.jsp" title="What is def. shipto"><%=shipToNameHead%> (<%=sesShipTo%>)</a></h5> 
	<!--<h5 class="block-title" align="left">Default Ship To : <a href="../SwitchAccount/ezChangeShipTo.jsp"><%=shipToNameHead%> (<%=sesShipTo%>)</a></h5> -->
        <!--<h5 class="block-title" align="left">Welcome : <%=userFNameH%> <%=userLNameH%></a></h5>-->
                
       <input type="text" name="atpforHE" autocomplete="off" value="Product Search"  onfocus='clrtxtHE()' onblur='enttxtHE()' id="atpforHE" class="search_imgHS"  onKeyPress="return submitenterH(this.value,event)"  onkeyup="lookupHE1(this.value)" />
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