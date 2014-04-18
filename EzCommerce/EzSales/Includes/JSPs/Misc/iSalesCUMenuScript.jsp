<script>
	EZ_SALES1 = [
		["Create","",1,1,"No"],
		["<%=view_L%>","",1,1,"No"]
		//["ATP","../Sales/ezATPSearchOptions.jsp",1,1,"No"]		
	]
	EZ_SALES1_1 = [
		//["<%=creOrder_L%>","../Sales/ezAddSales.jsp",0,1,"../Sales/ezAddSales.jsp"],	
		["By Catalog","../Sales/ezCreateSalesOrder.jsp",0,1,"../Sales/ezCreateSalesOrder.jsp"],	
		["Copy Order","../Sales/ezCopySalesOrder.jsp",0,1,"../Sales/ezCopySalesOrder.jsp"],
		//["Product Search","../DrillDownCatalog/ezProductSearch.jsp",0,1,"../DrillDownCatalog/ezProductSearch.jsp"],
		["Quick Entry by Products Code","../Sales/ezProductEntry.jsp",0,1,"../Sales/ezProductEntry.jsp"]
	]
	EZ_SALES1_2 = [
		["Open Orders","../Sales/ezBackEndSOList.jsp?RefDocType=P",0,1,"No"],
		["<%=closeOrder_L%>","../Sales/ezBackEndClosedSOList.jsp?RefDocType=P&DatesFlag=DATES",0,1,"No"],
		["Saved Orders","../Sales/ezSavedOrdersList.jsp?orderStatus='NEW'&RefDocType=P",0,1,"No"]
		//["Contracts","../Sales/ezBackEndContractList.jsp?RefDocType=P&DatesFlag=DATES",0,1,"No"]
	]
	/*
	EZ_SALES1_3 = [
			["By Product Search","../Sales/ezATPMaterialSearch.jsp",0,1,"No"],
			["By Browse General","../DrillDownCatalog/ezDrillDownCatalog.jsp",0,1,"No"],
			["By Characteristics","../MaterialSearch/ezSearchMaterials.jsp",0,1,"No"]
			
	]
	
	EZ_SALES1_2_1 = [
		["By Dates","../Sales/ezBackEndClosedSOList.jsp?RefDocType=P&DatesFlag=DATES",0,1,"No"],
		["By Months","../Sales/ezBackEndClosedSOList.jsp?RefDocType=P&DatesFlag=MONTHS",0,1,"No"]
	]
	*/
	EZ_SALES2 = [
		["<%=openInv_L%>","../SelfService/ezGridOpenInvoices.jsp?&FromForm=OpenInvoiceList",0,1,"No"],
		["<%=closeInv_L%>","../SelfService/ezGridClosedInvoices.jsp?DatesFlag=DATES",0,1,"No"],
		["Aging","../SelfService/ezInvoicesAging.jsp",0,1,"No"],
		["<%=acCopy_L%>","../SelfService/ezAcCopy.jsp",0,1,"No"]
	]
	/*
	EZ_SALES2_1 = [
		["By Dates","../SelfService/ezGridClosedInvoices.jsp?DatesFlag=DATES",0,1,"No"],
		["By Months","../SelfService/ezGridClosedInvoices.jsp?DatesFlag=MONTHS",0,1,"No"]
	]
	*/
	EZ_SALES4 = [
		["Vendor Catalog","../DrillDownCatalog/ezDrillDownVendorCatalog.jsp",0,1,"No"],
		//["<%=browseGen_L%>","../DrillDownCatalog/ezDrillDownCatalog.jsp",0,1,"No"],
		["<%=browsePers_L%>","../BusinessCatalog/ezCatalog.jsp",0,1,"No"],
		["Edit Catalog","../BusinessCatalog/ezListFavGroups.jsp",0,1,"No"],
		["<%=prodSearch_L%>","../BusinessCatalog/ezProductSearch.jsp",0,1,"No"],
		["My Account","../DrillDownCatalog/ezMyAccount.jsp",0,1,"No"]
		//["Char.Based Search","../MaterialSearch/ezSearchMaterials.jsp",0,1,"No"]
		//["<%=shopCart_L%>","../ShoppingCart/ezViewCart.jsp",0,1,"No"]
	]
	EZ_SALES5 = [
		["<%=mail_L%>","../Inbox/ezListPersMsgs.jsp",0,1,"No"],
<%		if(!"CU".equals((String)session.getValue("UserRole")))
		{
%>			
			["News","../News/ezListNews.jsp",0,1,"No"],
			["Image Upload","../Inbox/ezImageUpload.jsp",0,1,"No"],
<%		}
%>		["Change Address","../SelfService/ezGetInfo.jsp",0,1,"No"],
		["Change Password","../SelfService/ezPassword.jsp",0,1,"No"],
<%		if(!"CU".equals((String)session.getValue("UserRole")))
		{
%>		
		["Web Stats","javascript:void(0)",1,1,"No"],
<%}
%>		["FAQs","../FAQs/ezFaqs.jsp",0,1,"No"],

		["Contact Us","../Misc/ezContactInfo.jsp",0,1,"No"]
		
	]
	
	EZ_SALES5_1 = 
	[
		["By SBU","../WebStats/ezListWebStatsBySBU.jsp?Area=C",0,1,"No"],
				
		["Time Stats","../WebStats/ezTimeStats.jsp?Area=C",0,1,"No"],
	
		["User Frequency","../WebStats/ezListUserFrequency.jsp?Area=C",0,1,"No"]
	]
	
	
	
	EZ_SALES8 = 
	[
	
		
<%		if(!"CU".equals((String)session.getValue("UserRole")))
		{
%>
		["Add Shipments","../DeliverySchedules/ezGetDeliveryNos.jsp",0,1,"No"],
<%
		}
		else
		{
%>
		["To be Acknowledged","../DeliverySchedules/ezViewDispatchLocal.jsp?Stat=D&qFlag=ALL",0,1,"No"],
<%
		}
%>		

		["Acknowledged","../DeliverySchedules/ezViewDispatchLocal.jsp?Stat=R&qFlag=ALL",0,1,"No"]			
	]
	
	

</script>
