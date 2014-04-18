

<form name="menuForm" method="post">
<div id = "noprint" class="nav-container">
<ul id="nav">

	<li class="level0 nav-1 level-top first parent" id="">
	
	<a href="#" class="level-top"><span>Products</span></a>
		<div class="nav-arrow"></div>
		<ul class="level0">
		<li class="level1 nav-1-1 first" id="">
		<a href="javascript:funClick('../Catalog/ezGetFavProdMain.jsp')"><span>My Favorites</span></a></li>
		<li  class="level1 nav-1-2" id="">
		<a href="javascript:funClick('../Catalog/ezCatalogDisplay.jsp')"><span>ASB Product Categories</span></a></li>
		<li  class="level1 nav-1-3" id="">
		<a href="javascript:funClick('../Catalog/ezSubCatalogDisplay.jsp?dxvOrGeneral=DXV&mainCatID=DXVPRODUCTS&mainCatDesc=DXV Products')"><span>DXV Product Categories</span></a></li>
		<!-- <li  class="level1 nav-1-3" id="">
		<a href="../Catalog/ezCatalogDisplay.jsp?ctype='P'"><span>Price List Types</span></a></li> 
		<li  class="level1 nav-1-4 " id=""> 
		<a href="../Catalog/ezCatalogDisplayByClassification.jsp?ctype='Q'"><span>Quick Ship</span></a></li>
		<li  class="level1 nav-1-5 " id="">
		<a href="../Catalog/ezCatalogDisplayByClassification.jsp?ctype='C'"><span>Custom Ordered</span></a></li> -->
		<!-- <li  class="level1 nav-1-6" id="">
		<a href="../Catalog/ezCatalogDisplayByClassification.jsp?ctype='S'"><span>Bathroom Suites</span></a></li>
		<li  class="level1 nav-1-7" id="">
		<a href="../Catalog/ezCatalogDisplayByClassification.jsp?ctype='B'"><span>Bathroom Collections</span></a></li>
		<li  class="level1 nav-1-8" id="">
		<a href="../Catalog/ezCatalogDisplayByClassification.jsp?ctype='K'"><span>Kitchen Collections</span></a></li> -->
		</ul>
	</li>
	<li  class="level0 nav-2 level-top parent" id="">
	<a href="#" class="level-top"><span>Orders</span></a>
	<div class="nav-arrow"></div>
		<ul class="level0">
<!--		<li  class="level1 nav-2-1 first" id="">
		<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')"><span>Order Creation</span></a></li>
		<li  class="level2 nav-2-1-1 first" id="">
		<a href="javascript:funClick('../ShoppingCart/ezViewCart.jsp')"><span>Quick Order</span></a></li>
		<li  class="level2 nav-2-1-2" id="">
		<a href="../Search/ezQuickSearchMain.jsp"><span>Repeat Order</span></a></li> -->
		<li  class="level1 nav-2-4" id="">
		<a href="javascript:funClick('../Sales/ezOrderCreationDashBoard.jsp')"><span>Orders Dashboard</span></a></li>
		<!-- <li  class="level1 nav-2-4" id="">
		<a href="../Sales/ezSavedOrders.jsp"><span>Saved Orders </span></a></li> -->
		<li  class="level1 nav-2-4" id="">
		<a href="javascript:funClick('../Search/ezQuickSearchMain.jsp')"><span>PO Advanced Search</span></a></li>
		<li class="level1 nav-2-5" id="">
		<!-- <a href="../Quotes/ezJobQuotes.jsp?status=O" class="level-top"><span>Quotes</span></a>
		</li>
		<li  class="level1 nav-2-5" id="">
		<a href="../Sales/ezSalesOrders.jsp"><span>Pending-MENUWILLBEREMOVED</span></a></li>
		<li  class="level1 nav-2-6 last" id="">
		<a href="../Sales/ezClosedSalesOrders.jsp""><span>Processed/Shipped-MENUWILLBEREMOVED </span></a></li> -->

<%
	if(!"CU".equals(userRole))
	{
%>
		<!-- <li  class="level1 nav-2-2" id="">
		<a href="../Sales/ezOrdersForApproval.jsp?negotiateType=FORAPPROVAL&ORDERTYPE=A"><span>FD Orders</span></a></li>
		<li  class="level2 nav-2-2-1" id="">
		<a href="../Sales/ezOrdersForApproval.jsp?negotiateType=FORAPPROVAL&ORDERTYPE=A"><span>->To be Approved</span></a></li>
		<li  class="level2 nav-2-2-2" id="">
		<a href="../Sales/ezOrdersForApproval.jsp?negotiateType=ALL&ORDERTYPE=A"><span>->Approved/ Rejected</span></a></li> -->
<%
	}
