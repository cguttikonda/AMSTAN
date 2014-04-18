<%
//*************************Start of Declarations*******************************************/

	String plantVal = "";//(String)session.getValue("PLANT");
	String profitCenter = (String)session.getValue("PROFITCENTER");
	String salesOffice = (String)session.getValue("CU_SALESOFFICE");
	String salesGroup = (String)session.getValue("CU_SALESGROUP");

 	java.util.ArrayList uProdOrderType = new java.util.ArrayList();

 	for(int i=0;i<prodCodeLength;i++)
 	{
		if(!uProdOrderType.contains(splitKey[i]))
		{
			uProdOrderType.add(splitKey[i]);
		}
	}

	ArrayList multiOrders_A = new ArrayList();
log4j.log("uProdOrderType======>"+uProdOrderType, "D");
for(int us=0;us<uProdOrderType.size();us++)
{
	sDocNumber = "";
 
	// BAPI Parameters
	EzBapiiteminTable iteminTablesim = new EzBapiiteminTable();
	EzBapiiteminTableRow aItemRowConfirm = null;
	EzBapiiteminTableRow aItemRowsim = null;
	EzBapiscondTable condTable = new EzBapiscondTable();
	EzBapiscondTableRow condTableRow = null;
	EzBapischdlTable deliveryScheduleTable = new EzBapischdlTable();
	EzBapischdlTableRow dSTableRow = null;
	EzBapistextTable ezctextTable = new EzBapistextTable();
	EzBapistextTableRow ezctextRow = null;

	EzBapischdlTable deliveryScheduleTableSim = new EzBapischdlTable();
	EzBapischdlTableRow dSTableSimRow = null;

	// Date Format Object
	java.util.GregorianCalendar fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();
	GregorianCalendar calendar1 = new GregorianCalendar();
	calendar1.setTime(fromDate.getTime());
	calendar1.add(Calendar.DATE,5);
	Date reqDate1 =calendar1.getTime();
//***************************End of Declarations*******************************************/

	EzcSalesOrderParams       initParams 	   = new EzcSalesOrderParams();
	EziSalesOrderCreateParams initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);

	EziSalesOrderCreateParams ioParamsConfirm 	= (EziSalesOrderCreateParams)EzSalesOrderManager.initializeSalesOrder(initParams);
	EzBapisdheadStructure     orderHeaderConfirm 	= ioParamsConfirm.getOrderHeaderIn();
	EzBapipartnrTable 	  orderPartnersConfirm  = ioParamsConfirm.getOrderPartners();
	EzBapiiteminTable 	  iteminTableConfirm    = ioParamsConfirm.getOrderItemsIn();

//**********************Setting  Header Values *****************************************/

	if(salesOffice!=null && !"null".equals(salesOffice) && !"".equals(salesOffice.trim()))
		orderHeaderConfirm.setSalesOff(salesOffice.trim());
	if(salesGroup!=null && !"null".equals(salesGroup) && !"".equals(salesGroup.trim()))
		orderHeaderConfirm.setSalesGrp(salesGroup.trim());

	orderHeaderConfirm.setComplDlv(dlvChk);

	orderHeaderConfirm.setDivision("");
	orderHeaderConfirm.setDistrChan("");
	orderHeaderConfirm.setSalesOrg("");
	//orderHeaderConfirm.setDlvBlock("ZZ");  //"ZZ" in AF
	orderHeaderConfirm.setIncoterms1(incoTerms1);
	orderHeaderConfirm.setIncoterms2(incoTerms2);
	orderHeaderConfirm.setLog("TRUE");

	log4j.log("setIncoterms1  "+incoTerms1,"W");
	log4j.log("setIncoterms2  "+incoTerms2,"W");

	if(!(" ".equals(shippingCond)|| "null".equals(shippingCond)))
	{
		//orderHeaderConfirm.setShipCond(shippingCond); 
	}
	//orderHeaderConfirm.setShipCond("");
	//orderHeaderConfirm.setShippingType(carrierName);
	orderHeaderConfirm.setPmnttrms(paymentterms);
	orderHeaderConfirm.setPurchNo(poNumber);
	orderHeaderConfirm.setAgentCode((String)session.getValue("SAPPRDCODE"));
	//orderHeaderConfirm.setPromoCode(promoCode);

	log4j.log("setPmnttrms  "+paymentterms,"W");
	//log4j.log("setPurchNo  "+setSalVal.getPoNo(),"W");
	log4j.log("setAgentCode  "+(String)session.getValue("SAPPRDCODE"),"W");

	try
	{
		int mn = Integer.parseInt(poDate.substring(0,2));
		int dt = Integer.parseInt(poDate.substring(3,5));
		int yr = Integer.parseInt(poDate.substring(6,10));
		java.util.GregorianCalendar reqDatePO = new java.util.GregorianCalendar(yr,mn-1,dt);

		orderHeaderConfirm.setPurchDate(reqDatePO.getTime());

		log4j.log("setPurchDate  "+reqDatePO,"W");
	}
	catch(Exception e){}

	if((curr!=null) && (curr.trim().length()!=0))
	{
		orderHeaderConfirm.setCurrency(curr);
		log4j.log("setCurrency  "+curr,"W");
	}

	try
	{
		StringTokenizer del_Dates = new StringTokenizer(del_sch_date_1[0],"@@");
		String defaultdat = del_Dates.nextToken();

		int yearReq1 = Integer.parseInt(defaultdat.substring(6,10));
		int dateReq1 = Integer.parseInt(defaultdat.substring(3,5));
		int monthReq1 = Integer.parseInt(defaultdat.substring(0,2));

		java.util.GregorianCalendar reqDat = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);
		if("Y".equals(eddFlag))		
			orderHeaderConfirm.setReqDateH(reqDat.getTime());
		log4j.log("setReqDateH  "+reqDat,"W");
	}
	catch(Exception e)
	{
		if("Y".equals(eddFlag))
			orderHeaderConfirm.setReqDateH(reqDate1);
		log4j.log("setReqDateH  "+reqDate1,"W");
	}
