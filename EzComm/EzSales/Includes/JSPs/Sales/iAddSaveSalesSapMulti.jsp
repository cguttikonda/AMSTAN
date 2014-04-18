<%
//*************************Start of Declarations*******************************************/

	EzShoppingCartManager SCManager_C = new EzShoppingCartManager( Session );
	EzShoppingCart viewCart_C = null;
	EzcShoppingCartParams prevparams_C    = new EzcShoppingCartParams();
	EziShoppingCartParams prevsubparams_C = new EziShoppingCartParams();
	prevsubparams_C.setLanguage("EN");
	prevparams_C.setObject(prevsubparams_C);
	Session.prepareParams(prevparams_C);
	viewCart_C = (EzShoppingCart)SCManager_C.getSavedCart(prevparams_C);

	int rCnt_C = viewCart_C.getRowCount();

	Hashtable totPointsCatHT = new Hashtable();

	for(int h=0;h<rCnt_C;h++)
	{
		java.math.BigDecimal totItemPointsBD = new java.math.BigDecimal("0");

		String itemVenCat_C = (String)viewCart_C.getVendorCatalog(h);
		String itemPoints_C = (String)viewCart_C.getPoints(h);

		if(totPointsCatHT.containsKey(itemVenCat_C))
			totItemPointsBD = new java.math.BigDecimal((String)totPointsCatHT.get(itemVenCat_C));

		totItemPointsBD = totItemPointsBD.add(new java.math.BigDecimal(itemPoints_C));

		totPointsCatHT.put(itemVenCat_C,totItemPointsBD.toString());
	}

	String plantVal = "";//(String)session.getValue("PLANT");
	String profitCenter = (String)session.getValue("PROFITCENTER");
	String salesOffice = (String)session.getValue("CU_SALESOFFICE");
	String salesGroup = (String)session.getValue("CU_SALESGROUP");

	ArrayList multiOrders_A = new ArrayList();
	log4j.log("uProdOrderType======>"+uProdOrderType, "D");
 
	// BAPI Parameters
	EzBapiiteminTable iteminTablesim 	= new EzBapiiteminTable();
	EzBapiiteminTableRow aItemRowConfirm 	= null;
	EzBapiiteminTableRow aItemRowsim 	= null;
	EzBapiscondTable condTable 		= new EzBapiscondTable();
	EzBapiscondTableRow condTableRow 	= null;
	EzBapischdlTable deliveryScheduleTable 	= new EzBapischdlTable();
	EzBapischdlTableRow dSTableRow 		= null;
	EzBapistextTable ezctextTable 		= new EzBapistextTable();
	EzBapistextTableRow ezctextRow 		= null;
	EzBapischdlTable deliveryScheduleTableSim = new EzBapischdlTable();
	EzBapischdlTableRow dSTableSimRow 	= null;

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
	//EzBapisdheadStructure     orderHeaderConfirm 	= ioParamsConfirm.getOrderHeaderIn();
	EzBapisdheadTable	orderHeaderConfirm 	= ioParamsConfirm.getOrderHeaderTableIn();
	EzBapipartnrTable 	orderPartnersConfirm  	= ioParamsConfirm.getOrderPartners();
	EzBapiiteminTable 	iteminTableConfirm    	= ioParamsConfirm.getOrderItemsIn();

