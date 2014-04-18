<%
	String pageWithdraw = request.getParameter("status");
	if("".equals(pageWithdraw) && "null".equals(pageWithdraw) && pageWithdraw == null)
		pageWithdraw="";
	String poN = request.getParameter("poNum");
	if("".equals(poN) && "null".equals(poN) && poN == null)
		poN="";
		
%>


<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->

<Script>
function funBack()
{
	history.go(-1)
}

function withDr()
{
<%
	if(!"".equals(pageWithdraw) && !"null".equals(pageWithdraw) && pageWithdraw != null)
	{
%>		
		var response = '<%=pageWithdraw%>';
		var po = '<%=poN%>';
		var alertIcon ;
		if(response=='S')
		{
			alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
			new HelloBar( '<span>'+ alertIcon +' Order '+po+' has been closed.</span> ', {
					showWait: 100,
					positioning: 'sticky',
					fonts: 'Arial, Helvetica, sans-serif',
					forgetful: true,
					helloBarLogo : false,
					height : 30						
			}, 1.0 );

			Popup.hide('modal');
		}
		else
		{
			alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
			new HelloBar( '<span>'+ alertIcon +' Order '+po+' already closed.</span> ', {
					showWait: 100,
					positioning: 'sticky',
					fonts: 'Arial, Helvetica, sans-serif',
					forgetful: true,
					helloBarLogo : false,
					height : 30						
			}, 1.0 );

			Popup.hide('modal');
		}
<%
	}
%>
}

</Script>
<body  onload="withDr()">


<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
 <div class="main">
 <form name="myForm" method = 'POST'>
    <div class="col-main roundedCorners" style="margin-bottom:10px;">
       <div class="my-account">
        
          <div class="block block-account">
		<div class="block" style="padding-left:0px; width:100%;">
			<div class="block-title">
		<strong>
			<span>ORDERS DASHBOARD</span>
		</strong>
			</div>
		</div>


<div class="col2-set">
	<div class="col-1">
		<div class="info-box">
		<% if(!"CU".equals(userRole)) { %>

			<a href="../ShoppingCart/ezViewCart.jsp"><h1 class="orderDBh1">1</h1></a>
			<h3> Fast Entry </h3>
			<p> Just Provide American Standard SKU# and Quantity to place order.Ideal for users with American Standard Price Paper Catalogue handy. </p>
			<a href="../Quotes/ezJobQuotes.jsp"><h1 class="orderDBh1">3</h1></a>
			<h3> Job Quote Reference </h3>
			<p> Use this to place order if you have open unexpired Job Quote </p>
			<a href="../Catalog/ezCatalogDisplay.jsp?catalogType=standard&orderNeed=standard"><h1 class="orderDBh1">5</h1></a>
			<h3>Browse Catalog and Add to Cart</h3>
			<p> Clicking on the Link will take you to Catalog Browsing Pages. </p>
		</div>
	</div>
	<div class="col-2">
		<div class="info-box" >
			<a href="../Sales/ezSavedOrders.jsp?statusType=saved"><h1 class="orderDBh1">2</h1></a>
			<h3> Use A Template </h3>
			<p> Use a Previously Saved Order/Template Order to place a new one </p>

			<a href="../Sales/ezClosedSalesOrders.jsp"><h1 class="orderDBh1">4</h1></a>
			<h3> File a Claim </h3>
			<p> Use this link to file a Qualifying Claim. Shipped Orders will be listed to choose from.</p>
			<a href="../Sales/ezSalesOrders.jsp"><h1 class="orderDBh1">6</h1></a>
			<h3>Repeat Earlier Portal Order</h3>
			<p> Choose an order and click Repeat to add its items to Cart </p>

			<% } else { %>

			<a href="../ShoppingCart/ezViewCart.jsp"><h1 class="orderDBh1">1</h1></a>
			<h3> Fast Entry </h3>
			<p> Just Provide American Standard SKU# and Quantity to place order.Ideal for users with American Standard Price Paper Catalogue handy. </p>
			<a href="../Quotes/ezJobQuotes.jsp"><h1 class="orderDBh1">3</h1></a>
			<h3> Job Quote Reference </h3>
			<p> Use this to place order if you have open unexpired Job Quote </p>
			<a href="../Catalog/ezCatalogDisplay.jsp?catalogType=standard&orderNeed=standard"><h1 class="orderDBh1">5</h1></a>
			<h3>Browse Catalog and Add to Cart</h3>
			<p> Clicking on the Link will take you to Catalog Browsing Pages. </p>
		</div>
	</div>
	<div class="col-2">
		<div class="info-box" >
			<a href="../Sales/ezSavedOrders.jsp?statusType=saved"><h1 class="orderDBh1">2</h1></a>
			<h3> Use A Template </h3>
			<p> Use a Previously Saved Order/Template Order to place a new one </p>

			<a href="../Sales/ezClosedSalesOrders.jsp"><h1 class="orderDBh1">4</h1></a>
			<h3> File a Claim </h3>
			<p> Use this link to file a Qualifying Claim. Shipped Orders will be listed to choose from.</p>
			<a href="../Sales/ezSalesOrders.jsp"><h1 class="orderDBh1">6</h1></a>
			<h3>Repeat Earlier Portal Order</h3>
			<p> Choose an order and click Repeat to add its items to Cart </p>

			<% } %>
		</div> <!-- infobox -->
	</div> <!-- col-2 -->
</div> <!-- col set-->
</div> <!-- col2-set -->

</div> <!-- my account -->
</div> <!-- col-main -->
</Form>
<%@ include file="ezMyOrdersMenuLink.jsp"%>
</div> <!-- main-container col1-layout -->
</div> <!-- main-container col2-layout -->







</Body>