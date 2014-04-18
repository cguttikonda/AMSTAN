<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%
	String chkPurArea = "";
	java.util.Vector assignedAreas = (java.util.Vector) session.getValue("CATAREAS");
	java.util.Hashtable assignedTemplts = (java.util.Hashtable) session.getValue("TEMPLATES");
	java.util.Hashtable assignedHashWG = (java.util.Hashtable) session.getValue("WGHASHTABLE");
	java.util.Vector soldToVector = new java.util.Vector();
	String role = (String)session.getValue("ROLE");
	for(int i=0;i<assignedAreas.size();i++)
	{
		chkPurArea = (String)assignedAreas.get(i);
		int templateStep = 0;
		ArrayList desiredSteps=new ArrayList();
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziTemplateStepsParams params1= new ezc.ezworkflow.params.EziTemplateStepsParams();
		params1.setCode((String)assignedTemplts.get(chkPurArea));
		mainParams1.setObject(params1);
		Session.prepareParams(mainParams1);
		ezc.ezparam.ReturnObjFromRetrieve retTemplateStepsList=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams1);
		if(retTemplateStepsList!=null)
		{
			for(int k=0;k<retTemplateStepsList.getRowCount();k++)
			{
				if(role.equals((retTemplateStepsList.getFieldValueString(k,"ROLE")).trim()))
				{
					templateStep = 	Integer.parseInt(retTemplateStepsList.getFieldValueString(k,"STEP"));
					desiredSteps.add(templateStep-1+"");
				}
			}
		}	
		
		ezc.ezparam.EzcParams chkParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams eziWFParams= new ezc.ezworkflow.params.EziWFParams();
		eziWFParams.setTemplate((String)assignedTemplts.get(chkPurArea));
		eziWFParams.setSyskey(chkPurArea);
		eziWFParams.setParticipant((String)assignedHashWG.get(chkPurArea));
		eziWFParams.setDesiredSteps(desiredSteps);
		eziWFParams.setPartnerFunction("VN");
		chkParams.setObject(eziWFParams);
		Session.prepareParams(chkParams);
		ezc.ezparam.ReturnObjFromRetrieve retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(chkParams);
		if(retsoldto != null)
		{
			for(int j=0;j<retsoldto.getRowCount();j++)
			{
				if(!soldToVector.contains(retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO").trim()))
					soldToVector.addElement(retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO").trim());	
			}
		}
	}
	




	//out.println("Login As Pur Mgr");
	//out.println("Login"+(String) session.getValue("USERGROUP"));
	
	int newPOs 	 = 0;
	int blockedPOs	 = 0;
	int delSheds	 = 0;
	int schedAgrmnts = 0;
	int emailMsgs	 = 0;
	int blkdPosForAllVndrs = 0;
	int AcknPosForAllVndrs = 0;
	
	boolean SynchPos = true;
	String INITVAL = (String)session.getValue("INITVAL"); //REFFROM: iloginbanner.jsp
				
	if (session.getValue("OPENGRS")!=null)
	{
		session.removeValue("OPENGRS");
	}

	if("FIRST".equals(INITVAL)){
		//out.println("DEAR USER U HAVE LOGGED IN TO PORTAL WITH DEFAULT NAD FIRST>>"+INITVAL);
		session.putValue("INITVAL","1");
	}
	else{
		SynchPos = false;
		//out.println("DEAR USER U HAVE LOGGED AND REFRESH PAGES MORE TIMES>>"+INITVAL+"-->"+SynchPos);
	}
	
	String userId 		= Session.getUserId();
	String userLastLogin	= (String) session.getValue("LAST_LOGIN_DATE"); 
	String defCatArea	= (String) session.getValue("SYSKEY");
	String defErpVendor 	= (String) session.getValue("SOLDTO");
		
	String mgrAreas 	= "";
	String defOrderTo 	= defErpVendor;
	String defPayTo 	= defErpVendor;
	
	java.util.Vector reqPOKeys 	   = new java.util.Vector();
	
	
	java.util.Hashtable  purGroupsHash = (Hashtable) session.getValue("PURGRPSHASH");//REFFROM: iloginbanner.jsp
	java.util.Hashtable  ccHash	   = (Hashtable) session.getValue("CCODEHASH");  //REFFROM: iloginbanner.jsp
	java.util.Hashtable  sysKeyHash	   = new java.util.Hashtable();  //FOR PURGRPCCODE-SYSKEY MAPPING
	
	//out.println("allAreas>>"+allAreas);
	//out.println("<br>userId:"+userId);
	//out.println("<br>userLastLogin:"+userLastLogin);
	
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
	
	PurManager.setDefPayTo(defErpVendor);
	PurManager.setDefOrdAddr(defErpVendor);
		
	Date FromDate=null;
	if(userLastLogin!=null || !"null".equals(userLastLogin)){
		
		int dateArray[] = formatDate.getMMDDYYYY(userLastLogin,true);
		dateArray[0]=dateArray[0]-1;
		FromDate=new java.sql.Date(dateArray[2]-1900,dateArray[0],dateArray[1]);
	}
	
	for(int i=0;i<assignedAreas.size();i++)
	{
		String tempArea  = (String)assignedAreas.get(i);
		String searchKey = (String)purGroupsHash.get(tempArea)+(String)ccHash.get(tempArea);
		sysKeyHash.put(searchKey,tempArea);
		reqPOKeys.add(searchKey);
		 
		if(i==0)
			mgrAreas=tempArea;
		else
			mgrAreas+="','"+tempArea;
	}
	//out.println("<br>FromDate:"+FromDate);	
	
	EzPurchHdrXML hdrXML = null;
	int hdrCount = 0;
	
	if(SynchPos){
	try
	{
		EzPSIInputParameters iparams = new EzPSIInputParameters();
		EzcPurchaseParams Params = new EzcPurchaseParams();
		EziPurchaseInputParams testParams = new EziPurchaseInputParams();
		iparams.setCostCenter("ALL"); //Getting POs List For All Vendors.
		iparams.setWithDefaults("N"); //Getting POs List With Out Pur Defaults.
		testParams.setSelectionFlag("N");
		if(FromDate != null){
			testParams.setFromDate(FromDate);
		}
		Params.createContainer();
		Params.setObject(iparams);
		Params.setObject(testParams);
		Session.prepareParams(Params);
		ezc.ezcommon.EzLog4j.log("DESTEP3333333333333>>>"+FromDate,"I");
				
		hdrXML = (EzPurchHdrXML)PoManager.ezGetNewPurchaseOrderList(Params);
		if(hdrXML != null){
			hdrCount = hdrXML.getRowCount();
			///ezc.ezcommon.EzLog4j.log("DESTE---LISTPOSAP"+hdrXML.toEzcString(),"I");
		}	
		ezc.ezcommon.EzLog4j.log("DESTEP4444444444444>>"+hdrCount,"I");	
	}
	catch(Exception ex)
	{
		ezc.ezcommon.EzLog4j.log("CHECKOOOOOOEXEXEXE>>GET POS FROM R3"+ex,"I");
	}
	}
	
	//String soldTos = (String)session.getValue("SOLDTOS");
	EzcParams mainParams1 = new EzcParams(true);
	mainParams1.setLocalStore("Y");
	EziPurchaseOrderParams iParams =  new EziPurchaseOrderParams();
 	//iParams.setSysKey(defCatArea);
 	iParams.setSysKey(mgrAreas);
 	//iParams.setSoldTo(soldTos);
	mainParams1.setObject(iParams);
	Session.prepareParams(mainParams1);
	ezc.ezcommon.EzLog4j.log("DESTEP555555555>>","I");	
	ReturnObjFromRetrieve retPOAcknObj = (ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams1);
	ezc.ezcommon.EzLog4j.log("DESTEP666666666>>"+mgrAreas,"I");
	
	java.util.Vector vect = new java.util.Vector();
	java.util.Vector newContracts = new java.util.Vector();
	
	if(retPOAcknObj != null)
	{
		int retCount = retPOAcknObj.getRowCount();
		for(int i=0;i<retCount;i++)
		{
			vect.addElement(retPOAcknObj.getFieldValue(i,"DOCNO"));
			if((defErpVendor.trim()).equals((retPOAcknObj.getFieldValueString(i,"EXT1")).trim()))
			{
				//ezc.ezcommon.EzLog4j.log(">>>>>>>>>>>>>>>>>>>>>>>>"+defErpVendor.trim()+"::::::::::"+retPOAcknObj.toEzcString());
				
				if("A".equalsIgnoreCase(retPOAcknObj.getFieldValueString(i,"DOCSTATUS")) && defCatArea.equals(retPOAcknObj.getFieldValueString(i,"DOCSYSKEY")) )
				{
					newPOs=newPOs+1;
				}
				else if("B".equals(retPOAcknObj.getFieldValueString(i,"DOCSTATUS")) && defCatArea.equals(retPOAcknObj.getFieldValueString(i,"DOCSYSKEY"))) 
				{
					blockedPOs = blockedPOs+1;
				}
			}	
			if("A".equalsIgnoreCase(retPOAcknObj.getFieldValueString(i,"DOCSTATUS"))) // && defCatArea.equals(retPOAcknObj.getFieldValueString(i,"DOCSYSKEY"))) [Commented for getting all the POs irrespective of the PGs].
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
		String poNo 	  = hdrXML.getFieldValueString(i,"ORDER");
		String keySearch  = hdrXML.getFieldValueString(i,"PURGRP")+hdrXML.getFieldValueString(i,"COMPCODE");
		String defPurArea = (String)sysKeyHash.get(keySearch); 
		
		ezc.ezcommon.EzLog4j.log("ERPVENDCHK>>"+hdrXML.getFieldValueString(i,"VENDOR_NUMBER"),"I");
	 	ezc.ezcommon.EzLog4j.log("soldToVector>>"+soldToVector,"I");
		ezc.ezcommon.EzLog4j.log("reqPOKeys>>"+reqPOKeys,"I");
		ezc.ezcommon.EzLog4j.log("DOCCAT"+hdrXML.getFieldValueString(i,"DOCCAT")+"-->"+keySearch,"I");
		if(hdrXML.getFieldValueString(i,"DOCCAT").equalsIgnoreCase("F") && reqPOKeys.contains(keySearch))
		{
			//if(!vect.contains(poNo) && defErpVendor.trim().equals(hdrXML.getFieldValueString(i,"VENDOR_NUMBER").trim()))
			if(!vect.contains(poNo) && soldToVector.contains( (hdrXML.getFieldValueString(i,"VENDOR_NUMBER").trim()) ))
			{
				tableRow =  new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
				
				//tableRow.setSysKey(defCatArea);
				//tableRow.setSoldTo(defErpVendor);
				tableRow.setSysKey(defPurArea);
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
				isCallReq = true;
				if((defErpVendor.trim()).equals((hdrXML.getFieldValueString(i,"VENDOR_NUMBER")).trim()) && defCatArea.equals(defPurArea))
					blockedPOs=blockedPOs+1;
				blkdPosForAllVndrs = blkdPosForAllVndrs+1;	
			}
		}
	}

	if(isCallReq)
	{
		//params.setExt1("");
		//params.setExt2("");
		//params.setAuthKey("POUPDATEDDATE");
		//params.setSysKey(defCatArea);
		//params.setSoldTo(defErpVendor);
		params.setFlag("Y");
		ezParams.setObject(table);
		ezParams.setObject(params);
		Session.prepareParams(ezParams);
		ezc.ezcommon.EzLog4j.log("DESTEP777777777777777777>>ADDINGPOS_STARTS","I");
			retAdd=(ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezAddPOAcknowledgement(ezParams);
		ezc.ezcommon.EzLog4j.log("DESTEP888888888888888888>>ADDINGPOS_ENDS  ","I");
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
	
	
	
	/********
		if(delSheds > 0)
			alertsHashtable.put("KEY5","");
		else	
			alertsHashtable.put("KEY5","No New Delivery Schedules against Contract Orders");

		if(schedAgrmnts > 0)
			alertsHashtable.put("KEY6","<a href='../Purorder/ezContract.jsp?OrderType=New' >"+schedAgrmnts+" New Schedule Agreement(s)</a>");
		else	
			alertsHashtable.put("KEY6","No New Schedule Agreements");
	*********/	

	if(emailMsgs > 0)
		alertsHashtable.put("KEY5","<a href='../Inbox/ezListPersMsgs.jsp' >"+emailMsgs+" New Mails</a>");
	else	
		alertsHashtable.put("KEY5","No New Mails");
		
%>