//**********************Setting  Header Values *****************************************/

	boolean miscHandVal = true;
	boolean freightVal = true;
	String incoTerms_O = "";

	//if("YY".equals(incoTerms) || "PCO".equals(incoTerms)) incoTerms_O = incoTerms;
	//if(!"".equals(carrierId) && !"".equals(billToName)) incoTerms_O = "YY";
	if(!"".equals(carrierId) && !"".equals(billToName))
	{
		incoTerms_O = "YY";
		custCondGrp3 = "NF";
	}
	else if(!"STD".equals(shipMethod) && !"".equals(shipMethod) && "".equals(carrierId) && "".equals(billToName))
	{
		incoTerms_O = "PCO";
		custCondGrp3 = "NF";
	}

	boolean delSchAllow = false;
	String delSchDate = "";
	try
	{
		String defaultdat = request.getParameter("expectedDel");
		String expEDDFlag = request.getParameter("expEDDFlag");

		if(defaultdat==null || "null".equalsIgnoreCase(defaultdat)) defaultdat = "";

		if(expEDDFlag!=null && "Y".equals(expEDDFlag))
		{
			Date dateNow = new Date ();
			SimpleDateFormat newDate = new SimpleDateFormat("MM/dd/yyyy");

			SimpleDateFormat currTime = new SimpleDateFormat("HH");
			currTime.setTimeZone(TimeZone.getTimeZone("America/New_York"));
			Date date = currTime.parse(currTime.format(dateNow));

			int dd = Integer.parseInt(currTime.format(date));
			String dateToIncr = newDate.format(dateNow);
			Calendar cal = Calendar.getInstance();

			cal.setTime(newDate.parse(dateToIncr));

			int incr = 1;

			if("UP1A".equals(shipMethod) || "UP1B".equals(shipMethod) || "UP1C".equals(shipMethod) ||
			   "FE1A".equals(shipMethod) || "FE1B".equals(shipMethod) || "FE1C".equals(shipMethod))
			{
				incr = 1;
			}
			else if("UP2B".equals(shipMethod) || "UP2C".equals(shipMethod) || "FE2B".equals(shipMethod) || "FE2C".equals(shipMethod))
			{
				incr = 2;
			}
			else if("UP3C".equals(shipMethod) || "FE3C".equals(shipMethod))
			{
				incr = 3;
			}

			if(dd < 11)
			{
				cal.add(Calendar.DAY_OF_MONTH, incr);
			}
			else
			{
				incr = incr+1;
				cal.add(Calendar.DAY_OF_MONTH, incr);
			}
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			//out.println("dayOfWeek  : " + dayOfWeek);

			if(dayOfWeek==1 || dayOfWeek==7)
				cal.add(Calendar.DAY_OF_MONTH, 2);

			String dt = newDate.format(cal.getTime());
			//out.println("New Date  : " + dt);

			defaultdat = newDate.format(cal.getTime());
		}
		if(!"".equals(defaultdat))
		{
			delSchAllow = true;
			delSchDate = defaultdat;
		}
	}
	catch(Exception e){}

for(int us=0;us<uProdOrderType.size();us++)
{
	String splitKey_A = (String)uProdOrderType.get(us);

	String ordType_S	= splitKey_A.split("¥")[0];
	String salesOrg_S	= splitKey_A.split("¥")[1];
	String division_S	= splitKey_A.split("¥")[2];
	String distChnl_S	= splitKey_A.split("¥")[3];

	String ord_T = ordType_S;//itemOrderType[j];
	if("OR".equals(ord_T)) ord_T = "TA";
	if("FD".equals(ord_T)) ord_T = "KL";

	sDocNumber = "";

	EzBapisdheadTableRow ordHeadRow = new EzBapisdheadTableRow();

	if(salesOffice!=null && !"null".equals(salesOffice) && !"".equals(salesOffice.trim()))
		ordHeadRow.setSalesOff(salesOffice.trim());
	if(salesGroup!=null && !"null".equals(salesGroup) && !"".equals(salesGroup.trim()))
		ordHeadRow.setSalesGrp(salesGroup.trim());

	ordHeadRow.setSplitKey(splitKey_A);
	ordHeadRow.setComplDlv(dlvChk);
	ordHeadRow.setDivision(division_S);
	ordHeadRow.setDistrChan(distChnl_S);
	ordHeadRow.setSalesOrg(salesOrg_S);
	ordHeadRow.setDocType(ord_T);
	//ordHeadRow.setDlvBlock("ZZ");  //"ZZ" in AF
	//ordHeadRow.setIncoterms1(incoTerms1);
	//ordHeadRow.setIncoterms2(incoTerms2);
	ordHeadRow.setLog("TRUE");

	/*if("Z1".equals(ord_T))
	{
		ordHeadRow.setDlvBlock("Z1");
		ordHeadRow.setShipCond("ZQ");
	}*/

	log4j.log("setIncoterms1  "+incoTerms1,"W");
	log4j.log("setIncoterms2  "+incoTerms2,"W");

	if(!(" ".equals(shippingCond)|| "null".equals(shippingCond)))
	{
		//ordHeadRow.setShipCond(shippingCond); 
	}
	//ordHeadRow.setShipCond(incoTerms_O);
	ordHeadRow.setIncoterms1(incoTerms_O);
	if("PCO".equals(incoTerms_O))
	{
		ordHeadRow.setIncoterms2("Ppd & Charge");
	}
	if("NF".equals(custCondGrp3))
		ordHeadRow.setCustCondGroup3(custCondGrp3);

	custGrp5 = "";	// This is applicable only for sales org 1001 when order type OR and other than best way is selected
	if(shipMethod!=null && !"STD".equals(shipMethod) && "TA".equals(ord_T) && "1001".equals(salesOrg_S))
		custGrp5 = "EVE";

	if("EVE".equals(custGrp5))
		ordHeadRow.setCustGrp5(custGrp5);

	if("YES".equals(isResidential))
	{
		ordHeadRow.setShippingType("Y");
	}

	if(reasonCode!=null && !"null".equalsIgnoreCase(reasonCode) && !"".equals(reasonCode))
		ordHeadRow.setOrdReason(reasonCode);

	ordHeadRow.setPmnttrms(paymentterms);
	ordHeadRow.setPurchNo(poNumber);
	ordHeadRow.setAgentCode((String)session.getValue("SAPPRDCODE"));
	ordHeadRow.setPromoCode(promoCode);
	ordHeadRow.setCreatedBy(user_L);//This value is set to PP_SEARCH  field in create BAPI. This value is stored in a Z table in SAP

	log4j.log("setPmnttrms  "+paymentterms,"W");
	//log4j.log("setPurchNo  "+setSalVal.getPoNo(),"W");
	log4j.log("setAgentCode  "+(String)session.getValue("SAPPRDCODE"),"W");

	try
	{
		int mn = Integer.parseInt(poDate.substring(0,2));
		int dt = Integer.parseInt(poDate.substring(3,5));
		int yr = Integer.parseInt(poDate.substring(6,10));
		java.util.GregorianCalendar reqDatePO = new java.util.GregorianCalendar(yr,mn-1,dt);

		ordHeadRow.setPurchDate(reqDatePO.getTime());

		log4j.log("setPurchDate  "+reqDatePO,"W");
	}
	catch(Exception e){}

	if((curr!=null) && (curr.trim().length()!=0))
	{
		ordHeadRow.setCurrency(curr);
		log4j.log("setCurrency  "+curr,"W");
	}

	try
	{
		if("Y".equals(eddFlag))
		{
			int yearReq1 = Integer.parseInt(delSchDate.substring(6,10));
			int dateReq1 = Integer.parseInt(delSchDate.substring(3,5));
			int monthReq1 = Integer.parseInt(delSchDate.substring(0,2));

			java.util.GregorianCalendar reqDat = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);

			ordHeadRow.setReqDateH(reqDat.getTime());
			log4j.log("setReqDateH  "+reqDat,"W");
		}
	}
	catch(Exception e)
	{
		//ordHeadRow.setReqDateH(reqDate1);
		//log4j.log("setReqDateH  "+reqDate1,"W");
	}
