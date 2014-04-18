<%
	int newPOs 	 = 0;
	int blockedPOs	 = 0;
	int delSheds	 = 0;
	int schedAgrmnts = 0;
	int emailMsgs	 = 0;
	int blkdPosForAllVndrs = 0;
	int AcknPosForAllVndrs = 0;
	
	if (session.getValue("OPENGRS")!=null)
	{
		session.removeValue("OPENGRS");
	}

	String defCatArea	= (String) session.getValue("SYSKEY");
	String defErpVendor 	= (String) session.getValue("SOLDTO");
	String defUser 		= (String) Session.getUserId();
	
	String defOrderTo 	= defErpVendor;
	String defPayTo 	= defErpVendor;
	
	Date FromDate=null;
	
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);

	EzcParams sParams = new EzcParams(false);
	EziPurchaseOrderParams timeStampParams= new EziPurchaseOrderParams();
	sParams.setLocalStore("Y");
	timeStampParams.setDocType("POUPDATEDDATE");
	timeStampParams.setSysKey(defCatArea);
	timeStampParams.setSoldTo(defUser);
	sParams.setObject(timeStampParams);
	Session.prepareParams(sParams);
	ReturnObjFromRetrieve retDate=(ReturnObjFromRetrieve)AppManager.ezGetVendorTimeStamp(sParams);
	ezc.ezcommon.EzLog4j.log("Vendor timestamp "+retDate.toEzcString(),"I");
		
	if(retDate.getRowCount()>0)
	{
		String lastLoginDate = formatDate.getStringFromDate((java.util.Date)retDate.getFieldValue(0,"DOCDATE"),"/",FormatDate.MMDDYYYY);
		int dateArray[] = formatDate.getMMDDYYYY(lastLoginDate,true);
		dateArray[0]=dateArray[0]-1;
		FromDate=new java.sql.Date(dateArray[2]-1900,dateArray[0],dateArray[1]);
		ezc.ezcommon.EzLog4j.log("DESTEP4444444444444 FromDate>>"+FromDate,"I");
	}
	else
	{
		
		
		EzcParams aParams = new EzcParams(false);
		EzVendorTimeStampStructure addtimeStampParams= new EzVendorTimeStampStructure();
		aParams.setLocalStore("Y");
		addtimeStampParams.setAuthKey("POUPDATEDDATE");
		addtimeStampParams.setSysKey(defCatArea);
		addtimeStampParams.setSoldTo(defUser);
		addtimeStampParams.setExt1("");
		addtimeStampParams.setExt2("");
		aParams.setObject(addtimeStampParams);
		Session.prepareParams(aParams);
		AppManager.ezAddVendorTimeStamp(aParams);
		
		java.util.Calendar rightNow = java.util.Calendar.getInstance();
		rightNow.add(java.util.Calendar.MONTH,-5);
		FromDate=new java.sql.Date(rightNow.get(java.util.Calendar.YEAR)-1900,rightNow.get(java.util.Calendar.MONTH)-1,rightNow.get(java.util.Calendar.DATE));
		ezc.ezcommon.EzLog4j.log("DESTEP4444444444444 FromDate>>"+FromDate,"I");	
	}

	PurManager.setDefPayTo(defErpVendor);
	PurManager.setDefOrdAddr(defErpVendor);