//*******************Finished setting headervalues**************************************

//*************************SettingPartners**********************************************
	if(soldToCode!=null)
	{
		log4j.log("soldToCode in SAP creation call::::"+soldToCode,"I");

		EzBapipartnrTableRow aRowSold = new EzBapipartnrTableRow();

		aRowSold.setPartnRole("AG");
		aRowSold.setPartnNumb(soldToCode);
		aRowSold.setFirstTelephoneNo(soldToPhNum);
		aRowSold.setName1(soldToName);
		aRowSold.setHouseNumberAndStreet(soldToStreet);
		aRowSold.setPostalCode(soldToZipCode);
		aRowSold.setCity(soldToCity);
		aRowSold.setRegion(soldToState);
		aRowSold.setCountrykey(soldToCountry);

		orderPartnersConfirm.appendRow(aRowSold);

		log4j.log("soldToCode in SAP creation call2::::"+aRowSold.getPartnNumb(),"I");

		EzBapipartnrTableRow aRowShip = new EzBapipartnrTableRow();

		aRowShip.setPartnRole("WE");
		aRowShip.setPartnNumb(shipToCode);
		aRowShip.setHouseNumberAndStreet(shipToStreet);
		aRowShip.setPostalCode(shipToZipCode);
		aRowShip.setCity(shipToCity);
		aRowShip.setRegion(shipToState);
		aRowShip.setName1(shipToName);
		aRowShip.setCountrykey(shipToCountry);
		aRowShip.setTransportationZone(shipToTransZone);

		orderPartnersConfirm.appendRow(aRowShip);
	}

	if(shipMethod!=null && !(shipMethod.equals("STD")) && !"".equals(shipMethod))
	{
		EzBapipartnrTableRow aRowCarr = new EzBapipartnrTableRow();

		aRowCarr.setPartnRole(shipPartnRole);
		aRowCarr.setPartnNumb(shipMethod);

		if("ZF".equals(shipPartnRole))
		{
			aRowCarr.setHouseNumberAndStreet(billToStreet);
			aRowCarr.setPostalCode(billToZipCode);
			aRowCarr.setCity(billToCity);
			aRowCarr.setRegion(billToState);
			aRowCarr.setName1(billToName);
			aRowCarr.setCountrykey(billToCountry);
		}

		orderPartnersConfirm.appendRow(aRowCarr);
	}

	if(!"ZC".equals(shipPartnRole)) billToAddress = "None";

	log4j.log("Finished setting  Partner values","I");