//*******************Finished setting headervalues**************************************

//*************************SettingPartners**********************************************
	if(soldToCode!=null)
	{
		log4j.log("soldToCode in SAP creation call::::"+soldToCode,"I");

		EzBapipartnrTableRow aRowSold = new EzBapipartnrTableRow();

		aRowSold.setSplitKey(splitKey_A);
		aRowSold.setPartnRole("AG");
		aRowSold.setPartnNumb(soldToCode);

		/* MB for Issue reported by Amstan that sold to data passed in incomplete
		if("YES".equals(dropShipTo))
		{
			aRowSold.setFirstTelephoneNo(soldToPhNum);
			aRowSold.setName1(soldToName);
			aRowSold.setHouseNumberAndStreet(soldToStreet);
			aRowSold.setPostalCode(soldToZipCode);
			aRowSold.setCity(soldToCity);
			aRowSold.setRegion(soldToState);
			aRowSold.setCountrykey(soldToCountry);
		}
		END OF CHANGE BY MB */
		orderPartnersConfirm.appendRow(aRowSold);

		log4j.log("soldToCode in SAP creation call2::::"+aRowSold.getPartnNumb(),"I");

		EzBapipartnrTableRow aRowShip = new EzBapipartnrTableRow();

		aRowShip.setSplitKey(splitKey_A);
		aRowShip.setPartnRole("WE");
		aRowShip.setPartnNumb(shipToCode);

		if("YES".equals(dropShipTo))
		{
			if(shipToZipCode!=null && !"".equals(shipToZipCode)) shipToZipCode = shipToZipCode.trim();

			aRowShip.setHouseNumberAndStreet(shipToStreet);
			aRowShip.setPostalCode(shipToZipCode);
			aRowShip.setCity(shipToCity);
			aRowShip.setRegion(shipToState);
			aRowShip.setName1(shipToName);
			aRowShip.setCountrykey(shipToCountry);
			
			aRowShip.setTransportationZone(shipToTransZone);
			aRowShip.setTelexNumber(shipToPhNum);
		}

		orderPartnersConfirm.appendRow(aRowShip);
	}

	if(shipMethod!=null && !(shipMethod.equals("STD")) && !"".equals(shipMethod))
	{
		EzBapipartnrTableRow aRowCarr = new EzBapipartnrTableRow();

		aRowCarr.setSplitKey(splitKey_A);
		aRowCarr.setPartnRole(shipPartnRole);
		aRowCarr.setPartnNumb(shipMethod);

		if("ZF".equals(shipPartnRole))
		{
			if(billToZipCode!=null && !"".equals(billToZipCode)) billToZipCode = billToZipCode.trim();

			aRowCarr.setHouseNumberAndStreet(billToStreet);
			aRowCarr.setPostalCode(billToZipCode);
			aRowCarr.setCity(billToCity);
			aRowCarr.setRegion(billToState);
			aRowCarr.setName1(billToName);
			aRowCarr.setName2(carrierId);
			aRowCarr.setCountrykey(billToCountry);
		}

		orderPartnersConfirm.appendRow(aRowCarr);
	}

	if(!"ZC".equals(shipPartnRole) && !"ZF".equals(shipPartnRole) && !"FD".equals(docType)) billToAddress = "None";
	//billToAddress.replaceAll(",",",\n");

	log4j.log("Finished setting  Partner values","I");