ezc.ezcommon.EzLog4j.log(" ezGetNewPurchaseOrderList==","I");
	EzPurchHdrXML hdrXML = null;
	int hdrCount = 0;
	try
	{
		EzPSIInputParameters iparams = new EzPSIInputParameters();
		EzcPurchaseParams Params = new EzcPurchaseParams();
		EziPurchaseInputParams testParams = new EziPurchaseInputParams();
		testParams.setSelectionFlag("N");
		iparams.setCostCenter("ALL");
		if (FromDate != null)
		{
			testParams.setFromDate(FromDate);
		}
		Params.createContainer();
		Params.setObject(iparams);
		Params.setObject(testParams);
		Session.prepareParams(Params);
		ezc.ezcommon.EzLog4j.log("Before ezGetNewPurchaseOrderList==","I");
		hdrXML = (EzPurchHdrXML)PoManager.ezGetNewPurchaseOrderList(Params);
		if(hdrXML != null)
			hdrCount = hdrXML.getRowCount();
		ezc.ezcommon.EzLog4j.log("ezGetNewPurchaseOrderList >>"+hdrXML.toEzcString(),"I");	
			
	}
	catch(Exception ex)
	{
		ezc.ezcommon.EzLog4j.log("CHECKOOOOOOEXEXEXE>>GET POS FROM R3"+ex,"I");
	}
	
	String soldTos = (String)session.getValue("SOLDTOS");
	ezc.ezcommon.EzLog4j.log("soldTos>>>"+userType+"---->"+soldTos,"I");
	EzcParams mainParams1 = new EzcParams(true);
	mainParams1.setLocalStore("Y");
	EziPurchaseOrderParams iParams =  new EziPurchaseOrderParams();
 	iParams.setSysKey(defCatArea);
 	iParams.setSoldTo(soldTos);
	mainParams1.setObject(iParams);
	Session.prepareParams(mainParams1);
	ReturnObjFromRetrieve retPOAcknObj = (ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams1);
	java.util.Vector vect = new java.util.Vector();
	java.util.Vector newContracts = new java.util.Vector();
	
	if(retPOAcknObj != null)
	{
		int retCount = retPOAcknObj.getRowCount();
		for(int i=0;i<retCount;i++)
		{
			vect.addElement(retPOAcknObj.getFieldValue(i,"DOCNO"));//THESE ARE INSERTED DOCS IN PORTAL
			if((defErpVendor.trim()).equals((retPOAcknObj.getFieldValueString(i,"EXT1")).trim()))
			{
				//ezc.ezcommon.EzLog4j.log(">>>>>>>>>>>>>>>>>>>>>>>>"+defErpVendor.trim()+"::::::::::"+retPOAcknObj.toEzcString());
				
				if("A".equalsIgnoreCase(retPOAcknObj.getFieldValueString(i,"DOCSTATUS")))
				{
					newPOs=newPOs+1;
				}
				else if ("B".equals(retPOAcknObj.getFieldValueString(i,"DOCSTATUS"))) 
				{
					blockedPOs = blockedPOs+1;
				}
			}	
			if("A".equalsIgnoreCase(retPOAcknObj.getFieldValueString(i,"DOCSTATUS")))
			{
				AcknPosForAllVndrs = AcknPosForAllVndrs+1;
			}
			else if ("B".equals(retPOAcknObj.getFieldValueString(i,"DOCSTATUS"))) 
			{
				blkdPosForAllVndrs = blkdPosForAllVndrs+1;
			}
		}
	}	
	
	ezc.ezcommon.EzLog4j.log("CHECKOOOOOO>>>>"+blockedPOs+":"+blkdPosForAllVndrs+":"+vect,"I");
	
	/************
	B -- Blocked POs
	A -- To be Acknowledged
	X -- Acknowledged
	R -- Rejected
	*************/
	
	java.util.Vector soldTosVector = (java.util.Vector)session.getValue("SOLDTOVECT");
	
	boolean  isCallReq 	= false;
	String sKey = "";
	String date=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
	
	ezc.ezvendorapp.params.EzPOAcknowledgementTableRow tableRow=null;
	ezc.ezvendorapp.params.EzPOAcknowledgementTable table=new
	ezc.ezvendorapp.params.EzPOAcknowledgementTable();
	ezc.ezparam.EzcParams ezParams = new ezc.ezparam.EzcParams(true);
	ezParams.setLocalStore("Y");
	ezc.ezparam.ReturnObjFromRetrieve retAdd=null;
	ezc.ezvendorapp.params.EzVendorTimeStampStructure params=new ezc.ezvendorapp.params.EzVendorTimeStampStructure();

	for(int i=0;i<hdrCount;i++)
	{
		String poNo = hdrXML.getFieldValueString(i,"ORDER");

		if(hdrXML.getFieldValueString(i,"DOCCAT").equalsIgnoreCase("F"))
		{

			//if(!vect.contains(poNo) && defErpVendor.trim().equals(hdrXML.getFieldValueString(i,"VENDOR_NUMBER").trim()))
			if(!vect.contains(poNo) && soldTosVector.contains(hdrXML.getFieldValueString(i,"VENDOR_NUMBER")))
			{
				tableRow =  new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
				tableRow.setSysKey(defCatArea);
				tableRow.setSoldTo(hdrXML.getFieldValueString(i,"VENDOR_NUMBER"));
				tableRow.setDocNo(poNo);
				tableRow.setDocDate(date);
				tableRow.setDocStatus("B");
				tableRow.setCreatedOn(date);
				tableRow.setCreatedBy(Session.getUserId());
				tableRow.setModifiedOn(date);
				tableRow.setHeaderText("");
				tableRow.setExt1("");
				tableRow.setExt2("");
				tableRow.setExt3("");
				table.appendRow(tableRow);
				if((defErpVendor.trim()).equals((hdrXML.getFieldValueString(i,"VENDOR_NUMBER")).trim()))
					blockedPOs=blockedPOs+1;
				isCallReq = true;
				blkdPosForAllVndrs = blkdPosForAllVndrs+1;
			}
		}
	}

	if(isCallReq)
	{
		params.setExt1("");
		params.setExt2("");
		params.setAuthKey("POUPDATEDDATE");
		params.setSysKey(defCatArea);
		params.setSoldTo(defUser);
		params.setFlag("Y");
		ezParams.setObject(table);
		ezParams.setObject(params);
		Session.prepareParams(ezParams);
		retAdd=(ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezAddPOAcknowledgement(ezParams);
	}
   	
	   	
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