//*************************Finished setting  Partner values******************************

	String[] notesAll = new String[]{billToAddress,generalNotes1,generalNotes2};	//specialShIns 0012
	String notesHId[] = new String[]{"Z004","0004","0012","ZPH2"};
	EzStringTokenizer notesAllSt=null;
	int notesAllCt=0;
	String chkLin="";
	int strLength=0;
	int len=0;
	int rem=0;
	String cutLen = "";
	for(int i=0;i<notesAll.length;i++)
	{
		if(!"None".equals(notesAll[i]) )
		{
			notesAllSt = new EzStringTokenizer(notesAll[i],"\n");
			notesAllCt =notesAllSt.getTokens().size();
			if(notesAllCt == 0)
			{
				chkLin = notesAll[i];
				strLength = chkLin.length();
				if(strLength >130)
				{
					len = strLength / 130 ;
					rem = strLength % 130;
					for(int l=0;l<len;l++)
					{
						try{
							cutLen = chkLin.substring(130*l,130*(l+1));
						}catch(Exception e)
						{
							cutLen=chkLin.substring(130*l,chkLin.length());
						}
						ezctextRow = new EzBapistextTableRow();
						ezctextRow.setItmNumber(new java.math.BigInteger("0"));
						ezctextRow.setTextId(notesHId[i]);
						ezctextRow.setLanguage("E");
						ezctextRow.setTextLine(cutLen);
						ezctextRow.setColFormat("*");
						ezctextRow.setFunction("005");
						ezctextTable.appendRow(ezctextRow);
					}	
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						ezctextRow = new EzBapistextTableRow();
						ezctextRow.setItmNumber(new java.math.BigInteger("0"));
						ezctextRow.setTextId(notesHId[i]);
						ezctextRow.setLanguage("E");
						ezctextRow.setTextLine(cutLen);
						ezctextRow.setColFormat("*");
						ezctextRow.setFunction("005");
						ezctextTable.appendRow(ezctextRow);
					}
				}
				else{
					ezctextRow = new EzBapistextTableRow();
					ezctextRow.setItmNumber(new java.math.BigInteger("0"));
					ezctextRow.setTextId(notesHId[i]);
					ezctextRow.setLanguage("E");
					ezctextRow.setTextLine(chkLin);
					ezctextRow.setColFormat("*");
					ezctextRow.setFunction("005");
					ezctextTable.appendRow(ezctextRow);
				}
			}
			else
			{
				for(int linall=0;linall<notesAllCt;linall++)
				{
					chkLin = (String)notesAllSt.getTokens().elementAt(linall);
					strLength = chkLin.length();
					if(strLength >130)
					{
						len = strLength / 130 ;
						rem = strLength % 130;
						for(int l=0;l<len;l++)
						{
							try{
								cutLen = chkLin.substring(130*l,130*(l+1));
							}
							catch(Exception e)
							{
								cutLen=chkLin.substring(130*l,chkLin.length());
							}
							ezctextRow = new EzBapistextTableRow();
							ezctextRow.setItmNumber(new java.math.BigInteger("0"));
							ezctextRow.setTextId(notesHId[i]);
							ezctextRow.setLanguage("E");
							ezctextRow.setTextLine(cutLen);
							ezctextRow.setColFormat("*");
							ezctextRow.setFunction("005");
							ezctextTable.appendRow(ezctextRow);
						}	
						if(rem > 0)
						{
							cutLen =chkLin.substring(130*len,strLength);
							ezctextRow = new EzBapistextTableRow();
							ezctextRow.setItmNumber(new java.math.BigInteger("0"));
							ezctextRow.setTextId(notesHId[i]);
							ezctextRow.setLanguage("E");
							ezctextRow.setTextLine(cutLen);
							ezctextRow.setColFormat("*");
							ezctextRow.setFunction("005");
							ezctextTable.appendRow(ezctextRow);
						}
					}else
					{
						ezctextRow = new EzBapistextTableRow();
						ezctextRow.setItmNumber(new java.math.BigInteger("0"));
						ezctextRow.setTextId(notesHId[i]);
						ezctextRow.setLanguage("E");
						ezctextRow.setTextLine(chkLin);
						ezctextRow.setColFormat("*");
						ezctextRow.setFunction("005");
						ezctextTable.appendRow(ezctextRow);
					}
				}
			}
		}
	}
	
	log4j.log("Finished setting  header values","I");
	
//*******************Finished setting header values*************************************

