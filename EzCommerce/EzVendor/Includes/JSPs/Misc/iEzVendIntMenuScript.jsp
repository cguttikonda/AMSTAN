
<SCRIPT>

EZ_VENDOR1 = 
[
	
	["Create PR","../PRs/ezConfirmCreatePR.jsp",0,1,"No"],
//	["List PRs","../PRs/ezListPRs.jsp",0,1,"No"]
	["List PRs","../RFQ/ezPrePRList.jsp?Status=R",0,1,"No"]

]

EZ_VENDOR2 = 
[
	
	["All","../RFQ/ezListRFQs.jsp?type=All",0,1,"No"]
	//["View Quotations","../RFQ/ezListRFQs.jsp?type=List",0,1,"No"]
	
]

EZ_VENDOR3 = 
[
	["Purchase Orders","javascript:void(0)",1,1,"No"],
	["Contracts","../Purorder/ezGetContractsList.jsp",0,1,"No"]
	
	<%
		if("PURPERSON".equals(Session.getUserId()))
		{
	%>
		,["STO","javascript:void(0) ",1,1,"No"]
	<%
		}
	%>
	
]
 
EZ_VENDOR3_1 = [

		["Blocked Orders","javascript:void(0)",1,1,"No"],
		["Acknowledgements","javascript:void(0)",1,1,"No"],
		["Open","../Purorder/ezListPOs.jsp?OrderType=Open",0,1,"No"],
		["Closed","../Purorder/ezListPOs.jsp?OrderType=Closed",0,1,"No"],
		["All","../Purorder/ezListPOs.jsp?OrderType=All",0,1,"No"]
]

EZ_VENDOR3_1_1 = 
[
	["Current Vendor","../Purorder/ezListBlockedPOs.jsp",0,1,"No"],
	["For All Vendors","../Purorder/ezListBlockedPOs.jsp?SHOW=ALL",0,1,"No"]
]
EZ_VENDOR3_1_2 = 
[
	["To be Acknowledged","javascript:void(0)",1,1,"No"],
	["Acknowledged","../Purorder/ezListAcknowledgedPOs.jsp?type=Acknowledged",0,1,"No"],
	["Rejected","../Purorder/ezListAcknowledgedPOs.jsp?type=Rejected",0,1,"No"]
]

EZ_VENDOR3_1_2_1 = 
[
	["Current Vendor","../Purorder/ezListAcknowledgedPOs.jsp?type=NotAcknowledged",0,1,"No"],
	["For All Vendors","../Purorder/ezListAcknowledgedPOs.jsp?type=NotAcknowledged&SHOW=ALL",0,1,"No"]
]
EZ_VENDOR3_2 = [

		["Create STO","../Purorder/ezSTOCreate.jsp",0,1,"No"]
		//,["List STOs","../Purorder/ezListSTOs.jsp",0,1,"No"]

]

//EZ_VENDOR2_2 = 
//[
	//["UnReleased","../Purorder/ezListBlockedContracts.jsp?type=Contract",0,1,"No"],
	//["Blocked For Supplier","../Purorder/ezListBlockedContractsInPortal.jsp",0,1,"No"],
	//["View Contracts","../Purorder/ezGetContractsList.jsp",0,1,"No"]
//]

EZ_VENDOR4 = [
["Open","../Purorder/ezContract.jsp?OrderType=Open",0,1,"No"],
["Closed","../Purorder/ezContract.jsp?OrderType=Closed",0,1,"No"],
["All","../Purorder/ezContract.jsp?OrderType=All",0,1,"No"]
]



EZ_VENDOR5 = 
[
	["View","../Shipment/ezViewShipmentHeader.jsp",0,1,"No"]
]

EZ_VENDOR6 = 
[
	["Open","../Purorder/ezListInvWait.jsp?InvStat=O",0,1,"No"],
	["Closed","../Purorder/ezListInvWait.jsp?InvStat=C",0,1,"No"],
	["All","../Purorder/ezListInvWait.jsp?InvStat=A",0,1,"No"]
]

EZ_VENDOR7 = 
[
	["Outstanding Balance","../Purorder/ezVendbal.jsp",0,1,"No"],
	["A/C Statement","../Misc/ezAstatement.jsp",0,1,"No"],
	["Bank Details","../Purorder/ezBankDet.jsp",0,1,"No"],
	["To Be Delivered","../Purorder/ezListToBeDelivered.jsp",0,1,"No"],
	//["Display Consignment Stocks","../Reports/ezChangeReportCU.jsp?reportName=ZRM07MKBS&system=999&sysDesc=EzCommerce SAP System -> 999&repNo=177",0,1,"No"],
	//["Consignment Stocks per Vendor","../Reports/ezChangeReportCU.jsp?reportName=ZRM07MKBV&system=999&sysDesc=EzCommerce SAP System -> 999&repNo=178",0,1,"No"],
	["Vendor Profile","../Materials/ezViewVendorProfile.jsp",0,1,"No"],
	["Change Address","../Misc/ezGetInfo.jsp",0,1,"No"],
	["Change Password","../Misc/ezPassword.jsp",0,1,"No"],
<% if("purchase person".equals((String)session.getValue("FIRST_NAME")) )
{
%>
	["Vendor Registration","javascript:void(0)",1,1,"No"]
	
<% }
%>
	
]
<% if("purchase person".equals((String)session.getValue("FIRST_NAME")) )
{
%>
EZ_VENDOR7_1 = 
[
	["To Be Approved","../../../Vendor2/JSPs/Misc/ezListOfVendors.jsp?statusFlag=SUBMITTED",0,1,"NO"],
	["Approved","../../../Vendor2/JSPs/Misc/ezListOfVendors.jsp?statusFlag=APPROVED",0,1,"NO"]
	
]

<%
}
%>
	


EZ_VENDOR6_1 = 
[
	["New","../Purorder/ezQcf.jsp",0,1,"No"],
	["Action To be Taken","../Purorder/ezListQcfs.jsp?Type=N",0,1,"No"],
	["All","../Purorder/ezListQcfs.jsp?Type=A",0,1,"No"]
]

EZ_VENDOR8 = 
[
	//["Search","ezSelectSearch.jsp",0,1,"No"],
	["Search","../Search/ezSearch.jsp",0,1,"No"],
	["Mail","../Inbox/ezListPersMsgs.jsp",0,1,"No"],
	["Web Stats","javascript:void(0)",1,1,"No"],
	["Plant Info","../Misc/ezListSbuPlantAddresses.jsp",0,1,"No"],
	["News ","../News/ezListNews.jsp",0,1,"No"],
	["FAQs","../Misc/ezFAQs.jsp",0,1,"No"], 
	["Contact Info","../Misc/ezContactInfo.jsp",0,1,"No"]
]

EZ_VENDOR8_1 = 
[
	["By SBU","../WebStats/ezListWebStatsBySBU.jsp?Area=V",0,1,"No"],
	["Time Stats","../WebStats/ezTimeStats.jsp?Area=V",0,1,"No"],
	["User Frequency","../WebStats/ezListUserFrequency.jsp?Area=V",0,1,"No"]
]
</SCRIPT>