//*************************Finished setting  Partner values******************************

	generalNotes1 = generalNotes1.trim();
	generalNotes2 = generalNotes2.trim();

//************************* Header Info start *********************************/
	
	Date dateNow = new Date ();
	DateFormat dformat = new SimpleDateFormat("MM/dd/yyyy hh:mm a");
	dformat.setTimeZone(TimeZone.getTimeZone("America/New_York"));
	String curDate = dformat.format(dateNow);

	DateFormat dformat1 = new SimpleDateFormat("MM/dd/yyyy");
	dformat1.setTimeZone(TimeZone.getTimeZone("America/New_York"));
	String compDelDate = dformat1.format(dateNow);
	
	String shipComp		= "";
	String usrTyp		= "";
	String delSelectd	= "";
	String userFN = (String)session.getValue("FIRSTNAME");
	String userLN = (String)session.getValue("LASTNAME");

	if("Y".equals(eddFlag))
		delSelectd = "YES "+headerReqDate;
	else
		delSelectd = "NO";

	if("Y".equalsIgnoreCase(shipComplete))
		shipComp = "YES";
	else
		shipComp = "NO";		

	if("NOSEL".equals(isResidential) || "NO".equals(isResidential))
		isResidential = "NO";
	else if("YES".equals(isResidential))
		isResidential = "YES";
	
	if("2".equals(UserType))
		usrTyp = "ASB";
		
	if("3".equals(UserType))
	{
		if("Y".equals((String)session.getValue("REPAGENCY")))
		{
			usrTyp = "REP";
		}
		else
		{
			usrTyp = "CU";
		}
	}
	
	String orderInfo	= "BP User: "+userFN+" "+userLN+"/"+user_L+"/"+usrTyp+"\n"+"Date time: "+curDate+"\n"+"Delivery date selected: "+delSelectd+"\n"+"Deliver together selected: "+shipComp+"\n"+"Shipping Method selected: "+shipMethod+"\n"+"Lift Gate Selected: "+isResidential;

