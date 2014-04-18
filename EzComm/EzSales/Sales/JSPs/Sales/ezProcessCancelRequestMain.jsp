<%@ page import ="ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import ="java.text.*,ezc.ezmisc.params.*" %>
<%@ page import ="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.ezsap.*,ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%@ include file="../Misc/ezEncryption.jsp"%>
<%@ include file="../Misc/ezDBMethods.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret))
			ret = "";

		return ret;
	}
%>
<%
ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();

String cancOrRGA 	= request.getParameter("cancOrRGA");

String authChkStr = "SO_CANCEL";

if(cancOrRGA.equals("RGA"))
	authChkStr = "SO_RETURN_CREATE";

if(userAuth_R.containsKey(authChkStr))
{
	String poItems[] 	= request.getParameterValues("poItems");
	String poNumber 	= request.getParameter("PurchaseOrder");
	String customer 	= request.getParameter("soldTo");
	String salesOrder 	= request.getParameter("salesOrder");
	String shipTo   	= request.getParameter("selShipTo");
	String requestType 	= request.getParameter("requestType");
	String crType 		= request.getParameter("crType");
	String poDate   	= request.getParameter("poDate");

	if (requestType.equals("R")){
		// Also read Reason for Request and Ship To and Sold To Code
		// read Addresses if drop ship so that it can be posted.
	}
	
	
	log4j.log("CANCELLATION--poNumber======>"+poNumber, "D");
	log4j.log("CANCELLATION--customer======>"+customer, "D");
	log4j.log("CANCELLATION--shipTo======>"+shipTo, "D");
	
	String userRole 	= (String)session.getValue("UserRole");
	String userId		= Session.getUserId();
	String userFNameH 	= (String)session.getValue("FIRSTNAME");
	String userLNameH 	= (String)session.getValue("LASTNAME");
	log4j.log("CANCELLATION--userId======>"+userId, "D");

	String shipToName 	= nullCheck(request.getParameter("shipToName"));
	String shipToStreet 	= nullCheck(request.getParameter("shipToStreet"));
	String shipToCity 	= nullCheck(request.getParameter("shipToCity"));
	String shipToState 	= nullCheck(request.getParameter("shipToState"));
	String shipToZip 	= nullCheck(request.getParameter("shipToZip"));
	String shipToPhone 	= nullCheck(request.getParameter("shipToPhone"));
	String shipToCountry 	= nullCheck(request.getParameter("shipToCountry"));
	
	if(!"".equals(shipToName))	 shipToName 	= replaceString(shipToName,"'","`");
	if(!"".equals(shipToStreet))	 shipToStreet 	= replaceString(shipToStreet,"'","`");
	if(!"".equals(shipToCity))	 shipToCity 	= replaceString(shipToCity,"'","`");
	if(!"".equals(shipToState))	 shipToState 	= replaceString(shipToState,"'","`");
	if(!"".equals(shipToZip))	 shipToZip 	= replaceString(shipToZip,"'","`");
	if(!"".equals(shipToPhone))	 shipToPhone 	= replaceString(shipToPhone,"'","`");
	if(!"".equals(shipToCountry))	 shipToCountry 	= replaceString(shipToCountry,"'","`");
	
	if(poNumber!=null)
		poNumber = poNumber.replaceAll("'","`");

	int selecedItemsCnt = 0;
	 	
	if(poItems!=null)
 		selecedItemsCnt = poItems.length;
 

	String showMsg 		= "", showErrorMessage = "" ,showSuccessMessage = "", showCancellationReqMsg = "";
	
	Hashtable matCodeHT = new Hashtable();
	Hashtable matDescHT = new Hashtable();
	Hashtable rejReasonHT = new Hashtable();
	Hashtable cancelTypeHT = new Hashtable();
	Hashtable quantityHT = new Hashtable();
	Hashtable commentsHT = new Hashtable();
	
	Hashtable retQtyHT = new Hashtable();
	Hashtable retMatHT = new Hashtable();
	Hashtable retMatNPHT = new Hashtable();
	Hashtable retInvNoHT = new Hashtable();
	Hashtable salesOrgHT = new Hashtable();
	Hashtable divisionHT = new Hashtable();
	Hashtable distChannelHT = new Hashtable();
	
	
	Vector directCancelItems = new Vector();
	Vector reqCancelItems = new Vector();
	Vector reqRGAItems = new Vector();
	
	
	for(int i=0;i<poItems.length;i++)
	{
		boolean isError 	= false;
	
		String poItemStr 	=  poItems[i];
		String selReason	=  request.getParameter("reasonForRej"+poItemStr);
		String salesOrderItem  	=  request.getParameter("salesOrderItem"+poItemStr);
		String prodCode  	=  request.getParameter("prodCode"+poItemStr);
		String prodDesc  	=  request.getParameter("prodDesc"+poItemStr);
		String quantity  	=  request.getParameter("quantity"+poItemStr);
		String cancelType	=  request.getParameter("cancelType"+poItemStr);
		String comments		=  request.getParameter("comments"+poItemStr);
		
		String retQty		=  request.getParameter("retQty"+poItemStr);
		String retMat		=  request.getParameter("retMat"+poItemStr);
		String retMatNP		=  request.getParameter("retMatNP"+poItemStr);
		String retInvNo		=  request.getParameter("retInvNo"+poItemStr);
		String salesOrg		=  request.getParameter("salesOrg"+poItemStr);
		String division		=  request.getParameter("division"+poItemStr);
		String distChannel	=  request.getParameter("distChannel"+poItemStr);
		
		
		
		//out.println(comments+"<Br>");
		
		if(comments!=null)
			comments = comments.replaceAll("'","`");
		else
			comments = "";
		
		String soNumber 	= salesOrderItem.split("/")[0];
		String soItem 		= salesOrderItem.split("/")[1];
		
		matCodeHT.put(poItemStr,prodCode);
		matDescHT.put(poItemStr,prodDesc);
		if (!("RGA".equals(cancelType))){
		rejReasonHT.put(poItemStr,selReason);
		commentsHT.put(poItemStr,comments);
		}
		cancelTypeHT.put(poItemStr,cancelType);
		quantityHT.put(poItemStr,quantity);
		
		retQtyHT.put(poItemStr,retQty);
		retMatHT.put(poItemStr,retMat);
		retMatNPHT.put(poItemStr,retMatNP);
		retInvNoHT.put(poItemStr,retInvNo);
		salesOrgHT.put(poItemStr,salesOrg);
		divisionHT.put(poItemStr,division);
		distChannelHT.put(poItemStr,distChannel);
		
		log4j.log("CANCELLATION--Hashtable Entries for ======>"+i+"  "+userId, "D");
		
		
		if("C".equals(cancelType))
			directCancelItems.addElement(salesOrderItem); 
			
		if("RC".equals(cancelType))
			reqCancelItems.addElement(salesOrderItem); 	
		
		if("RGA".equals(cancelType))
			reqRGAItems.addElement(salesOrderItem); 
			
		
	}
	
	//out.println(commentsHT);
	
	if(directCancelItems.size()>0)
	{
		log4j.log(":::::::::::::::::::CANCELLATION:::::::::::::::::::::", "D");
	
		ReturnObjFromRetrieve retCancIdObj = null;

		ezc.ezparam.EzcParams canMainParams = new ezc.ezparam.EzcParams(false);
		EziMiscParams canMiscParams = new EziMiscParams();
		canMiscParams.setIdenKey("MISC_SELECT");
		String canQuery="SELECT MAX(ESCH_ID) CANC_ID FROM EZC_SO_CANCEL_HEADER";
		canMiscParams.setQuery(canQuery);
		canMainParams.setLocalStore("Y");
		canMainParams.setObject(canMiscParams);
		Session.prepareParams(canMainParams);	
		try{	retCancIdObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(canMainParams);
		}
		catch(Exception e)
		{
			log4j.log(":::::CANCELLATIONID::ezMiscManager-Cancel::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");
		}




		int cancellationId = 1000;

		if(retCancIdObj!=null && retCancIdObj.getRowCount()>0)
		{
			String canId = retCancIdObj.getFieldValueString(0,"CANC_ID");

			try{
				cancellationId = Integer.parseInt(canId)+1;
			}catch(Exception e){}
		}


		log4j.log("CANCELLATIONID======>"+cancellationId, "D");

		for(int i=0;i<directCancelItems.size();i++)
		{
			boolean isError 	= false;
			String soItemStr        = (String)directCancelItems.get(i);
		
			String soNumber 	= soItemStr.split("/")[0];
			String soItem 		= soItemStr.split("/")[1];
			
			String selRejReason 	= (String)rejReasonHT.get(soNumber+""+soItem);
			String selRejComments = (String)commentsHT.get(soNumber+""+soItem);
			
			log4j.log("soNumber======>"+soNumber, "D");
			log4j.log("soItem======>"+soItem, "D");
			log4j.log("selRejReason======>"+selRejReason, "D");
			log4j.log("selRejComments======>"+selRejComments, "D");
			
			JCO.Client client	=	null;
			JCO.Function jcoFunction 	= 	null;
			JCO.Function jcoTextFunction = null;
			JCO.Function commit = null;

			Date dateposted = new Date();  
			SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm");  
			
			String site_S = (String)session.getValue("Site");
			String skey_S = "999";

			try
			{
				client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
				jcoFunction 	= EzSAPHandler.getFunction("Z_EZ_SALESORDER_CHANGE",site_S+"~"+skey_S);
				commit 		= EzSAPHandler.getFunction("BAPI_TRANSACTION_COMMIT",site_S+"~"+skey_S);

				JCO.ParameterList 	sapProc 	= jcoFunction.getImportParameterList();
				JCO.Structure orderHdrStructure     	= sapProc.getStructure("ORDER_HEADER_INX");
				


				//out.println(orderHdrStructure);

				JCO.Table soItemTab          		= jcoFunction.getTableParameterList().getTable("ORDER_ITEM_IN");
				JCO.Table soItemX          		= jcoFunction.getTableParameterList().getTable("ORDER_ITEM_INX");
				JCO.Table soItemText          		= jcoFunction.getTableParameterList().getTable("ORDER_TEXT");


				sapProc.setValue(soNumber,"SALESDOCUMENT");

				orderHdrStructure.setValue("U","UPDATEFLAG");

				JCO.Structure	logicSwitch = sapProc.getStructure("LOGIC_SWITCH");
				logicSwitch.setValue("C","PRICING");
				
				

				soItemTab.appendRow();
				soItemTab.setValue(soItem,"ITM_NUMBER");
				soItemTab.setValue(selRejReason,"REASON_REJ");


				soItemX.appendRow();
				soItemX.setValue(soItem,"ITM_NUMBER");
				soItemX.setValue("U","UPDATEFLAG");
				soItemX.setValue("X","REASON_REJ");

				commit.getImportParameterList().setValue("X", "WAIT");
				
				soItemText.appendRow();
				soItemText.setValue(soNumber,"DOC_NUMBER");
				soItemText.setValue(soItem,"ITM_NUMBER");
				soItemText.setValue("ZPI1","TEXT_ID");
				soItemText.setValue("EN","LANGU");
				soItemText.setValue("*","FORMAT_COL");
				soItemText.setValue("Cancellation Requested by Portal User: "+userFNameH+" "+userLNameH+" on: "+format.format(dateposted),"TEXT_LINE");
				soItemText.setValue("005","FUNCTION");

				if (!selRejComments.trim().equals("")) {
				soItemText.appendRow();
				soItemText.setValue(soNumber,"DOC_NUMBER");
				soItemText.setValue(soItem,"ITM_NUMBER");
				soItemText.setValue("ZPI1","TEXT_ID");
				soItemText.setValue("EN","LANGU");
				soItemText.setValue("*","FORMAT_COL");
				soItemText.setValue("Comments on Cancellation:"+selRejComments,"TEXT_LINE");
				soItemText.setValue("005","FUNCTION");
				}

				soItemText.appendRow();
				soItemText.setValue(soNumber,"DOC_NUMBER");
				soItemText.setValue(soItem,"ITM_NUMBER");
				soItemText.setValue("ZPI1","TEXT_ID");
				soItemText.setValue("EN","LANGU");
				soItemText.setValue("*","FORMAT_COL");
				soItemText.setValue("Cancellation Id on myasb2b.com: "+cancellationId,"TEXT_LINE");
				soItemText.setValue("005","FUNCTION");

				soItemText.appendRow();
				soItemText.setValue(soNumber,"DOC_NUMBER");
				soItemText.setValue(soItem,"ITM_NUMBER");
				soItemText.setValue("ZPI1","TEXT_ID");
				soItemText.setValue("EN","LANGU");
				soItemText.setValue("*","FORMAT_COL");
				soItemText.setValue("Cancellation Approved and Posted by Portal user: "+userFNameH+" "+userLNameH+" on "+format.format(dateposted),"TEXT_LINE");
				soItemText.setValue("005","FUNCTION");

				try
				{
					
					client.execute(jcoFunction);
					client.execute(commit);

				}
				catch(Exception ec)
				{
					log4j.log("::::::::CLIENT:::::::::::ezProcessCancelRequest::::::::::::::::::::"+ec, "E");
				}

				JCO.Table returnTable 	= jcoFunction.getTableParameterList().getTable("RETURN");

				boolean okToUpdateText = true;
				if ( returnTable != null )
				{
					if (returnTable.getNumRows() > 0)
					{
						do
						{
							if("E".equals(returnTable.getValue("TYPE")))
							{
								isError = true;
								showMsg += returnTable.getValue("MESSAGE"); 

								showErrorMessage += " Sales Order / Item "+  soNumber+"/"+soItem+" is not cancelled. "+showMsg;
								okToUpdateText = false;
								log4j.log("::::::::ERROR:::::::::::showErrorMessage::::::::::::::::::::"+showErrorMessage, "E");

							}	

						}while(returnTable.nextRow());
						
					}	
				}
				log4j.log(":::::NOW ATTEMPT TO UPDATETEXT::::::::::::::::::::"+okToUpdateText, "I");

			}
			catch(Exception e)
			{
				log4j.log(":::::::EXCEPTION::::::::::::Probably in updating text::::::::::::::::::::"+e, "E");
			}
			finally
			{
				if (client!=null)
				{
					log4j.log(":::::::RELEASING CLIENT:::::::::::", "D");
					JCO.releaseClient(client);
					client = null;
					jcoFunction=null;
					commit = null;
				}
			}


			if(!isError)
				showSuccessMessage += "<Br>Sales Order / Item "+  soNumber+"/"+soItem+" is cancelled successfully.";
			
			
			
			
			
			
			if(i==0)
			{
				canMainParams = new ezc.ezparam.EzcParams(false);
				canMiscParams = new EziMiscParams();

				canMiscParams.setIdenKey("MISC_INSERT");
				canQuery="INSERT INTO EZC_SO_CANCEL_HEADER(ESCH_ID,ESCH_PO_NUM,ESCH_SO_NUM,ESCH_SOLD_TO,ESCH_SYSKEY,ESCH_CREATED_BY,ESCH_CREATED_ON,ESCH_MODIFIED_BY,ESCH_MODIFIED_ON,ESCH_STATUS,ESCH_TYPE,ESCH_EXT1,ESCH_EXT2,ESCH_EXT3,ESCH_SHIP_TO_NAME,ESCH_SHIP_TO_STREET1,ESCH_SHIP_TO_CITY,ESCH_SHIP_TO_STATE,ESCH_SHIP_TO_COUNTRY,ESCH_SHIP_TO_ZIP,ESCH_SHIP_TO_PHONE) VALUES("+cancellationId+",'"+poNumber+"','"+soNumber+"','"+customer+"','999100','"+userId+"',getdate(),'"+userId+"',getdate(),'A','C','"+shipTo+"','','','"+shipToName+"','"+shipToStreet+"','"+shipToCity+"','"+shipToState+"','"+shipToCountry+"','"+shipToZip+"','"+shipToPhone+"')";
				canMiscParams.setQuery(canQuery);
				canMainParams.setLocalStore("Y");
				canMainParams.setObject(canMiscParams);
				Session.prepareParams(canMainParams);	
				try{	
					ezMiscManager.ezAdd(canMainParams);
				}catch(Exception e){
					log4j.log(":::::EZC_SO_CANCEL_HEADER::ezMiscManager::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");
				}
			}
			
			String updateStatus = "A";
			if(isError)
				updateStatus = "E";
				
			canMainParams = new ezc.ezparam.EzcParams(false);
			canMiscParams = new EziMiscParams();

			canMiscParams.setIdenKey("MISC_INSERT");
			canQuery="INSERT INTO EZC_SO_CANCEL_ITEMS(ESCI_ID,ESCI_SO_NUM,ESCI_SO_ITEM,ESCI_MAT_CODE,ESCI_MAT_DESC,ESCI_QUANTITY,ESCI_REJ_REASON,ESCI_COMMENTS,ESCI_TYPE,ESCI_STATUS,ESCI_EXT1,ESCI_EXT2,ESCI_EXT3) VALUES("+cancellationId+",'"+soNumber+"','"+soItem+"','"+matCodeHT.get(soNumber+""+soItem)+"','"+matDescHT.get(soNumber+""+soItem)+"','"+quantityHT.get(soNumber+""+soItem)+"','"+rejReasonHT.get(soNumber+""+soItem)+"','"+commentsHT.get(soNumber+""+soItem)+"','C','"+updateStatus+"','','','')";
			canMiscParams.setQuery(canQuery);
			canMainParams.setLocalStore("Y");
			canMainParams.setObject(canMiscParams);
			Session.prepareParams(canMainParams);	
			try{	
				ezMiscManager.ezAdd(canMainParams);
			}catch(Exception e){
				log4j.log(":::::EZC_SO_CANCEL_ITEMS::ezMiscManager::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");
			}
		}	
	}

	String rgaNumber = "";

	if(reqCancelItems.size()>0 )
	{
		log4j.log(":::::::::::::::::::CANCELLATION REQUEST:::::::::::::::::::::", "D");
	
		ReturnObjFromRetrieve retCancIdObj = null;

		ezc.ezparam.EzcParams canMainParams = new ezc.ezparam.EzcParams(false);
		EziMiscParams canMiscParams = new EziMiscParams();
		canMiscParams.setIdenKey("MISC_SELECT");
		String canQuery="SELECT MAX(ESCH_ID) CANC_ID FROM EZC_SO_CANCEL_HEADER";
		canMiscParams.setQuery(canQuery);
		canMainParams.setLocalStore("Y");
		canMainParams.setObject(canMiscParams);
		Session.prepareParams(canMainParams);	
		try{	retCancIdObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(canMainParams);
		}
		catch(Exception e){out.println("Exception in Getting Data"+e);}


		

		int cancellationId = 1000;

		if(retCancIdObj!=null && retCancIdObj.getRowCount()>0)
		{
			String canId = retCancIdObj.getFieldValueString(0,"CANC_ID");

			try{
				cancellationId = Integer.parseInt(canId)+1;
			}catch(Exception e)
			{
				log4j.log(":::::CANCELLATIONID::ezMiscManager-Cancel Request::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");
			}
		}
		rgaNumber = cancellationId+"";
		
		log4j.log("CANCELLATIONID==Cancel Request====>"+cancellationId, "D");
		
		showCancellationReqMsg += "Request for cancellation for the below Item(s) is sent to CUSTOMER SERVICE. <Br> Reference Number : "+cancellationId;

		
		for(int i=0;i<reqCancelItems.size();i++)
		{
			String soItemStr        = (String)reqCancelItems.get(i);

			String soNumber 	= soItemStr.split("/")[0];
			String soItem 		= soItemStr.split("/")[1];
			
			log4j.log("soNumber======>"+soNumber, "D");
			log4j.log("soItem======>"+soItem, "D");
		
			
			if(i==0)
			{
				canMainParams = new ezc.ezparam.EzcParams(false);
				canMiscParams = new EziMiscParams();

				canMiscParams.setIdenKey("MISC_INSERT");
				canQuery="INSERT INTO EZC_SO_CANCEL_HEADER(ESCH_ID,ESCH_PO_NUM,ESCH_SO_NUM,ESCH_SOLD_TO,ESCH_SYSKEY,ESCH_CREATED_BY,ESCH_CREATED_ON,ESCH_MODIFIED_BY,ESCH_MODIFIED_ON,ESCH_STATUS,ESCH_TYPE,ESCH_EXT1,ESCH_EXT2,ESCH_EXT3,ESCH_SHIP_TO_NAME,ESCH_SHIP_TO_STREET1,ESCH_SHIP_TO_CITY,ESCH_SHIP_TO_STATE,ESCH_SHIP_TO_COUNTRY,ESCH_SHIP_TO_ZIP,ESCH_SHIP_TO_PHONE) VALUES("+cancellationId+",'"+poNumber+"','"+soNumber+"','"+customer+"','999100','"+userId+"',getdate(),'"+userId+"',getdate(),'A','C','"+shipTo+"','','','"+shipToName+"','"+shipToStreet+"','"+shipToCity+"','"+shipToState+"','"+shipToCountry+"','"+shipToZip+"','"+shipToPhone+"')";
				canMiscParams.setQuery(canQuery);
				canMainParams.setLocalStore("Y");
				canMainParams.setObject(canMiscParams);
				Session.prepareParams(canMainParams);	
				try{	
					ezMiscManager.ezAdd(canMainParams);
				}catch(Exception e){
					log4j.log(":::::EZC_SO_CANCEL_HEADER::ezMiscManager-Cancel Request::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");

				}
			}				



			canMainParams = new ezc.ezparam.EzcParams(false);
			canMiscParams = new EziMiscParams();

			canMiscParams.setIdenKey("MISC_INSERT");
			canQuery="INSERT INTO EZC_SO_CANCEL_ITEMS(ESCI_ID,ESCI_SO_NUM,ESCI_SO_ITEM,ESCI_MAT_CODE,ESCI_MAT_DESC,ESCI_QUANTITY,ESCI_REJ_REASON,ESCI_COMMENTS,ESCI_TYPE,ESCI_STATUS,ESCI_EXT1,ESCI_EXT2,ESCI_EXT3) VALUES("+cancellationId+",'"+soNumber+"','"+soItem+"','"+matCodeHT.get(soNumber+""+soItem)+"','"+matDescHT.get(soNumber+""+soItem)+"','"+quantityHT.get(soNumber+""+soItem)+"','"+rejReasonHT.get(soNumber+""+soItem)+"','"+commentsHT.get(soNumber+""+soItem)+"','RC','P','','','')";
			canMiscParams.setQuery(canQuery);
			canMainParams.setLocalStore("Y");
			canMainParams.setObject(canMiscParams);
			Session.prepareParams(canMainParams);	
			try{	
				ezMiscManager.ezAdd(canMainParams);
			}catch(Exception e){
				log4j.log(":::::EZC_SO_CANCEL_ITEMS::ezMiscManager-Cancel Request::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");
			}
			
			showCancellationReqMsg += "<Br>Sales Order / Item "+  soNumber+"/"+soItem;
		}	
	}
	

	if(reqRGAItems.size()>0)
	{
		log4j.log(":::::::::::::::::::RGA:::::::::::::::::::::", "D");
		
		ReturnObjFromRetrieve retCancIdObj = null;

		ezc.ezparam.EzcParams canMainParams = new ezc.ezparam.EzcParams(false);
		EziMiscParams canMiscParams = new EziMiscParams();
		canMiscParams.setIdenKey("MISC_SELECT");
		String canQuery="SELECT MAX(ESCH_ID) CANC_ID FROM EZC_SO_CANCEL_HEADER";
		canMiscParams.setQuery(canQuery);
		canMainParams.setLocalStore("Y");
		canMainParams.setObject(canMiscParams);
		Session.prepareParams(canMainParams);	
		try{	retCancIdObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(canMainParams);
		}
		catch(Exception e)
		{
			log4j.log(":::::CANCELLATIONID::ezMiscManager-RGA::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");
		}

		int cancellationId = 1000;

		if(retCancIdObj!=null && retCancIdObj.getRowCount()>0)
		{
			String canId = retCancIdObj.getFieldValueString(0,"CANC_ID");

			try{
				cancellationId = Integer.parseInt(canId)+1;
			}catch(Exception e){}
		}
		rgaNumber = cancellationId+"";
		
		log4j.log("CANCELLATIONID==RGA====>"+cancellationId, "D");
		
		showCancellationReqMsg += "<Br>Request for RGA for the below Item(s) is sent to RGA Department. <Br>Reference Number : "+cancellationId;

		String contactName  	= nullCheck(request.getParameter("contactName"));
		String contactEmail 	= nullCheck(request.getParameter("contactEmail"));
		String contactPhone 	= nullCheck(request.getParameter("contactPhone"));
		String returnReason 	= nullCheck(request.getParameter("returnReason"));
		String orderReason  	= nullCheck(request.getParameter("orderReason"));
		String incoTerm	    	= nullCheck(request.getParameter("incoTerm"));
		String forwardingAgent 	= nullCheck(request.getParameter("forwardingAgent"));
		String restockFees 	= nullCheck(request.getParameter("restockFees"));

		String isResidential 	= nullCheck(request.getParameter("isResidential"));

		String retText 		= nullCheck(request.getParameter("retText"));
		String invNotes 	= nullCheck(request.getParameter("invNotes"));

		String incoTerm1 = "";
		String incoTerm2 = "";

		if(incoTerm!=null && !"null".equalsIgnoreCase(incoTerm) && !"".equals(incoTerm))
		{
			try
			{
				incoTerm1 = incoTerm.substring(0,3);
				incoTerm2 = incoTerm.substring(4);
			}
			catch(Exception e)
			{
				incoTerm1 = "";
				incoTerm2 = "";
			}
		}

		String contactAppended = "";

		if(!"".equals(contactName))	 contactName 	= replaceString(contactName,"'","`");
		if(!"".equals(contactEmail))	 contactEmail 	= replaceString(contactEmail,"'","`");
		if(!"".equals(contactPhone))	 contactPhone 	= replaceString(contactPhone,"'","`");
		if(!"".equals(retText))		 retText 	= replaceString(retText,"'","`");
		if(!"".equals(invNotes))	 invNotes 	= replaceString(invNotes,"'","`");

		//contactAppended = contactName+"!!"+contactEmail+"!!"+contactPhone;

		for(int i=0;i<reqRGAItems.size();i++)
		{
			String soItemStr        = (String)reqRGAItems.get(i);

			String soNumber 	= soItemStr.split("/")[0];
			String soItem 		= soItemStr.split("/")[1];

			String parentCode	=  request.getParameter("parentCode"+soNumber+soItem);
			if(parentCode==null || "null".equalsIgnoreCase(parentCode)) parentCode = "";

			String invNum 	= "";
			String invItem 	= "";

			try
			{
				String invStr 	= (String)retInvNoHT.get(soNumber+""+soItem);
				invNum 	= invStr.split("/")[0];
				invItem = invStr.split("/")[1];
			}
			catch(Exception e)
			{
				invNum 	= "";
				invItem = "";
			}

			log4j.log("soNumber======>"+soNumber, "D");
			log4j.log("soItem======>"+soItem, "D");


			if(i==0)
			{
				canMainParams = new ezc.ezparam.EzcParams(false);
				canMiscParams = new EziMiscParams();

				canMiscParams.setIdenKey("MISC_INSERT");
				canQuery="INSERT INTO EZC_SO_CANCEL_HEADER(ESCH_ID,ESCH_PO_NUM,ESCH_SO_NUM,ESCH_SOLD_TO,ESCH_SYSKEY,ESCH_CREATED_BY,ESCH_CREATED_ON,ESCH_MODIFIED_BY,ESCH_MODIFIED_ON,ESCH_STATUS,ESCH_TYPE,ESCH_EXT1,ESCH_EXT2,ESCH_EXT3,ESCH_REASON,ESCH_CUST_TEXT,ESCH_CONTACT_NAME,ESCH_CONTACT_EMAIL,ESCH_CONTACT_PHONE,ESCH_SAP_REASON,ESCH_INCO_TERM1,ESCH_INCO_TERM2,ESCH_SHIPPING_PARTNER,ESCH_SHIP_TO,ESCH_SHIP_TO_RES,ESCH_SHIP_TO_NAME,ESCH_SHIP_TO_STREET1,ESCH_SHIP_TO_STREET2,ESCH_SHIP_TO_CITY,ESCH_SHIP_TO_STATE,ESCH_SHIP_TO_ZIP,ESCH_SHIP_TO_COUNTRY,ESCH_HEADER_FEES_TYPE,ESCH_HEADER_FEES_VALUE,ESCH_INTERNAL_TEXT,ESCH_SHIP_TO_PHONE,ESCH_EXPIRE_ON) VALUES("+cancellationId+",'"+poNumber+"','"+soNumber+"','"+customer+"','999100','"+userId+"',getdate(),'"+userId+"',getdate(),'P','RGA','"+shipTo+"','"+returnReason+"','"+contactAppended+"','"+returnReason+"','"+retText+"','"+contactName+"','"+contactEmail+"','"+contactPhone+"','"+orderReason+"','"+incoTerm1+"','"+incoTerm2+"','"+forwardingAgent+"','"+shipTo+"','"+isResidential+"','"+shipToName+"','"+shipToStreet+"','','"+shipToCity+"','"+shipToState+"','"+shipToZip+"','"+shipToCountry+"','','"+restockFees+"','"+invNotes+"','"+shipToPhone+"','')";
				//out.println("RGA insert query as prepared "+canQuery);
				canMiscParams.setQuery(canQuery);
				canMainParams.setLocalStore("Y");
				canMainParams.setObject(canMiscParams);
				Session.prepareParams(canMainParams);	
				try{	
					ezMiscManager.ezAdd(canMainParams);
				}catch(Exception e){
					log4j.log(":::::EZC_SO_CANCEL_HEADER::ezMiscManager-RGA Request::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");
				}
			}				

			canMainParams = new ezc.ezparam.EzcParams(false);
			canMiscParams = new EziMiscParams();

			canMiscParams.setIdenKey("MISC_INSERT");
		
			canQuery="INSERT INTO EZC_SO_CANCEL_ITEMS(ESCI_ID,ESCI_SO_NUM,ESCI_SO_ITEM,ESCI_MAT_CODE,ESCI_MAT_DESC,ESCI_QUANTITY,ESCI_REJ_REASON,ESCI_COMMENTS,ESCI_TYPE,ESCI_STATUS,ESCI_EXT1,ESCI_EXT2,ESCI_EXT3,ESCI_RET_MAT,ESCI_RET_QTY,ESCI_RETMAT_NP,ESCI_SO_SORG,ESCI_SO_DCH,ESCI_SO_DIV,ESCI_INV_NUM,ESCI_INV_ITEM,ESCI_REQ_QTY,ESCI_BACK_END_ORDER) VALUES("+cancellationId+",'"+soNumber+"','"+soItem+"','"+matCodeHT.get(soNumber+""+soItem)+"','"+matDescHT.get(soNumber+""+soItem)+"','"+quantityHT.get(soNumber+""+soItem)+"','"+rejReasonHT.get(soNumber+""+soItem)+"','"+commentsHT.get(soNumber+""+soItem)+"','RGA','P','"+parentCode+"','','','"+retMatHT.get(soNumber+""+soItem)+"','"+retQtyHT.get(soNumber+""+soItem)+"','"+retMatNPHT.get(soNumber+""+soItem)+"','"+salesOrgHT.get(soNumber+""+soItem)+"','"+distChannelHT.get(soNumber+""+soItem)+"','"+divisionHT.get(soNumber+""+soItem)+"','"+invNum+"','"+invItem+"','"+retQtyHT.get(soNumber+""+soItem)+"','')";
			//out.println(canQuery);
			canMiscParams.setQuery(canQuery);
			canMainParams.setLocalStore("Y");
			canMainParams.setObject(canMiscParams);
			Session.prepareParams(canMainParams);	
			try{	
				ezMiscManager.ezAdd(canMainParams);
			}catch(Exception e){
				log4j.log(":::::EZC_SO_CANCEL_ITEMS::ezMiscManager-RGA Request::::::::::::ezProcessCancelRequest::::::::::::::::::::"+e, "E");
			}
			
			showCancellationReqMsg += "<Br>Sales Order / Item "+  soNumber+"/"+soItem;
		}
	}
	
	log4j.log("::::::::::::::::::showErrorMessage::::::::::::::::::::"+showErrorMessage, "E");
	log4j.log("::::::::::::::::::showSuccessMessage::::::::::::::::::::"+showSuccessMessage, "E");
	log4j.log("::::::::::::::::::showCancellationReqMsg::::::::::::::::::::"+showCancellationReqMsg, "E");

	boolean insOffLink = false;
	String offLink = "";
	String toEncryp = "";
	String encrypText = "";

	/*
	HashMap soldToHash = (HashMap)session.getValue("SOLDTONAMES");
	//out.println("soldToHash:::::"+soldToHash);
    	String soldToName_N = "";
	if(soldToHash!=null && soldToHash.size()>0)
		soldToName_N = (String)soldToHash.get(customer);
	*/
	String soldToName_N = request.getParameter("soldTo_Name");

	Properties prop=new Properties();

	try
	{
		String fileName_P = "ezProcessCancelRequestMain.jsp";
		String filePath = request.getRealPath(fileName_P);
		filePath = filePath.substring(0,filePath.indexOf(fileName_P));
		filePath+="ezEmailText.properties";
		prop.load(new java.io.FileInputStream(filePath));
	}
	catch(Exception e){}

	String mainURL = prop.getProperty("MAINURL");
	String toEmail	= "";
	String ccEmail	= "";
	String msgText	= "";
	String msgSubject = "";
	String concernUser = getUserName(Session,userId);

	if(reqCancelItems.size()>0 )
	{
		toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezCancReqDetailsMain.jsp?cancellationId="+rgaNumber+"&crType=RC";
		encrypText = MD5(toEncryp);
		offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

		toEmail = getUserEmail(Session,userId);
		//ccEmail = (String)session.getValue("CCEMAIL");

		String msgSubjectToCu = prop.getProperty("EMAILSUB_CR_CRE_TOCU");
		msgSubjectToCu = msgSubjectToCu.replaceAll("%PONumber%",poNumber);

		String msgTextToCu = prop.getProperty("EMAILBODY_CR_CRE_TOCU");
		msgTextToCu = msgTextToCu.replaceAll("%ConcernedUser%",concernUser);
		msgTextToCu = msgTextToCu.replaceAll("%MainURL%",mainURL);
		msgTextToCu = msgTextToCu.replaceAll("%OffLineURL%",offLink);

		log4j.log("toEmailtoEmailtoEmail======>"+toEmail, "D");
		log4j.log("ccEmailccEmailccEmail======>"+ccEmail, "D");
		log4j.log("msgTextmsgTextmsgText======>"+msgTextToCu, "D");
		log4j.log("msgSubjectmsgSubject======>"+msgSubjectToCu, "D");

		//out.println(" Customer's email "+toEmail);
		//toEmail = "BP_CC_Support@AmericanStandard.com";
		ccEmail = "chanumanthu@answerthink.com,mbablani@answerthink.com,georgesa@americanstandard.com";

		sendEmail(Session,toEmail,ccEmail,msgTextToCu,msgSubjectToCu);

		String toEmailCC = (String)session.getValue("CCEMAIL");//"BP_CC_Support@AmericanStandard.com";

		String msgSubjectToCC = prop.getProperty("EMAILSUB_CR_CRE_TOCC");
		msgSubjectToCC = msgSubjectToCu.replaceAll("%PONumber%",poNumber);

		String msgTextToCC = prop.getProperty("EMAILBODY_CR_CRE_TOCC");
		msgTextToCC = msgTextToCC.replaceAll("%MainURL%",mainURL);
		msgTextToCC = msgTextToCC.replaceAll("%OffLineURL%",offLink);
		msgTextToCC = msgTextToCC.replaceAll("%CustomerInfo%",soldToName_N+"<br>"+concernUser);

		log4j.log("toEmailtoEmailtoEmail======>"+toEmailCC, "D");
		log4j.log("ccEmailccEmailccEmail======>"+ccEmail, "D");
		log4j.log("msgTextmsgTextmsgText======>"+msgTextToCC, "D");
		log4j.log("msgSubjectmsgSubject======>"+msgSubjectToCC, "D");


		sendEmail(Session,toEmailCC,ccEmail,msgTextToCC,msgSubjectToCC);
		insOffLink = true;
	}

	if(reqRGAItems.size()>0 && "CU".equals(userRole))
	{
		toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezCancReqDetailsMain.jsp?cancellationId="+rgaNumber+"&crType=RGA";
		encrypText = MD5(toEncryp);
		offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

		msgSubject = prop.getProperty("EMAILSUB_RGA_TOCU");
		msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
		msgSubject = msgSubject.replaceAll("%RGANumber%",rgaNumber);
		msgText = prop.getProperty("EMAILBODY_RGA_TOCU");
		msgText = msgText.replaceAll("%ConcernedUser%",concernUser);
		msgText = msgText.replaceAll("%MainURL%",mainURL);
		msgText = msgText.replaceAll("%OffLineURL%",offLink);

		toEmail = getUserEmail(Session,userId);

		log4j.log("toEmailtoEmailtoEmail======>"+toEmail, "D");
		log4j.log("msgTextmsgTextmsgText======>"+msgText, "D");
		log4j.log("msgSubjectmsgSubject======>"+msgSubject, "D");

		//toEmail = "georgesa@AmericanStandard.com";
		//ccEmail = "chanumanthu@answerthink.com,mbablani@answerthink.com";

		sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);

		msgSubject = prop.getProperty("EMAILSUB_RGA_TOAPPR");
		msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
		msgSubject = msgSubject.replaceAll("%RGANumber%",rgaNumber);
		msgText = prop.getProperty("EMAILBODY_RGA_TOAPPR");
		msgText = msgText.replaceAll("%ConcernedUser%",soldToName_N);
		msgText = msgText.replaceAll("%MainURL%",mainURL);
		msgText = msgText.replaceAll("%OffLineURL%",offLink);
		msgText = msgText.replaceAll("%CustomerInfo%",soldToName_N+"<br>"+concernUser);

		toEmail = "chanumanthu@answerthink.com";//"BP_AC_RGA@americanstandard.com";

		log4j.log("toEmailtoEmailtoEmail======>"+toEmail, "D");
		log4j.log("msgTextmsgTextmsgText======>"+msgText, "D");
		log4j.log("msgSubjectmsgSubject======>"+msgSubject, "D");

		//toEmail = "georgesa@AmericanStandard.com";
		//ccEmail = "chanumanthu@answerthink.com,mbablani@answerthink.com";

		sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);
		insOffLink = true;
	}

	if(insOffLink)
	{
		/******************************/
		EzcParams mainParamsURL = new EzcParams(false);
		EziMiscParams miscParamsURL = new EziMiscParams();

		miscParamsURL.setIdenKey("MISC_INSERT");
		miscParamsURL.setQuery("INSERT INTO EZC_URL_MAPPING(EUM_SHORT_URL,EUM_ACTUAL_URL) VALUES('"+encrypText+"','"+toEncryp+"')");

		mainParamsURL.setLocalStore("Y");
		mainParamsURL.setObject(miscParamsURL);
		Session.prepareParams(mainParamsURL);	

		try
		{
			ezMiscManager.ezAdd(mainParamsURL);
		}
		catch(Exception e){}
		/******************************/
	}

	String outMsg = "";
	String outMsgF = "";
	String outMsgB = "";

	if(!"".equals(showErrorMessage))
	{
		outMsg = "ERROR : <BR>"+showErrorMessage;
	}
	else if(!"".equals(showSuccessMessage))
	{
		outMsg = "SUCCESS : <BR>"+showSuccessMessage;
	}
	else if(!"".equals(showCancellationReqMsg))
	{
		outMsg = "SUCCESS : <BR>"+showCancellationReqMsg;
	}

	outMsgF = "PLEASE NOTE THAT DUE TO CUSTOMER REQUESTED CHANGES TO THIS ORDER PRICING TERMS AND FREIGHT CHARGES MAY BE AFFECTED";
	outMsgB = "<a href=\"JavaScript:getDetails(\'"+poNumber+"\',\'"+customer+"\',\'"+shipTo+"\',\'"+poDate+"\')\"><small>&laquo;</small>Ok</a>";

	if(session.getValue("EzMsg")!=null)
		session.removeValue("EzMsg"); 
	if(session.getValue("EzMsgF")!=null)
		session.removeValue("EzMsgF"); 
	if(session.getValue("EzMsgB")!=null)
		session.removeValue("EzMsgB"); 
	if(session.getValue("EzMsgH")!=null)
		session.removeValue("EzMsgH"); 

	session.putValue("EzMsg",outMsg);
	session.putValue("EzMsgF",outMsgF);
	session.putValue("EzMsgB",outMsgB);
	session.putValue("EzMsgH","Confirm Cancel Item(s)");

log4j.log("EzMsgEzMsgEzMsg======>"+(String)session.getValue("EzMsg"), "D");
log4j.log("EzMsgFEzMsgFEzMsgF======>"+(String)session.getValue("EzMsgF"), "D");
log4j.log("EzMsgBEzMsgBEzMsgB======>"+(String)session.getValue("EzMsgB"), "D");

	response.sendRedirect("../Sales/ezRetOutMsg.jsp");

}
else
{

%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Authorization Error</title>
</head> 
<body class=" customer-account-index">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
<%
	String authKey = "SO_CANCEL";//(String) request.getAttribute("authKey");
	if(authKey == null) authKey = "";
%>
<h2> Authorization Check Failed </h2>
<p> You are not authorized to view requested information.
<br>Please contact your ASB Administrator or ASB Customer Service if you believe you have received this in error.
<br><strong>Information for Administrator : Auth Key Code checked </strong><%=authKey%></p>
<br>
<div id="divAction" style="display:block">
	<button type="button" title="Back" class="button btn-update" onclick="javascript:history.go(-1)"><span>Back</span></button>
</div>
</div>
</div>
</div>
</div>
</body>
</html>
<%
}
%>