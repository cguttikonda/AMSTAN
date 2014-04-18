<html>
<head>
<title>Accordion Menu Demo</title>
	<script type="text/javascript" src="prototype.js"></script>
	<script type="text/javascript" src="effects.js"></script>
	<script type="text/javascript" src="accordion.js"></script>
<script type="text/javascript">
	Event.observe(window, 'load', loadAccordions, false);
        function loadAccordions()
        {
			var bottomAccordion = new accordion('vertical_container');
			var nestedVerticalAccordion = new accordion('vertical_nested_container',
			{
				classNames :
				{
						toggle : 'vertical_accordion_toggle',
						toggleActive : 'vertical_accordion_toggle_active',
						content : 'vertical_accordion_content'
				}
			});
                        bottomAccordion.activate($$('#vertical_container .accordion_toggle')[0]);
		}
</script>
	<style type="text/css" >
		.accordion_toggle
		{
			display: block;
			height: 30px;
			width: 270px;
			background: url(accordion_toggle.jpg) no-repeat top right #a9d06a;
			padding: 0 10px 0 10px;
			line-height: 30px;
			color: #ffffff;
			font-weight: normal;
			text-decoration: none;
			outline: none;
			font-size: 12px;
			color: #000000;
			border-bottom: 1px solid #cde99f;
			cursor: pointer;
			margin: 0 0 0 0;
		}

		.accordion_toggle_active
		{
			background: url(accordion_toggle_active.jpg) no-repeat top right #e0542f;
			color: #ffffff;
			border-bottom: 1px solid #f68263;
		}

		.accordion_content
		{
			background-color: #ffffff;
			color: #444444;
			overflow: hidden;
		}
		.accordion_sub_content
		{
			background-color: #ffffff;
			color: #444444;
			overflow: hidden;
		}

		.vertical_accordion_toggle
		{
			display: block;
			height: 30px;
			width: 200px;
			background: url(accordion_toggle.jpg) no-repeat top right #a9d06a;
			padding: 0 10px 0 10px;
			line-height: 30px;
			color: #ffffff;
			font-weight: normal;
			text-decoration: none;
                        list-style:none;
			outline: none;
			font-size: 12px;
			color: #000000;
			border-bottom: 1px solid #cde99f;
			cursor: pointer;
			margin: 0 0 0 0;
		}
		.vertical_sub_accordion_toggle
		{
			display: block;
			height: 30px;
			width: 170px;
			background: url(accordion_toggle.jpg) no-repeat top right #a9d06a;
			padding: 0 10px 0 10px;
			line-height: 30px;
			color: #ffffff;
                        list-style:none;
			font-weight: normal;
			text-decoration: none;
			outline: none;
			font-size: 12px;
			color: #000000;
			border-bottom: 1px solid #cde99f;
			cursor: pointer;
			margin: 0 0 0 0;
		}

		.vertical_accordion_toggle_active
		{
			background: url(accordion_toggle_active.jpg) no-repeat top right #e0542f;
			color: #ffffff;
			border-bottom: 1px solid #f68263;
		}
		.vertical_sub_accordion_toggle_active
		{
			background: url(accordion_toggle_active.jpg) no-repeat top right #e0542f;
			color: #ffffff;
			border-bottom: 1px solid #f68263;
		}
		.vertical_accordion_content
		{
			background-color: #ffffff;
			color: #444444;
			overflow: hidden;
		}
		#vertical_nested_container {
		  margin: 20px auto 20px auto;
		  width: 620px;
		}
	</style>