%>
		<!-- <li  class="level1 nav-2-3" id="">
		<a href="../Sales/ezNegotiatedOrders.jsp?negotiateType=INPROCESS&ORDERTYPE=N"><span>Needing AS Review</span></a></li>

		<li  class="level2 nav-2-3-1" id="">
		<a href="../Sales/ezNegotiatedOrders.jsp?negotiateType=INPROCESS&ORDERTYPE=N"><span>->Awaiting AS Response</span></a></li>
		<li  class="level2 nav-2-3-2" id="">
		<a href="../Sales/ezNegotiatedOrders.jsp?negotiateType=ACCEPTED&ORDERTYPE=N"><span>->Accepted by AS</span></a></li>		
		<li  class="level2 nav-2-3-3" id="">
		<a href="../Sales/ezNegotiatedOrders.jsp?negotiateType=REJECTED&ORDERTYPE=N"><span>->Rejected by AS</span></a></li>-->		 
		</ul>
	</li>

	<li  class="level0 nav-3 level-top parent" id="">
	<a href="#" class="level-top"><span>Job Quotes</span></a>
	<div class="nav-arrow"></div>
		<ul class="level0">
		<li  class="level1 nav-3-1 first" id="">
		<a href="javascript:funClick('../Quotes/ezJobQuotes.jsp?status=O')"><span>Open</span></a></li>
		<li  class="level1 nav-3-1 first" id="">
		<a href="javascript:funClick('../Quotes/ezJobQuotes.jsp?status=C')"><span>Closed</span></a></li>
		<li  class="level1 nav-3-2" id="">
		<a href="javascript:funClick('../Quotes/ezExpiredJobQuotes.jsp')"><span>Expired</span></a></li>
		<li  class="level1 nav-3-2" id="">
		<a href="javascript:funClick('../Quotes/ezExpiringJobQuotes.jsp')"><span>Expiring Soon</span></a></li>		
		</ul>
	</li>
	<li  class="level0 nav-4 level-top parent" id="">
	<a href="#" class="level-top"><span>Invoices</span></a>
	<div class="nav-arrow"></div>
		<ul class="level0">
		<li  class="level1 nav-4-1 first" id="">
		<a href="javascript:funClick('../Invoices/ezOpenInvoices.jsp')"><span>Open Invoices</span></a></li>		
		<!--<li  class="level1 nav-4-4" id="">
		<a href="javascript:getAccDtl()"><span>Account Statement</span></a></li>-->
		<input type="hidden" name="newsFilter" >
		</ul>
	</li>
	<!-- <li  class="level0 nav-5 level-top parent" id="">
	<a href="../Sales/ezCancellationRequestsMain.jsp" class="level-top"><span>Cancellations/RGAs</span></a>
	<div class="nav-arrow"></div>
		<ul class="level0">
			<li  class="level2 nav-5-1" id="">
			<a href="../Sales/ezCancellationRequestsMain.jsp"><span>Pending AS Approval</span></a></li>
			<li  class="level2 nav-5-2" id="">
			<a href="../Sales/ezProcessedRequestsMain.jsp"><span>Approved </span></a></li>
			<li  class="level2 nav-5-3" id="">
			<a href="../Sales/ezRejectedRequestsMain.jsp"><span>Rejected </span></a></li>

		</ul> 
	</li>-->
	<!-- <li  class="level0 nav-6 level-top parent" id="">

	<a href="../Quotes/ezJobQuotes.jsp" class="level-top"><span>RGAs</span></a>
	<div class="nav-arrow"></div>
		<ul class="level0">
			<li  class="level2 nav-6-1" id="">
			<a href="../Sales/ezCancellationRequestsMain.jsp"><span>Pending AS Approval</span></a></li>
			<li  class="level2 nav-6-2" id="">
			<a href="../Sales/ezProcessedRequestsMain.jsp"><span>Approved </span></a></li>
			<li  class="level2 nav-6-3" id="">
			<a href="../Sales/ezRejectedRequestsMain.jsp"><span>Rejected </span></a></li>
		</ul>
	</li>
	-->
	
		<li  class="level0 nav-6 level-top parent" id="">
		<a href="#" class="level-top"><span>My Account</span></a>

		<div class="nav-arrow"></div>
			<ul class="level0">
			<li  class="level1 nav-6-1 first" id=""><a href="javascript:funClick('../News/ezListNewsDash.jsp')"><span>News</span></a></li>
			<li  class="level1 nav-6-2 " id=""><a href="javascript:funClick('../Inbox/ezListPersMsgsMain.jsp')"><span>Messages</span></a></li>
			<li  class="level1 nav-6-3 " id=""><a href="javascript:funClick('../SelfService/ezChangeAcctInfo.jsp')"><span>Account Profile</span></a></li>
<%
			if("3".equals((String)session.getValue("UserType")))
			{
%>			
				<li  class="level1 nav-6-3 " id=""><a href="javascript:funClick('../SelfService/ezChangePassword.jsp')"><span>Change Password</span></a></li>
<%
			}
%>			
			<li  class="level1 nav-6-4 " id="">
			<a href="javascript:funClick('../SwitchAccount/ezChangeSoldTo.jsp')"><span>Default SoldTo/ShipTo</span></a></li>
			<!-- <li  class="level1 nav-6-6" id="">
			<a href="../SelfService/download1.pdf"><span>Download RGA Form</span></a></li>
			<li  class="level1 nav-6-7" id="">
			<a href="../SelfService/download2.pdf"><span>Download Replacement Form</span></a></li> -->
<%
	if("3".equals((String)session.getValue("UserType")) && "N".equals((String)session.getValue("IsSubUser")))
	{
%>
			<li  class="level1 nav-6-4 first" id="">
			<a href="javascript:funClick('../SelfService/ezAddSubUser.jsp')"><span>Add SubUser</span></a></li>
			<li  class="level1 nav-6-5" id="">
			<a href="javascript:funClick('../SelfService/ezListSubUsers.jsp')"><span>SubUser List</span></a></li>
<%
	}

	if(!"CU".equals(userRole) && userAuthCount.containsKey("PUBLISH_NEWS"))
	{
%>	
		<!-- <li  class="level1 nav-6-7" id=""><a href="../News/ezListNewsDash.jsp?newsFilter=PA"><span>Promotions</span></a></li> -->
		<li  class="level1 nav-6-7" id=""><a href="../News/ezConfigureNews.jsp"><span>Configure News</span></a></li>
<%
	}
%>
			</ul>
		</li>
</ul>
</div>
</form>

<script type="text/javascript" src="../../Library/Script/Misc/ezMenu.js"></script>
