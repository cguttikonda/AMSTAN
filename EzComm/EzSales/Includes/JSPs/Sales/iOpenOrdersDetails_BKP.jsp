<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ page import="com.sap.mw.jco.*,java.util.*" %>
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
	String sort_types = request.getParameter("sort_types");
	if ((sort_types == null) || (sort_types.equals(""))){
		sort_types = "1";
	}
	
	
	//out.println("salesOrder:::::::"+salesOrder+":::::customer:::::::"+customer);
	String poSONums[] = null;
		
		

	if(salesOrder!=null)
		poSONums = salesOrder.split("#");	


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
	ReturnObjFromRetrieve retAddress    = (ReturnObjFromRetrieve)sodetails.getFieldValue("PARTNERADDR");


	//out.println("retHeader::"+retHeader.toEzcString());
	//out.println("retItems::"+retItems.toEzcString());
	//out.println("retPartners::"+retPartners.toEzcString());
	//out.println("retLineText::"+retLineText.toEzcString());
	//out.println("retStatus::"+retStatus.toEzcString());
	//out.println("retCond::"+retCond.toEzcString());
	//out.println("retAddress::::::::::::::::::::::"+retAddress.toEzcString());	
	//out.println("retDeliveryHdr::"+retDeliveryHdr.toEzcString());
	
	/***********cart points value mapping************/

	ReturnObjFromRetrieve pointsMapRetObj = null;

	EzcParams mainParams_CVM = new EzcParams(false);
	EziMiscParams miscParams_CVM = new EziMiscParams();
	miscParams_CVM.setIdenKey("MISC_SELECT");
	miscParams_CVM.setQuery("SELECT POINTS_TYPE,VALUE2 POINTS_DESC,DIV_VAL,PH1_VAL,CGR_VAL,MG1_VAL,MG5_VAL FROM EZC_POINTS_MAPPING,EZC_VALUE_MAPPING WHERE POINTS_TYPE=VALUE1 AND MAP_TYPE='CARTSUMAR'");
	mainParams_CVM.setLocalStore("Y");
	mainParams_CVM.setObject(miscParams_CVM);
	Session.prepareParams(mainParams_CVM);	
	try{	pointsMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_CVM);
	}
	catch(Exception e){out.println("Exception in Getting Data"+e);}
						
	/***********cart points value mapping************/
	
	String SOHeaderText = "";
	String SOHeaderSCACText = "";
	String tempLineText = "";
	String eol = "<br/>";System.getProperty("line.separator");
	
	Hashtable retLineTextHT = new Hashtable();
	if(retLineText!=null && retLineText.getRowCount()>0)
	{
		for(int l=0;l<retLineText.getRowCount();l++)
		{
			if("0002".equals(retLineText.getFieldValueString(l,"TEXT_NO"))){ //Item Note
				tempLineText = (String) retLineTextHT.get(retLineText.getFieldValueString(l,"ITEM_NO"));
				if ((tempLineText != null)){
					tempLineText+=retLineText.getFieldValueString(l,"TEXT");
					tempLineText+=eol;
					retLineTextHT.put(retLineText.getFieldValueString(l,"ITEM_NO"),tempLineText);
				} else {
					retLineTextHT.put(retLineText.getFieldValueString(l,"ITEM_NO"),retLineText.getFieldValueString(l,"TEXT")+eol);
				}	
				
			}
			if("0004".equals(retLineText.getFieldValueString(l,"TEXT_NO"))) 
				SOHeaderText+=retLineText.getFieldValueString(l,"TEXT")+"\n";
			if("Z004".equals(retLineText.getFieldValueString(l,"TEXT_NO"))) 
				SOHeaderSCACText+=retLineText.getFieldValueString(l,"TEXT")+eol;
		}		
	}
	
	if(retHeader!=null && retHeader.getRowCount()>0)
		retHeaderCount = retHeader.getRowCount();
	if(retItems!=null && retItems.getRowCount()>0)
		retItemsCount = retItems.getRowCount();
	

	Hashtable soHeaderDataHT = new Hashtable();	
	if(retHeaderCount>0)
	{
		for(int d=0;d<retHeaderCount;d++)
			soHeaderDataHT.put(retHeader.getFieldValueString(d,"DOC_NO"),retHeader.getFieldValueString(d,"DOC_TYPE")+"#"+retHeader.getFieldValueString(d,"SALES_ORG")+"#"+retHeader.getFieldValueString(d,"DIVISION")+"#"+retHeader.getFieldValueString(d,"DIST_CHANNEL"));
	}

	String delivStatus = "";

	Hashtable dStatusHT = new Hashtable();

	dStatusHT.put(" ","Not relevant");
	dStatusHT.put("A","Not delivered");
	dStatusHT.put("B","Partially delivered");
	dStatusHT.put("C","Fully delivered");

	if(retStatus!=null && retStatus.getRowCount()>0)
	{
		delivStatus = (String) dStatusHT.get(retStatus.getFieldValueString(0,"DELIV_STAT"));

		if(delivStatus == null || "null".equals(delivStatus))
		{
			delivStatus = "";
		}
	}

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
 		
	String [] dlvDocHdrCols = {"DLV_DOC_NO","DLV_TIME","DLV_CREATED_ON","DLV_DOC_TYPE","LIFEX","ZZTDLNR","BOLNR"};
	ReturnObjFromRetrieve dlvDocHdrRetObj	= new ReturnObjFromRetrieve(dlvDocHdrCols);


	String [] dlvDocItemsCols = {"DLV_DOC_NO","DLV_DOC_ITEM","DLV_QTY","SALES_DOC_NO","SALES_DOC_ITEM"};
	ReturnObjFromRetrieve dlvDocItemsRetObj	= new ReturnObjFromRetrieve(dlvDocItemsCols);


	String [] shipDocHdrCols = {"SHIP_DOC_NO","SHIP_CREATED_ON","SHIP_TIME"};
	ReturnObjFromRetrieve shipDocHdrRetObj  = new ReturnObjFromRetrieve(shipDocHdrCols);


	String [] shipDocItemsCols = {"SHIP_DOC_NO","SHIP_DOC_ITEM","DLV_DOC_NO","DLV_DOC_ITEM","DLV_QTY"};
	ReturnObjFromRetrieve shipDocItemsRetObj	= new ReturnObjFromRetrieve(shipDocItemsCols);
	
	
	String [] salesQuoteDocCols = {"SALES_DOC","SALES_DOC_ITEM","QUOTE_DOC","QUOTE_DOC_ITEM","DOC_CATEGORY"};
	ReturnObjFromRetrieve salesQuoteDocRetObj	= new ReturnObjFromRetrieve(salesQuoteDocCols);
	
	String [] slsOrdLineCols = {"SALES_DOC", "SALES_DOC_ITEM", "CUST_MAT35","VOLUME","PARENT_ITEM"};
	ReturnObjFromRetrieve slsOrdLineRetObj = new ReturnObjFromRetrieve(slsOrdLineCols);
	
	String [] businessDataCols = {"SALES_DOC", "SALES_DOC_ITEM", "CUSTCONGR4"};
	ReturnObjFromRetrieve businessDataRetObj = new ReturnObjFromRetrieve(businessDataCols);
	
	String [] deliverySchedulesDataCols = {"OPERATION", "DOC_NUMBER", "ITM_NUMBER", "SCHED_LINE","SCHED_TYPE","REQ_DATE","REQ_QTY","CONFIR_QTY","SALES_UNIT", "REQ_QTY1"};
	ReturnObjFromRetrieve deliverySchedulesRetObj = new ReturnObjFromRetrieve(deliverySchedulesDataCols);
	
 	
 	Hashtable  SO_DAYS_HT =  new Hashtable();
 	
 	try
 	{
 		function1= EzSAPHandler.getFunction("Z_BAPISDORDER_GETDETAILEDLIST","200~999");
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
		}
		sapProc.setValue("A","I_MEMORY_READ");
		sapProc.setValue("X","DELIV_SHIP_INFO");
		sapProc.setValue(customer,"CUSTOMER");
		
		for(int s=0;s<poSONums.length;s++)
		{		
			salesTable.appendRow();
			salesTable.setValue(poSONums[s], "VBELN");
		}	
		

 
 		try
 		{
 			client2 = EzSAPHandler.getSAPConnection("200~999");
 			client2.execute(function1);
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
 					//slsOrdLineRetObj.setFieldValue("CUST_MAT35", itemOutTable.getValue("CUST_MAT35"));
 					String cmat35 = (String) itemOutTable.getValue("CUST_MAT35");
 					String volume = (String) itemOutTable.getValue("VOLUME");
 					String qty = (String) itemOutTable.getValue("REQ_QTY");
 					String nValue = (String) itemOutTable.getValue("NET_VALUE");
 					String hItem = (String) itemOutTable.getValue("HG_LV_ITEM");
 					if ((hItem != null) && (hItem !="")) {
 						slsOrdLineRetObj.setFieldValue("PARENT_ITEM",hItem);
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

				for(int alr=0;alr<pointsMapRetObj.getRowCount();alr++)
				{
					String pointsType = pointsMapRetObj.getFieldValueString(alr,"POINTS_TYPE");
					String pointsDesc = pointsMapRetObj.getFieldValueString(alr,"POINTS_DESC");
					String divVal 	  = pointsMapRetObj.getFieldValueString(alr,"DIV_VAL");
					String ph1Val 	  = pointsMapRetObj.getFieldValueString(alr,"PH1_VAL");
					String cgrVal 	  = pointsMapRetObj.getFieldValueString(alr,"CGR_VAL");
					String mg1Val 	  = pointsMapRetObj.getFieldValueString(alr,"MG1_VAL");
					String mg5Val 	  = pointsMapRetObj.getFieldValueString(alr,"MG5_VAL"); 
					
 					if("CHINA".equals(pointsType) && divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 || ("5N".equals(ph1) && mg5Val.indexOf(mg5)!=-1))
				     	{	
						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Chinaware");
						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						if ((hItem != null) && hItem.equals("000000")) {
							chinaVolume = new java.math.BigDecimal(chinaVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}	
						//out.println("China Volume So Far " + chinaVolume +"at product "+itemOutTable.getValue("DOC_NUMBER") + "--" + itemOutTable.getValue("ITM_NUMBER") ); 
						break;
 					}
 					else if("AACRYLUX".equals(pointsType) && divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1){
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Americast & Acrylics (Excludes Acrylux)");     
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						americastVolume = new java.math.BigDecimal(americastVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						out.println(" Americast Volume Info as of now  at product counter "+lineNumber +"---"+ volume + "----"+americastVolume);
 						break;
 						}
 					else if("ACRYLUX".equals(pointsType) && divVal.indexOf(div)!=-1 || mg1Val.indexOf(mg1)!=-1)
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Acrylux");     	
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						acryluxVolume = new java.math.BigDecimal(acryluxVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					}else if("ENAMEL".equals(pointsType) && divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1)
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Enamel Steel");     
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						enamelVolume = new java.math.BigDecimal(enamelVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					}else if("MARBLE".equals(pointsType) && divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1)
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Marble");
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						marbleVolume = new java.math.BigDecimal(marbleVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					} else if("SHOWSTD".equals(pointsType) && divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 && cgrVal.indexOf(cgr)==-1)
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Shower Doors-Standard");	
 						//volume = new java.math.BigDecimal(qty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						sDoorStandardVolume = new java.math.BigDecimal(sDoorStandardVolume).add(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					} else if("SHOWCST".equals(pointsType) && divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 && cgrVal.indexOf(cgr)!=-1)
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Shower Doors-Custom");
 						//volume = new java.math.BigDecimal(qty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						sDoorCustomVolume = new java.math.BigDecimal(sDoorCustomVolume).add(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					} else if("WALK".equals(pointsType) && divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1)
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Walk In Baths");
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						walkInBathVolume = new java.math.BigDecimal(walkInBathVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					} else if("FAUCETSNL".equals(pointsType) && divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1 && mg1Val.indexOf(mg1)==-1)  				     
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Faucets(incl. Flush Valves)-Non Luxury ");	
 						volume = new java.math.BigDecimal(qty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						sDoorStandardVolume = new java.math.BigDecimal(sDoorStandardVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
					} else if("FAUCETSL".equals(pointsType) && divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1 && mg1Val.indexOf(mg1)!=-1)
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Faucets(incl. Flush Valves)-Luxury ");	 						
 						volume = new java.math.BigDecimal(qty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();;
 						faucetsNonLuxuryVolume = new java.math.BigDecimal(faucetsNonLuxuryVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
					} else if("REPAIR".equals(pointsType) && divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1)
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Repair Parts ");	 						 						
 						volume = new java.math.BigDecimal(nValue).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						faucetsLuxuryVolume = new java.math.BigDecimal(faucetsLuxuryVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					} else if("JADO".equals(pointsType) && divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1)
 					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","Jado ");	 						 						
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						jadoVolume = new java.math.BigDecimal(jadoVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
					} else if("FIAT".equals(pointsType) && divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1)
					{
 						slsOrdLineRetObj.setFieldValue("CUST_MAT35","FIAT ");	
 						//volume = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(qty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						volume = new java.math.BigDecimal(volume).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						fiatVolume = new java.math.BigDecimal(fiatVolume).add(new java.math.BigDecimal(volume)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
 						break;
 					}	
 						slsOrdLineRetObj.setFieldValue("VOLUME",volume);
 					slsOrdLineRetObj.addRow();
 				}
 				}while(itemOutTable.nextRow());
 			}	
		}
 		//out.println(slsOrdLineRetObj.toEzcString());
 		
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

 		
 		JCO.Table deliveryHeaderTable	= function1.getTableParameterList().getTable("DELIVERY_HEADER");
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
					dlvDocHdrRetObj.setFieldValue("BOLNR",deliveryHeaderTable.getValue("BOLNR"));
					dlvDocHdrRetObj.addRow();
				}while(deliveryHeaderTable.nextRow());
			}	
		}


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
				}while(deliveryItemsTable.nextRow());
			}	
		}

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
					salesQuoteDocRetObj.addRow();
				}while(salesQuoteTable.nextRow());
			}	
		}
 	}
 	catch(Exception e)
 	{
 		out.println("EXCEPTION>>>>>>"+e);
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
	
	if ( deliverySchedulesRetObjCnt > 0){
			for (int ds=0;ds<deliverySchedulesRetObjCnt;ds++){
			schedSONum = deliverySchedulesRetObj.getFieldValueString(ds,"DOC_NUMBER");
			schedSOLine = deliverySchedulesRetObj.getFieldValueString(ds,"ITM_NUMBER");
			schedSOSchLine = deliverySchedulesRetObj.getFieldValueString(ds,"SCHED_LINE");
			schedConfQty = deliverySchedulesRetObj.getFieldValueString(ds,"CONFIR_QTY");
			Date cdtObj = (Date)deliverySchedulesRetObj.getFieldValue(ds,"REQ_DATE");
			DateFormat formatter2 = new SimpleDateFormat("MM/dd/yyyy");
			String cdtStr = formatter2.format(cdtObj);
			String tStr = schedSONum+schedSOLine;							
			if (!schedConfQty.equals("0.000") && !schedConfQty.equals("0")){
				//out.println(tStr+"--->"+schedConfQty);
				itemConfirmedQtyHT.put(tStr,schedConfQty);
				itemConfirmedDatesHT.put(tStr,cdtStr);
			} 	
			} // end for
			//out.println((String)itemConfirmedQtyHT.get(schedSONum+":"+schedSOLine+":"+schedSOSchline));
		}
	
	
	if(dlvDocHdrRetObjCnt>0)
	{
		for(int h=0;h<dlvDocHdrRetObjCnt;h++)
		{
			dlvDocType = dlvDocHdrRetObj.getFieldValueString(h,"DLV_DOC_TYPE"); 
			dlvDocNo = dlvDocHdrRetObj.getFieldValueString(h,"DLV_DOC_NO"); 
			
			dlvDocTypes.put(dlvDocNo,dlvDocType);
			
			
			
			trackingNumber = dlvDocHdrRetObj.getFieldValueString(h,"LIFEX");
			dlvTrackingNumbers.put(dlvDocNo,trackingNumber);
			
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
			
			
			if("LF".equals(dlvDocType) || "ZD".equals(dlvDocType))
			{
				soLineTrackingNumbers.put(dlvSODoc+""+dlvSODocItem,trackingNumber);
				soLineBolNumbers.put(dlvSODoc+""+dlvSODocItem,dlvBolNumber);
				soLineShippingPartners.put(dlvSODoc+""+dlvSODocItem,dlvShippingPartner);
				//out.println("+++++++++++++++HERE3 +++");
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
	
	//out.println(":::salesQuoteDocRetObj::::"+salesQuoteDocRetObj.toEzcString());
		//out.println(":::itemShippedDispDates::::"+itemShippedDispDates);
		
		
	Hashtable refSalesQuotations = new Hashtable();	
	Hashtable poNumSOItemHT = new Hashtable();	
	if(salesQuoteDocRetObj.getRowCount()>0)
	{
		for(int s=0;s<salesQuoteDocRetObj.getRowCount();s++)
		{
			if(!"000000".equals(salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM")) && "C".equals(salesQuoteDocRetObj.getFieldValueString(s,"DOC_CATEGORY")))
				refSalesQuotations.put(salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC")+""+salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM"),salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC")+"/<br>"+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM"));
				
			
			if("V".equals(salesQuoteDocRetObj.getFieldValueString(s,"DOC_CATEGORY")) && !"000000".equals(salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM")))
				poNumSOItemHT.put(salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC")+""+salesQuoteDocRetObj.getFieldValueString(s,"QUOTE_DOC_ITEM"),salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC")+"/"+salesQuoteDocRetObj.getFieldValueString(s,"SALES_DOC_ITEM")); //QUOTE_DOC = SO Num &  QUOTE_DOC_ITEM = SO Item & SALES_DOC = PO Num && SALES_DOC_ITEM = PO Item
		}		
	}

	//out.println(refSalesQuotations);

%>
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
		return ret;
	}	
%>