</head>
<body>
	<div id="container">
		<div id="vertical_container" >

			<h1 class="accordion_toggle">RFQ</h1>
                            <div class="accordion_content">
				<div id="vertical_nested_container" >
                                    <a href="../RFQ/ezListRFQs.jsp?type=New" target="left"><h3 class="vertical_accordion_toggle"></h3></a>
                                    <a href="../RFQ/ezListRFQs.jsp?type=New" target="left"><h3 class="vertical_accordion_toggle">New</h3></a>
                                    <a href="../RFQ/ezListRFQs.jsp?type=All" target="left"><h3 class="vertical_accordion_toggle">All</h3></a>
                                    <a href="../RFQ/ezListRFQs.jsp?type=List" target="left"><h3 class="vertical_accordion_toggle">View Quatations</h3></a>
				</div>
                            </div>

			<h1 class="accordion_toggle">PO/CONTRACTS</h1>
                            <div class="accordion_content">
				<div id="vertical_nested_container">
                                    <a href="view.jsp" target="left"><h3 class="vertical_accordion_toggle">Purchase Orders</h3></a>
                                    <a href="../Purorder/ezGetContractsList.jsp" target="left"><h3 class="vertical_accordion_toggle">Contracts</h3></a>
				</div>
                            </div>

			<h1 class="accordion_toggle">SCHLD AGREEMENTS</h1>
                            <div class="accordion_content">
				<div id="vertical_nested_container">
                                    <a href="../Purorder/ezContract.jsp?OrderType=Open" target="left"><h3 class="vertical_accordion_toggle">Open</h3></a>
                                    <a href="../Purorder/ezContract.jsp?OrderType=Closed" target="left"><h3 class="vertical_accordion_toggle">Closed</h3></a>
                                    <a href="../Purorder/ezContract.jsp?OrderType=All" target="left"><h3 class="vertical_accordion_toggle">All</h3></a>
				</div>
                            </div>

			<h1 class="accordion_toggle">SHIPMENTS</h1>
                            <div class="accordion_content">
				<div id="vertical_nested_container">
                                    <a href="../Shipment/ezAddShipmentDetails.jsp?FROM=MENU" target="left"><h3 class="vertical_accordion_toggle">Add</h3></a>
                                    <a href="../Shipment/ezViewShipmentHeader.jsp?FROM=MENU" target="left"><h3 class="vertical_accordion_toggle">View</h3></a>
				</div>
                            </div>

			<h1 class="accordion_toggle">INVOICES</h1>
                            <div class="accordion_content">
				<div id="vertical_nested_container">
                                    <a href="../Purorder/ezListInvWait.jsp?InvStat=O" target="left"><h3 class="vertical_accordion_toggle">Open</h3></a>
                                    <a href="../Purorder/ezListInvWait.jsp?InvStat=C" target="left"><h3 class="vertical_accordion_toggle">Closed</h3></a>
                                    <a href="../Purorder/ezListInvWait.jsp?InvStat=A" target="left"><h3 class="vertical_accordion_toggle">All</h3></a>
				</div>
                            </div>

			<h1 class="accordion_toggle">SELF SERVICES</h1>
                            <div class="accordion_content">
				<div id="vertical_nested_container">
                                    <a href="../Purorder/ezListPendingDcs.jsp" target="left"><h3 class="vertical_accordion_toggle">DNs to be Invoiced</h3></a>
                                    <a href="../Purorder/ezVendbal.jsp" target="left"><h3 class="vertical_accordion_toggle">Out Standing Balance</h3></a>
                                    <a href="../Misc/ezAstatement.jsp" target="left"><h3 class="vertical_accordion_toggle">A/C Statement</h3></a>
                                    <a href="../Purorder/ezBankDet.jsp" target="left"><h3 class="vertical_accordion_toggle">Bank Details</h3></a>
                                    <a href="../Materials/ezListRejectedMaterials.jsp" target="left"><h3 class="vertical_accordion_toggle">Rejected Materials</h3></a>
                                    <a href="../Purorder/ezListToBeDelivered.jsp" target="left"><h3 class="vertical_accordion_toggle">To Be Delivered</h3></a>
                                    <a href="../Reports/ezChangeReportCU.jsp?reportName=ZRM07MKBS&system=999&sysDesc=EzCommerce SAP System -> 999&repNo=177" target="left"><h3 class="vertical_accordion_toggle">Display Consigment Stock</h3></a>
                                    <a href="../Materials/ezAddVendorProfile.jsp" target="left"><h3 class="vertical_accordion_toggle">Vendor Profile</h3></a>
                                    <a href="../Misc/ezGetInfo.jsp" target="left"><h3 class="vertical_accordion_toggle">Change Address</h3></a>
                                    <a href="../Misc/ezPassword.jsp" target="left"><h3 class="vertical_accordion_toggle">Change Password</h3></a>
				</div>
                            </div>

			<h1 class="accordion_toggle">OPTIONS</h1>
                            <div class="accordion_content">
				<div id="vertical_nested_container">
                                    <a href="../Search/ezSearch.jsp" target="left"><h3 class="vertical_accordion_toggle">Search</h3></a>
                                    <a href="../Inbox/ezListPersMsgs.jsp" target="left"><h3 class="vertical_accordion_toggle">Mail</h3></a>
                                    <a href="../Misc/ezListSbuPlantAddresses.jsp" target="left"><h3 class="vertical_accordion_toggle">Plant Info</h3></a>
                                    <a href="../Misc/ezFAQs.jsp" target="left"><h3 class="vertical_accordion_toggle">FAQs</h3></a>
                                    <a href="../Misc/ezContactInfo.jsp" target="left"><h3 class="vertical_accordion_toggle">Contact Info</h3></a>
				</div>
                            </div>
		</div>
	</div>
</body>
</html>