//****************************Setting Items conditions and delivery schedules*********************************************

	int lineno = 1;

	String OrderQuantity = "";
	String itemUom = "";
	String itemCat = "";

	java.math.BigDecimal bOrderQty = null;
	java.math.BigInteger line = null;
	java.math.BigDecimal ordqty = null;

	int dateReq = 0;
	int monthReq = 0;
	int yearReq = 0;
	java.util.GregorianCalendar reqDate2 = null;

	String del_Qty = "";
	String del_Dates = "";
	StringTokenizer del_Dates_St = null;
	StringTokenizer del_Qty_ST = null;
	int del_Qty_Count = 0;
	int dschline = 0;

	String dreqqty = "";
	String schdat = "";
	java.util.GregorianCalendar reqDatesch = null;
	int yearReq1 = 0;
	int monthReq1 = 0;
	int dateReq1 = 0;

	String ordType_S = "";
	String salesOrg_S = "";
	String division_S = "";
	String distChnl_S = "";

	String quoteNum = "";

	log4j.log("prodCodeLengthprodCodeLength"+prodCodeLength,"I");
	

	java.math.BigDecimal itemPointsBD = new java.math.BigDecimal("0");

	Hashtable pointsCatHT = new Hashtable();
	ArrayList itemCat_A = new ArrayList();

	for(int j=0;j<prodCodeLength;j++)
	{		
		if(splitKey[j].equals((String)uProdOrderType.get(us)))
		{

		ordType_S	= splitKey[j].split("¥")[0];
		salesOrg_S	= splitKey[j].split("¥")[1];
		division_S	= splitKey[j].split("¥")[2];
		distChnl_S	= splitKey[j].split("¥")[3];

		OrderQuantity 	= prodCQty_1[j];
		itemUom		= prodPack_1[j];
		custProd        = custprodCode[j];
		OrderQuantity 	= (OrderQuantity==null|| "".equals(OrderQuantity.trim()) || "null".equals(OrderQuantity) )?"0":OrderQuantity.trim();
		itemCat 	= prodItemCat_1[j];

		if(!OrderQuantity.equals("0") && !"TANN".equals(itemCat))
		{
			bOrderQty  = new  java.math.BigDecimal(OrderQuantity);
			bOrderQty  = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
			line 	   = new java.math.BigInteger(String.valueOf(lineno*10));			
			ordqty 	   = new java.math.BigDecimal(OrderQuantity);
			ordqty     = ordqty .multiply(new java.math.BigDecimal(Integer.toString(1000)));

			String ord_T = ordType_S;//itemOrderType[j];
			if("OR".equals(ord_T)) ord_T = "TA";
			if("FD".equals(ord_T)) ord_T = "KL";

			quoteNum = quoteNum_1[j];
			if(quoteNum==null || "null".equalsIgnoreCase(quoteNum) || "N/A".equals(quoteNum)) quoteNum = "";

			log4j.log("Check11111::::::","I");
			String lineNum = lineNum_1[j];
			if(lineNum==null || "null".equalsIgnoreCase(lineNum) || "N/A".equals(lineNum)) lineNum = "";
			
			java.math.BigInteger lineNum_B = new java.math.BigInteger("0");
			try
			{
				lineNum_B = new java.math.BigInteger(lineNum);
			}
			catch(Exception e){}
			log4j.log("Check2222222::::::","I");			

			if(itemPlant[j]==null || "null".equalsIgnoreCase(itemPlant[j]) || "N/A".equals(itemPlant[j]))
			{
				plantVal = "";
				log4j.log("Check33333333::::::","I");
			}	
			else
				plantVal = itemPlant[j];
				
			log4j.log("plantVal::::::"+plantVal,"I");	

//******************************setting  items*********************************************

			aItemRowConfirm = new EzBapiiteminTableRow();
			aItemRowsim = new EzBapiiteminTableRow();

			aItemRowConfirm.setItmNumber(line);
			aItemRowConfirm.setCustMat(custprodCode[j]);
			aItemRowConfirm.setMaterial(prodCode_1[j]);
			aItemRowConfirm.setShortText(prodDesc_1[j]);
			aItemRowConfirm.setSalesUnit(itemUom);
			aItemRowConfirm.setBillDate(fromDate.getTime()); // current Date as Bill Date
			aItemRowConfirm.setProfitCenter(profitCenter);
			aItemRowConfirm.setShipTo(shipToCode);
			aItemRowConfirm.setSysKey(sysKey);
			aItemRowConfirm.setSalesOrg(salesOrg_S);		//SalesOrg
			aItemRowConfirm.setDistributionChanel(distChnl_S); 	//DC
			aItemRowConfirm.setDivision(division_S);		//Div
			aItemRowConfirm.setPlant("");				//plantVal
			//aItemRowConfirm.setDocType(docType);
			aItemRowConfirm.setDocType(ord_T);
			aItemRowConfirm.setRefDoc(quoteNum);
			aItemRowConfirm.setRefDocIt(lineNum_B);
			aItemRowConfirm.setRefDocCa("B");

			log4j.log("setItmNumber  "+line,"W");
			log4j.log("setCustMat  "+custprodCode[j],"W");
			log4j.log("setMaterial  "+prodCode_1[j],"W");
			log4j.log("setShortText  "+prodDesc_1[j],"W");
			log4j.log("setSalesUnit  "+itemUom,"W");
			log4j.log("setBillDate  "+fromDate,"W");

			aItemRowsim.setItmNumber(line);
			aItemRowsim.setMaterial(prodCode_1[j]);
			aItemRowsim.setCustMat(custprodCode[j]);
			aItemRowsim.setEanUpc(itemEanUPC[j]);
			aItemRowsim.setMatExt(itemMfrPart[j]);
			aItemRowsim.setMatlGroup(itemMfrNr[j]);
			aItemRowsim.setBatch(itemMatId[j]);			
			aItemRowsim.setSalesUnit(itemUom);
			aItemRowsim.setBillDate(fromDate.getTime()); // current Date as Bill Date
			aItemRowsim.setShipTo(shipToCode);	//setSalVal.getShipTo()
			aItemRowsim.setSysKey(sysKey);	
			aItemRowsim.setSalesOrg(salesOrg_S);			//SalesOrg
			aItemRowsim.setDistributionChanel(distChnl_S);		//DC
			aItemRowsim.setDivision(division_S);			//Div
			aItemRowsim.setPlant("");	 	//plantVal - This has to be set with material group based material code
			//aItemRowsim.setDocType(docType);
			aItemRowsim.setDocType(ord_T);
			aItemRowsim.setRefDoc(quoteNum);
			aItemRowsim.setRefDocIt(lineNum_B);

			log4j.log("itemEanUPC  "+itemEanUPC[j],"W");
			log4j.log("itemMfrPart  "+itemMfrPart[j],"W");
			log4j.log("itemMfrNr  "+itemMfrNr[j],"W");
			log4j.log("itemMatId  "+itemMatId[j],"W");
			log4j.log("setShipTo  "+shipToCode,"W");
			//log4j.log("setShipTo  "+setSalVal.getShipTo(),"W");
			log4j.log("setSysKey  "+sysKey,"W");
			log4j.log("SalesOrg  "+SalesOrg,"W");
			log4j.log("setDistributionChanel  "+DC,"W");
			log4j.log("setDivision  "+Div,"W");
			log4j.log("setPlant  "+plantVal,"W");
			log4j.log("setDocType  "+docType,"W");

			iteminTableConfirm.appendRow(aItemRowConfirm);
			iteminTablesim.appendRow(aItemRowsim);

			String soCondType = (String)session.getValue("SOCONDTYPE");

			try
			{
				if(!"".equals(quoteNum))
				{
					soCondType = "ZJOB";

					condTableRow =new EzBapiscondTableRow();
					condTableRow.setItmNumber(line);
					condTableRow.setCondType(soCondType);   //"PR00"
					condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice[j])/10));
					condTable.appendRow(condTableRow);
				}
			}
			catch(Exception err){}

