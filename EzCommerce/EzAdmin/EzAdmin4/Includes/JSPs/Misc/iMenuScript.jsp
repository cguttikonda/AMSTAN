<script>
EZ_ADMIN1 = [
		["Authorizations","../Config/ezListAuth.jsp",0,1,"No"],
		["User Roles","",1,1,"No"],
		["Site Defaults","",1,1,"No"],
		["Systems","",1,1,"No"],
		["System Auth","../Config/ezListSystemAuth.jsp",0,1,"No"],
		["ERP Connection","",1,1,"No"],
		["Sales Areas","",1,1,"No"],
		//["Purchase Areas","",1,1,"No"],
		//["Service Areas","",1,1,"No"],
		["Master Defaults","",1,1,"No"],
		["Mail Group","",1,1,"No"]
		//["Support","ezGetData.jsp",0,1,"No"]
		//["Addresses","../Config/ezListAddress.jsp",0,1,"No"],
		//["Audit","../Audit/ezGetAuditDocuments.jsp",1,1,"No"],
		//["Preferences","../Config/ezChangeStyleSheet.jsp",0,1,"No"],
		//["Custom Menu","../Config/ezCustomMenu.jsp",0,1,"No"],
		//["News","../News/ezListNews.jsp",0,1,"No"]

	]

	EZ_ADMIN1_1 = [
			["Create","../Arms/ezAddRoleDefinition.jsp",0,1,"No"],
			["Authorizations","../Arms/ezListRoleAuth.jsp",0,1,"No"],
			["List","../Arms/ezListUserRoles.jsp",0,1,"No"],
			["Disabled","../Arms/ezDeleteUserRoles.jsp",0,1,"No"],			
			["Attributes","../WorkFlow/ezAttributesList.jsp",0,1,"No"],
			["Conditions","../WorkFlow/ezRoleConditionsList.jsp",0,1,"No"]
		]

	EZ_ADMIN1_2 = [
			["List","../Config/Defaults/ezListSiteDefaults.jsp",0,1,"No"],
			["Add","../Config/Defaults/ezAddSiteDefaults.jsp",0,1,"No"],
			["Modify","../Config/Defaults/ezModifySiteDefaults.jsp",0,1,"No"]
		]

	EZ_ADMIN1_3 = [
			["List","../Config/ezListSystems.jsp",0,1,"No"],
			["Add","../Config/ezAddSystemDesc.jsp",0,1,"No"],
			["Modify","../Config/ezUpdateSystems.jsp",0,1,"No"]
		]

	EZ_ADMIN1_4 = [
			["List","../Config/ezListConnections.jsp",0,1,"No"],
			["Add Group","../CParam/ezAddConnectParam.jsp",0,1,"No"],
			["Modify Group","../CParam/ezUpdateConnectParam.jsp",0,1,"No"],
			["Delete Group","../CParam/ezDeleteConnectParam.jsp",0,1,"No"]
		]

	EZ_ADMIN1_5 = [
			["List","../Config/ezListBusAreas.jsp?Area=C",0,1,"No"],
			["Add","../Config/ezAddBusAreaDesc.jsp?Area=C",0,1,"No"],
			["Modify","../Config/ezUpdateBusAreas.jsp?Area=C",0,1,"No"],
			["Defaults","../Config/ezSetBusAreaDefaults.jsp?Area=C",0,1,"No"],
			["By Defaults","../Config/ezListBusAreasByDefaults.jsp?Area=C",0,1,"No"],
			["With Defaults","../Config/ezListAllAreasWithDefaults.jsp?Area=AC",0,1,"No"]
			//["Doc Types","../Config/ezAddOrderType.jsp?Area=C",0,1,"No"]

		]

	EZ_ADMIN1_6 = [
			["List","../Config/Defaults/ezListSystemDefaults.jsp",0,1,"No"],
			["Add","../Config/Defaults/ezAddSystemDefaults.jsp",0,1,"No"],
			["Modify","../Config/Defaults/ezModifySystemDefaults.jsp",0,1,"No"]

		]

	EZ_ADMIN1_7 = [
			["List","../MailGroups/ezListMailGroups.jsp",0,1,"No"],
			["Send Mail","../MailGroups/ezSend.jsp",0,1,"No"]
			//["R3 Mail","../MailGroups/ezPreSendR3Mail.jsp",0,1,"No"]
		]
	
	EZ_ADMIN1_9 = [
			["List","../Audit/ezGetAuditDocuments.jsp",0,1,"No"],
			["Add","../Audit/ezAddAuditDocuments.jsp",0,1,"No"],
			["View Log","../Audit/ezAuditDocumentsList.jsp",0,1,"No"]
		]

	EZ_ADMIN2 =  [
			//["WF Actions","../WorkFlow/ezActionsList.jsp",0,1,"No"],
			//["WF Action Stats","../WorkFlow/ezActionStatList.jsp",0,1,"No"],
			["Work Groups","../WorkFlow/ezWorkGroupsList.jsp",0,1,"No"],
			["Work Group Users","../WorkFlow/ezWorkGroupUsersList.jsp",0,1,"No"],
			//["User Hierarchy","",1,1,"No"],
			["Templates","../WorkFlow/ezTemplateCodeList.jsp",0,1,"No"],
			["Organogram","",1,1,"No"],
			//["Escalations","../WorkFlow/ezEscalationList.jsp",0,1,"No"],
			//["Holiday Calendar","../Misc/ezHolidayCalListWithReason.jsp",0,1,"No"],
			["Scheduled Jobs","../WorkFlow/ezJobList.jsp",0,1,"No"]
			
			/*["Delegations","../WorkFlow/ezDelegationInfoList.jsp",0,1,"No"],
			["Delegation Conditions","../WorkFlow/ezDelegationConditionsList.jsp",0,1,"No"],
			["Escalations","../WorkFlow/ezEscalationList.jsp",0,1,"No"],
			["Document List","../WorkFlow/ezWFDocList.jsp",0,1,"No"],
			["Document Details","../WorkFlow/ezWFDocDetails.jsp",0,1,"No"],
			["Document History","../WorkFlow/ezWFDocHistory.jsp",0,1,"No"],
			["Document History","",1,1,"No"],
			["Simulate WF","../WorkFlow/ezSimulateWF.jsp",0,1,"No"],
			["View WF Users","../WorkFlow/ezViewWFUsers.jsp",0,1,"No"]
			*/
		]
	
	EZ_ADMIN2_1 = [
			
			["List","../WorkFlow/ezListOrganograms.jsp",0,1,"No"],
			["Details by Role","../WorkFlow/ezOrganogramLevelsByParticipant.jsp",0,1,"No"],
			["Levels From Known Participant","../WorkFlow/ezOrganogramLevelsByLevel.jsp",0,1,"No"]
			]


	EZ_ADMIN3 = [
			["Synchronize","../Catalog/ezPreSync.jsp",0,1,"No"],
			["Create Vendor Catalog","../Catalog/ezAddVendorCatalog.jsp",0,1,"No"],
			["Modify Vendor Catalog","../Catalog/ezCatalogName.jsp",0,1,"No"],
			["List","../Catalog/ezListCatalogs.jsp",0,1,"No"],
			["Upload Products","../Catalog/ezPreUploadProduct.jsp",0,1,"No"],
			["Maintain Products","../Catalog/ezPreUploadPrice.jsp",0,1,"No"],
			["Delete Products","../Catalog/ezDeleteProducts.jsp",0,1,"No"],
			["Upload Products by Status","../Catalog/ezPreUploadByStatus.jsp",0,1,"No"],
			["Thresholds","",1,1,"No"],
			["Promotional Codes","",1,1,"No"],
			["CNET","",1,1,"No"],
			["FedEx Freight","",1,1,"No"],
			["Category Defaults","../Catalog/ezCategoryList.jsp",0,1,"No"],
			["Points Mapping","../Catalog/ezPointsMapping.jsp",0,1,"No"],
			//["Categories","../Categories/ezViewCatalogCategories.jsp",0,1,"No"]
			["Categories","",1,1,"No"]
			//["Create","../Catalog/ezAddCatalogNumber.jsp",0,1,"No"],
			//["Modify","../Catalog/ezModifyCatalog.jsp",0,1,"No"],
			//["Copy","../Catalog/ezCopyMatDesc.jsp",0,1,"No"],
			
			//["Group Description","../Catalog/ezChangeGroupDesc.jsp",0,1,"No"],
			//["Product Description","../Catalog/ezDisplayGroups.jsp",0,1,"No"],
			//["Search","../Catalog/ezPreMaterialSearch.jsp",0,1,"No"]
			
			//["Mass Synchronize","../Catalog/ezPreMassMaterialSynch.jsp",0,1,"No"]
			//["Mass Synchronize","../Catalog/ezMassSynchronize.jsp",0,1,"No"]
		]

	EZ_ADMIN3_1 = [
			["List","../Threshold/ezGetThreshold.jsp",0,1,"No"],
			["Add","../Threshold/ezAddThreshold.jsp",0,1,"No"]
		]
	
	EZ_ADMIN3_2 = [
			["List","../PromoCode/ezGetPromoCode.jsp",0,1,"No"],
			["Add","../PromoCode/ezAddPromoCode.jsp",0,1,"No"]
		]

	EZ_ADMIN3_3 = [
			["Maintain Prices","../CnetPrices/ezPreUploadCnetPrice.jsp",0,1,"No"]
		]

	EZ_ADMIN3_4 = [
			["Add Zone Mapping","../Freight/ezAddZoneMap.jsp",0,1,"No"],
			["List Zone Mapping","../Freight/ezListZoneMap.jsp",0,1,"No"],
			//["Add ServiceType","../Freight/ezAddServiceType.jsp",0,1,"No"],
			["List Service Type","../Freight/ezListServiceType.jsp",0,1,"No"],
			["Upload Freight","../Freight/ezPreUpload.jsp",0,1,"No"],
			["Delete Freight","../Freight/ezPreUploadDel.jsp",0,1,"No"]
			//["Download Freight","../Freight/ezDownloadFreight.jsp",0,1,"No"]
		]
	EZ_ADMIN3_5 = [
			["Catalog Categories","../Categories/ezViewCatalogCategories.jsp",0,1,"No"],
			["Categories List","../Categories/ezCategoriesList.jsp",0,1,"No"],
			["Category Description","../Categories/ezCategoryDescList.jsp",0,1,"No"],
			["Attribute Set","../Categories/ezAttributeSetList.jsp",0,1,"No"],
			["Attributes in Attribute Set","../Categories/ezAttributesInAttrSetList.jsp",0,1,"No"]
			//["Category Products","../Categories/ezGetProductList.jsp",0,1,"No"]
			//["Category Products","../Categories/ezCategoryProductList.jsp",0,1,"No"]
			
		]		

	EZ_ADMIN4 = [
			["Create","../Partner/ezAddBPInfo.jsp",0,1,"No"],
			["Authorizations","",1,1,"No"],
			["Synchronization","",1,1,"No"],
			["Defaults","",1,1,"No"],
			["List","",1,1,"No"],
			//["Delete Sync","",1,1,"No"],
			["Quick Add User","",1,1,"No"],
			["Search","",1,1,"No"]
		]

	EZ_ADMIN4_1 = [
			//["Vendor Partners","../Partner/ezAuthListBPBySysKey.jsp?Area=V",0,1,"No"],
			["Sales Partners","../Partner/ezAuthListBPBySysKey.jsp?Area=C",0,1,"No"]
			//["Service Partners","../Partner/ezAuthListBPBySysKey.jsp?Area=S",0,1,"No"]
		]

	EZ_ADMIN4_2 = [
			//["Vendor","../Partner/ezSynchListBPBySysKey.jsp?Area=V&FUNCTION=VN",0,1,"No"],
			["Customer","../Partner/ezSynchListBPBySysKey.jsp?Area=C&FUNCTION=AG",0,1,"No"],
			["With Hierarchy Code","../Partner/ezHierListBPBySysKey.jsp?Area=C&FUNCTION=AG",0,1,"No"]
			//["Customer From 3PL","../3PL/ezCustSynch.jsp",0,1,"No"],
			//["Products From 3PL","../3PL/ezPreSyncProducts.jsp",0,1,"No"]			
		]

	EZ_ADMIN4_3 = [
			//["Vendor","../Partner/ezDefaultsListBPBySysKey.jsp?Area=V&FUNCTION=VN",0,1,"No"],
			["Customer","../Partner/ezDefaultsListBPBySysKey.jsp?Area=C&FUNCTION=AG",0,1,"No"]
			
		]

	EZ_ADMIN4_4 = [
			//["Vendor Partners","../Partner/ezListBPBySysKey.jsp?Area=V",0,1,"No"],
			["Sales Partners","../Partner/ezListBPBySysKey.jsp?Area=C",0,1,"No"]
			//["3PL Customers","../3PL/ezListCustomers.jsp",0,1,"No"]
			//["Service Partners","../Partner/ezListBPBySysKey.jsp?Area=S",0,1,"No"]
	]
	EZ_ADMIN4_5 = [
			//["Vendor","../User/ezQuickVendorCheck.jsp?Area=V",0,1,"No"],
			//["Vendor Internal User","../User/ezPreQuickAddInternalVendorUser.jsp?Area=V&myUserType=2",0,1,"No"],
			//["Customer","../User/ezPreQuickAddCustomer.jsp?Area=C",0,1,"No"],
			["Customer","../NewUser/ezPreQuickAddUser.jsp",0,1,"No"],
			["Customer Internal User","../User/ezPreQuickAddInternalSalesUser.jsp?Area=C",0,1,"No"]
			//["Service Customer","../User/ezPreQuickAddServiceCustomer.jsp?Area=C",0,1,"No"],
			//["Service Internal User","../User/ezPreQuickAddInternalServiceUser.jsp?Area=C",0,1,"No"]
		]
	EZ_ADMIN4_6 = [
			//["Vendor Partners","",1,1,"No"],
			["Sales Partners","",1,1,"No"]
	]

	EZ_ADMIN4_6_1 = [
			["By Partner Name","../Partner/ezSearchBPBySysKey.jsp?Area=C",0,1,"No"],
			["By ERP Customer","../Partner/ezSearchBPBySoldTo.jsp?Area=C",0,1,"No"],
			["By Partner Function","../Partner/ezSearchPartnerByPartnerFunction.jsp?Area=C",0,1,"No"]
	]	

	EZ_ADMIN5 = [
			//["Create","../User/ezAddUserData.jsp",0,1,"No"],
			["Create","",1,1,"No"],
			["Authorizations","",1,1,"No"],
			["User Defaults","",1,1,"No"],
			//["InDependent Defaults","",1,1,"No"],
			["List","",1,1,"No"],
			//["Copy","",1,1,"No"],
			//["Vendor Mass Synch","",1,1,"No"],
			//["Customer Mass Synch","",1,1,"No"],
			//["Service  Mass Synch","",1,1,"No"],
			//["View Mass Sync","",1,1,"No"],
			//["Reset Password","",1,1,"No"],
			["Search","",1,1,"No"],
			["Search For Password","",1,1,"No"],
			["Lock User ","../User/ezGetPassword.jsp?PwdFlg=L",0,1,"No"],
			["Unlock User","../User/ezGetPassword.jsp?PwdFlg=U",0,1,"No"],
			["Change Password","../User/ezPassword.jsp",0,1,"No"],
			["Report Defnition","../User/ezReportDefnition.jsp",0,1,"No"],
			["News"," ",1,1,"No"]
			//["Lock User ","../User/ezGetPassword.jsp?PwdFlg=L",0,1,"No"],
			//["Unlock User","../User/ezGetPassword.jsp?PwdFlg=U",0,1,"No"]

			//["Change Field Executive","../User/ezSelectSalesEmp.jsp",0,1,"No"]
		]
	EZ_ADMIN5_1 = [
			//["Vendor User","../User/ezAddUserData.jsp?Area=V",0,1,"No"],
			["Sales User","../User/ezAddUserData.jsp?Area=C",0,1,"No"]
			
		]
	

	EZ_ADMIN5_2 = [
			//["Vendor Users","",1,1,"No"],
			["Sales Users","",1,1,"No"]
			//["Service Users","../User/ezAuthListAllUsersBySysKey.jsp?Area=S",0,1,"No"]
			//["All","../User/ezUserAuthList.jsp",0,1,"No"]
		]
	
	EZ_ADMIN5_2_1 = [
			["Business Users","../User/ezAuthListAllUsersBySysKey.jsp?Area=C&myUserType=3",0,1,"No"],
			["Internal Users","../User/ezAuthListAllUsersBySysKey.jsp?Area=C&myUserType=2",0,1,"No"],
			["All Users","../User/ezAuthListAllUsersBySysKey.jsp?Area=C",0,1,"No"]
		]

	EZ_ADMIN5_3 = [
			//["Vendor Users","",1,1,"No"],
			["Sales Users","",1,1,"No"]
			
		]

	EZ_ADMIN5_3_1 = [
			["Business Users","../User/ezDefaultsListAllUsersBySysKey.jsp?Area=C&myUserType=3",0,1,"No"],
			["Internal Users","../User/ezDefaultsListAllUsersBySysKey.jsp?Area=C&myUserType=2",0,1,"No"],
			["All Users","../User/ezDefaultsListAllUsersBySysKey.jsp?Area=C",0,1,"No"]
		]

	EZ_ADMIN5_4 = [
			//["Vendor Users","",1,1,"No"],
			["Sales Users","",1,1,"No"],
			["By Role","../User/ezListUsersByRole.jsp",0,1,"No"]
		]
	EZ_ADMIN5_4_1 = [
			["Business Users","../User/ezListAllUsersBySysKey.jsp?Area=C&myUserType=3",0,1,"No"],
			["Internal Users","../User/ezListAllUsersBySysKey.jsp?Area=C&myUserType=2",0,1,"No"],
			["Work Page","../User/ezListAllUsersBySysKey_work.jsp?Area=C&myUserType=",0,1,"No"]
			//["All Users","../User/ezListAllUsersBySysKey.jsp?Area=C",0,1,"No"]
		]
		
	EZ_ADMIN5_5 = [
			["Single","../User/ezPreMassVendSynch.jsp?Area=V",0,1,"No"],
			//["Multiple","../User/ezPreMassMultiVendSynch.jsp?Area=V",0,1,"No"],
			["Create Internal Users","../User/ezPreInternalMassVendSynch.jsp?Area=V",0,1,"No"]
		]

	EZ_ADMIN5_6 = [
			["Single","../User/ezPreMassCustSynch.jsp?Area=C",0,1,"No"],
			//["Multiple","",0,1,"No"],
			["Create Internal Users","../User/ezPreInternalMassCustSynch.jsp?Area=C",0,1,"No"]
		]

	EZ_ADMIN5_7 = [
			["Single","../User/ezPreMassServiceCustSynch.jsp?Area=C",0,1,"No"],
			//["Multiple","",0,1,"No"],
			["Create Engineers","../User/ezPreInternalMassServiceSynch.jsp?Area=C",0,1,"No"]
		]
			
	EZ_ADMIN5_5 = [
			//["Vendor Users","",1,1,"No"],
			["Sales Users","",1,1,"No"]
	]		
	EZ_ADMIN5_5_1 = [
			["By User Name","../User/ezSearchByUserName.jsp?Area=C",0,1,"No"],
			["By ERP Customer","../User/ezSearchUserBySoldTo.jsp?Area=C",0,1,"No"],
			["By Partner Function","../User/ezSearchUserByPartnerFunction.jsp?Area=C",0,1,"No"]
	]
	EZ_ADMIN5_6 = [
				//["Business Users","../User/ezGetPasswordForSelectedUser.jsp?Area=C&myUserType=3",0,1,"No"],
				//["Internal Users","../User/ezGetPasswordForSelectedUser.jsp?Area=C&myUserType=2",0,1,"No"],
				//["All Users","../User/ezGetPasswordForSelectedUser.jsp?Area=C",0,1,"No"],
				["By Input","../User/ezGetPasswordForEnteredUser.jsp",0,1,"No"]
		]
	EZ_ADMIN5_7 = [

			["Configure","../User/ezConfigureNews.jsp?Area=C",0,1,"No"],
			["List","../User/ezNewsList.jsp",0,1,"No"],
	]		
			
	EZ_ADMIN6 = [
			["Mailbox","",1,1,"No"]
			//["Forums","",1,1,"No"],
			//["Trans Messages","",1,1,"No"],
			//["Sales Doc Mails","",1,1,"No"]
			//["New Mail Box","../Inbox1/ezListPersMsgs.jsp?temp=allmess",0,1,"No"]
			//["New Mail Box","../Inbox_Siva/ezListPersMsgs.jsp?temp=allmess",0,1,"No"]
		]
	EZ_ADMIN6_1 = [
			["All Messages","../Inbox/ezListPersMsgs.jsp?msgFlag=0",0,1,"No"],
			["New Messages","../Inbox/ezListPersMsgs.jsp?msgFlag=1",0,1,"No"],
			["Compose Message","../Inbox/ezComposePersMsg.jsp?msgFlag=0",0,1,"No"],
			["List Folders","../Inbox/ezListFolders.jsp?msgFlag=0",0,1,"No"],
			["Add Folder","../Inbox/ezAddFolder.jsp?msgFlag=0",0,1,"No"]
		]
	EZ_ADMIN6_2 = [
			["Plant Planners","../SalesDocMails/ezListPlantPlannerMails.jsp",0,1,"No"],
			["Central Planner","../SalesDocMails/ezUpdateSalesDocMails.jsp?cenplan=centralplanner",0,1,"No"],
			["Marketing Service","../SalesDocMails/ezUpdateSalesDocMails.jsp?cenplan=mktservices",0,1,"No"]
		]

	EZ_ADMIN7 = [
			
			["View SBU Web Stats","",1,1,"No"],
			["View Sales Web Stats","",1,1,"No"],
			["ERP Reports","",1,1,"No"]
			//["View Service Web Stats","",1,1,"No"],
			//["Clear Web Stats","",1,1,"No"],
			//["Eye Ball View","",1,1,"No"],
			//["RDM","",1,1,"No"]			
    		]
	EZ_ADMIN7_1 = [
			["By SBU","../WebStats/ezListWebStatsBySBU.jsp?Area=V",0,1,"No"],
			["User Frequency","../WebStats/ezListUserFrequency.jsp?Area=V",0,1,"No"],
			["Time Stats","../WebStats/ezTimeStats.jsp?Area=V",0,1,"No"],
			["Activated","../WebStats/ezActiveUserList.jsp?Area=V",0,1,"No"],
			["To Be Activated","../WebStats/ezToBeActiveUserList.jsp?Area=V",0,1,"No"]
		]
	
	EZ_ADMIN7_2 = [
			["By Sales Area","../WebStats/ezListWebStatsBySBU.jsp?Area=C",0,1,"No"],
			["User Frequency","../WebStats/ezListUserFrequency.jsp?Area=C",0,1,"No"],
			["Time Stats","../WebStats/ezTimeStats.jsp?Area=C",0,1,"No"]
		]
	EZ_ADMIN7_3 = [
			["List","../Reports/ezListReports.jsp",0,1,"No"],
			["Add","../Reports/ezAddReport.jsp",0,1,"No"],
			["Edit","../Reports/ezListReport.jsp",0,1,"No"],
			["Delete","../Reports/ezDeleteReport.jsp",0,1,"No"],
			["Execute","../Reports/ezListReportCU.jsp",0,1,"No"],
			["Status","../Reports/ezListBGStatus.jsp",0,1,"No"]
	    	]	

	EZ_ADMIN7_4 = [
			["By SBU","../WebStats/ezClearWebStatsBySBU.jsp?Area=V",0,1,"No"],
			["By Sales Area","../WebStats/ezClearWebStatsBySBU.jsp?Area=C",0,1,"No"]
		]

	EZ_ADMIN7_5 = [
			["Customer","",1,1,"No"],
			["Vendor","",1,1,"No"],
			["Service","../WebStats/ezPreEyeBallView.jsp?type=3",0,1,"No"],
			["All","../WebStats/ezPreEyeBallView.jsp?type=3",0,1,"No"]
		]
	EZ_ADMIN7_5_1 = [
				["SalesOrder","../Webstats/ezViewEyeBallInfoByCategory.jsp?cat=Sales",0,1,"No"],
				["Stock","../Webstats/ezViewEyeBallInfoByCategory.jsp?cat=Stock",0,1,"No"],
				["Projections","../Webstats/ezViewEyeBallInfoByCategory.jsp?cat=Projections",0,1,"No"],
				["SelfService","../Webstats/ezViewEyeBallInfoByCategory.jsp?cat=Self",0,1,"No"],
				["Catalog","../Webstats/ezViewEyeBallInfoByCategory.jsp?cat=Catalog",0,1,"No"],				
				["Dispatch","../Webstats/ezViewEyeBallInfoByCategory.jsp?cat=dispatch",0,1,"No"],
				["Customer Details","../Webstats/ezViewEyeBallInfoByCategory.jsp?cat=customer",0,1,"No"],
				["All","../Webstats/ezViewEyeBallInfoByCategory.jsp?cat=All",0,1,"No"]
		]	
	EZ_ADMIN7_5_2 = [
				["Purchase Orders","",0,1,"No"],
				["Shipments","",0,1,"No"],
				["All","",0,1,"No"]
		]			
	EZ_ADMIN7_6 = [
			["Components","../EzcSFA/ezComponentsList.jsp",0,1,"No"],
			["Component Versions","../EzcSFA/ezComponentsVersionList.jsp",0,1,"No"],
			["Version History","../EzcSFA/ezComponentsVersionHistoryList.jsp",0,1,"No"],
			["ProductSynch","../EzcSFA/ezSynchRequest.jsp",0,1,"No"],
			["CustomerSynch","../EzcSFA/ezCustSynchRequest.jsp",0,1,"No"],
			["OrderHistorySynch","../EzcSFA/ezOrderSynch.jsp",0,1,"No"]
		]
		
	EZ_NoOfMenusToBuild   = 7
</script>