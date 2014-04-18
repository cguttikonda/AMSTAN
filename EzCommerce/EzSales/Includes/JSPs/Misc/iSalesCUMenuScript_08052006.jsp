<script>

EZ_SALES1 = [
			["<%=create_L%>","",1,1,"No"],
			["<%=view_L%>","",1,1,"No"]
			
	]
EZ_SALES1_1 = [
	["<%=creOrder_L%>","../Sales/ezAddSales.jsp",0,3,"../Sales/ezAddSales.jsp"],
	//["Return Orders","../Sales/ezAddReturnSalesOrder.jsp",0,3,"../Sales/ezAddReturnSalesOrder.jsp"],
	["<%=reOrder_L%>","../Sales/ezCopySalesOrder.jsp",0,3,"../Sales/ezCopySalesOrder.jsp"]
]
EZ_SALES1_2 = [
	["<%=acceptOrder_L%>","../Sales/ezBackEndSOList.jsp?RefDocType=P",0,1,"No"],
	["<%=closeOrder_L%>","",1,1,"No"],
	//["Open Returns/Breakages","ezMenuFrameset.jsp?urlPage=OpenReturnBackEndList&RefDocType=P",0,3,"No"],
	//["Closed Returns/Breakages","ezMenuFrameset.jsp?urlPage=ClosedReturnBackEndList&RefDocType=P",0,3,"No"],
	//["Open FRS","ezMenuFrameset.jsp?urlPage=OpenFRSBackEndList&RefDocType=P",0,3,"No"],
	//["Posted Return Order List","../Sales/ezListSalesOrders.jsp?orderStatus='RETTRANSFERED','RETCMTRANSFER'&RefDocType=R",0,1,"No"],
	["Saved Orders","../Sales/ezListSalesOrders.jsp?orderStatus='NEW'&RefDocType=P",0,1,"No"],
	//["<%=submi_L%>","../Sales/ezListSalesOrders.jsp?orderStatus='SUBMITTED','APPROVED','SUBMITTEDTOBP','RETURNEDBYBP'&RefDocType=P",0,1,"No"],
	//["Saved Ret Order List","../Sales/ezListSalesOrders.jsp?orderStatus='RETNEW'&RefDocType=R",0,1,"No"]
	//["<%=retByCM_L%>","../Sales/ezListSalesOrders.jsp?orderStatus='ReturnedBYCM'&RefDocType=P",0,1,"No"],
	//["<%=retByLF_L%>","../Sales/ezListSalesOrders.jsp?orderStatus='ReturnedBYLF'&RefDocType=P",0,1,"No"],
	//["<%=reject_L%>","../Sales/ezListSalesOrders.jsp?orderStatus='REJECTED'&RefDocType=P",0,1,"No"]

]
EZ_SALES1_2_1 = [
			["By Dates","../Sales/ezBackEndClosedSOList.jsp?RefDocType=P&DatesFlag=DATES",0,1,"No"],
			["By Months","../Sales/ezBackEndClosedSOList.jsp?RefDocType=P&DatesFlag=MONTHS",0,1,"No"]
]

EZ_SALES2 = [
["<%=addStat_L%>","../Projections/ezAddStockInfo.jsp",0,3,"../Projections/ezAddStockInfo.jsp"],
["<%=editStat_L%>","../Projections/ezEditStockInfoByCU.jsp",0,3,"../Projections/ezEditStockInfoByCU.jsp"],
["<%=viewStat_L%>","../Projections/ezViewStockInfo.jsp",0,3,"../Projections/ezViewStockInfo.jsp"]
]

EZ_SALES3 = [
["<%=openInv_L%>","../Sales/ezOpenInvoices.jsp",0,1,"No"],
["<%=closeInv_L%>","",1,1,"No"],
["Ageing","../Sales/ezInvoicesAging.jsp",0,1,"No"],
["<%=acCopy_L%>","../Misc/ezAcCopy.jsp",0,1,"No"],
["<%=cAddr_L%>","../Misc/ezGetInfo.jsp",0,1,"No"],
["<%=cPwd_L%>","../Misc/ezPassword.jsp",0,1,"No"]
//["<%=contactUs_L%>","../Misc/ezContactInfo.jsp",0,1,"No"]
]
EZ_SALES3_1 = [
			["By Dates","../Sales/ezClosedInvoices.jsp?DatesFlag=DATES",0,1,"No"],
			["By Months","../Sales/ezClosedInvoices.jsp?DatesFlag=MONTHS",0,1,"No"]
	]

EZ_SALES4= [
//["<%=tobeAcknow_L%>","../DeliverySchedules/ezViewDispatches.jsp?Stat=D",0,1,"No"],
["<%=tobeAcknow_L%>","../DeliverySchedules/ezViewDispatchLocal.jsp?Stat=D&qFlag=ALL",0,1,"No"],
["<%=acknowledge_L%>","../DeliverySchedules/ezViewDispatchLocal.jsp?Stat=R&qFlag=ALL",0,1,"No"]
//["<%=tobeAcknow_L%>","../DeliverySchedules/ezViewOrders.jsp?Stat=D",0,1,"No"]
]
EZ_SALES5= [
		["Add Physician","../Distribution/ezAddDoctorDetails.jsp",0,1,"No"],
		["List","",1,1,"No"],
		["Samples Issued","../Distribution/ezListDisbursmentsByProduct.jsp",0,1,"No"]
]
EZ_SALES5_1 = [
			["By Sub Region","../Distribution/ezListDoctorsByRegion.jsp",0,1,"No"],
			["All Physicians","../Distribution/ezListDoctors.jsp",0,1,"No"]
	]
	
EZ_SALES6 = [
//		["<%=mail_L%>","",1,1,"No"]
		//["Preferences","../Preferences/ezChangeStyleSheet.jsp",0,1,"No"],
//]
//EZ_SALES6_1 = [

	["<%=inbox_L%>","../Inbox/ezListPersMsgs.jsp",0,1,"No"],
	["<%=liFolders_L%>","../Inbox/ezListFolders.jsp",0,1,"No"],
	["<%=compMsg_L%>","../Inbox/ezComposePersMsg.jsp",0,1,"No"],
	["<%=createFol_L%>","../Inbox/ezAddFolder.jsp",0,1,"No"]
]       
EZ_SALES7 = [
["<%=browseGen_L%>","../BusinessCatalog/ezFullCatalog.jsp",0,1,"No"],
["<%=browsePers_L%>","../BusinessCatalog/ezCatalog.jsp",0,1,"No"],
["Drill Down Catalog","../DrillDownCatalog/ezDrillDownCatalog.jsp",0,1,"No"],
["<%=perso_L%>","../BusinessCatalog/ezListFavGroups.jsp",0,1,"No"],
["<%=prodSearch_L%>","../BusinessCatalog/ezProductSearch.jsp",0,1,"No"],
["<%=shopCart_L%>","../ShoppingCart/ezViewCart.jsp",0,1,"No"]
]


</script>
