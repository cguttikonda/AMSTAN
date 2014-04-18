<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<jsp:useBean id="Manager" class="ezc.sales.local.client.EzSalesManager" />
<%
	String salesDoc = request.getParameter("salDoc");
	String customer	= request.getParameter("soldTo");
	String dstat	= request.getParameter("docStat");
	String fromPage = request.getParameter("fromPage");
	
	if (fromPage == null) fromPage="";
	
	//salesDoc="0020000102";
	//customer="0102400000";
	
	//out.println(salesDoc);
	//out.println("::"+customer);

	int retHeaderCount = 0,retItemsCount=0;

	ReturnObjFromRetrieve sodetails= null;

	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	ezcSalesOrderParams.setSalesDocNum(salesDoc);
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
	ReturnObjFromRetrieve retFlow     = (ReturnObjFromRetrieve)sodetails.getFieldValue("FLOW");
	ReturnObjFromRetrieve retSched    = (ReturnObjFromRetrieve)sodetails.getFieldValue("SDSCHEDULE");
	
	
	/*if(retFlow!=null && retFlow.getRowCount()>0)
	{
		for(int f=retFlow.getRowCount()-1;f>=0;f--)
		{
			if(!"C".equals(retFlow.getFieldValueString(f,"DOC_CAT")))
			{
				retFlow.deleteRow(f);
			}
		}
	}*/
	//out.println(retLineText.toEzcString());
	
	HashMap flowHM = new HashMap();
	String openQtyHM="0",openQtyRet="0",totOpenQtyHM="0";
	String itemNo;

	if(retFlow!=null && retFlow.getRowCount()>0)
	{
		for(int fl=0;fl<retFlow.getRowCount();fl++)
		{
			if("C".equals(retFlow.getFieldValueString(fl,"DOC_CAT")))
			{	
			
				itemNo 	  =  retFlow.getFieldValueString(fl,"REFSDDOCITM");
				openQtyRet = retFlow.getFieldValueString(fl,"REF_QTY");
				//out.println(" Ref Doc Item No is "+ itemNo);
				try
				{
					openQtyRet = new java.math.BigDecimal(openQtyRet).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					//out.println("openQty:::"+openQtyRet);
				}
				catch(Exception e){}
				
				try
				{
					itemNo = (Long.parseLong(itemNo))+"";
				}
				catch(Exception e)
				{
					itemNo = itemNo;
					
				}	
				if(flowHM.containsKey(itemNo))
				{
					openQtyHM  = (String)flowHM.get(itemNo);
					
					//out.println("openQtyHM:::"+openQtyHM);
					
					try
					{
						openQtyHM = new java.math.BigDecimal(openQtyHM).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}
					catch(Exception e){}
					
					try
					{
						totOpenQtyHM = new java.math.BigDecimal(openQtyHM).add(new java.math.BigDecimal(openQtyRet)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}

					catch(Exception e){}
					
					flowHM.remove(itemNo);
					flowHM.put(itemNo,totOpenQtyHM);
				//	out.println("PUTTING TQTY VALUE :::"+totOpenQtyHM+" for Item No ::"+itemNo);
				}
				else
				{
					flowHM.put(itemNo,openQtyRet);
				//	out.println("PUTTING SINGLE VALUE :::"+openQtyRet);
				}			
			}
		}
	}
	
	/*if(retSched!=null && retSched.getRowCount()>0)
	{
		for(int sl=0;sl<retSched.getRowCount();sl++)
		{
		
		}
	
	}*/
	
	if(retSched!=null && retSched.getRowCount()>0)
	{
		for(int sl=retSched.getRowCount()-1;sl>=0;sl--)
		{
			if("0".equals(retSched.getFieldValueString(sl,"CONFIR_QTY")))
			{
				retSched.deleteRow(sl);
			}
		}
	}
	
	//out.println("flowHMflowHM:::"+flowHM);
	//out.println("retHeader::"+retHeader.toEzcString());
	//out.println("retItems::"+retItems.toEzcString());
	//out.println("retPartners::"+retPartners.toEzcString());
	//out.println("retLineText::"+retLineText.toEzcString());
	//out.println("retStatus::"+retStatus.toEzcString());
	//out.println("retCond::"+retCond.toEzcString());
	//out.println("retFlow::"+retFlow.toEzcString());
	//out.println("retSched::"+retSched.toEzcString());	
	//out.println("sodetails::::::::::::::::::::::"+sodetails.toEzcString());

	if(retHeader!=null && retHeader.getRowCount()>0)
		retHeaderCount = retHeader.getRowCount();
	if(retItems!=null && retItems.getRowCount()>0)
		retItemsCount = retItems.getRowCount();

	
	Vector types = new Vector();
	Vector names = new Vector();
	types.addElement("currency");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	names.addElement("NET_VALUE");
	names.addElement("PO_DATE");
	names.addElement("CT_VALID_F");
	names.addElement("CT_VALID_T");
	names.addElement("QT_VALID_F");
	names.addElement("QT_VALID_T");
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
	//types.addElement("String");
	//types.addElement("String");
	names.addElement("VALUE");
	names.addElement("REQUIREDDATE");
	names.addElement("NET_PRICE");
	//names.addElement("DOC_NO");
	//names.addElement("LINE_NO");
	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);

	ezc.ezparam.ReturnObjFromRetrieve ret1 = EzGlobal.getGlobal(retItems); 
	
	
	types = new Vector();
	names = new Vector();
	
	types.addElement("date");
	names.addElement("REQ_DATE");
	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);
	
	ezc.ezparam.ReturnObjFromRetrieve retSchedGl = EzGlobal.getGlobal(retSched); 

 	JCO.Client client2=null;
 	JCO.Function function1 = null;

	String [] slsOrdLineCols = {"SALES_DOC", "SALES_DOC_ITEM", "CUST_MAT35","VOLUME","PARENT_ITEM","ITEM_NO"};
	ReturnObjFromRetrieve slsOrdLineRetObj = new ReturnObjFromRetrieve(slsOrdLineCols);

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

	String site_SO = (String)session.getValue("Site");
	String skey_SO = "999";
	
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
 	
 	try
 	{
 		function1= EzSAPHandler.getFunction("Z_BAPISDORDER_GETDETAILEDLIST",site_SO+"~"+skey_SO);
 		//out.println(function1);
		JCO.ParameterList 	sapProc 	= function1.getImportParameterList();
		
		JCO.Structure order_viewstructure = sapProc.getStructure("I_BAPI_VIEW");
		JCO.Table salesTable = function1.getTableParameterList().getTable("SALES_DOCUMENTS");

		if(order_viewstructure!=null)
		{	
			order_viewstructure.setValue("X","ITEM");
		}
		
		sapProc.setValue("A","I_MEMORY_READ");
		sapProc.setValue(customer,"CUSTOMER");
		sapProc.setValue("H","ATTACHMENT_TYPE");
		
		salesTable.appendRow();
		salesTable.setValue(salesDoc, "VBELN");

 		try
 		{
 			client2 = EzSAPHandler.getSAPConnection(site_SO+"~"+skey_SO);
 			client2.execute(function1);
 		}
 		catch(Exception ec)
 		{
 			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
 		}

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
						else if("AACRYLUX".equals(pointsType.trim()) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1)){
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
 					}	// for alr
 					slsOrdLineRetObj.setFieldValue("VOLUME",volume);
 					slsOrdLineRetObj.addRow();
 				
 				}while(itemOutTable.nextRow());
 			}	// if itemRows
		} // if itemNull check
 		//out.println(slsOrdLineRetObj.toEzcString());
	} // main try block for 
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
 
	retItems.sort(new String[]{"DOC_NO","LINE_NO"},true);
	slsOrdLineRetObj.sort(new String[]{"SALES_DOC","SALES_DOC_ITEM"},true);
	//out.println(ret1.toEzcString());
	//ret1.sort(new String[]{"DOC_NO","LINE_NO"},true);
	int countItems = retItems.getRowCount();
	java.util.HashMap catalogHM = new java.util.HashMap();

	if(slsOrdLineRetObj!=null)
	{
		for(int i=0;i<slsOrdLineRetObj.getRowCount();i++)
		{
			String catalog_S = slsOrdLineRetObj.getFieldValueString(i,"CUST_MAT35");
			String volume_S = slsOrdLineRetObj.getFieldValueString(i,"VOLUME");
			String matno	= slsOrdLineRetObj.getFieldValueString(i,"ITEM_NO");
			String rejReason = retItems.getFieldValueString(i,"REJREASON");
			

			if(("PTSAM".equals(matno) || "PTSCH".equals(matno) || "PIECES".equals(matno)))
				continue;

	
			if(!catalogHM.containsKey(catalog_S))
			{
				catalogHM.put(catalog_S,volume_S);
			}
			else
			{
				String volume_H = (String)catalogHM.get(catalog_S);
				//volume_H = new java.math.BigDecimal(volume_S).add(new java.math.BigDecimal(volume_H)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
				volume_H = new java.math.BigDecimal(volume_S).add(new java.math.BigDecimal(volume_H)).toString();
				catalogHM.put(catalog_S,volume_H);
			}
		}
	}
	//out.println("catalogHM::"+catalogHM);

	
%>