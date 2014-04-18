<script>

EZ_VENDOR1 = 
[
	["New","../RFQ/ezListRFQs.jsp?type=New",0,1,"No"],
	["All","../RFQ/ezListRFQs.jsp?type=All",0,1,"No"],
	["View Quotations","../RFQ/ezListRFQs.jsp?type=List",0,1,"No"]
]

EZ_VENDOR2 = 
[
	["Purchase Orders","javascript:void(0)",1,1,"No"],
	["Contracts","../Purorder/ezGetContractsList.jsp",0,1,"No"]
	
]

EZ_VENDOR2_1 = 
[
	["Acknowledgements","javascript:void(0)",1,1,"No"],
	["Closed","../Purorder/ezListPOs.jsp?OrderType=Closed",0,1,"No"],
	["All","../Purorder/ezListPOs.jsp?OrderType=All",0,1,"No"]
]

EZ_VENDOR2_1_1 = 
[
	["To be Acknowledged","../Purorder/ezListAcknowledgedPOs.jsp?type=NotAcknowledged",0,1,"No"],
	["Acknowledged","../Purorder/ezListAcknowledgedPOs.jsp?type=Acknowledged",0,1,"No"]
]

EZ_VENDOR3 = [
["Open","../Purorder/ezContract.jsp?OrderType=Open",0,1,"No"],
["Closed","../Purorder/ezContract.jsp?OrderType=Closed",0,1,"No"],
["All","../Purorder/ezContract.jsp?OrderType=All",0,1,"No"]
]

EZ_VENDOR4 = 
[
	["Add","../Shipment/ezAddShipmentDetails.jsp?FROM=MENU",0,1,"No"],
	["View","../Shipment/ezViewShipmentHeader.jsp?FROM=MENU",0,1,"No"],
	["Saved Shipments","../Shipment/ezSavedShipments.jsp?FROM=MENU",0,1,"No"] 
]

EZ_VENDOR5 = 
[
	["Open","../Purorder/ezListInvWait.jsp?InvStat=O",0,1,"No"],
	["Closed","../Purorder/ezListInvWait.jsp?InvStat=C",0,1,"No"],
	["All","../Purorder/ezListInvWait.jsp?InvStat=A",0,1,"No"]
]

EZ_VENDOR6 = 
[
	["DNs To be Invoiced","../Purorder/ezListPendingDcs.jsp",0,1,"No"],
	["Outstanding Balance","../Purorder/ezVendbal.jsp",0,1,"No"],
	["A/C Statement","../Misc/ezAstatement.jsp",0,1,"No"],
	["Bank Details","../Purorder/ezBankDet.jsp",0,1,"No"],
	["Rejected Materials","../Materials/ezListRejectedMaterials.jsp",0,1,"No"],
	["To Be Delivered","../Purorder/ezListToBeDelivered.jsp",0,1,"No"],
	["Display Consignment Stocks","../Reports/ezChangeReportCU.jsp?reportName=ZRM07MKBS&system=999&sysDesc=EzCommerce SAP System -> 999&repNo=177",0,1,"No"],
	//["Consignment Stocks per Vendor","../Reports/ezChangeReportCU.jsp?reportName=ZRM07MKBV&system=999&sysDesc=EzCommerce SAP System -> 999&repNo=178",0,1,"No"],
	["Vendor Profile","../Materials/ezAddVendorProfile.jsp",0,1,"No"],
	["Change Address","../Misc/ezGetInfo.jsp",0,1,"No"],
	["Change Password","../Misc/ezPassword.jsp",0,1,"No"]
]

EZ_VENDOR7 = 
[
	["Search","../Search/ezSearch.jsp",0,1,"No"],
	["Mail","../Inbox/ezListPersMsgs.jsp",0,1,"No"],
	["Plant Info","../Misc/ezListSbuPlantAddresses.jsp",0,1,"No"],
	["FAQs","../Misc/ezFAQs.jsp",0,1,"No"],
	["Contact Info","../Misc/ezContactInfo.jsp",0,1,"No"]
]
</script>
