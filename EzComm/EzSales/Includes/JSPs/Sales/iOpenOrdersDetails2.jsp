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
	String customer	= request.getParameter("soldTo");
	String shipTo = request.getParameter("shipTo");

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
	
	
	//out.println("salesOrder:::::::"+salesOrder+":::::customer:::::::"+customer);
	String poSONums[] = null;
		
		

	if(salesOrder!=null)
		poSONums = salesOrder.split("ÿ");	


	int retHeaderCount = 0,retItemsCount=0;

	ReturnObjFromRetrieve sodetails= null;

	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	//ezcSalesOrderParams.setSalesDocNum(salesOrder);
	ezcSalesOrderParams.setMultipleSalesDocs(poSONums);
	ezcSalesOrderParams.setCustomer(customer);

	ezc.sales.local.params.EziUserList userList = new ezc.sales.local.params.EziUserList();
	ezcSalesOrderParams.setObject(userList);
	Session.prepareParams(ezcSalesOrderParams);
	sodetails = (ReturnObjFromRetrieve)Manager.ezGetSODetails(ezcSalesOrderParams);

	ReturnObjFromRetrieve retHeader	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("HEADER");
	ReturnObjFromRetrieve retItems	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("ITEMS");	
	ReturnObjFromRetrieve retPartners = (ReturnObjFromRetrieve)sodetails.getFieldValue("PARTNERS");
	ReturnObjFromRetrieve retLineText = (ReturnObjFromRetrieve)sodetails.getFieldValue("ITEMTEXT");
	ReturnObjFromRetrieve retStatus   = (ReturnObjFromRetrieve)sodetails.getFieldValue("STATUS");
	ReturnObjFromRetrieve retCond     = (ReturnObjFromRetrieve)sodetails.getFieldValue("SDCOND");
	ReturnObjFromRetrieve retAddress  = (ReturnObjFromRetrieve)sodetails.getFieldValue("PARTNERADDR");
	
	ReturnObjFromRetrieve flowRet 	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("FLOW");
	ReturnObjFromRetrieve delSchedules = (ReturnObjFromRetrieve)sodetails.getFieldValue("SDSCHEDULE");
	ReturnObjFromRetrieve retDeliveryHdr  = (ReturnObjFromRetrieve)sodetails.getFieldValue("DLVHEADER");
	ReturnObjFromRetrieve retDeliveryItems  = (ReturnObjFromRetrieve)sodetails.getFieldValue("DLVITEMS");
	ReturnObjFromRetrieve attachRet   = (ReturnObjFromRetrieve)sodetails.getFieldValue("ATTACHMENTS");
	ReturnObjFromRetrieve bussRet     = (ReturnObjFromRetrieve)sodetails.getFieldValue("BUSINESSDATA");


	
	/**out.println("retHeader::"+retHeader.toEzcString());
	out.println("retItems::"+retItems.toEzcString());
	out.println("retPartners::"+retPartners.toEzcString());
	out.println("retLineText::"+retLineText.toEzcString());
	out.println("retStatus::"+retStatus.toEzcString());
	out.println("retCond::"+retCond.toEzcString());	
	out.println("retAddress::::::::::::::::::::::"+retAddress.toEzcString());	
	out.println("retDeliveryHdr::"+retDeliveryHdr.toEzcString());
	out.println("retDeliveryItems::"+retDeliveryItems.toEzcString());
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
	
	
 	//JCO.Client client2=null;
 	//JCO.Function function1 = null;
 		
	//String [] dlvDocHdrCols = {"DLV_DOC_NO","DLV_TIME","DLV_CREATED_ON","DLV_DOC_TYPE","LIFEX","ZZTDLNR","BOLNR","ZZAMT","ZZPOOLCRY","ZZSHPTYP","ZZTRAILER"};
	//ReturnObjFromRetrieve dlvDocHdrRetObj	= new ReturnObjFromRetrieve(dlvDocHdrCols);


	//String [] dlvDocItemsCols = {"DLV_DOC_NO","DLV_DOC_ITEM","DLV_QTY","SALES_DOC_NO","SALES_DOC_ITEM"};
	//ReturnObjFromRetrieve dlvDocItemsRetObj	= new ReturnObjFromRetrieve(dlvDocItemsCols);


	//String [] shipDocHdrCols = {"SHIP_DOC_NO","SHIP_CREATED_ON","SHIP_TIME"};
	//ReturnObjFromRetrieve shipDocHdrRetObj  = new ReturnObjFromRetrieve(shipDocHdrCols);


	//String [] shipDocItemsCols = {"SHIP_DOC_NO","SHIP_DOC_ITEM","DLV_DOC_NO","DLV_DOC_ITEM","DLV_QTY"};
	//ReturnObjFromRetrieve shipDocItemsRetObj	= new ReturnObjFromRetrieve(shipDocItemsCols);
	
	
	//String [] salesQuoteDocCols = {"SALES_DOC","SALES_DOC_ITEM","QUOTE_DOC","QUOTE_DOC_ITEM","DOC_CATEGORY","DOC_CAT_SD"};
	//ReturnObjFromRetrieve salesQuoteDocRetObj	= new ReturnObjFromRetrieve(salesQuoteDocCols);
	
	//String [] slsOrdLineCols = {"SALES_DOC", "SALES_DOC_ITEM", "CUST_MAT35","VOLUME","PARENT_ITEM","ITEM_NO"};
	//ReturnObjFromRetrieve slsOrdLineRetObj = new ReturnObjFromRetrieve(slsOrdLineCols);
	
	//String [] slsOrdHdrCols = {"SALES_DOC", "PO_SUPPLEM","NET_VALUE","PO_NO","PO_DATE","CT_VALID_F","CT_VALID_T","REQ_DATE","DOC_DATE","DOC_TYPE","DOC_NO","SALES_ORG","DIVISION","DIST_CHANNEL","COMPL_DLV"};
	//ReturnObjFromRetrieve slsOrdHdrRetObj = new ReturnObjFromRetrieve(slsOrdHdrCols);
	
	//String [] businessDataCols = {"SALES_DOC", "SALES_DOC_ITEM", "CUSTCONGR4"};
	//ReturnObjFromRetrieve businessDataRetObj = new ReturnObjFromRetrieve(businessDataCols);
	
	//String [] deliverySchedulesDataCols = {"OPERATION", "DOC_NUMBER", "ITM_NUMBER", "SCHED_LINE","SCHED_TYPE","REQ_DATE","REQ_QTY","CONFIR_QTY","SALES_UNIT", "REQ_QTY1"};
	//ReturnObjFromRetrieve deliverySchedulesRetObj = new ReturnObjFromRetrieve(deliverySchedulesDataCols);
	
	//String [] attachmentDataCols = {"FILENAME", "INSTID", "PH_OBJID", "PH_CLASS","CREA_USER","CHNG_USER","DOCUMENT_ID"};
	//ReturnObjFromRetrieve attachmentRetObj = new ReturnObjFromRetrieve(attachmentDataCols);
	
 	
 	//Hashtable  SO_DAYS_HT =  new Hashtable();

	String site_SO = (String)session.getValue("Site");
	String skey_SO = "999";
 	
 	try
 	{
 		
 		String div = "";
 		String ph1 = "";
 		String mg1 = "";
 		String mg5 = "";
 		String cgr = "";
 		String hItem = "";
 		int lineNumber = 0;
 		if (retItems != null){
 			for ( int rI=0;rI<retItems.getRowCount();rI++){
 				String cmat35 = retItems.getFieldValueString(rI,"CUST_MAT35");
 				String volume = retItems.getFieldValueString(rI,"VOLUME");
				String qty = retItems.getFieldValueString(rI,"REQ_QTY");
				String nValue = retItems.getFieldValueString(rI,"NET_VALUE");
				hItem = "";
				hItem = retItems.getFieldValueString(rI,"HG_LV_ITEM");
				//if ((hItem != null) && (hItem !="")) {
				// 	slsOrdLineRetObj.setFieldValue("PARENT_ITEM",hItem);
				//out.println("HItem is "+hItem+" for "+itemOutTable.getValue("ITM_NUMBER")+"<br>");
 				//	}	
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
						String ioRejReason = retItems.getFieldValueString(rI,"REJREASON");

						if("CHINA".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 || ("5N".equals(ph1) && mg5Val.indexOf(mg5)!=-1)))
						{	
							retItems.setFieldValueAt("CUST_MAT35","Chinaware",rI);
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
							retItems.setFieldValueAt("CUST_MAT35","Americast & Acrylics (Excludes Acrylux)",rI);     
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
							retItems.setFieldValueAt("CUST_MAT35","Acrylux",rI);     	
							//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();

							volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							acryluxVolume = new java.math.BigDecimal(acryluxVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							}
							break;
						}else if("ENAMEL".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1))
						{
							retItems.setFieldValueAt("CUST_MAT35","Enamel Steel",rI);     
							//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();

							volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							enamelVolume = new java.math.BigDecimal(enamelVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							}
							break;
						}else if("MARBLE".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1))
						{
							retItems.setFieldValueAt("CUST_MAT35","Marble",rI);
							//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
							volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							marbleVolume = new java.math.BigDecimal(marbleVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							}
							break;
						} else if("SHOWSTD".equals(pointsType) && ((divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1) && cgrVal.indexOf(cgr)==-1))
						{
							retItems.setFieldValueAt("CUST_MAT35","Shower Doors-Standard",rI);	
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
							retItems.setFieldValueAt("CUST_MAT35","Shower Doors-Custom",rI);
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
							retItems.setFieldValueAt("CUST_MAT35","Walk In Baths",rI);
							//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
							//volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
							if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							walkInBathVolume = new java.math.BigDecimal(walkInBathVolume).add(new java.math.BigDecimal(volume)).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
							}
							break;
						} else if("FAUCETSNL".equals(pointsType) && ((divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1) && mg1Val.indexOf(mg1)==-1))  				     
						{
							retItems.setFieldValueAt("CUST_MAT35","Faucets(incl. Flush Valves)-Non Luxury",rI);	
							if ((hItem.trim().equals("000000"))) { 
								volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
							} else {
								volume = new java.math.BigDecimal(0).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
							}
							faucetsNonLuxuryVolume = new java.math.BigDecimal(faucetsNonLuxuryVolume).add(new java.math.BigDecimal(volume)).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();

							break;
						} else if("FAUCETSL".equals(pointsType) && ((divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1) && mg1Val.indexOf(mg1)!=-1))
						{
							retItems.setFieldValueAt("CUST_MAT35","Faucets(incl. Flush Valves)-Luxury",rI);
							if ((hItem.trim().equals("000000"))) { 
								volume = new java.math.BigDecimal(qty).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();;
							} else {
								volume = new java.math.BigDecimal(0).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();;
							}
							faucetsLuxuryVolume = new java.math.BigDecimal(faucetsLuxuryVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							break;
						} else if("REPAIR".equals(pointsType) && (divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1))
						{
							retItems.setFieldValueAt("CUST_MAT35","Repair Parts",rI);	 						 						
							if ((hItem != null) && hItem.equals("000000") && ioRejReason.equals("")) {
							volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							}
							break;
						} else if("JADO".equals(pointsType) && (divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1))
						{
							retItems.setFieldValueAt("CUST_MAT35","Jado",rI);	
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
							retItems.setFieldValueAt("CUST_MAT35","FIAT",rI);	
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
						else if(alr==pointsMapRetObj.getRowCount()-1)
						{

							retItems.setFieldValueAt("CUST_MAT35","Others",rI);	
							//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
							volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							break;
						}
					}	
 					retItems.setFieldValueAt("VOLUME",volume,rI);

 			}
 		}
 		//out.println(slsOrdLineRetObj.toEzcString());
 		//out.println("++++++++ STEP4 ORD DETAILS READ AGAIN AND POINTS DETERMINED");
 		
 		//out.println("++++++++ STEP5 BIZ DATA READ TO GET PROMO INFO");

		
		
		/**
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
		*/
		//out.println("++++++++ STEP11 QUOTE INFO OBTAINED FROM DOC FLOW");
		
		
 	}
 	catch(Exception e)
 	{
 		out.println("EXCEPTION>>>>>>"+e);
 	}
 	finally
 	{
 		
 	}
 
 	
 	//out.println(dlvDocHdrRetObj.toEzcString());
 	//out.println(dlvDocItemsRetObj.toEzcString());
 	//out.println(shipDocHdrRetObj.toEzcString());
 	//out.println(shipDocItemsRetObj.toEzcString());	
	// 10/17/2012 --> FOR AMERICAN STANDARD, delivStatus is OVERWRITTEN with status from PO_SUPPL which is based on 
	// Z table created by American Standard to keep PO Status
	// Logic assumes that irrespective of nr of SOs in a PO, PO Status is SAME in Z table for all corresponding SOs
	//out.println("STATUS USING EZC Logic "+delivStatus);
	if (retHeader!=null && retHeader.getRowCount()>0 ){
		if (retHeader.getFieldValueString(0,"PO_SUPPLEM")!= null && !(retHeader.getFieldValueString(0,"PO_SUPPLEM").trim().equals(""))){
			//out.println("STATUS EXTRACTED IS "+retHeader.getFieldValueString(0,"PO_SUPPLEM"));
			delivStatus = (String) dStatusHT.get(retHeader.getFieldValueString(0,"PO_SUPPLEM"));
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
	
	int dlvDocHdrRetObjCnt = retDeliveryHdr.getRowCount();//dlvDocHdrRetObj.getRowCount();
	int dlvDocItemsRetObjCnt = retDeliveryItems.getRowCount();//dlvDocItemsRetObj.getRowCount();
	int deliverySchedulesRetObjCnt = delSchedules.getRowCount();//deliverySchedulesRetObj.getRowCount();
	
	String schedSONum = "", schedSOLine = "", schedSOSchLine = "" , schedConfQty = "",schedConfDateStr ="";
	ezc.ezutil.FormatDate frmDt=new ezc.ezutil.FormatDate();
	//out.println(dlvDocHdrRetObj.toEzcString());
	
	if ( deliverySchedulesRetObjCnt > 0){
			for (int ds=0;ds<deliverySchedulesRetObjCnt;ds++)
			{
				schedSONum = delSchedules.getFieldValueString(ds,"DOC_NUM");
				schedSOLine = delSchedules.getFieldValueString(ds,"ITM_NUM");
				schedSOSchLine = delSchedules.getFieldValueString(ds,"SCHED_LINE");
				schedConfQty = delSchedules.getFieldValueString(ds,"CONFIR_QTY");
				Date cdtObj = (Date)delSchedules.getFieldValue(ds,"REQ_DATE");
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
			dlvDocType = retDeliveryHdr.getFieldValueString(h,"DLV_DOC_TYPE"); 
			dlvDocNo = retDeliveryHdr.getFieldValueString(h,"DLV_DOC_NO"); 
			
			dlvDocTypes.put(dlvDocNo,dlvDocType);
			
			
			
			trackingNumber = retDeliveryHdr.getFieldValueString(h,"LIFEX");
			dlvTrackingNumbers.put(dlvDocNo,trackingNumber);
			
			if (retDeliveryHdr.getFieldValueString(h,"ZZPOOLCRY")!=null && !retDeliveryHdr.getFieldValueString(h,"ZZPOOLCRY").equals("")) 
				dlvShippingPartner = retDeliveryHdr.getFieldValueString(h,"ZZPOOLCRY");
			else 
				dlvShippingPartner = retDeliveryHdr.getFieldValueString(h,"ZZTDLNR");
			dlvShippingPartners.put(dlvDocNo,dlvShippingPartner);
			dlvBolNumber = retDeliveryHdr.getFieldValueString(h,"BOLNR");
			dlvBolNumbers.put(dlvDocNo,dlvBolNumber);
						
			try{
				Date dtObj = (Date)retDeliveryHdr.getFieldValue(h,"DLV_CREATED_ON");
				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
				String dtStr = formatter.format(dtObj);
			
				itemShippedDatesHT.put(dlvDocNo,dtStr);
			}catch(Exception e){}	
			//itemShippedDatesHT.put(dlvDocNo,ezc.ezutil.FormatDate.getStringFromDate((Date)retDeliveryHdr.getFieldValue(h,"DLV_CREATED_ON"),".",frmDt.MMDDYYYY));
		}
	}
	
	//out.println(itemShippedDatesHT);
	//out.println("++++++++ STEP13 DELIVERED QTY RETRIEVED");
	//out.println(dlvDocItemsRetObj.toEzcString());			
	if(dlvDocHdrRetObjCnt>0)
	{	
		for(int i=0;i<dlvDocItemsRetObjCnt;i++)
		{
			dlvDocNo = retDeliveryItems.getFieldValueString(i,"DLV_DOC_NO"); 
			dlvDocType = (String)dlvDocTypes.get(dlvDocNo);
			dlvSODocItem = retDeliveryItems.getFieldValueString(i,"SALES_DOC_ITEM");	
			dlvSODoc = retDeliveryItems.getFieldValueString(i,"SALES_DOC_NO");
			
			trackingNumber = (String) dlvTrackingNumbers.get(dlvDocNo);
			dlvBolNumber = (String) dlvBolNumbers.get(dlvDocNo);
			dlvShippingPartner = (String) dlvShippingPartners.get(dlvDocNo);
			//out.println("-------- dlvDocType -----dovDocNo"+dlvDocType+"---"+dlvDocNo);
			
			if("LF".equals(dlvDocType) || "ZD".equals(dlvDocType) || "EL".equals(dlvDocType) || "ZL".equals(dlvDocType))
			{
				soLineTrackingNumbers.put(dlvSODoc+""+dlvSODocItem,trackingNumber);
				soLineBolNumbers.put(dlvSODoc+""+dlvSODocItem,dlvBolNumber);
				soLineShippingPartners.put(dlvSODoc+""+dlvSODocItem,dlvShippingPartner);
				//out.println("+++++++++++++++HERE3 +++Del Doc Item"+dlvSODoc+""+dlvSODocItem);
				if(shippedItemsVect.contains(dlvSODoc+""+dlvSODocItem))
				{
					try{
						itemShippedQtys.put(dlvSODoc+""+dlvSODocItem,Double.parseDouble((String)itemShippedQtys.get(dlvSODoc+""+dlvSODocItem))+Double.parseDouble(retDeliveryItems.getFieldValueString(i,"DLV_QTY"))+"");
					}catch(Exception e){
					}	
					
					
					if(itemShippedDatesHT.get(dlvDocNo)!=null)
						itemDeliveryDates.put(dlvSODoc+""+dlvSODocItem,(String)itemDeliveryDates.get(dlvSODoc+""+dlvSODocItem)+"#"+(String)itemShippedDatesHT.get(dlvDocNo)+"!!"+retDeliveryItems.getFieldValueString(i,"DLV_QTY"));
					
					
				}else{
					shippedItemsVect.addElement(dlvSODoc+""+dlvSODocItem);
					itemShippedQtys.put(dlvSODoc+""+dlvSODocItem,retDeliveryItems.getFieldValueString(i,"DLV_QTY"));
					
					if(itemShippedDatesHT.get(dlvDocNo)!=null)
						itemDeliveryDates.put(dlvSODoc+""+dlvSODocItem,(String)itemShippedDatesHT.get(dlvDocNo)+"!!"+retDeliveryItems.getFieldValueString(i,"DLV_QTY"));
				}
				
				
				
				
				
				
			}
			else if("LR".equals(dlvDocType))
			{
				if(returnedItemsVect.contains(dlvSODoc+""+dlvSODocItem))
				{
					try{
						itemReturnedQtys.put(dlvSODoc+""+dlvSODocItem,Double.parseDouble((String)itemShippedQtys.get(dlvSODoc+""+dlvSODocItem))+Double.parseDouble(retDeliveryItems.getFieldValueString(i,"DLV_QTY"))+"");
					}catch(Exception e){}			
				}else{
					returnedItemsVect.addElement(dlvSODoc+""+dlvSODocItem);
					itemReturnedQtys.put(dlvSODoc+""+dlvSODocItem,retDeliveryItems.getFieldValueString(i,"DLV_QTY"));
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
	Hashtable invNumSOItemHT = new Hashtable();
	
	if(flowRet.getRowCount()>0)
	{
		flowRet.sort(new String[]{"REFSDDOC","REFSDDOCITM"},true);
		for(int s=0;s<flowRet.getRowCount();s++)
		{
			if(!"000000".equals(flowRet.getFieldValueString(s,"REFSDDOCITM")) && "C".equals(flowRet.getFieldValueString(s,"DOC_CAT")) && "B".equals(flowRet.getFieldValueString(s,"DOC_CAT_SD")))
				refSalesQuotations.put(flowRet.getFieldValueString(s,"SUBSSDDOC")+""+flowRet.getFieldValueString(s,"SUBSDDOCITM"),flowRet.getFieldValueString(s,"REFSDDOC")+"/<br>"+flowRet.getFieldValueString(s,"REFSDDOCITM"));
				// DOC_CAT_SD as B will ensure that only Quotes and NO Inquiries are checked . DOC_CAT_SD = Preceding doc doc cat
				// DOC_CATEGORY is current doc doc category

			if("V".equals(flowRet.getFieldValueString(s,"DOC_CAT")) && !"000000".equals(flowRet.getFieldValueString(s,"SUBSDDOCITM"))){
				poNumSOItemHT.put(flowRet.getFieldValueString(s,"REFSDDOC")+""+flowRet.getFieldValueString(s,"REFSDDOCITM"),flowRet.getFieldValueString(s,"SUBSDDOC")+"/"+flowRet.getFieldValueString(s,"SUBSDDOCITM")); //QUOTE_DOC = SO Num &  QUOTE_DOC_ITEM = SO Item & SALES_DOC = PO Num && SALES_DOC_ITEM = PO Item
				//out.println("Inserted poNum in Hash Table with SO#"+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC")+"---"+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM"));
				}
				
			if("J".equals(flowRet.getFieldValueString(s,"DOC_CAT")) && !"000000".equals(flowRet.getFieldValueString(s,"SUBSDDOCITM"))){
				dlvNumSOItemHT.put(flowRet.getFieldValueString(s,"REFSDDOC")+""+flowRet.getFieldValueString(s,"REFSDDOCITM"),flowRet.getFieldValueString(s,"SUBSDDOC")+"/"+flowRet.getFieldValueString(s,"SUBSDDOCITM")); //QUOTE_DOC = SO Num &  QUOTE_DOC_ITEM = SO Item & SALES_DOC = Dlv Num && SALES_DOC_ITEM = PO Item
				// Now see if there are invoices with ref to this delivery
				for(int inv=0;inv<flowRet.getRowCount();inv++)
				{
				if("M".equals(flowRet.getFieldValueString(inv,"DOC_CAT")) 
				    && flowRet.getFieldValueString(s,"SUBSDDOC").equals(flowRet.getFieldValueString(inv,"REFSDDOC"))
				    && flowRet.getFieldValueString(s,"SUBSDDOCITM").equals(flowRet.getFieldValueString(inv,"REFSDDOCITM"))
				    ){
				    if (invNumSOItemHT.contains(flowRet.getFieldValueString(inv,"REFSDDOC")+""+flowRet.getFieldValueString(inv,"REFSDDOCITM"))){
						invNumSOItemHT.put(flowRet.getFieldValueString(inv,"REFSDDOC")+""+flowRet.getFieldValueString(inv,"REFSDDOCITM"),flowRet.getFieldValueString(inv,"SUBSDDOC")+"*/"+flowRet.getFieldValueString(inv,"SUBSDDOCITM")); 
				    } else {
				    		invNumSOItemHT.put(flowRet.getFieldValueString(inv,"REFSDDOC")+""+flowRet.getFieldValueString(inv,"REFSDDOCITM"),flowRet.getFieldValueString(inv,"SUBSDDOC")+"/"+flowRet.getFieldValueString(inv,"SUBSDDOCITM")); 
				    }
				}
				}
					
			}
			
		}// end for		
	}

	//out.println(refSalesQuotations);

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
		
		
	
		EzcParams localSODetailsParamsMisc = new EzcParams(false);
		EziMiscParams localSODetailsMisc = new EziMiscParams();
	
		ReturnObjFromRetrieve localSODetailsRetObj = null;
	
		localSODetailsMisc.setIdenKey("MISC_SELECT");
		String soNumscsv = "";
		for(int s=0;s<poSONums.length;s++){

			String strSalesOrderA = poSONums[s];
			if (s==0)
				soNumscsv+="'"+strSalesOrderA+"'";
			else
				soNumscsv+=","+"'"+strSalesOrderA+"'";
		}
		
		String queryLocalLines="select * from EZC_SALES_DOC_HEADER,EZC_SALES_DOC_ITEMS where ESDH_BACK_END_ORDER IN ("+soNumscsv+") and esdh_doc_number = esdi_sales_doc ";
		localSODetailsMisc.setQuery(queryLocalLines);
	
		localSODetailsParamsMisc.setLocalStore("Y");
		localSODetailsParamsMisc.setObject(localSODetailsMisc);
		Session.prepareParams(localSODetailsParamsMisc);	
	
		try
		{
			localSODetailsRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(localSODetailsParamsMisc);
		}
		catch(Exception e){}	
		
		
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
			else 	
				progSOItemHT.put(localSODetailsRetObj.getFieldValueString(im,"ESDI_BACK_END_ORDER")+""+df.format(dd),"Standard");
			
			} // end try
			catch(Exception e){
			}
			} // end for
		}
	
	/** END OF finding if Local Data Exists */ 
	
	String webOrNo = "";

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
	//out.println("++++++++ STEP15 LOCAL WEBORDER DATA READ");

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