//***********************************finished setting Items***********************************

			del_Qty 	= del_sch_qty_1[j];
			del_Dates 	= del_sch_date_1[j];
			del_Dates_St 	= new StringTokenizer(del_Dates,"@@");
			del_Qty_ST 	= new StringTokenizer(del_Qty,"@@");

			del_Qty_Count 	  = del_Qty_ST.countTokens();
			String schqty1[]  = new String[del_Qty_Count];
			String schdate1[] = new String[del_Qty_Count];
			dschline = 1;
			for(int d=0;d<del_Qty_Count;d++)
		 	{
				schqty1[d]  = del_Qty_ST.nextToken();
				schdate1[d] = del_Dates_St.nextToken();
				schqty1[d]  = ((schqty1[d] == null)||("null".equals(schqty1[d]))||(schqty1[d].trim().length() ==0) )?"0":schqty1[d];
				if(!"0".equals(schqty1[d]))
				{
					dSTableRow = new EzBapischdlTableRow();
					dSTableSimRow = new EzBapischdlTableRow();

					dreqqty = schqty1[d];
					schdat = schdate1[d];
					try
					{
						yearReq1  = Integer.parseInt(schdat.substring(6,10));
						dateReq1  = Integer.parseInt(schdat.substring(3,5));
						monthReq1 = Integer.parseInt(schdat.substring(0,2));
						reqDatesch = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);
						dSTableRow.setReqQty(new java.math.BigDecimal(dreqqty) );
						dSTableRow.setReqDate(reqDatesch.getTime());

						dSTableSimRow.setReqQty(new java.math.BigDecimal(dreqqty) );
						dSTableSimRow.setReqDate(reqDatesch.getTime());
						
						log4j.log("setReqQty  "+dreqqty,"W");
						log4j.log("setReqDate  "+schdat,"W");
						
					}catch(Exception e){}
					dSTableRow.setItmNumber(line);
					dSTableRow.setShortText(String.valueOf(dschline));

					dSTableSimRow.setItmNumber(line);
					dSTableSimRow.setShortText(String.valueOf(dschline));

					log4j.log("setItmNumber  "+line,"W");
					log4j.log("setShortText  "+dschline,"W");
					
					//dSTableRow.setDlvBlock("ZZ"); //"ZZ" in AF
					deliveryScheduleTable.appendRow(dSTableRow);
					deliveryScheduleTableSim.appendRow(dSTableSimRow);
					dschline++;
				}
			}
			lineno++;

			try
			{
				log4j.log("itemVenCatalog[j]  "+itemVenCatalog[j],"W");
				String itemVendorCatalog_C = itemVenCatalog[j];
				if(!itemCat_A.contains(itemVendorCatalog_C))
					itemCat_A.add(itemVendorCatalog_C);

				log4j.log("itemCat_A::::"+itemCat_A,"D");
				if(pointsCatHT.containsKey(itemVendorCatalog_C))
					itemPointsBD = new java.math.BigDecimal((String)pointsCatHT.get(itemVendorCatalog_C));

				log4j.log("itemPointsBD::::"+itemPointsBD,"D");
				itemPointsBD = itemPointsBD.add(new java.math.BigDecimal(itemPoints[j]));

				log4j.log("itemPoints[j]::::"+itemPoints[j],"D");

				pointsCatHT.put(itemVendorCatalog_C,itemPointsBD.toString());
				log4j.log("pointsCatHT::::"+pointsCatHT,"D");
			}
			catch(Exception e){}
		}
		}
  	}
	log4j.log("dummy check 1","D");
	log4j.log("dummy check itemCat_A"+itemCat_A,"D");
	log4j.log("dummy check pointsCatHT"+pointsCatHT,"D");

	for(int ic=0;ic<itemCat_A.size();ic++)
	{
		String itemCatSel = (String)itemCat_A.get(ic);
		log4j.log("dummy check itemCatSel>>>>>>>>"+itemCatSel,"D");
		
		String catPoints = (String)session.getValue(itemCatSel);
		String itemPointsSel = (String)pointsCatHT.get(itemCatSel);
		log4j.log("dummy check catPoints>>>>>>>>>"+catPoints,"D");
		log4j.log("dummy check itemPointsSel>>>>>>>>>"+itemCatSel,"D");

		java.math.BigDecimal catPointsBD = new java.math.BigDecimal("0");
		java.math.BigDecimal itemSelBD = new java.math.BigDecimal("0");

		try
		{
			catPointsBD = new java.math.BigDecimal(catPoints);
			itemSelBD = new java.math.BigDecimal(itemPointsSel);
		}
		catch(Exception e){}

		log4j.log("dummy check compBD"+catPointsBD.compareTo(itemSelBD),"D");
		int compBD = catPointsBD.compareTo(itemSelBD);
		log4j.log("dummy check compBD"+compBD,"D");

		log4j.log("dummy check 2","D");

		if(compBD==1)
		{
			boolean dPoint = false;

			String dProdCode = "";
			String dQuantity = "";
			String dschQty 	 = "";

			int dQty = 1;

			if("Enamel Steel".equals(itemCatSel) || "Acrylux".equals(itemCatSel) || "Chinaware".equals(itemCatSel) || "Americast & Acrylics (Excludes Acrylux)".equals(itemCatSel))
			{
				int cp_1000 = catPointsBD.compareTo(new java.math.BigDecimal("1000"));
				int cp_300 = catPointsBD.compareTo(new java.math.BigDecimal("300"));

				int ip_1000 = itemSelBD.compareTo(new java.math.BigDecimal("1000"));
				int ip_300 = itemSelBD.compareTo(new java.math.BigDecimal("300"));

				if(cp_1000==1 && ip_1000==-1)
				{
					dPoint = true;
					dQuantity = "1000";
					dschQty = "1";

					int ip_100 = (itemSelBD).compareTo(new java.math.BigDecimal("100"));
					int ip_400 = (itemSelBD).compareTo(new java.math.BigDecimal("400"));
					int ip_700 = (itemSelBD).compareTo(new java.math.BigDecimal("700"));

					if(ip_700==0 || ip_700==1)
						dQty = 1;
					else if(ip_400==0 || ip_400==1)
						dQty = 2;
					else if(ip_100==0 || ip_100==1)
						dQty = 3;
					else if(ip_100==-1)
						dQty = 4;
				}
				else if(cp_300==1 && ip_300==-1)
				{
					dPoint = true;
					dQuantity = "1000";
				}
			}
			else
			{
				int cp_180 = catPointsBD.compareTo(new java.math.BigDecimal("180"));
				int cp_90 = catPointsBD.compareTo(new java.math.BigDecimal("90"));
				int cp_48 = catPointsBD.compareTo(new java.math.BigDecimal("48"));

				int ip_180 = itemSelBD.compareTo(new java.math.BigDecimal("180"));
				int ip_90 = itemSelBD.compareTo(new java.math.BigDecimal("90"));
				int ip_48 = itemSelBD.compareTo(new java.math.BigDecimal("48"));

				if(cp_180==1 && ip_180==-1)
				{
					dPoint = true;
					dQuantity = "180000";
					dschQty = "180";
				}
				else if(cp_90==1 && ip_90==-1)
				{
					dPoint = true;
					dQuantity = "90000";
					dschQty = "90";
				}
				else if(cp_48==1 && ip_48==-1)
				{
					dPoint = true;
					dQuantity = "48000";
					dschQty = "48";
				}
			}

			if(dPoint)
			{
				if("Acrylux".equals(itemCatSel) || "Americast & Acrylics (Excludes Acrylux)".equals(itemCatSel))
					dProdCode = "PTSAM";
				else if("Enamel Steel".equals(itemCatSel) || "Chinaware".equals(itemCatSel))
					dProdCode = "PTSCH";
				else
					dProdCode = "PIECES";

				for(int dq=0;dq<dQty;dq++)
				{
					line 	   = new java.math.BigInteger(String.valueOf(lineno*10));

					String ord_T = ordType_S;
					if("OR".equals(ord_T)) ord_T = "TA";
					if("FD".equals(ord_T)) ord_T = "KL";

					aItemRowConfirm = new EzBapiiteminTableRow();
					aItemRowsim = new EzBapiiteminTableRow();

					aItemRowConfirm.setItmNumber(line);
					aItemRowConfirm.setCustMat(dProdCode);
					aItemRowConfirm.setMaterial(dProdCode);
					aItemRowConfirm.setShortText("");
					//aItemRowConfirm.setSalesUnit("PTS");
					aItemRowConfirm.setBillDate(fromDate.getTime());
					aItemRowConfirm.setProfitCenter(profitCenter);
					aItemRowConfirm.setShipTo(shipToCode);
					aItemRowConfirm.setSysKey(sysKey);
					aItemRowConfirm.setSalesOrg(salesOrg_S);
					aItemRowConfirm.setDistributionChanel(distChnl_S);
					aItemRowConfirm.setDivision(division_S);
					aItemRowConfirm.setPlant("");	//plantVal
					aItemRowConfirm.setDocType(ord_T);
					aItemRowConfirm.setReqQty(new java.math.BigInteger(dQuantity));

					aItemRowsim.setItmNumber(line);
					aItemRowsim.setMaterial(dProdCode);
					aItemRowsim.setCustMat(dProdCode);
					aItemRowsim.setEanUpc("");
					aItemRowsim.setMatExt(dProdCode);
					aItemRowsim.setMatlGroup("");
					aItemRowsim.setBatch(dProdCode);			
					//aItemRowsim.setSalesUnit("PTS");
					aItemRowsim.setBillDate(fromDate.getTime());
					aItemRowsim.setShipTo(shipToCode);
					aItemRowsim.setSysKey(sysKey);
					aItemRowsim.setSalesOrg(salesOrg_S);
					aItemRowsim.setDistributionChanel(distChnl_S);
					aItemRowsim.setDivision(division_S);
					aItemRowsim.setPlant("");	//plantVal
					aItemRowsim.setDocType(ord_T);
					aItemRowsim.setReqQty(new java.math.BigInteger(dQuantity));

					iteminTableConfirm.appendRow(aItemRowConfirm);
					iteminTablesim.appendRow(aItemRowsim);

					dSTableRow = new EzBapischdlTableRow();
					try
					{
						dSTableRow.setReqQty(new java.math.BigDecimal(dschQty));
						dSTableRow.setReqDate(reqDatesch.getTime());
					}
					catch(Exception e){}

					dSTableRow.setItmNumber(line);
					dSTableRow.setShortText(String.valueOf(dschline));
					deliveryScheduleTable.appendRow(dSTableRow);
					dschline++;

					lineno++;
				}
			}
		}
	}
	log4j.log("dummy check 3","D");

	if(!"".equals(quoteNum))
	{
		orderHeaderConfirm.setLogicSwitch("G");
		orderHeaderConfirm.setExt1("X");
		//orderHeaderConfirm.setRefDoc(quoteNum);
		//orderHeaderConfirm.setRefDocCa("B");
		log4j.log("LogicSwitch::"+orderHeaderConfirm.getLogicSwitch(),"I");
	}

