<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ page import="com.sap.mw.jco.*,java.util.*,java.net.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<jsp:useBean id="Manager" class="ezc.sales.local.client.EzSalesManager" />
<%


	String chinaVolume = "0.00";
	String americastVolume = "0.00";
	String acryluxVolume = "0.00";
	String enamelVolume = "0.00";
	String marbleVolume = "0.00";
	String sDoorStandardVolume = "0.00";
	String sDoorCustomVolume = "0.00";
	String walkInBathVolume = "0.00";
	String faucetsNonLuxuryVolume = "0.00";
	String faucetsLuxuryVolume = "0.00";
	String repairPartsVolume = "0.00";
	String jadoVolume = "0.00";
	String fiatVolume = "0.00";

	String salesOrder = request.getParameter("salesOrder");//"0051537725#0051574887"
	//out.println("salesOrder::::::"+salesOrder);
	long start_D0 = System.currentTimeMillis();
	log4j.log("To pull SO Details Start at INCLUDE OpenOrderDetails.jsp>>>"+salesOrder,"F");
	String customer	= request.getParameter("soldTo");
	//out.println("customer::::::"+customer);
	String shipTo = request.getParameter("shipTo");
	if (shipTo.equals("A")){
		shipTo = request.getParameter("OrdShipTo");
	}
	//out.println("shipTo::::::"+shipTo);
	//out.println(" Ship To as extracted -->"+shipTo);
	String poNum = request.getParameter("poNo"); 
	//out.println("poNum::::::"+poNum);
	String poDate2 = request.getParameter("poDate");
	//out.println("poDate2::::::"+poDate2);
	
	String [] soListCols = {"SD_DOC","ITM_NUMBER","DOC_TYPE","DOC_DATE","PURCH_NO","SOLD_TO","NET_VALUE","SHIP_TO","SHIP_TO_NAME","PO_DATE"};
	ReturnObjFromRetrieve soListRetObj	= new ReturnObjFromRetrieve(soListCols);
	
	if (poNum != null && !poNum.equals("null") && !"".equals(poNum)){
		// make rfc call and get the SO numbers
		JCO.Client clientList=null;
		JCO.Function functionList = null;
		 		
		String site_SOL = (String)session.getValue("Site");
		String skey_SOL = "999";
	 	
	 	try
	 	{
	 		functionList= EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_LIST",site_SOL+"~"+skey_SOL);
	 		//out.println(function1);
			JCO.ParameterList 	sapProcL 	= functionList.getImportParameterList();
			
			//JCO.Structure order_viewstructure = sapProc.getStructure("I_BAPI_VIEW");
			JCO.Table customerSelection = functionList.getTableParameterList().getTable("CUSTOMER_SELECTION");
	
			sapProcL.setValue(poNum,"PURCHASE_ORDER");
			sapProcL.setValue("0","TRANSACTION_GROUP");
			sapProcL.setValue("A","WITHOPENCLOSEDESTATUS");
			/**
			out.println("PO Date" +poDate2);
			if (poDate2 != null ){
				sapProcL.setValue(poDate2,"PO_DATE");
			}	
			*/
			sapProcL.setValue("X","ADV_SEARCH");

			// Exclude Returns, Debits and Credits from output
			JCO.Table auartExclusionTable = functionList.getTableParameterList().getTable("ZAUART");

			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("L2", "AUART");
			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("TR", "AUART");
			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("ZRET", "AUART");
			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("G2", "AUART");
			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("RE", "AUART");

	 		try
	 		{
	 			clientList = EzSAPHandler.getSAPConnection(site_SOL+"~"+skey_SOL);
				long start = System.currentTimeMillis();
	 			log4j.log("To pull SO numbers Start>>>"+poNum,"F");
	 			clientList.execute(functionList);
	 			log4j.log("To pull SO numbers End>>>"+poNum,"F");
				long finish = System.currentTimeMillis();
				log4j.log("To pull SO numbers>>>"+(finish-start)+" msec","F");
	 		}
	 		catch(Exception ec)
	 		{
	 			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
	 		}
	 		
	 		
	 		JCO.Table salesOrderTbl	= functionList.getTableParameterList().getTable("SALES_ORDERS");
	 		//out.println(salesOrderTbl.toString());
			if ( salesOrderTbl != null )
			{
				if (salesOrderTbl.getNumRows() > 0)
				{
					do
					{
											
						soListRetObj.setFieldValue("SD_DOC", salesOrderTbl.getValue("SD_DOC"));
						soListRetObj.setFieldValue("DOC_TYPE", salesOrderTbl.getValue("DOC_TYPE"));
						soListRetObj.setFieldValue("DOC_DATE", salesOrderTbl.getValue("DOC_DATE"));
						soListRetObj.setFieldValue("PURCH_NO", salesOrderTbl.getValue("PURCH_NO"));
						soListRetObj.setFieldValue("SOLD_TO", salesOrderTbl.getValue("SOLD_TO"));
						soListRetObj.setFieldValue("NET_VALUE", salesOrderTbl.getValue("NET_VALUE"));
						soListRetObj.setFieldValue("SHIP_TO", salesOrderTbl.getValue("SHIP_TO"));
						soListRetObj.setFieldValue("SHIP_TO_NAME", salesOrderTbl.getValue("SHIP_TO_NAME"));
						soListRetObj.setFieldValue("PO_DATE", salesOrderTbl.getValue("VALID_FROM"));
						soListRetObj.addRow();
					}while(salesOrderTbl.nextRow());
				}	
			}

		} catch ( Exception eMain)
		{
			out.println(" Exception in getting SOs for given PO. Please Check PO Number or Contact Administrator");
		}
		finally
		{
			if(clientList!=null)
			{
				JCO.releaseClient(clientList);
				clientList = null;
				functionList = null;
			}
		}
	
	}
	Vector typesS = new Vector();
	Vector namesS = new Vector();
	typesS.addElement("date");
	typesS.addElement("date");
	namesS.addElement("PO_DATE");
	namesS.addElement("DOC_DATE");


	EzGlobal.setColTypes(typesS);
	EzGlobal.setColNames(namesS);
	ezc.ezparam.ReturnObjFromRetrieve soListRetObj2 = null;
	if (soListRetObj != null){
		soListRetObj2 = EzGlobal.getGlobal(soListRetObj);
	}
	
	
	//out.println(soListRetObj.toEzcString());
	
	
	
	String poSONums[] = null;
	
	
	if("Y".equals((String)session.getValue("OFFLINE")))
	{
		salesOrder = (String)session.getValue("DocSalesOrder");
		customer = (String)session.getValue("DocSoldTo");
		shipTo = (String)session.getValue("DocShipTo");
	}


	String sort_types = request.getParameter("sort_types");
	if ((sort_types == null) || (sort_types.equals(""))){
		sort_types = "1";
	}
	//out.println("sort_types::::::"+sort_types);	
	
	//out.println("salesOrder:::::::"+salesOrder+":::::customer:::::::"+customer+"::shipTo::::::"+shipTo);
	
		
		

	if(salesOrder!=null)
		poSONums = salesOrder.split("ÿ");	
		
	String soNums2 = "";
	//out.println(" PoDate2 -->"+poDate2);
	//out.println(" Ship To -->"+shipTo);
	if (poDate2 != null) {
	for (int soL=0;soL<soListRetObj.getRowCount();soL++){
		//out.println("PO Date at row x "+soListRetObj2.getFieldValueString(soL,"PO_DATE")+ " -- "+poDate2.equals(soListRetObj2.getFieldValueString(soL,"PO_DATE")));
		//out.println("Ship To at row x "+soListRetObj.getFieldValueString(soL,"SHIP_TO")+" -- "+ shipTo.equals(soListRetObj.getFieldValueString(soL,"SHIP_TO")));
		
		if ( poDate2.equals(soListRetObj2.getFieldValueString(soL,"PO_DATE")) && shipTo.equals(soListRetObj.getFieldValueString(soL,"SHIP_TO")))
		{
			

			if (soL < soListRetObj.getRowCount()-1) {
			soNums2+=soListRetObj.getFieldValueString(soL,"SD_DOC")+"ÿ";	
			} else {
			soNums2+=soListRetObj.getFieldValueString(soL,"SD_DOC");
			}
		} //poDate2 equals soList PO Date

		
	}
	}
	//out.println(" Sales Order Numbers with criteria matching PO Number,PO Date and Ship To -->"+soNums2);
	if (soNums2 !=null && !soNums2.trim().equals("") && !soNums2.equals("null")){
	poSONums = null;
	poSONums = soNums2.split("ÿ");
	}	
	
	int retHeaderCount = 0,retItemsCount=0;

	ReturnObjFromRetrieve sodetails= null;

	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	//ezcSalesOrderParams.setSalesDocNum(salesOrder);
	ezcSalesOrderParams.setMultipleSalesDocs(poSONums);
	ezcSalesOrderParams.setCustomer(customer);

	ezc.sales.local.params.EziUserList userList = new ezc.sales.local.params.EziUserList();
	ezcSalesOrderParams.setObject(userList);
	Session.prepareParams(ezcSalesOrderParams);

	long start_D = System.currentTimeMillis();
	log4j.log("To pull SO Details Start>>>"+soNums2,"F");
	sodetails = (ReturnObjFromRetrieve)Manager.ezGetSODetails(ezcSalesOrderParams);
	log4j.log("To pull SO Details End>>>"+soNums2,"F");
	long finish_D = System.currentTimeMillis();
	log4j.log("To pull SO Details>>>"+(finish_D-start_D)+" msec","F");

	ReturnObjFromRetrieve retHeader	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("HEADER");
	ReturnObjFromRetrieve retItems	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("ITEMS");	
	ReturnObjFromRetrieve retPartners = (ReturnObjFromRetrieve)sodetails.getFieldValue("PARTNERS");
	ReturnObjFromRetrieve retLineText = (ReturnObjFromRetrieve)sodetails.getFieldValue("ITEMTEXT");
	ReturnObjFromRetrieve retStatus   = (ReturnObjFromRetrieve)sodetails.getFieldValue("STATUS");
	ReturnObjFromRetrieve retCond     = (ReturnObjFromRetrieve)sodetails.getFieldValue("SDCOND");
	ReturnObjFromRetrieve retAddress  = (ReturnObjFromRetrieve)sodetails.getFieldValue("PARTNERADDR");
	
	ReturnObjFromRetrieve flowRet 	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("FLOW");
	ReturnObjFromRetrieve delShedules = (ReturnObjFromRetrieve)sodetails.getFieldValue("SDSCHEDULE");
	ReturnObjFromRetrieve retDeliveryHdr  = (ReturnObjFromRetrieve)sodetails.getFieldValue("DLVHEADER");
	ReturnObjFromRetrieve attachRet   = (ReturnObjFromRetrieve)sodetails.getFieldValue("ATTACHMENTS");
	ReturnObjFromRetrieve bussRet     = (ReturnObjFromRetrieve)sodetails.getFieldValue("BUSINESSDATA");

