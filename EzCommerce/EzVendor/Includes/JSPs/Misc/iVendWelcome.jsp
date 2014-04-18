<%
	int newPOs 	 = 0; //FOR TO BE ACK ORDERS.
	int blockedPOs	 = 0; //FOR REF OF MAIN PAGE
	int delSheds	 = 0; //FOR REF OF MAIN PAGE
	int schedAgrmnts = 0; //FOR REF OF MAIN PAGE
	int emailMsgs	 = 0; //FOR EMAIL MSGS
	int blkdPosForAllVndrs = 0;//FOR REF OF MAIN PAGE
	int AcknPosForAllVndrs = 0;//FOR REF OF MAIN PAGE
	int retCount = 0;
	
	if (session.getValue("OPENGRS")!=null)
	{
		session.removeValue("OPENGRS");
	}

	String defCatArea	= (String) session.getValue("SYSKEY");
	String defErpVendor 	= (String) session.getValue("SOLDTO");
	
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
		
	PurManager.setDefPayTo(defErpVendor);
	PurManager.setDefOrdAddr(defErpVendor);
	
	//GETTING ACK POS FROM PORTAL.
	EzcParams mainParams1 = new EzcParams(true);
	mainParams1.setLocalStore("Y");
	EziPurchaseOrderParams iParams =  new EziPurchaseOrderParams();
 	iParams.setSysKey(defCatArea);
 	iParams.setSoldTo(defErpVendor);
 	iParams.setDocStatus("A");
	mainParams1.setObject(iParams);
	Session.prepareParams(mainParams1);
	ezc.ezcommon.EzLog4j.log("DEdefCatArea>>>>>>"+defCatArea,"I");
	ezc.ezcommon.EzLog4j.log("DEdefErpVendor>>>>"+defErpVendor,"I");
	ezc.ezcommon.EzLog4j.log("DEdefCatArea>>>>>>"+defCatArea,"I");
	ezc.ezcommon.EzLog4j.log("DEBefore Calling to be ACK POS>>>>"+defErpVendor,"I");
	ReturnObjFromRetrieve retPOAcknObj = (ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams1);
	ezc.ezcommon.EzLog4j.log("DEEnd Calling to be ACK POS>>>>"+defErpVendor,"I");
	
	if(retPOAcknObj != null)
	{
		retCount = retPOAcknObj.getRowCount();
		newPOs= retCount;
	}	
	
	ezc.ezcommon.EzLog4j.log("DE:END OF VEND SBU WELCOME"+newPOs,"I");
	/************
	B -- Blocked POs
	A -- To be Acknowledged
	X -- Acknowledged
	R -- Rejected
	*************/
	
	/************************************
	int newMaterialCount	= 0;
	int excessMaterialCount	= 0;

	if(userType.equals("3"))
	{
	   	
		ezc.ezparam.EzcParams newMaterialParams = new ezc.ezparam.EzcParams(false);
   		ezc.ezvendorapp.params.EzMaterialRequestStructure newStruct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();
		newStruct.setCurrentStatus("A");	// Active Status
		newStruct.setRequestType("N");	        // New Materials
		newStruct.setFlag("N");	                // Flag to get New Requests
		newStruct.setSoldTo(defErpVendor);	       
		newStruct.setUserType(userType);
		newMaterialParams.setObject(newStruct);
		newMaterialParams.setLocalStore("Y");
		Session.prepareParams(newMaterialParams);
		ezc.ezparam.ReturnObjFromRetrieve newMaterialRet= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetAllMaterialRequests(newMaterialParams);
		int newRetCount = newMaterialRet.getRowCount();

		for(int i=0;i<newRetCount;i++)
		{
			if(newMaterialRet.getFieldValueString(i,"VISIBILITYLEVEL").equals("A") || newMaterialRet.getFieldValueString(i,"SYSKEY").equals(defCatArea))
			{
				newMaterialCount++;
			}
		}
	
		ezc.ezparam.EzcParams excessMaterialParams = new ezc.ezparam.EzcParams(false);
   		ezc.ezvendorapp.params.EzMaterialRequestStructure excessStruct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();
		excessStruct.setCurrentStatus("A");    // Active Status
		excessStruct.setRequestType("E");      // Excess Materials	
		excessStruct.setFlag("N");	       // Flag to get New Requests
		excessStruct.setSoldTo(defErpVendor);	       
		excessStruct.setUserType(userType);
		excessMaterialParams.setObject(excessStruct);
		excessMaterialParams.setLocalStore("Y");
		Session.prepareParams(excessMaterialParams);
		ezc.ezparam.ReturnObjFromRetrieve excessMaterialRet= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetAllMaterialRequests(excessMaterialParams);

		int excessRetCount = excessMaterialRet.getRowCount();

		for(int i=0;i<excessRetCount;i++)
		{
			if(excessMaterialRet.getFieldValueString(i,"VISIBILITYLEVEL").equals("A") || excessMaterialRet.getFieldValueString(i,"SYSKEY").equals(defCatArea))
			{
				excessMaterialCount++;				
			}
		}	   	
	   	
	}
	********************/	
	
	
	
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setClient("200");
	ezMessageParams.setToFolderId("1000");
	ezMessageParams.setLanguage("EN");
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams);
	ezc.ezparam.ReturnObjFromRetrieve retMsgList = (ezc.ezparam.ReturnObjFromRetrieve)Manager.getPersonalNewMsgHeader(ezcMessageParams);
	if(retMsgList != null)
		emailMsgs = retMsgList.getRowCount();

	/**********
	KEY1	==== BLKD_POS
	KEY2	==== BLKD_POS_ALL
	KEY3	==== NEW_POS
	KEY4	==== NEW_POS_ALL
	KEY5	==== EMAILS


	//KEY5	==== DEL_SHEDS
	//KEY6	==== SCHD_AGRMNTS
	
	**********/


	

	if(blockedPOs > 0)
		alertsHashtable.put("KEY1","<a href='../Purorder/ezListBlockedPOs.jsp' text-decoration=none >"+blockedPOs+" Blocked Purchase Order(s) for "+defErpVendor+"</a>");
	else	
		alertsHashtable.put("KEY1","No Blocked Purchase Orders for "+defErpVendor);
	
	if(blkdPosForAllVndrs > 0)
		alertsHashtable.put("KEY2","<a href='../Purorder/ezListBlockedPOs.jsp?SHOW=ALL' text-decoration=none >"+blkdPosForAllVndrs+" Blocked Purchase Order(s) for all Suppliers</a>");
	else	
		alertsHashtable.put("KEY2","No Blocked Purchase Order(s) for all Suppliers");
	
	if(newPOs > 0)
		alertsHashtable.put("KEY3","<a href='../Purorder/ezListAcknowledgedPOs.jsp?type=NotAcknowledged' text-decoration=none >"+newPOs+" Purchase Order(s) to Acknowledge for "+defErpVendor+"</a>");
	else	
		alertsHashtable.put("KEY3","No Purchase Orders to Acknowledge for "+defErpVendor);
	
	if(AcknPosForAllVndrs > 0)
		alertsHashtable.put("KEY4","<a href='../Purorder/ezListAcknowledgedPOs.jsp?type=NotAcknowledged&SHOW=ALL' text-decoration=none >"+AcknPosForAllVndrs+" Purchase Order(s) to Acknowledge for all suppliers</a>");
	else	
		alertsHashtable.put("KEY4","No Purchase Order(s) to Acknowledge for all suppliers");
	
	/*
	if(delSheds > 0)
		alertsHashtable.put("KEY5","");
	else	
		alertsHashtable.put("KEY5","No New Delivery Schedules against Contract Orders");
		
	if(schedAgrmnts > 0)
		alertsHashtable.put("KEY6","<a href='../Purorder/ezContract.jsp?OrderType=New' >"+schedAgrmnts+" New Schedule Agreement(s)</a>");
	else	
		alertsHashtable.put("KEY6","No New Schedule Agreements");
	*/	

	if(emailMsgs > 0)
		alertsHashtable.put("KEY5","<a href='../Inbox/ezListPersMsgs.jsp' >"+emailMsgs+" New Mails</a>");
	else	
		alertsHashtable.put("KEY5","No New Mails");
		
%>