//************************* Finished Setting Items *****************************************

	try
	{
		EzcSalesOrderParams  ezcSalesOrderParamsSim = new EzcSalesOrderParams();
        	EziSalesOrderCreateParams escpSim = new EziSalesOrderCreateParams();
        	escpSim.setCreditChkFlag("Y");
        	ezcSalesOrderParamsSim.setObject(escpSim);
		escpSim.setOrderHeaderIn(orderHeaderConfirm);
		escpSim.setOrderPartners(orderPartnersConfirm);
		escpSim.setOrderItemsIn(iteminTablesim);
		escpSim.setOrderDelSchedule(deliveryScheduleTableSim);
		escpSim.setType("BULK"); // if this is set to bulk or RBPG(if RBPG plant has tobe set material group),for every sales area one sap order is simulated
        	Session.prepareParams(ezcSalesOrderParamsSim);
        	long start = System.currentTimeMillis();
		EzoSalesOrderCreate  ioParamsSim = (EzoSalesOrderCreate)EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParamsSim);
		long finish = System.currentTimeMillis();
		log4j.log("Simulate Sales Order1 >>>"+(finish-start)/1000,"I");
		itemoutTable 	= (ReturnObjFromRetrieve)ioParamsSim.getOrderItemsOut();
		ReturnObjFromRetrieve orderErrorSim =(ReturnObjFromRetrieve)ioParamsSim.getReturn();
		int orderErrorSimCount=orderErrorSim.getRowCount();
		log4j.log("orderErrorSim======>"+orderErrorSim.toEzcString(), "D");
		for(int pc=0;pc<orderErrorSimCount;pc++) 
		{
			ErrorType =orderErrorSim.getFieldValueString(pc,"Type").trim();
			if("E".equalsIgnoreCase(ErrorType) )
			{
				ErrorMessage = ErrorMessage+"<br>simulate "+ErrorType+":"+orderErrorSim.getFieldValueString(pc,"Message");
				SAPnumber=false; 
			}
		}
	}
	catch(Exception e)
	{
		System.out.println(e);
		SAPnumber=false;
	}

	log4j.log("SAPnumberSAPnumberSAPnumberSAPnumber======>"+SAPnumber, "D");

	if(SAPnumber) 
	{
		try
		{
			EzcSalesOrderParams  ezcSalesOrderParamsSave = new EzcSalesOrderParams();
			EziSalesOrderCreateParams escpSave = new EziSalesOrderCreateParams();
	        	ezcSalesOrderParamsSave.setObject(escpSave);
			escpSave.setOrderHeaderIn(orderHeaderConfirm);
			escpSave.setOrderPartners(orderPartnersConfirm);
			escpSave.setOrderItemsIn(iteminTableConfirm);
			escpSave.setOrderDelSchedule(deliveryScheduleTable);
			escpSave.setOrderText(ezctextTable);
			escpSave.setOrderConditions(condTable); 
			escpSave.setType("BULK");  	//if this is set to bulk or RBPG(if RBPG plant has to be set material group),for every sales area one sap order is simulated
			Session.prepareParams(ezcSalesOrderParamsSave);
			log4j.log("iteminTableConfirmiteminTableConfirm======>"+iteminTableConfirm.getRowCount(), "D");
			long start1 = System.currentTimeMillis();
			EzoSalesOrderCreate ioParamsSave = (EzoSalesOrderCreate)EzSalesOrderManager.ezCreateWebSalesOrder(ezcSalesOrderParamsSave);
			long finish1 = System.currentTimeMillis();
			log4j.log("Create Sales Order >>>"+(finish1-start1)/1000,"I");
			orderError = ioParamsSave.getReturn();
			orders =(ReturnObjFromRetrieve) ioParamsSave.getObject("SalesOrders");
			int orderErrorCount = orderError.getRowCount();

			log4j.log("orderErrorCount======>"+orderErrorCount, "D");
			log4j.log("orderError======>"+orderError.toEzcString(), "D");
			log4j.log("ordersordersorders======>"+orders.toEzcString(), "D");

			for(int pc=0;pc<orderErrorCount;pc++)
			{
				ErrorType =orderError.getFieldValueString(pc,"Type");
				if("E".equalsIgnoreCase(ErrorType))
				{
					ErrorMessage = ErrorMessage+"<br>Post:"+orderError.getFieldValueString(pc,"Message");
					SAPnumber=false; 
				}
			}

			ArrayList chkWaste = new ArrayList();
			String s="";
			int ordersCount = orders.getRowCount();
			for(int ord = 0;ord<ordersCount;ord++)
			{
				s =orders.getFieldValueString(ord,"SalesOrder");
				if(!chkWaste.contains(s))
				{
					chkWaste.add(s);
					if((sDocNumber == null) || (sDocNumber.trim().length()==0))
					{
						sDocNumber = s;
					}
					else
					{
						sDocNumber = sDocNumber+ "," + s ;
					}
				}
			}
			
			multiOrders_A.add(sDocNumber);
			
			if((sDocNumber ==null ) || (sDocNumber.trim().length()==0))
			{
				SAPnumber=false;
			}
		}	
      		catch(Exception e)
      		{
			e.printStackTrace();
			SAPnumber=false;
      		}
	}
}
log4j.log("multiOrders_A======>"+multiOrders_A, "D");
for(int mo=0;mo<multiOrders_A.size();mo++)
{
	if(mo==0)
	{
		sDocNumber = (String)multiOrders_A.get(mo);
	}
	else
	{
		sDocNumber = sDocNumber+ "," + (String)multiOrders_A.get(mo);
	}

	String tempDocNo_U = (String)multiOrders_A.get(mo);
	String tempAttachFile_U = (String)session.getValue("ATTACHEDFILES");

log4j.log("tempAttachFile_U======>"+tempAttachFile_U, "D");

	if(tempAttachFile_U!=null && !"null".equalsIgnoreCase(tempAttachFile_U) && !"".equals(tempAttachFile_U))
	{
%>
		<%@ include file="../../../Sales/JSPs/UploadFiles/ezSendAttachFileToSap.jsp"%>
<%
	}
}
log4j.log("sDocNumber CHECK======>"+sDocNumber, "D");
%>