/**
	out.println("retHeader::"+retHeader.toEzcString());
	out.println("retItems::"+retItems.toEzcString());
	out.println("retLineText::"+retLineText.toEzcString());
	out.println("retStatus::"+retStatus.toEzcString());
	out.println("retCond::"+retCond.toEzcString());
	out.println("retAddress::::::::::::::::::::::"+retAddress.toEzcString());	
	out.println("retPartners::"+retPartners.toEzcString());
	out.println("retDeliveryHdr::"+retDeliveryHdr.toEzcString());
	out.println("attachRet::"+attachRet.toEzcString());
	out.println("bussRet::"+bussRet.toEzcString());
	out.println("delShedules::"+delShedules.toEzcString());*/
	//out.println("flowRet::"+flowRet.toEzcString());
	//out.println("attachRet::"+attachRet.toEzcString());
	
	
	/***********cart points value mapping************/

	ReturnObjFromRetrieve pointsMapRetObj = null;

	EzcParams mainParams_CVM = new EzcParams(false);
	EziMiscParams miscParams_CVM = new EziMiscParams();
	miscParams_CVM.setIdenKey("MISC_SELECT");
	miscParams_CVM.setQuery("SELECT POINTS_TYPE,VALUE2 POINTS_DESC,DIV_VAL,PH1_VAL,CGR_VAL,MG1_VAL,MG5_VAL FROM EZC_POINTS_MAPPING,EZC_VALUE_MAPPING WHERE POINTS_TYPE=VALUE1 AND MAP_TYPE='POINTSGRP'");
	mainParams_CVM.setLocalStore("Y");
	mainParams_CVM.setObject(miscParams_CVM);
	Session.prepareParams(mainParams_CVM);	
	try{	pointsMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_CVM);
	}
	catch(Exception e){out.println("Exception in Getting Data"+e);}
						
	/***********cart points value mapping************/
	
	String SOHeaderText = "";
	String SOHeaderSCACText = "";
	String SOHeaderShipText = "";
	String tempLineText = "";
	String tempCancLineText = "";
	String eol = "<br/>";System.getProperty("line.separator");
	//out.println(retLineText.toEzcString());
	Hashtable retLineTextHT = new Hashtable();
	Hashtable retLineCancTextHT = new Hashtable();
	if(retLineText!=null && retLineText.getRowCount()>0)
	{
		String curr_item_no = "";
		String prev_item_no = "";
		boolean appendScacText = true;
		for(int l=0;l<retLineText.getRowCount();l++)
		{
			
			curr_item_no = retLineText.getFieldValueString(l,"ITEM_NO");
			if("0002".equals(retLineText.getFieldValueString(l,"TEXT_NO")))
			
			{ //Item Note
				tempLineText = (String) retLineTextHT.get(retLineText.getFieldValueString(l,"ITEM_NO"));
				if ((tempLineText != null)){
					tempLineText+=retLineText.getFieldValueString(l,"TEXT");
					tempLineText+=eol;
					retLineTextHT.put(retLineText.getFieldValueString(l,"ITEM_NO"),tempLineText);
				} else {
					retLineTextHT.put(retLineText.getFieldValueString(l,"ITEM_NO"),retLineText.getFieldValueString(l,"TEXT")+eol);
				}	
				
			}
			if("ZPI1".equals(retLineText.getFieldValueString(l,"TEXT_NO")))

			{ //Item Cancellation Note
				tempCancLineText = (String) retLineCancTextHT.get(retLineText.getFieldValueString(l,"ITEM_NO"));
				if ((tempCancLineText != null)){
					tempCancLineText+=retLineText.getFieldValueString(l,"TEXT");
					tempCancLineText+=eol;
					retLineCancTextHT.put(retLineText.getFieldValueString(l,"ITEM_NO"),tempCancLineText);
				} else {
					retLineCancTextHT.put(retLineText.getFieldValueString(l,"ITEM_NO"),retLineText.getFieldValueString(l,"TEXT")+eol);
				}	

			}

			//out.println("BEFORE-->"+curr_item_no+"---"+prev_item_no);
			if (curr_item_no.equals(prev_item_no) || prev_item_no.equals("") && appendScacText) {
				appendScacText = true;
				prev_item_no = curr_item_no;
			} else {
				appendScacText = false;
			}
			//out.println("AFTER-->"+curr_item_no+"---"+prev_item_no);

			if("0004".equals(retLineText.getFieldValueString(l,"TEXT_NO")) && appendScacText) 
				SOHeaderText+=retLineText.getFieldValueString(l,"TEXT")+"\n";
			if("ZPH1".equals(retLineText.getFieldValueString(l,"TEXT_NO")) && appendScacText) {
				if (appendScacText)
				SOHeaderSCACText+=retLineText.getFieldValueString(l,"TEXT")+eol;
			}	
			if("Z004".equals(retLineText.getFieldValueString(l,"TEXT_NO")) && appendScacText) 
				SOHeaderShipText+=retLineText.getFieldValueString(l,"TEXT")+"\n";
		}		
	}
	//out.println("++++++++ STEP1 LINETEXTDONE");
	if ( SOHeaderSCACText!= null){
	SOHeaderSCACText.replaceAll(",",","+"%n");
	}
	if(retHeader!=null && retHeader.getRowCount()>0)
		retHeaderCount = retHeader.getRowCount();
	if(retItems!=null && retItems.getRowCount()>0)
		retItemsCount = retItems.getRowCount();
	
	//out.println(retItems.toEzcString());
	Hashtable soHeaderDataHT = new Hashtable();	
	if(retHeaderCount>0)
	{
		for(int d=0;d<retHeaderCount;d++)
			soHeaderDataHT.put(retHeader.getFieldValueString(d,"DOC_NO"),retHeader.getFieldValueString(d,"DOC_TYPE")+"#"+retHeader.getFieldValueString(d,"SALES_ORG")+"#"+retHeader.getFieldValueString(d,"DIVISION")+"#"+retHeader.getFieldValueString(d,"DIST_CHANNEL"));
	}

	String delivStatus = "";

	Hashtable dStatusHT = new Hashtable();

	dStatusHT.put(" ","NOT RELEVANT");
	dStatusHT.put("A","OPEN");
	dStatusHT.put("B","PARTIALLY SHIPPED");
	dStatusHT.put("C","CLOSED");
	//out.println("++++++++ STEP2 HEADER HT PREPARED");
	if(retStatus!=null && retStatus.getRowCount()>0)
	{
		delivStatus = (String) dStatusHT.get(retStatus.getFieldValueString(0,"DELIV_STAT"));
		//out.println(" Status from SAP Status DELIVSTAT "+retStatus.getFieldValueString(0,"DELIV_STAT"));
		if(delivStatus == null || "null".equals(delivStatus))
		{
			delivStatus = "OPEN";
		}
	}
	//out.println("++++++++ STEP3 FIRST LINES DEL STATUS USED TO SET STATUS");
	// THIS STATUS IS OVERWRITTEN DOWN BELOW
	
	
	
	
	
	Vector types = new Vector();
	Vector names = new Vector();
	types.addElement("currency");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	names.addElement("NET_VALUE");
	names.addElement("PO_DATE");
	names.addElement("CT_VALID_F");
	names.addElement("CT_VALID_T");
	names.addElement("REQ_DATE");
	names.addElement("DOC_DATE");

	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);
	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(retHeader);

	types = new Vector();
	names = new Vector();
	types.addElement("currency");
	types.addElement("date");
	types.addElement("currency");
	names.addElement("VALUE");
	names.addElement("REQUIREDDATE");
	names.addElement("NET_PRICE");
	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);

	ezc.ezparam.ReturnObjFromRetrieve ret1 = EzGlobal.getGlobal(retItems); 
	
	
 	JCO.Client client2=null;
 	JCO.Function function1 = null;
 		
	String [] dlvDocHdrCols = {"DLV_DOC_NO","DLV_TIME","DLV_CREATED_ON","DLV_DOC_TYPE","LIFEX","ZZTDLNR","BOLNR","ZZAMT","ZZPOOLCRY","ZZSHPTYP","ZZTRAILER"};
	ReturnObjFromRetrieve dlvDocHdrRetObj	= new ReturnObjFromRetrieve(dlvDocHdrCols);


	String [] dlvDocItemsCols = {"DLV_DOC_NO","DLV_DOC_ITEM","DLV_QTY","SALES_DOC_NO","SALES_DOC_ITEM"};
	ReturnObjFromRetrieve dlvDocItemsRetObj	= new ReturnObjFromRetrieve(dlvDocItemsCols);


	String [] shipDocHdrCols = {"SHIP_DOC_NO","SHIP_CREATED_ON","SHIP_TIME"};
	ReturnObjFromRetrieve shipDocHdrRetObj  = new ReturnObjFromRetrieve(shipDocHdrCols);


	String [] shipDocItemsCols = {"SHIP_DOC_NO","SHIP_DOC_ITEM","DLV_DOC_NO","DLV_DOC_ITEM","DLV_QTY"};
	ReturnObjFromRetrieve shipDocItemsRetObj	= new ReturnObjFromRetrieve(shipDocItemsCols);
	
	
	String [] salesQuoteDocCols = {"SALES_DOC","SALES_DOC_ITEM","QUOTE_DOC","QUOTE_DOC_ITEM","DOC_CATEGORY","DOC_CAT_SD"};
	ReturnObjFromRetrieve salesQuoteDocRetObj	= new ReturnObjFromRetrieve(salesQuoteDocCols);
	
	String [] slsOrdLineCols = {"SALES_DOC", "SALES_DOC_ITEM", "CUST_MAT35","VOLUME","PARENT_ITEM","ITEM_NO","NET_VALUE"};
	ReturnObjFromRetrieve slsOrdLineRetObj = new ReturnObjFromRetrieve(slsOrdLineCols);
	
	String [] slsOrdHdrCols = {"SALES_DOC", "PO_SUPPLEM","NET_VALUE","PO_NO","PO_DATE","CT_VALID_F","CT_VALID_T","REQ_DATE","DOC_DATE","DOC_TYPE","DOC_NO","SALES_ORG","DIVISION","DIST_CHANNEL","COMPL_DLV"};
	ReturnObjFromRetrieve slsOrdHdrRetObj = new ReturnObjFromRetrieve(slsOrdHdrCols);
	
	String [] businessDataCols = {"SALES_DOC", "SALES_DOC_ITEM", "CUSTCONGR4"};
	ReturnObjFromRetrieve businessDataRetObj = new ReturnObjFromRetrieve(businessDataCols);
	
	String [] deliverySchedulesDataCols = {"OPERATION", "DOC_NUMBER", "ITM_NUMBER", "SCHED_LINE","SCHED_TYPE","REQ_DATE","REQ_QTY","CONFIR_QTY","SALES_UNIT", "REQ_QTY1"};
	ReturnObjFromRetrieve deliverySchedulesRetObj = new ReturnObjFromRetrieve(deliverySchedulesDataCols);
	
	String [] attachmentDataCols = {"FILENAME", "INSTID", "PH_OBJID", "PH_CLASS","CREA_USER","CHNG_USER","DOCUMENT_ID"};
	ReturnObjFromRetrieve attachmentRetObj = new ReturnObjFromRetrieve(attachmentDataCols);
	 	
 	Hashtable  SO_DAYS_HT =  new Hashtable();

	String site_SO = (String)session.getValue("Site");
	String skey_SO = "999";
	long start_D2 = System.currentTimeMillis();
 	log4j.log("To pull SO Details Start -2nd Call>>>"+soNums2,"F");
 	
 	try
 	{
 		function1= EzSAPHandler.getFunction("Z_BAPISDORDER_GETDETAILEDLIST",site_SO+"~"+skey_SO);
 		//out.println(function1);
		JCO.ParameterList 	sapProc 	= function1.getImportParameterList();
		
		JCO.Structure order_viewstructure = sapProc.getStructure("I_BAPI_VIEW");
		JCO.Table salesTable = function1.getTableParameterList().getTable("SALES_DOCUMENTS");

		if(order_viewstructure!=null)
		{	
			order_viewstructure.setValue("X","HEADER");
			order_viewstructure.setValue("X","ITEM");
			order_viewstructure.setValue("X","FLOW");
			order_viewstructure.setValue("X","BUSINESS");
			order_viewstructure.setValue("X","SDSCHEDULE");
			order_viewstructure.setValue("X","PARTNER");
		}
		
		sapProc.setValue("A","I_MEMORY_READ");
		sapProc.setValue("X","DELIV_SHIP_INFO");
		sapProc.setValue(customer,"CUSTOMER");
		sapProc.setValue("H","ATTACHMENT_TYPE");
		
		boolean execRfc = false;
		if (poSONums != null){
		for(int s=0;s<poSONums.length;s++)
		{		
			salesTable.appendRow();
			salesTable.setValue(poSONums[s], "VBELN");
			execRfc = true;
			//out.println(" PO SO Num "+poSONums[s]+" ");
		}	
		}

 
 		try
 		{
 			client2 = EzSAPHandler.getSAPConnection(site_SO+"~"+skey_SO);
 			if(execRfc){
 			client2.execute(function1);
 			}
 		}
 		catch(Exception ec)
 		{
 			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
 		}
 		
 		
 		JCO.Table orderHdrTbl	= function1.getTableParameterList().getTable("ORDER_HEADERS_OUT");
		if ( orderHdrTbl != null )
		{
			if (orderHdrTbl.getNumRows() > 0)
			{
				do
				{
					long diffInDays = 0;
					try{
						Date createdOnDt   = (Date)orderHdrTbl.getValue("REC_DATE");
						Date createdOnTime = (Date)orderHdrTbl.getValue("REC_TIME");
						Date soCreatedOn = new Date(createdOnDt.getYear(),createdOnDt.getMonth(),createdOnDt.getDate(),createdOnTime.getHours(),createdOnTime.getMinutes(),createdOnTime.getSeconds());
						Date currentSysDate = new Date();
					
						diffInDays = (currentSysDate.getTime() - soCreatedOn.getTime())/(1000 * 60 * 60);
					}catch(Exception e){}	
					
					SO_DAYS_HT.put(orderHdrTbl.getValue("DOC_NUMBER"),diffInDays+"");
					slsOrdHdrRetObj.setFieldValue("SALES_DOC", orderHdrTbl.getValue("DOC_NUMBER"));
 					slsOrdHdrRetObj.setFieldValue("PO_SUPPLEM", orderHdrTbl.getValue("PO_SUPPLEM"));
					slsOrdHdrRetObj.addRow();

				}while(orderHdrTbl.nextRow());
			}	
		}

 		
 		//out.println(":::SO_DAYS_HT:::::"+SO_DAYS_HT);
 		
 		
 		
 		JCO.Table itemOutTable	= function1.getTableParameterList().getTable("ORDER_ITEMS_OUT");
 		String div = "";
 		String ph1 = "";
 		String mg1 = "";
 		String mg5 = "";
 		String cgr = "";
 		String hItem = "";
 		int lineNumber = 0;
 		if ( itemOutTable != null )
 		{
 			if (itemOutTable.getNumRows() > 0)
 			{
 				do
 				{
 					lineNumber++;
 					slsOrdLineRetObj.setFieldValue("SALES_DOC", itemOutTable.getValue("DOC_NUMBER"));
 					slsOrdLineRetObj.setFieldValue("SALES_DOC_ITEM", itemOutTable.getValue("ITM_NUMBER"));
 					slsOrdLineRetObj.setFieldValue("ITEM_NO", itemOutTable.getValue("MATERIAL"));
 					slsOrdLineRetObj.setFieldValue("NET_VALUE", itemOutTable.getValue("NET_VALUE"));
 					//slsOrdLineRetObj.setFieldValue("CUST_MAT35", itemOutTable.getValue("CUST_MAT35"));
 					String cmat35 = (String) itemOutTable.getValue("CUST_MAT35");
 					//out.println("cmat35:::"+cmat35);
 					String volume = (String) itemOutTable.getValue("VOLUME");
 					String qty = (String) itemOutTable.getValue("REQ_QTY");
 					String nValue = (String) itemOutTable.getValue("NET_VALUE");
 					hItem = "";
 					hItem = (String) itemOutTable.getValue("HG_LV_ITEM");
 					if ((hItem != null) && (hItem !="")) {
 						slsOrdLineRetObj.setFieldValue("PARENT_ITEM",hItem);
 						//out.println("HItem is "+hItem+" for "+itemOutTable.getValue("ITM_NUMBER")+"<br>");
 					}	
 					String[] pricGrpParams = cmat35.split(";");
 					div = pricGrpParams[0];
 					ph1 = pricGrpParams[1];
 					mg1 = pricGrpParams[2];
 					mg5 = pricGrpParams[3];
 					cgr = pricGrpParams[4];
 					
				mg1 = nullCheck(mg1);
				mg5 = nullCheck(mg5);
				cgr = nullCheck(cgr);																				
				div = nullCheck(div);								
				ph1 = nullCheck(ph1);
				
				
				//out.println(volume);
				//out.println("pointsMapRetObj:::"+pointsMapRetObj.toEzcString());
				for(int alr=0;alr<pointsMapRetObj.getRowCount();alr++)
				{
					String pointsType = pointsMapRetObj.getFieldValueString(alr,"POINTS_TYPE");
					String pointsDesc = pointsMapRetObj.getFieldValueString(alr,"POINTS_DESC");
					String divVal 	  = pointsMapRetObj.getFieldValueString(alr,"DIV_VAL");
					String ph1Val 	  = pointsMapRetObj.getFieldValueString(alr,"PH1_VAL");
					String cgrVal 	  = pointsMapRetObj.getFieldValueString(alr,"CGR_VAL");
					String mg1Val 	  = pointsMapRetObj.getFieldValueString(alr,"MG1_VAL");
					String mg5Val 	  = pointsMapRetObj.getFieldValueString(alr,"MG5_VAL"); 
					
					//out.println("divVal:::"+divVal+":::div::::"+div);
					//out.println("ph1Val:::"+ph1Val+":::ph1::::"+ph1);
					//out.println("cgrVal:::"+cgrVal+":::cgr::::"+cgr);
					//out.println("cmat35:::"+cmat35);
					String ioRejReason = (String) itemOutTable.getValue("REA_FOR_RE");
															
 					if("CHINA".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 || ("5N".equals(ph1) && mg5Val.indexOf(mg5)!=-1)))
				     	{	
						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Chinaware");
						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							chinaVolume = new java.math.BigDecimal(chinaVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}	
						//out.println("China Volume So Far " + chinaVolume +"at product "+itemOutTable.getValue("DOC_NUMBER") + "--" + itemOutTable.getValue("ITM_NUMBER") ); 
						break;
 					}
 					else if("AACRYLUX".equals(pointsType.trim()) && 
 					       ((divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1) && !(mg1Val.indexOf(mg1)!=-1))){
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Americast & Acrylics (Excludes Acrylux)");     
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 						americastVolume = new java.math.BigDecimal(americastVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						//out.println(" Americast Volume Info as of now  at product counter "+lineNumber +"---"+ volume + "----"+americastVolume);
 						break;
 						}
 					else if("ACRYLUX".equals(pointsType) && (divVal.indexOf(div)!=-1 || mg1Val.indexOf(mg1)!=-1))
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Acrylux");     	
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 						acryluxVolume = new java.math.BigDecimal(acryluxVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
 					}else if("ENAMEL".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1))
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Enamel Steel");     
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 						enamelVolume = new java.math.BigDecimal(enamelVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
 					}else if("MARBLE".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1))
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Marble");
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 						marbleVolume = new java.math.BigDecimal(marbleVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
 					} else if("SHOWSTD".equals(pointsType) && ((divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1) && cgrVal.indexOf(cgr)==-1))
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Shower Doors-Standard");	
 						//volume = new java.math.BigDecimal(qty).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						//MB0719volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						 if ((hItem.trim().equals("000000")) && ioRejReason.equals("")) { 
 							volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						} else {
 							volume = new java.math.BigDecimal(0).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						sDoorStandardVolume = new java.math.BigDecimal(sDoorStandardVolume).add(new java.math.BigDecimal(qty)).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					} else if("SHOWCST".equals(pointsType) && ((divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1) && cgrVal.indexOf(cgr)!=-1))
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Shower Doors-Custom");
 						//volume = new java.math.BigDecimal(qty).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						//MB0719volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						if ((hItem.trim().equals("000000"))) {  							
 						volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						} else {
 							volume = new java.math.BigDecimal(0).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						sDoorCustomVolume = new java.math.BigDecimal(sDoorCustomVolume).add(new java.math.BigDecimal(qty)).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					} else if("WALK".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1))
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Walk In Baths");
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						//volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 						walkInBathVolume = new java.math.BigDecimal(walkInBathVolume).add(new java.math.BigDecimal(volume)).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
 					} else if("FAUCETSNL".equals(pointsType) && ((divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1) && mg1Val.indexOf(mg1)==-1))  				     
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Faucets(incl. Flush Valves)-Non Luxury");	
 						if ((hItem.trim().equals("000000"))) { 
 							volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						} else {
 							volume = new java.math.BigDecimal(0).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						faucetsNonLuxuryVolume = new java.math.BigDecimal(faucetsNonLuxuryVolume).add(new java.math.BigDecimal(volume)).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						
 						break;
					} else if("FAUCETSL".equals(pointsType) && ((divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1) && mg1Val.indexOf(mg1)!=-1))
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Faucets(incl. Flush Valves)-Luxury");	 						
 						if ((hItem.trim().equals("000000"))) { 
 							volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();;
 						} else {
 							volume = new java.math.BigDecimal(0).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();;
 						}
 						faucetsLuxuryVolume = new java.math.BigDecimal(faucetsLuxuryVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
					}
					else if("DXVREPAIR".equals(pointsType) && (divVal.indexOf(div)!=-1))
					{
						slsOrdLineRetObj.setFieldValue("CUST_MAT35","DXV Repair Parts");
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 							volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
					}
					else if("REPAIR".equals(pointsType) && (divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1))
					{
						if("D9".equals(div))
							slsOrdLineRetObj.setFieldValue("CUST_MAT35","DXV Repair Parts");
						else
	 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Repair Parts");

 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 						volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
 					} else if("JADO".equals(pointsType) && (divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1))
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Jado");	
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						if ((hItem.trim().equals("000000"))) { 
 							// DO Pieces count only for parent items
 							volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}else {
 							volume = new java.math.BigDecimal(0).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}	
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 						jadoVolume = new java.math.BigDecimal(jadoVolume).add(new java.math.BigDecimal(volume)).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
					} else if("FIAT".equals(pointsType) && (divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1))
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","FIAT");	
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
						if ((hItem.trim().equals("000000"))) { 
 							// DO Pieces count only for parent items
 							volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}else {
 							volume = new java.math.BigDecimal(0).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						} 		
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
 						fiatVolume = new java.math.BigDecimal(fiatVolume).add(new java.math.BigDecimal(volume)).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
 					}
					else if("DXVCHINA".equals(pointsType) && (divVal.indexOf(div)!=-1))
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","DXV Chinaware");	
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
					}
					else if("DXVFAUCETS".equals(pointsType) && (divVal.indexOf(div)!=-1))
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","DXV Faucets");	
						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) { 
 							volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
					}
					else if("DXVFURNT".equals(pointsType) && (divVal.indexOf(div)!=-1))
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","DXV Furniture");	
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
					}
					else if("DXVTUBS".equals(pointsType) && (divVal.indexOf(div)!=-1))
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","DXV Tubs");	
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
					}
					else if("DXVSINKSNC".equals(pointsType) && (divVal.indexOf(div)!=-1))
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","DXV Sinks (Non-CW)");	
 						if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						}
 						break;
					}
					else if(alr==pointsMapRetObj.getRowCount()-1)
					{
						
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Others");	
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					}
 				}	
 					slsOrdLineRetObj.setFieldValue("VOLUME",volume);
 					slsOrdLineRetObj.addRow();
 				
 				}while(itemOutTable.nextRow());
 			}	
		}
 		//out.println(slsOrdLineRetObj.toEzcString());
 		//out.println("++++++++ STEP4 ORD DETAILS READ AGAIN AND POINTS DETERMINED");
 		JCO.Table businessDataTable	= function1.getTableParameterList().getTable("ORDER_BUSINESS_OUT");
		if ( businessDataTable != null )
		{
			if (businessDataTable.getNumRows() > 0)
			{
				do
				{
					businessDataRetObj.setFieldValue("SALES_DOC", businessDataTable.getValue("SD_DOC"));
					businessDataRetObj.setFieldValue("SALES_DOC_ITEM", businessDataTable.getValue("ITM_NUMBER"));
					businessDataRetObj.setFieldValue("CUSTCONGR4", businessDataTable.getValue("CUSTCONGR4"));
					businessDataRetObj.addRow();
				}while(businessDataTable.nextRow());
			}	
		}

 		//out.println("++++++++ STEP5 BIZ DATA READ TO GET PROMO INFO");
 		JCO.Table deliveryHeaderTable = null;
 		deliveryHeaderTable	= function1.getTableParameterList().getTable("DELIVERY_HEADER");
 		//out.println(" Dlv Header Nr of rows "+deliveryHeaderTable.getNumRows());
		if ( deliveryHeaderTable != null )
		{
			if (deliveryHeaderTable.getNumRows() > 0)
			{
				do
				{
					dlvDocHdrRetObj.setFieldValue("DLV_DOC_NO", deliveryHeaderTable.getValue("VBELN"));
					dlvDocHdrRetObj.setFieldValue("DLV_TIME", deliveryHeaderTable.getValue("ERZET"));
					//dlvDocHdrRetObj.setFieldValue("DLV_CREATED_ON", deliveryHeaderTable.getValue("ERDAT"));
					dlvDocHdrRetObj.setFieldValue("DLV_CREATED_ON", deliveryHeaderTable.getValue("WADAT_IST"));
					dlvDocHdrRetObj.setFieldValue("DLV_DOC_TYPE", deliveryHeaderTable.getValue("LFART"));
					dlvDocHdrRetObj.setFieldValue("LIFEX",deliveryHeaderTable.getValue("LIFEX"));
					dlvDocHdrRetObj.setFieldValue("ZZTDLNR",deliveryHeaderTable.getValue("ZZTDLNR"));
					dlvDocHdrRetObj.setFieldValue("BOLNR",deliveryHeaderTable.getValue("BOLNR")); //AMSA
					dlvDocHdrRetObj.setFieldValue("ZZAMT",deliveryHeaderTable.getValue("ZZAMT")); //NEMFEZ
					dlvDocHdrRetObj.setFieldValue("ZZPOOLCRY",deliveryHeaderTable.getValue("ZZPOOLCRY")); //NEMFEZ
					dlvDocHdrRetObj.setFieldValue("ZZSHPTYP",deliveryHeaderTable.getValue("ZZSHPTYP")); //LTL P
					dlvDocHdrRetObj.setFieldValue("ZZTRAILER",deliveryHeaderTable.getValue("ZZTRAILER")); //ZZTRAILER
					dlvDocHdrRetObj.addRow();
				}while(deliveryHeaderTable.nextRow());
			}	
		}

		//out.println("++++++++ STEP6 DEL HEADERS READ "+dlvDocHdrRetObj.toEzcString());
		JCO.Table deliveryItemsTable	= function1.getTableParameterList().getTable("DELIVERY_ITM");
		if ( deliveryItemsTable != null )
		{
			if (deliveryItemsTable.getNumRows() > 0)
			{
				do
				{
					dlvDocItemsRetObj.setFieldValue("DLV_DOC_NO", deliveryItemsTable.getValue("VBELN"));
					dlvDocItemsRetObj.setFieldValue("DLV_DOC_ITEM", deliveryItemsTable.getValue("POSNR"));
					dlvDocItemsRetObj.setFieldValue("DLV_QTY", deliveryItemsTable.getValue("LFIMG"));
					dlvDocItemsRetObj.setFieldValue("SALES_DOC_NO", deliveryItemsTable.getValue("VGBEL"));
					dlvDocItemsRetObj.setFieldValue("SALES_DOC_ITEM", deliveryItemsTable.getValue("VGPOS"));
					dlvDocItemsRetObj.addRow();
					//out.println(" Adding delivery line "+deliveryItemsTable.getValue("VBELN")+" "+deliveryItemsTable.getValue("POSNR"));
				}while(deliveryItemsTable.nextRow());
			}	
		}
		//out.println("++++++++ STEP7 DEL ITEMS READ");
		JCO.Table deliverySchedulesTable	= function1.getTableParameterList().getTable("ORDER_SCHEDULES_OUT");
		
		if ( deliverySchedulesTable != null )
		{
			
			if (deliverySchedulesTable.getNumRows() > 0)
			{
				do
				{
				// "OPERATION", "DOC_NUMBER", "ITM_NUMBER", "SCHED_LINE","SCHED_TYPE","REQ_DATE","REQ_QTY","CONFIR_QTY","SALES_UNIT", "REQ_QTY1"
				deliverySchedulesRetObj.setFieldValue("OPERATION", deliverySchedulesTable.getValue("OPERATION"));
				deliverySchedulesRetObj.setFieldValue("DOC_NUMBER", deliverySchedulesTable.getValue("DOC_NUMBER"));
				deliverySchedulesRetObj.setFieldValue("ITM_NUMBER", deliverySchedulesTable.getValue("ITM_NUMBER"));
				deliverySchedulesRetObj.setFieldValue("SCHED_LINE", deliverySchedulesTable.getValue("SCHED_LINE"));
				deliverySchedulesRetObj.setFieldValue("SCHED_TYPE", deliverySchedulesTable.getValue("SCHED_TYPE"));
				deliverySchedulesRetObj.setFieldValue("REQ_DATE", deliverySchedulesTable.getValue("REQ_DATE"));
				deliverySchedulesRetObj.setFieldValue("REQ_QTY", deliverySchedulesTable.getValue("REQ_QTY"));
				deliverySchedulesRetObj.setFieldValue("CONFIR_QTY", deliverySchedulesTable.getValue("CONFIR_QTY"));
				deliverySchedulesRetObj.setFieldValue("SALES_UNIT", deliverySchedulesTable.getValue("SALES_UNIT"));
				deliverySchedulesRetObj.setFieldValue("REQ_QTY1", deliverySchedulesTable.getValue("REQ_QTY1"));
					deliverySchedulesRetObj.addRow();
				}while(deliverySchedulesTable.nextRow());
			}	
		}
		//out.println("++++++++ STEP8 DEL SCHEDULES READ DONE");
		JCO.Table shipmentHeaderTable	= function1.getTableParameterList().getTable("SHIP_HEADER");
		if ( shipmentHeaderTable != null )
		{
			if (shipmentHeaderTable.getNumRows() > 0)
			{
				do
				{
					shipDocHdrRetObj.setFieldValue("SHIP_DOC_NO", shipmentHeaderTable.getValue("TKNUM"));
					shipDocHdrRetObj.setFieldValue("SHIP_CREATED_ON", shipmentHeaderTable.getValue("ERDAT"));
					shipDocHdrRetObj.setFieldValue("SHIP_TIME", shipmentHeaderTable.getValue("ERZET"));
					shipDocHdrRetObj.addRow();
				}while(shipmentHeaderTable.nextRow());
			}	
		}

		//out.println("++++++++ STEP9 SHIPMENT HEADER READ");
		JCO.Table shipmentItemsTable	= function1.getTableParameterList().getTable("SHIP_ITM");
		if ( shipmentItemsTable != null )
		{
			if (shipmentItemsTable.getNumRows() > 0)
			{
				do
				{
					shipDocItemsRetObj.setFieldValue("SHIP_DOC_NO", shipmentItemsTable.getValue("TKNUM"));
					shipDocItemsRetObj.setFieldValue("SHIP_DOC_ITEM", shipmentItemsTable.getValue("TPNUM"));
					shipDocItemsRetObj.setFieldValue("DLV_DOC_NO", shipmentItemsTable.getValue("VBELN"));
					shipDocItemsRetObj.setFieldValue("DLV_DOC_ITEM", shipmentItemsTable.getValue("TPRFO"));
					//shipDocItemsRetObj.setFieldValue("DLV_QTY", shipmentItemsTable.getValue("LFIMG"));
					shipDocItemsRetObj.addRow();
				}while(shipmentItemsTable.nextRow());
			}	
		}
		
		//out.println("++++++++ STEP10 SHIPMENT LINES READ");
		
		JCO.Table salesQuoteTable	= function1.getTableParameterList().getTable("ORDER_FLOWS_OUT");
		
	
		if ( salesQuoteTable != null )
		{
			if (salesQuoteTable.getNumRows() > 0)
			{
				do
				{
					salesQuoteDocRetObj.setFieldValue("SALES_DOC", salesQuoteTable.getValue("SUBSSDDOC"));
					salesQuoteDocRetObj.setFieldValue("SALES_DOC_ITEM", salesQuoteTable.getValue("SUBSITDOC"));
					salesQuoteDocRetObj.setFieldValue("QUOTE_DOC", salesQuoteTable.getValue("PRECSDDOC"));
					salesQuoteDocRetObj.setFieldValue("QUOTE_DOC_ITEM", salesQuoteTable.getValue("PREDITDOC"));
					salesQuoteDocRetObj.setFieldValue("DOC_CATEGORY", salesQuoteTable.getValue("DOCCATEGOR"));
					salesQuoteDocRetObj.setFieldValue("DOC_CAT_SD", salesQuoteTable.getValue("DOC_CAT_SD"));
					// DOC_CAT_SD = A if Order is created with ref to inquiry, and B if it is created in ref to Quote
					
					salesQuoteDocRetObj.addRow();
				}while(salesQuoteTable.nextRow());
			}	
		}
		//out.println("++++++++ STEP11 QUOTE INFO OBTAINED FROM DOC FLOW");
		
		JCO.Table attachmentTable	= function1.getTableParameterList().getTable("FILELIST");
		if ( attachmentTable != null )
		{
			if (attachmentTable.getNumRows() > 0)
			{
				do
				{
					attachmentRetObj.setFieldValue("FILENAME", attachmentTable.getValue("FILENAME"));
					attachmentRetObj.setFieldValue("INSTID", attachmentTable.getValue("INSTID"));
					attachmentRetObj.setFieldValue("PH_OBJID", attachmentTable.getValue("PH_OBJID"));
					attachmentRetObj.setFieldValue("PH_CLASS", attachmentTable.getValue("PH_CLASS"));
					attachmentRetObj.setFieldValue("CREA_USER", attachmentTable.getValue("CREA_USER"));
					attachmentRetObj.setFieldValue("CHNG_USER", attachmentTable.getValue("CHNG_USER"));
					attachmentRetObj.setFieldValue("DOCUMENT_ID", attachmentTable.getValue("DOCUMENT_ID"));
					attachmentRetObj.addRow();
				}while(attachmentTable.nextRow());
			}	
		}

		
		
 	}
 	catch(Exception e)
 	{
 		out.println("EXCEPTION in SECOND JCO CALL>>>>>>"+e);
 	}
 	finally
 	{
 		if (client2!=null)
 		{
 			JCO.releaseClient(client2);
 			client2 = null;
 			function1=null;
 		}
 	}
 
 	
 	//out.println(dlvDocHdrRetObj.toEzcString());
 	//out.println(dlvDocItemsRetObj.toEzcString());
 	//out.println(shipDocHdrRetObj.toEzcString());
 	//out.println(shipDocItemsRetObj.toEzcString());	
	// 10/17/2012 --> FOR AMERICAN STANDARD, delivStatus is OVERWRITTEN with status from PO_SUPPL which is based on 
	// Z table created by American Standard to keep PO Status
	// Logic assumes that irrespective of nr of SOs in a PO, PO Status is SAME in Z table for all corresponding SOs
	//out.println("STATUS USING EZC Logic "+delivStatus);
	if (slsOrdHdrRetObj!=null && slsOrdHdrRetObj.getRowCount()>0 ){
		if (slsOrdHdrRetObj.getFieldValueString(0,"PO_SUPPLEM")!= null && !(slsOrdHdrRetObj.getFieldValueString(0,"PO_SUPPLEM").trim().equals(""))){
			//out.println("STATUS EXTRACTED IS "+slsOrdHdrRetObj.getFieldValueString(0,"PO_SUPPLEM"));
			delivStatus = (String) dStatusHT.get(slsOrdHdrRetObj.getFieldValueString(0,"PO_SUPPLEM"));
			}
	}
	
	Hashtable dlvDocTypes = new Hashtable();
	Hashtable itemShippedQtys = new Hashtable();
	Hashtable itemReturnedQtys = new Hashtable();
	Hashtable itemShippedDatesHT = new Hashtable();
	Hashtable itemDeliveryDates = new Hashtable();
	
	java.util.Hashtable dlvTrackingNumbers = new java.util.Hashtable();
	java.util.Hashtable dlvShippingPartners = new java.util.Hashtable();
	java.util.Hashtable dlvBolNumbers = new java.util.Hashtable();
	java.util.Hashtable soLineTrackingNumbers = new java.util.Hashtable();
	java.util.Hashtable soLineBolNumbers = new java.util.Hashtable();
	java.util.Hashtable soLineShippingPartners = new java.util.Hashtable();
	
	Hashtable itemShippedDispDates = new Hashtable();
	Hashtable itemConfirmedDatesHT = new Hashtable();
	Hashtable itemConfirmedQtyHT = new Hashtable();
	
	Vector shippedItemsVect  = new Vector();
	Vector returnedItemsVect = new Vector();
	
	
	Vector tempVect  = new Vector();
	
	String dlvDocNo = "", dlvDocType = "",dlvSODoc = "",dlvSODocItem = "", trackingNumber = "", dlvShippingPartner="", dlvBolNumber="";
	
	int dlvDocHdrRetObjCnt = dlvDocHdrRetObj.getRowCount();
	int dlvDocItemsRetObjCnt = dlvDocItemsRetObj.getRowCount();
	int deliverySchedulesRetObjCnt = deliverySchedulesRetObj.getRowCount();
	
	String schedSONum = "", schedSOLine = "", schedSOSchLine = "" , schedConfQty = "",schedConfDateStr ="";
	ezc.ezutil.FormatDate frmDt=new ezc.ezutil.FormatDate();
	//out.println(dlvDocHdrRetObj.toEzcString());
	
	if ( deliverySchedulesRetObjCnt > 0){
			for (int ds=0;ds<deliverySchedulesRetObjCnt;ds++)
			{
				schedSONum = deliverySchedulesRetObj.getFieldValueString(ds,"DOC_NUMBER");
				schedSOLine = deliverySchedulesRetObj.getFieldValueString(ds,"ITM_NUMBER");
				schedSOSchLine = deliverySchedulesRetObj.getFieldValueString(ds,"SCHED_LINE");
				schedConfQty = deliverySchedulesRetObj.getFieldValueString(ds,"CONFIR_QTY");
				Date cdtObj = (Date)deliverySchedulesRetObj.getFieldValue(ds,"REQ_DATE");
				DateFormat formatter2 = new SimpleDateFormat("MM/dd/yyyy");
				String cdtStr = formatter2.format(cdtObj);
				String tStr = schedSONum+schedSOLine;							
				if (!schedConfQty.equals("0.000") && !schedConfQty.equals("0"))
				{
					//out.println(tStr+"--->"+schedConfQty);

					if (itemConfirmedQtyHT.containsKey(tStr))
					{
						try{
							itemConfirmedQtyHT.put(tStr,Double.parseDouble((String)itemConfirmedQtyHT.get(tStr))+Double.parseDouble(schedConfQty)+"");
							itemConfirmedDatesHT.put(tStr,(String)itemConfirmedDatesHT.get(tStr)+"#"+cdtStr+"!!"+schedConfQty);
						} catch (Exception e) 
						{
						} // end catch
					} 
					else 
					{
						itemConfirmedQtyHT.put(tStr,schedConfQty);
						itemConfirmedDatesHT.put(tStr,cdtStr+"!!"+schedConfQty);
					} 	
				}
			} // end for
			//out.println((String)itemConfirmedQtyHT.get(schedSONum+":"+schedSOLine+":"+schedSOSchline));
	} // end deliverySchedulesRetObjCn
	
	//out.println("++++++++ STEP12 CONFIRMED QTY RETRIEVED");
	if(dlvDocHdrRetObjCnt>0)
	{
		for(int h=0;h<dlvDocHdrRetObjCnt;h++)
		{
			dlvDocType = dlvDocHdrRetObj.getFieldValueString(h,"DLV_DOC_TYPE"); 
			dlvDocNo = dlvDocHdrRetObj.getFieldValueString(h,"DLV_DOC_NO"); 
			
			dlvDocTypes.put(dlvDocNo,dlvDocType);
			
			
			
			trackingNumber = dlvDocHdrRetObj.getFieldValueString(h,"LIFEX");
			dlvTrackingNumbers.put(dlvDocNo,trackingNumber);
			
			if (dlvDocHdrRetObj.getFieldValueString(h,"ZZPOOLCRY")!=null && !dlvDocHdrRetObj.getFieldValueString(h,"ZZPOOLCRY").equals("")) 
				dlvShippingPartner = dlvDocHdrRetObj.getFieldValueString(h,"ZZPOOLCRY");
			else 
				dlvShippingPartner = dlvDocHdrRetObj.getFieldValueString(h,"ZZTDLNR");
			dlvShippingPartners.put(dlvDocNo,dlvShippingPartner);
			dlvBolNumber = dlvDocHdrRetObj.getFieldValueString(h,"BOLNR");
			dlvBolNumbers.put(dlvDocNo,dlvBolNumber);
						
			try{
				Date dtObj = (Date)dlvDocHdrRetObj.getFieldValue(h,"DLV_CREATED_ON");
				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
				String dtStr = formatter.format(dtObj);
			
				itemShippedDatesHT.put(dlvDocNo,dtStr);
			}catch(Exception e){}	
			//itemShippedDatesHT.put(dlvDocNo,ezc.ezutil.FormatDate.getStringFromDate((Date)dlvDocHdrRetObj.getFieldValue(h,"DLV_CREATED_ON"),".",frmDt.MMDDYYYY));
		}
	}
	
	//out.println(itemShippedDatesHT);
	//out.println("++++++++ STEP13 DELIVERED QTY RETRIEVED");
	//out.println(dlvDocItemsRetObj.toEzcString());			
	if(dlvDocHdrRetObjCnt>0)
	{	
		for(int i=0;i<dlvDocItemsRetObjCnt;i++)
		{
			dlvDocNo = dlvDocItemsRetObj.getFieldValueString(i,"DLV_DOC_NO"); 
			dlvDocType = (String)dlvDocTypes.get(dlvDocNo);
			dlvSODocItem = dlvDocItemsRetObj.getFieldValueString(i,"SALES_DOC_ITEM");	
			dlvSODoc = dlvDocItemsRetObj.getFieldValueString(i,"SALES_DOC_NO");
			
			trackingNumber = (String) dlvTrackingNumbers.get(dlvDocNo);
			dlvBolNumber = (String) dlvBolNumbers.get(dlvDocNo);
			dlvShippingPartner = (String) dlvShippingPartners.get(dlvDocNo);
			//out.println("-------- dlvDocType -----dovDocNo"+dlvDocType+"---"+dlvDocNo);
			
			if("LF".equals(dlvDocType) || "ZD".equals(dlvDocType) || "EL".equals(dlvDocType) || "ZL".equals(dlvDocType) || "Z28".equals(dlvDocType))
			{
				soLineTrackingNumbers.put(dlvSODoc+""+dlvSODocItem,trackingNumber);
				soLineBolNumbers.put(dlvSODoc+""+dlvSODocItem,dlvBolNumber);
				soLineShippingPartners.put(dlvSODoc+""+dlvSODocItem,dlvShippingPartner);
				//out.println("+++++++++++++++HERE3 +++Del Doc Item"+dlvSODoc+""+dlvSODocItem);
				if(shippedItemsVect.contains(dlvSODoc+""+dlvSODocItem))
				{
					try{
						itemShippedQtys.put(dlvSODoc+""+dlvSODocItem,Double.parseDouble((String)itemShippedQtys.get(dlvSODoc+""+dlvSODocItem))+Double.parseDouble(dlvDocItemsRetObj.getFieldValueString(i,"DLV_QTY"))+"");
					}catch(Exception e){
					}	
					
					
					if(itemShippedDatesHT.get(dlvDocNo)!=null)
						itemDeliveryDates.put(dlvSODoc+""+dlvSODocItem,(String)itemDeliveryDates.get(dlvSODoc+""+dlvSODocItem)+"#"+(String)itemShippedDatesHT.get(dlvDocNo)+"!!"+dlvDocItemsRetObj.getFieldValueString(i,"DLV_QTY"));
					
					
				}else{
					shippedItemsVect.addElement(dlvSODoc+""+dlvSODocItem);
					itemShippedQtys.put(dlvSODoc+""+dlvSODocItem,dlvDocItemsRetObj.getFieldValueString(i,"DLV_QTY"));
					
					if(itemShippedDatesHT.get(dlvDocNo)!=null)
						itemDeliveryDates.put(dlvSODoc+""+dlvSODocItem,(String)itemShippedDatesHT.get(dlvDocNo)+"!!"+dlvDocItemsRetObj.getFieldValueString(i,"DLV_QTY"));
				}
				
				
				
				
				
				
			}
			else if("LR".equals(dlvDocType))
			{
				if(returnedItemsVect.contains(dlvSODoc+""+dlvSODocItem))
				{
					try{
						itemReturnedQtys.put(dlvSODoc+""+dlvSODocItem,Double.parseDouble((String)itemShippedQtys.get(dlvSODoc+""+dlvSODocItem))+Double.parseDouble(dlvDocItemsRetObj.getFieldValueString(i,"DLV_QTY"))+"");
					}catch(Exception e){}			
				}else{
					returnedItemsVect.addElement(dlvSODoc+""+dlvSODocItem);
					itemReturnedQtys.put(dlvSODoc+""+dlvSODocItem,dlvDocItemsRetObj.getFieldValueString(i,"DLV_QTY"));
				}
								
			}
		}
		
		//out.println(itemDeliveryDates);
		
		
	}
	
	//out.println(itemDeliveryDates);
	//out.println("++++++++ STEP14 Additional Shipped Qty Data Retrieved");
	//out.println(":::salesQuoteDocRetObj::::"+salesQuoteDocRetObj.toEzcString());
		//out.println(":::itemShippedDispDates::::"+itemShippedDispDates);
		
		
	Hashtable refSalesQuotations = new Hashtable();	
	Hashtable poNumSOItemHT = new Hashtable();	
	Hashtable dlvNumSOItemHT = new Hashtable();
	Hashtable invNumSOItemHT = new Hashtable(50);
	
	if(salesQuoteDocRetObj.getRowCount()>0)
	{
		salesQuoteDocRetObj.sort(new String[]{"QUOTE_DOC","QUOTE_DOC_ITEM"},true);
		for(int s=0;s<salesQuoteDocRetObj.getRowCount();s++)
		{
			if(!"000000".equals(salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM")) && "C".equals(salesQuoteDocRetObj.getFieldValueString(s,"DOC_CATEGORY")) && "B".equals(salesQuoteDocRetObj.getFieldValueString(s,"DOC_CAT_SD")))
				refSalesQuotations.put(salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC")+""+salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM"),salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC")+"/<br>"+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM"));
				// DOC_CAT_SD as B will ensure that only Quotes and NO Inquiries are checked . DOC_CAT_SD = Preceding doc doc cat
				// DOC_CATEGORY is current doc doc category

			if("V".equals(salesQuoteDocRetObj.getFieldValueString(s,"DOC_CATEGORY")) && !"000000".equals(salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM"))){
				poNumSOItemHT.put(salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC")+""+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM"),salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC")+"/"+salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM")); //QUOTE_DOC = SO Num &  QUOTE_DOC_ITEM = SO Item & SALES_DOC = PO Num && SALES_DOC_ITEM = PO Item
				//out.println("Inserted poNum in Hash Table with SO#"+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC")+"---"+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM"));
				}
				
			if("J".equals(salesQuoteDocRetObj.getFieldValueString(s,"DOC_CATEGORY")) && !"000000".equals(salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM"))){
				dlvNumSOItemHT.put(salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC")+""+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM"),salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC")+"/"+salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM")); //QUOTE_DOC = SO Num &  QUOTE_DOC_ITEM = SO Item & SALES_DOC = Dlv Num && SALES_DOC_ITEM = PO Item
				// Now see if there are invoices with ref to this delivery
				for(int inv=0;inv<salesQuoteDocRetObj.getRowCount();inv++)
				{
				if("M".equals(salesQuoteDocRetObj.getFieldValueString(inv,"DOC_CATEGORY")) 
				    && salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC").equals(salesQuoteDocRetObj.getFieldValueString(inv,"QUOTE_DOC"))
				    && salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM").equals(salesQuoteDocRetObj.getFieldValueString(inv,"QUOTE_DOC_ITEM"))
				    ){
				    	String newKey = salesQuoteDocRetObj.getFieldValueString(inv,"QUOTE_DOC").trim()+""+salesQuoteDocRetObj.getFieldValueString(inv,"QUOTE_DOC_ITEM").trim();
				    	String newValue = salesQuoteDocRetObj.getFieldValueString(inv,"SALES_DOC")+"/"+salesQuoteDocRetObj.getFieldValueString(inv,"SALES_DOC_ITEM");
					invNumSOItemHT.put(newKey,newValue); //QUOTE_DOC = Del Nr &  QUOTE_DOC_ITEM = Del. Line & SALES_DOC = Inv && SALES_DOC_ITEM = Inv Line

				}
				}
					
			}
			
		}// end for		
	}

	//out.println(refSalesQuotations);
	//out.println(salesQuoteDocRetObj.toEzcString());
	//out.println(dlvNumSOItemHT);
	//out.println(invNumSOItemHT);
	log4j.log("To pull SO Details End - 2nd Call>>>"+soNums2,"F");
	long finish_D2 = System.currentTimeMillis();
	log4j.log("To pull SO Details-2nd call>>>"+(finish_D2-start_D2)+" msec","F");


	/* FOR AS --> Find Cancellation and Return Requests against SO Line */
	
	

	EzcParams cancRetParamsMisc = new EzcParams(false);
	EziMiscParams cancRetMisc = new EziMiscParams();

	ReturnObjFromRetrieve cancRetRetObj = null;

	cancRetMisc.setIdenKey("MISC_SELECT");
	
	String queryRC="select * from EZC_SO_CANCEL_HEADER, EZC_SO_CANCEL_ITEMS where ESCH_PO_NUM = '"+retHeader.getFieldValueString(0,"PO_NO").trim()+"' and ESCH_ID = ESCI_ID and ESCH_STATUS = 'P'";
	cancRetMisc.setQuery(queryRC);

	cancRetParamsMisc.setLocalStore("Y");
	cancRetParamsMisc.setObject(cancRetMisc);
	Session.prepareParams(cancRetParamsMisc);	

	try
	{
		cancRetRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(cancRetParamsMisc);
	}
	catch(Exception e){}	
	String requestId="";
	String requestType="";
	String requestStatus="";	
	
	Hashtable cancReqSOItemHT = new Hashtable();	
	Hashtable retReqSOItemHT = new Hashtable();
	
	if(cancRetRetObj!=null && cancRetRetObj.getRowCount()>0)
	{
		//out.println(cancRetRetObj.toEzcString());
		
		for(int im=0;im<cancRetRetObj.getRowCount();im++)
		{
		requestId = cancRetRetObj.getFieldValueString(im,"ESCH_ID");	
		requestType = cancRetRetObj.getFieldValueString(im,"ESCH_TYPE");	
		requestStatus = cancRetRetObj.getFieldValueString(im,"ESCH_STATUS");	
		if (requestType.equals("RC"))
			cancReqSOItemHT.put(cancRetRetObj.getFieldValueString(im,"ESCI_SO_NUM")+""+cancRetRetObj.getFieldValueString(im,"ESCI_SO_ITEM"),cancRetRetObj.getFieldValueString(im,"ESCI_ID")+"/"+cancRetRetObj.getFieldValueString(im,"ESCI_SO_ITEM"));
		else
			retReqSOItemHT.put(cancRetRetObj.getFieldValueString(im,"ESCI_SO_NUM")+""+cancRetRetObj.getFieldValueString(im,"ESCI_SO_ITEM"),cancRetRetObj.getFieldValueString(im,"ESCI_ID")+"/"+cancRetRetObj.getFieldValueString(im,"ESCI_SO_ITEM"));
		}
	}

	/** END OF finding if Canc or Return Request Exists */ 
	
	
	/* FOR AS --> Find Program Name/Info for Locally created Orders */
		
		long start_D3 = System.currentTimeMillis();	
	
		EzcParams localSODetailsParamsMisc = new EzcParams(false);
		EziMiscParams localSODetailsMisc = new EziMiscParams();
	
		ReturnObjFromRetrieve localSODetailsRetObj = null;
	
		localSODetailsMisc.setIdenKey("MISC_SELECT");
		String soNumscsv = "";
		if (poSONums != null){
		for(int s=0;s<poSONums.length;s++){

			String strSalesOrderA = poSONums[s];
			if (s==0)
				soNumscsv+="'"+strSalesOrderA+"'";
			else
				soNumscsv+=","+"'"+strSalesOrderA+"'";
		}
		}
		String queryLocalLines="select * from EZC_SALES_DOC_HEADER SDH INNER JOIN EZC_SALES_DOC_ITEMS SDI ON SDH.ESDH_DOC_NUMBER = SDI.ESDI_SALES_DOC LEFT OUTER JOIN EZC_ORDER_NEGOTIATE EON ON SDH.ESDH_DOC_NUMBER = EON.EON_ORDER_NO LEFT OUTER JOIN EZC_VALUE_MAPPING EVM ON EON_QUESTION_TYPE = EVM.VALUE1 WHERE SDI.ESDI_BACK_END_ORDER in ("+soNumscsv+")";
		//select * from EZC_SALES_DOC_HEADER SDH INNER JOIN EZC_SALES_DOC_ITEMS SDI ON SDH.ESDH_DOC_NUMBER = SDI.ESDI_SALES_DOC LEFT OUTER JOIN EZC_ORDER_NEGOTIATE EON ON SDH.ESDH_DOC_NUMBER = EON.EON_ORDER_NO LEFT OUTER JOIN EZC_VALUE_MAPPING EVM

		localSODetailsMisc.setQuery(queryLocalLines);
	
		localSODetailsParamsMisc.setLocalStore("Y");
		localSODetailsParamsMisc.setObject(localSODetailsMisc);
		Session.prepareParams(localSODetailsParamsMisc);	
	
		try
		{
			localSODetailsRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(localSODetailsParamsMisc);
		}
		catch(Exception e){}	
		
		//out.println(localSODetailsRetObj.toEzcString());
		
		Hashtable progSOItemHT = new Hashtable();	
		
		
		if(localSODetailsRetObj!=null && localSODetailsRetObj.getRowCount()>0)
		{
			
			DecimalFormat df = new DecimalFormat("000000"); 
			
			for(int im=0;im<localSODetailsRetObj.getRowCount();im++)
			{
			try{
			double dd = Double.valueOf(localSODetailsRetObj.getFieldValueString(im,"ESDI_SALES_DOC_ITEM").trim()).doubleValue();
			//out.println(df.format(dd));
			
    			
			if (localSODetailsRetObj.getFieldValueString(im,"ESDI_VIP_FLAG").trim().equalsIgnoreCase("Y"))
				progSOItemHT.put(localSODetailsRetObj.getFieldValueString(im,"ESDI_BACK_END_ORDER")+""+df.format(dd),"VIP");
			else if (localSODetailsRetObj.getFieldValueString(im,"ESDI_DISPLAY_FLAG").trim().equalsIgnoreCase("Y"))
				progSOItemHT.put(localSODetailsRetObj.getFieldValueString(im,"ESDI_BACK_END_ORDER")+""+df.format(dd),"Display");
			else if (localSODetailsRetObj.getFieldValueString(im,"ESDI_QUICKSHIP_FLAG").trim().equalsIgnoreCase("Y"))
				progSOItemHT.put(localSODetailsRetObj.getFieldValueString(im,"ESDI_BACK_END_ORDER")+""+df.format(dd),"Quick Ship");
			else if (localSODetailsRetObj.getFieldValueString(im,"ESDI_QUICKSHIP_FLAG").trim().equalsIgnoreCase("F"))
				progSOItemHT.put(localSODetailsRetObj.getFieldValueString(im,"ESDI_BACK_END_ORDER")+""+df.format(dd),"Quick Ship Faucet");
			else if (localSODetailsRetObj.getFieldValueString(im,"ESDI_ORDER_TYPE").trim().equalsIgnoreCase("FD") || localSODetailsRetObj.getFieldValueString(im,"ESDI_ORDER_TYPE").trim().equalsIgnoreCase("ZIDF"))
				progSOItemHT.put(localSODetailsRetObj.getFieldValueString(im,"ESDI_BACK_END_ORDER")+""+df.format(dd),"Free of Charge");
			else 	
				progSOItemHT.put(localSODetailsRetObj.getFieldValueString(im,"ESDI_BACK_END_ORDER")+""+df.format(dd),"Standard");
			
			} // end try
			catch(Exception e){
			}
			} // end for
		}
	
	/** END OF finding if Local Data Exists */ 
	
	String webOrNo = "";
	if (poSONums != null){
	for(int s=0;s<poSONums.length;s++)
	{
		String strSalesOrder = poSONums[s];

		EzcSalesOrderParams  ezcWebOrderParams = new EzcSalesOrderParams();
		ezcWebOrderParams.setSalesDocNum(strSalesOrder);
		ezcWebOrderParams.setLocalStore("Y");
		Session.prepareParams(ezcWebOrderParams);
		ReturnObjFromRetrieve  webRetObj = new ReturnObjFromRetrieve();
		ReturnObjFromRetrieve retWeb=null;

		try
		{
			webRetObj = (ReturnObjFromRetrieve)EzSalesOrderManager.ezGetWebOrderNo(ezcWebOrderParams);
		}
		catch(Exception e){}
		
		if(webRetObj!=null)
		{
			webOrNo = webRetObj.getFieldValueString(0,"WEB_ORNO");

			if(!"".equals(webOrNo))
				break;
		}
	}
	}
	//out.println("++++++++ STEP15 LOCAL WEBORDER DATA READ");
	
	log4j.log("To pull SO Details Start -Local DB data>>>"+soNums2,"F");
	log4j.log("To pull SO Details End - Local DB Data>>>"+soNums2,"F");
	long finish_D3 = System.currentTimeMillis();
	log4j.log("To pull SO Details-Local DB>>>"+(finish_D3-start_D3)+" msec","F");

%>
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
		return ret;
	}
	public String nullCheckBlank(String str)
		{
			String ret = str;
	
			if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
				ret = "";
			return ret;
	}
%>