//************************Header Info End **************************************/

	String shipMethod_Desc = (String)shipMethodHM.get(shipMethod);
	String genNoteBillToAdd = generalNotes2;
	if("null".equals(shipMethod_Desc))shipMethod_Desc="";

	if("STD".equals(shipMethod))
	{
		if(!"None".equals(billToAddress) && !"".equals(billToAddress))
			genNoteBillToAdd = generalNotes2;
	}
	else
	{
		genNoteBillToAdd = "Customer Selected Carrier: "+shipMethod+" / "+shipMethod_Desc+"\n"+"\n"+generalNotes2+"\n"+"Customer Provided Billing Instructions:"+"\n"+billToAddress;
	}
	
	String[] notesAll = new String[]{billToAddress,generalNotes1,genNoteBillToAdd,orderInfo};	//specialShIns 0012
	String notesHId[] = new String[]{"ZPH1","0004","Z004","ZPH2"};
	EzStringTokenizer notesAllSt=null;
	int notesAllCt=0;
	String chkLin="";
	int strLength=0;
	int len=0;
	int rem=0;
	String cutLen = "";
	for(int i=0;i<notesAll.length;i++)
	{
		if(!"None".equals(notesAll[i]) && !"".equals(notesAll[i]))
		{
			if ( i==99) { // billToAddress
			notesAllSt = new EzStringTokenizer(notesAll[i],",");
			} else {
			notesAllSt = new EzStringTokenizer(notesAll[i],"\n");
			}
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
						ezctextRow.setSplitKey(splitKey_A);
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
						ezctextRow.setSplitKey(splitKey_A);
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
					ezctextRow.setSplitKey(splitKey_A);
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
							ezctextRow.setSplitKey(splitKey_A);
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
							ezctextRow.setSplitKey(splitKey_A);
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
						ezctextRow.setSplitKey(splitKey_A);
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
	String itemLineNo = "";
	String dummyLineNo = "";
	String itemClass = "";

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


	String quoteNum = "";
	String kitComp_A = "";
	boolean quoteRef_I = false;

	String qsFlag_A = "";
	String qsItem_A = "";
	boolean quickShip_I = false;
	boolean quickShip_J = false;

	log4j.log("prodCodeLengthprodCodeLength"+prodCodeLength,"I");
	

	java.math.BigDecimal itemPointsBD = new java.math.BigDecimal("0");

	Hashtable pointsCatHT = new Hashtable();
	ArrayList itemCat_A = new ArrayList();

	for(int j=0;j<prodCodeLength;j++)
	{
		if(splitKey[j].equals(splitKey_A))
		{
		OrderQuantity 	= prodCQty_1[j];
		itemUom		= prodPack_1[j];
		custProd        = custprodCode[j];
		OrderQuantity 	= (OrderQuantity==null|| "".equals(OrderQuantity.trim()) || "null".equals(OrderQuantity) )?"0":OrderQuantity.trim();
		itemCat 	= prodItemCat_1[j];
		itemLineNo	= splitItemNo_1[j];
		String lNo	= itemLineItem[j];

		String stdMulti_A = request.getParameter("stdMulti_"+lNo);
		String netPrice_A = request.getParameter("netPrice_"+lNo);
		String stdMultiChng = request.getParameter("stdMultiChng_"+lNo);
		String netPriceChng = request.getParameter("netPriceChng_"+lNo);
		String itemFlag = request.getParameter("itemFlag_"+lNo);

log4j.log("stdMulti_AstdMulti_A::::::>>>"+stdMulti_A,"I");
log4j.log("netPrice_AnetPrice_A::::::"+netPrice_A,"I");
log4j.log("stdMultiChngstdMultiChng::::::"+stdMultiChng,"I");
log4j.log("netPriceChngnetPriceChng::::::"+netPriceChng,"I");
log4j.log("itemFlagitemFlag::::::"+itemFlag,"I");

		if(!OrderQuantity.equals("0") && !"TANN".equals(itemCat))
		{
			bOrderQty  = new  java.math.BigDecimal(OrderQuantity);
			bOrderQty  = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
			//line 	   = new java.math.BigInteger(String.valueOf(lineno*10));
			line 	   = new java.math.BigInteger(String.valueOf(itemLineNo));
			ordqty 	   = new java.math.BigDecimal(OrderQuantity);
			ordqty     = ordqty .multiply(new java.math.BigDecimal(Integer.toString(1000)));

			qsFlag_A   = ((qsFlag[j]==null)||(("").equals(qsFlag[j])))?"":qsFlag[j];
			qsItem_A   = ((itemCnetProd[j]==null)||(("").equals(itemCnetProd[j])))?"":itemCnetProd[j];
			itemClass  = ((itemClass_1[j]==null)||(("").equals(itemClass_1[j])))?"":itemClass_1[j];

			if(("Y".equals(qsFlag_A) || "F".equals(qsFlag_A)) && "QS".equals(qsItem_A))
			{
				quickShip_J = true;

				if(!("LUX".equals(itemClass) || "COM".equals(itemClass)))
					quickShip_I = true;
			}

			plantVal = "";
			if("F".equals(qsFlag_A) && "LUX".equals(itemClass))
				plantVal = "15";

			quoteNum = quoteNum_1[j];
			if(quoteNum==null || "null".equalsIgnoreCase(quoteNum) || "N/A".equals(quoteNum)) quoteNum = "";

			kitComp_A = kitComp_1[j];
			if(kitComp_A==null || "null".equalsIgnoreCase(kitComp_A) || "".equals(kitComp_A)) kitComp_A = "0";

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

			/*if(itemPlant[j]==null || "null".equalsIgnoreCase(itemPlant[j]) || "N/A".equals(itemPlant[j]))
			{
				plantVal = "";
				log4j.log("Check33333333::::::","I");
			}	
			else
				plantVal = itemPlant[j];*/
				
			log4j.log("plantVal::::::"+plantVal,"I");	

//******************************setting  items*********************************************

			aItemRowConfirm = new EzBapiiteminTableRow();
			aItemRowsim = new EzBapiiteminTableRow();

			aItemRowConfirm.setSplitKey(splitKey_A);
			aItemRowConfirm.setItmNumber(line);
			if (!itemCustSku[j].equals("N/A"))
				aItemRowConfirm.setCustMat(itemCustSku[j]);	//custprodCode[j]
			aItemRowConfirm.setMaterial(prodCode_1[j]);
			//aItemRowConfirm.setShortText(prodDesc_1[j]);
			aItemRowConfirm.setSalesUnit(itemUom);
			aItemRowConfirm.setBillDate(fromDate.getTime()); // current Date as Bill Date
			aItemRowConfirm.setProfitCenter(profitCenter);
			aItemRowConfirm.setShipTo(shipToCode);
			aItemRowConfirm.setSysKey(sysKey);
			aItemRowConfirm.setSalesOrg("");		//SalesOrg
			aItemRowConfirm.setDistributionChanel(""); 	//DC
			aItemRowConfirm.setDivision("");		//Div
			aItemRowConfirm.setPlant(plantVal);				//plantVal
			//aItemRowConfirm.setDocType(docType);
			aItemRowConfirm.setDocType("");
			aItemRowConfirm.setRefDoc(quoteNum);
			aItemRowConfirm.setRefDocIt(lineNum_B);
			aItemRowConfirm.setRefDocCa("B");
			if (!itemPoLine[j].equals("N/A"))
				aItemRowConfirm.setCustPOLineNO(itemPoLine[j]);

			log4j.log("setItmNumber  "+line,"W");
			log4j.log("setCustMat  "+itemCustSku[j],"W");
			log4j.log("setMaterial  "+prodCode_1[j],"W");
			log4j.log("setShortText  "+prodDesc_1[j],"W");
			log4j.log("setSalesUnit  "+itemUom,"W");
			log4j.log("setBillDate  "+fromDate,"W");

			aItemRowsim.setSplitKey(splitKey_A);
			aItemRowsim.setItmNumber(line);
			aItemRowsim.setMaterial(prodCode_1[j]);
			aItemRowsim.setCustMat(itemCustSku[j]);		//custprodCode[j]
			aItemRowsim.setEanUpc(itemEanUPC[j]);
			aItemRowsim.setMatExt(itemMfrPart[j]);
			aItemRowsim.setMatlGroup(itemMfrNr[j]);
			aItemRowsim.setBatch(itemMatId[j]);			
			aItemRowsim.setSalesUnit(itemUom);
			aItemRowsim.setBillDate(fromDate.getTime()); // current Date as Bill Date
			aItemRowsim.setShipTo(shipToCode);	//setSalVal.getShipTo()
			aItemRowsim.setSysKey(sysKey);	
			aItemRowsim.setSalesOrg("");			//SalesOrg
			aItemRowsim.setDistributionChanel("");		//DC
			aItemRowsim.setDivision("");			//Div
			aItemRowsim.setPlant(plantVal);	 	//plantVal - This has to be set with material group based material code
			//aItemRowsim.setDocType(docType);
			aItemRowsim.setDocType("");
			aItemRowsim.setRefDoc(quoteNum);
			aItemRowsim.setRefDocIt(lineNum_B);
			aItemRowsim.setCustPOLineNO(itemPoLine[j]);

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
					if("0".equals(kitComp_A))
					{
						soCondType = "ZJOB";

						condTableRow =new EzBapiscondTableRow();
						condTableRow.setSplitKey(splitKey_A);
						condTableRow.setItmNumber(line);
						condTableRow.setCondType(soCondType);   //"PR00"
						condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice[j])/10));
						condTable.appendRow(condTableRow);
					}
					if(!"0".equals(kitComp_A))
						quoteRef_I = true;
				}
				else
				{
					String soCondVal = "";
					soCondType = "";

					if(stdMultiChng!=null && "Y".equals(stdMultiChng))
					{
						if(stdMulti_A!=null && !"N/A".equals(stdMulti_A) && !"0".equals(stdMulti_A))
						{
							/*(if(itemFlag!=null && ("DISP".equals(itemFlag) || "VIP".equals(itemFlag)))
								soCondType = "Z706";//ZMPM
							else
								soCondType = "ZMPM";*/

							if("ZDPO".equals(ord_T) || "ZIDP".equals(ord_T))
							{
								if("1001".equals(salesOrg_S))
								{
									if("40".equals(distChnl_S))
										soCondType = "ZMUL";	//Per lisa, ZMUL is linked to ZUSM on UI user see ZMUL
									else
										soCondType = "ZUVP";
								}
								else if("1002".equals(salesOrg_S))
								{
									if("40".equals(distChnl_S))
										soCondType = "ZSTD";
									else
										soCondType = "Z706";
								}
								else if("1004".equals(salesOrg_S))
									soCondType = "ZMPM";

								soCondVal = stdMulti_A;

								log4j.log("soCondTypesoCondType::::::"+soCondType,"I");
								log4j.log("soCondValsoCondVal::::::"+soCondVal,"I");

								try
								{
									condTableRow =new EzBapiscondTableRow();
									condTableRow.setSplitKey(splitKey_A);
									condTableRow.setItmNumber(line);
									condTableRow.setCondType(soCondType);
									condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(soCondVal)*100));
									condTable.appendRow(condTableRow);
								}
								catch(Exception err){}
							}
						}
					}
					else
					{
					if(netPriceChng!=null && "Y".equals(netPriceChng))
					{
						if(netPrice_A!=null && !"N/A".equals(netPrice_A) && !"0".equals(netPrice_A))
						{
							/*if("1002".equals(salesOrg_S))
								soCondType = "ZMPR";
							else
								soCondType = "ZUMP";*/

							if("ZDPO".equals(ord_T) || "ZIDP".equals(ord_T))
							{
								if("1001".equals(salesOrg_S))
									soCondType = "ZUMP";
								else if("1002".equals(salesOrg_S))
									soCondType = "ZMPR";
								else if("1004".equals(salesOrg_S))
									soCondType = "ZMPR";

								soCondVal = netPrice_A;

								log4j.log("soCondTypesoCondType::::::"+soCondType,"I");
								log4j.log("soCondValsoCondVal::::::"+soCondVal,"I");

								try
								{
									condTableRow =new EzBapiscondTableRow();
									condTableRow.setSplitKey(splitKey_A);
									condTableRow.setItmNumber(line);
									condTableRow.setCondType(soCondType);
									condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(soCondVal)/10));
									condTable.appendRow(condTableRow);
								}
								catch(Exception err){}
							}
						}
					}
					}
				}
				if(miscSplitKey!=null && splitKey_A.equals(miscSplitKey) && miscHandVal)
				{
					if(miscHandFee!=null && !"null".equalsIgnoreCase(miscHandFee) && !"".equals(miscHandFee) && !"0".equals(miscHandFee))
					{
						try
						{
							condTableRow =new EzBapiscondTableRow();
							condTableRow.setSplitKey(splitKey_A);
							//condTableRow.setItmNumber(line);
							condTableRow.setCondType("ZMSC");
							condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(miscHandFee)/10));
							condTable.appendRow(condTableRow);
							miscHandVal = false;
						}
						catch(Exception e){}
					}
				}
				if(freightVal)
				{
					if(freightTotal!=null && !"null".equalsIgnoreCase(freightTotal) && !"".equals(freightTotal) && !"0".equals(freightTotal))
					{
						try
						{
							condTableRow =new EzBapiscondTableRow();
							condTableRow.setSplitKey(splitKey_A);
							//condTableRow.setItmNumber(line);
							condTableRow.setCondType("HD00");
							condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(freightTotal)/10));
							condTable.appendRow(condTableRow);
							freightVal = false;
						}
						catch(Exception e){}
					}
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
						if(delSchAllow)
						{
							schdat = delSchDate;
							yearReq1  = Integer.parseInt(schdat.substring(6,10));
							dateReq1  = Integer.parseInt(schdat.substring(3,5));
							monthReq1 = Integer.parseInt(schdat.substring(0,2));
							reqDatesch = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);
							dSTableRow.setReqDate(reqDatesch.getTime());
						}
						else
						{
							yearReq1  = Integer.parseInt(schdat.substring(6,10));
							dateReq1  = Integer.parseInt(schdat.substring(3,5));
							monthReq1 = Integer.parseInt(schdat.substring(0,2));
							reqDatesch = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);
						}

						dSTableRow.setReqQty(new java.math.BigDecimal(dreqqty) );

						dSTableSimRow.setReqQty(new java.math.BigDecimal(dreqqty) );
						dSTableSimRow.setReqDate(reqDatesch.getTime());

						log4j.log("setReqQty  "+dreqqty,"W");
						log4j.log("setReqDate  "+schdat,"W");
					}
					catch(Exception e){}

					dSTableRow.setSplitKey(splitKey_A);
					dSTableRow.setItmNumber(line);
					dSTableRow.setShortText(String.valueOf(dschline));

					dSTableSimRow.setSplitKey(splitKey_A);
					dSTableSimRow.setItmNumber(line);
					dSTableSimRow.setShortText(String.valueOf(dschline));

					log4j.log("setItmNumber  "+line,"W");
					log4j.log("setShortText  "+dschline,"W");
					
					//dSTableRow.setDlvBlock("ZZ"); //"ZZ" in AF
					deliveryScheduleTable.appendRow(dSTableRow);
					//deliveryScheduleTableSim.appendRow(dSTableSimRow);
					dschline++;
				}
			}
			//lineno++;
			try
			{
				dummyLineNo = Integer.parseInt(kitComp_A)+Integer.parseInt(itemLineNo)+"";
			}
			catch(Exception e)
			{
				dummyLineNo = itemLineNo;
			}

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
		
		//String catPoints = (String)session.getValue(itemCatSel);
		String catPoints = (String)totPointsCatHT.get(itemCatSel);
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
				int cp_1000 = catPointsBD.compareTo(new java.math.BigDecimal("999"));
				int cp_300 = catPointsBD.compareTo(new java.math.BigDecimal("299"));

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
					dschQty = "1";
				}
			}
			else
			{
				int cp_180 = catPointsBD.compareTo(new java.math.BigDecimal("179"));
				int cp_90 = catPointsBD.compareTo(new java.math.BigDecimal("89"));
				int cp_48 = catPointsBD.compareTo(new java.math.BigDecimal("47"));

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
					//line 	   = new java.math.BigInteger(String.valueOf(lineno*10));
					line 	   = (new java.math.BigInteger(dummyLineNo)).add(new java.math.BigInteger(String.valueOf(lineno*10)));//itemLineNo

					aItemRowConfirm = new EzBapiiteminTableRow();
					aItemRowsim = new EzBapiiteminTableRow();

					aItemRowConfirm.setSplitKey(splitKey_A);
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

					aItemRowsim.setSplitKey(splitKey_A);
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

					dSTableRow.setSplitKey(splitKey_A);
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

	if(quoteRef_I)
	{
		ordHeadRow.setLogicSwitch("G");
		//ordHeadRow.setExt1("X");
		//ordHeadRow.setRefDoc(quoteNum);
		//ordHeadRow.setRefDocCa("B");
		log4j.log("LogicSwitch::"+ordHeadRow.getLogicSwitch(),"I");
	}
	if(quickShip_I)
	{
		//ordHeadRow.setDlvBlock("Z1");	//Commented as per Sam's request on 8th Jan'14. Quick Ship Orders should not be on Delivery Block.
	}
	if(quickShip_J)
	{
		ordHeadRow.setShipCond("ZQ");
	}
	orderHeaderConfirm.appendRow(ordHeadRow);

	//************************* Finished Setting Items *****************************************
}

	try
	{
		EzcSalesOrderParams  ezcSalesOrderParamsSim = new EzcSalesOrderParams();
        	EziSalesOrderCreateParams escpSim = new EziSalesOrderCreateParams();
        	escpSim.setCreditChkFlag("Y");
        	ezcSalesOrderParamsSim.setObject(escpSim);
		escpSim.setOrderHeaderTableIn(orderHeaderConfirm);
		escpSim.setOrderPartners(orderPartnersConfirm);
		escpSim.setOrderItemsIn(iteminTablesim);
		escpSim.setOrderDelSchedule(deliveryScheduleTableSim);
		escpSim.setType("SPLIT"); // if this is set to bulk or RBPG(if RBPG plant has tobe set material group),for every sales area one sap order is simulated
        	Session.prepareParams(ezcSalesOrderParamsSim);
        	long start = System.currentTimeMillis();
        	log4j.log("Simulate Sales Order At Creation Start>>>"+poNumber,"F");
		EzoSalesOrderCreate  ioParamsSim = (EzoSalesOrderCreate)EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParamsSim);
		log4j.log("Simulate Sales Order At Creation End>>>"+poNumber,"F");
		long finish = System.currentTimeMillis();
		log4j.log("Simulate Sales Order At Creation>>>"+(finish-start)/1000,"F");
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
			escpSave.setOrderHeaderTableIn(orderHeaderConfirm);
			escpSave.setOrderPartners(orderPartnersConfirm);
			escpSave.setOrderItemsIn(iteminTableConfirm);
			escpSave.setOrderDelSchedule(deliveryScheduleTable);
			escpSave.setOrderText(ezctextTable);
			escpSave.setOrderConditions(condTable); 
			escpSave.setType("SPLIT");  	//if this is set to bulk or RBPG(if RBPG plant has to be set material group),for every sales area one sap order is simulated
			Session.prepareParams(ezcSalesOrderParamsSave);
			log4j.log("iteminTableConfirmiteminTableConfirm======>"+iteminTableConfirm.getRowCount(), "D");
			long start1 = System.currentTimeMillis();
			log4j.log("Create Sales Order Start>>>"+poNumber,"F");
			EzoSalesOrderCreate ioParamsSave = (EzoSalesOrderCreate)EzSalesOrderManager.ezCreateWebSalesOrder(ezcSalesOrderParamsSave);
			log4j.log("Create Sales Order End>>>"+poNumber,"F");
			long finish1 = System.currentTimeMillis();
			log4j.log("Create Sales Order >>>"+(finish1-start1)/1000,"F");
			orderError = ioParamsSave.getReturn();
			//orders =(ReturnObjFromRetrieve) ioParamsSave.getObject("SalesOrders");
			orders = (ReturnObjFromRetrieve) ioParamsSave.getOrderHeaderIn();
			ordItems = (ReturnObjFromRetrieve) ioParamsSave.getOrderItemsIn();
			int orderErrorCount = orderError.getRowCount();

			log4j.log("orderErrorCount======>"+orderErrorCount, "D");
			log4j.log("orderError======>"+orderError.toEzcString(), "D");
			log4j.log("ordersordersorders======>"+orders.toEzcString(), "D");
			log4j.log("ordItemsordItems======>"+ordItems.toEzcString(), "D");

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
				s =orders.getFieldValueString(ord,"DocNumber");
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

log4j.log("SAPnumberSAPnumberSAPnumberSAPnumber======>After Creation"+SAPnumber, "D");
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