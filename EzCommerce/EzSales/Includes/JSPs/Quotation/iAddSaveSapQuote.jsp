<%@ page import="java.util.*,ezc.ezutil.FormatDate"%>
<%
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	String defPartnNum =UtilManager.getUserDefErpSoldTo();
	ReturnObjFromRetrieve drlRet = null;
	String SalesAreaCode=(String)session.getValue("SalesAreaCode");
	String curr = request.getParameter("currency");
	String poDate = setSalVal.getPoDate();
	String salesOffice = (String)session.getValue("CU_SALESOFFICE");
	String salesGroup = (String)session.getValue("CU_SALESGROUP");
	
	String profitCenter = (String)session.getValue("PROFITCENTER");
	String quoteCondType = (String)session.getValue("QUOTECONDTYPE");

	// Date Format Object
	java.util.GregorianCalendar fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();
	GregorianCalendar calendar1 = new GregorianCalendar();
	calendar1.setTime(fromDate.getTime());
	calendar1.add(Calendar.DATE,5);
	Date fromDate1 =calendar1.getTime();
	
	java.math.BigDecimal bOrderQty = null;
	int lineno = 1;
	String OrderQuantity="";
	String uom="";
	java.math.BigInteger line=null;
	java.math.BigDecimal ordqty=null;

	int dateReq = 0;
	int monthReq = 0;
	int yearReq = 0;
	java.util.GregorianCalendar reqDate2 = null;

	EzBapiiteminTable ezcIteminTable 	= new EzBapiiteminTable();
	EzBapiiteminTableRow ezcIteminRow 	= null;
	EzBapipartnrTable ezcPartnrTable 	= new EzBapipartnrTable();
	EzBapipartnrTableRow ezcPartnrRow 	= null;
	EzBapiscondTable ezccondtable 		= new EzBapiscondTable();
	EzBapiscondTableRow ezccondRow 		= null;
	EzBapischdlTable ezcschdlTable 		= new EzBapischdlTable();
	EzBapischdlTableRow ezcschdlRow		= null;
	EzBapistextTable ezctextTable 		= new EzBapistextTable();
	EzBapistextTableRow ezctextRow 		= null;

	EzBapisdheadStructure ezcSdheadStructure = new EzBapisdheadStructure();

	ezcSdheadStructure.setDocType("AG");
	ezcSdheadStructure.setPurchNo("");	//setSalVal.getPoNo()
	
	ezcSdheadStructure.setQtValidF(fromQTDate.getTime());
	ezcSdheadStructure.setQtValidT(toQTDate.getTime());
	log4j.log("SalesOrgSalesOrg  "+SalesOrg,"W");
	log4j.log("DCDCDCDCDCDCDCDC  "+DC,"W");
	log4j.log("DivDivDivDivDiv  "+Div,"W");
	
	ezcSdheadStructure.setSalesOrg(SalesOrg);
	ezcSdheadStructure.setDistrChan(DC);
	ezcSdheadStructure.setDivision(Div);

	ezcSdheadStructure.setShippingType(shipType);
	//ezcSdheadStructure.setShipCond(shipType); 
	//ezcSdheadStructure.setPmnttrms(paymentTerm);
	if(salesOffice!=null && !"null".equals(salesOffice) && !"".equals(salesOffice.trim()))
		ezcSdheadStructure.setSalesOff(salesOffice.trim());
	if(salesGroup!=null && !"null".equals(salesGroup) && !"".equals(salesGroup.trim()))
		ezcSdheadStructure.setSalesGrp(salesGroup.trim());


	try
	{
		int mn = Integer.parseInt(poDate.substring(0,2));
		int dt = Integer.parseInt(poDate.substring(3,5));
		int yr = Integer.parseInt(poDate.substring(6,10));
		java.util.GregorianCalendar reqDatePO = new java.util.GregorianCalendar(yr,mn-1,dt);
		ezcSdheadStructure.setPurchDate(reqDatePO.getTime());
		log4j.log("reqDatePO  "+reqDatePO,"W");
	}catch(Exception e){}

	try
	{
		int yearReq1 = Integer.parseInt(headerReqDate.substring(6,10));
		int dateReq1 = Integer.parseInt(headerReqDate.substring(3,5));
		int monthReq1 = Integer.parseInt(headerReqDate.substring(0,2));
		java.util.GregorianCalendar reqDat = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);
		ezcSdheadStructure.setReqDateH(reqDat.getTime());
		log4j.log("reqDatreqDatreqDat  "+reqDat,"W");
	}
	catch(Exception e)
	{
		ezcSdheadStructure.setReqDateH(fromDate1);
	}
	
	int dschline = 0;

	String schdat = "";
	java.util.GregorianCalendar reqDatesch = null;
	int yearReq1 = 0;
	int monthReq1 = 0;
	int dateReq1 = 0;	

	for(int j=0;j <prodCodeLength;j++)
	{
		plant 		= "BP01";
		OrderQuantity 	= prodCQty_1[j];
		uom 		= prodPack_1[j];
		custProd        = custprodCode[j];
		
		log4j.log("custProdcustProdcustProdcustProd  "+custprodCode[j],"W");
		log4j.log("prodCode_1[j]>>>>>>>>...  "+prodCode_1[j],"W");
		
		OrderQuantity 	= (OrderQuantity==null|| "".equals(OrderQuantity.trim()) || "null".equals(OrderQuantity) )?"0":OrderQuantity.trim();
		
		if(!OrderQuantity.equals("0"))
		{		
			bOrderQty  = new  java.math.BigDecimal(OrderQuantity);
			bOrderQty  = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
			line 	   = new java.math.BigInteger(String.valueOf(lineno*10));			
			ordqty 	   = new java.math.BigDecimal(OrderQuantity);
			ordqty     = ordqty .multiply(new java.math.BigDecimal(Integer.toString(1000)));

			ezcIteminRow = new EzBapiiteminTableRow();
			
			//ezcIteminRow.setBillDate(fromDate.getTime());
			ezcIteminRow.setItmNumber(line);
			ezcIteminRow.setMaterial(prodCode_1[j]);
			ezcIteminRow.setShortText(prodDesc_1[j]);
			ezcIteminRow.setProfitCenter(profitCenter);	//"HQ6000"
			log4j.log("linelineline  "+line,"W");
			log4j.log("prodDesc_1prodDesc_1  "+prodDesc_1[j],"W");
			
			//ezcIteminRow.setSalesUnit(uom);
			//ezcIteminRow.setPlant(plant);
			ezcIteminRow.setCustMat(custprodCode[j]);
			
			ezcIteminTable.appendRow(ezcIteminRow);
			
	                log4j.log("setShipTo>>>>>>>>>>...  "+setSalVal.getShipTo(),"W");
	                
			try{
				ezccondRow = new EzBapiscondTableRow();
				
				ezccondRow.setItmNumber(line);
				ezccondRow.setCondType(quoteCondType);	//"PR00"
				ezccondRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice[j])/10));
				//ezccondRow.setCurrency();
				//ezccondRow.setCondUnit();
				
				ezccondtable.appendRow(ezccondRow);
				
			}catch(Exception err){}
			
			dschline = 1;

			ezcschdlRow = new EzBapischdlTableRow();

			schdat = request.getParameter("DesiredDate_"+j);
			
			try
			{
				yearReq1  = Integer.parseInt(schdat.substring(6,10));
				dateReq1  = Integer.parseInt(schdat.substring(3,5));
				monthReq1 = Integer.parseInt(schdat.substring(0,2));
				reqDatesch = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);

				ezcschdlRow.setReqQty(new java.math.BigDecimal(OrderQuantity));
				ezcschdlRow.setReqDate(reqDatesch.getTime());

				log4j.log("OrderQuantity>>>>>>>>>>..."+OrderQuantity,"I");
				log4j.log("reqDatesch>>>>>>>>>>..."+reqDatesch,"I");

			}catch(Exception e){}

			ezcschdlRow.setItmNumber(line);
			ezcschdlRow.setShortText(String.valueOf(dschline));
			//ezcschdlRow.setDlvBlock();


			ezcschdlTable.appendRow(ezcschdlRow);
			dschline++;

			lineno++;
		}
  	}
	
	if(PartnNum!=null)
	{
		
		String agentCode	=(String)session.getValue("AgentCode");
		String tpZone ="";
		String jurisdiction ="";
		
		log4j.log("agentCodeagentCodeagentCodeagentCodeagentCodeagentCode"+agentCode,"I");

		//For Ship To
		ReturnObjFromRetrieve  listShipTos = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(agentCode);

               log4j.log("listShipToslistShipTos","I");
               
		if(listShipTos!=null && listShipTos.getRowCount()>0)
		{

			EzBapipartnrTableRow aRow2 = new EzBapipartnrTableRow();
			aRow2.setPartnRole("WE"); //"WE" for shipto
			aRow2.setPartnNumb(PartnNum);
			aRow2.setName1(listShipTos.getFieldValueString(0,"ECA_NAME"));
			aRow2.setFirstTelephoneNo(listShipTos.getFieldValueString(0,"ECA_PHONE"));
			if(streetName!=null)
			{
				if(floorNo==null || "null".equals(floorNo)) floorNo = "";
				if(buildingName==null || "null".equals(buildingName)) buildingName = "";
				
				//aRow2.setRoom(roomNo);
				//aRow2.setFloor(floorNo);
				//aRow2.setBuilding(buildingName);
				
				aRow2.setHouseNumberAndStreet(streetName);
				aRow2.setPostalCode(pcode_freq);
				aRow2.setCity(city_freq);
				aRow2.setRegion(state_freq); 	
			}
			else
			{
				aRow2.setHouseNumberAndStreet(listShipTos.getFieldValueString(0,"ECA_ADDR_1"));
				aRow2.setPostalCode(listShipTos.getFieldValueString(0,"ECA_PIN").trim());
				aRow2.setCity(listShipTos.getFieldValueString(0,"ECA_CITY"));
				aRow2.setRegion(listShipTos.getFieldValueString(0,"ECA_STATE"));	
			}
			aRow2.setCountrykey(listShipTos.getFieldValueString(0,"ECA_COUNTRY"));
			
			tpZone       = listShipTos.getFieldValueString(0,"ECA_TRANSORT_ZONE");
			jurisdiction = listShipTos.getFieldValueString(0,"ECA_JURISDICTION_CODE");
			
			String finalTPZone = null;
			String finalJurCode = null;

			finalTPZone  = billTPZone;
			finalJurCode = billJurCode;

			log4j.log("finalTPZonefinalTPZone===>  "+finalTPZone,"I"); 
			log4j.log("finalJurCodefinalJurCode===>  "+finalJurCode,"I"); 

			if(finalTPZone!=null && !"null".equals(finalTPZone) && !"".equals(finalTPZone.trim())){
				aRow2.setTransportationZone(finalTPZone);
				log4j.log("finalTPZonefinalTPZone===>  "+finalTPZone,"I");
			}
			if(finalJurCode!=null && !"null".equals(finalJurCode) && !"".equals(finalJurCode.trim())){
				aRow2.setTaxJurisdictionCode(finalJurCode);
				log4j.log("finalJurCodefinalJurCode===>  "+finalJurCode,"I"); 
			} 

			if(shFax!=null && !"null".equals(shFax) && !"".equals(shFax.trim())){
				shFax = shFax.trim();
				aRow2.setFaxNumber(shFax);
				log4j.log("shFaxshFaxshFax===>  "+shFax,"I");
			} 

			if(shAttn!=null && !"null".equals(shAttn) && !"".equals(shAttn.trim())){
				aRow2.setName2(shAttn);
				log4j.log("shAttnshAttn===>  "+shAttn,"I");
			} 



			if(shTel!=null && !"null".equals(shTel) && !"".equals(shTel.trim())){
				shTel = shTel.trim();
				aRow2.setTelexNumber(shTel);
				log4j.log("shTelshTelshTel===>  "+shTel,"I");
			} 
			if(shMobi!=null && !"null".equals(shMobi) && !"".equals(shMobi.trim())){
				shMobi = shMobi.trim();
				aRow2.setTeletexNumber(shMobi);
				log4j.log("shMobishMobishMobi===>  "+shMobi,"I"); 
			} 

			ezcPartnrTable.appendRow(aRow2);

		}
	    
		
		EzBapipartnrTableRow aRow1 = new EzBapipartnrTableRow(); 
		aRow1.setPartnRole("AG"); 	//"AG" for soldto
		aRow1.setPartnNumb(PartnNum);
		aRow1.setName1(setSalVal.getSoldToName());
		ezcPartnrTable.appendRow(aRow1);

	}
	String[] notesAll = new String[]{generalNotes1};
	String notesHId[] = new String[]{"Z001"};
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

	log4j.log("SAPnumberSAPnumberSAPnumberSAPnumber======>"+SAPnumber, "D");

	if(SAPnumber) 
	{
		try
		{
			ezc.ezsalesquote.client.EzSalesQuoteManager EzSalesQuote = new ezc.ezsalesquote.client.EzSalesQuoteManager();
			
			ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(true);

			ezcParams.setObject(ezcSdheadStructure);
			ezcParams.setObject(ezcPartnrTable);
			ezcParams.setObject(ezcIteminTable);
			ezcParams.setObject(ezcschdlTable);
			ezcParams.setObject(ezctextTable);
			ezcParams.setObject(ezccondtable); 
			
			Session.prepareParams(ezcParams);
			ezc.ezsalesquote.params.EzoSalesQuoteCreate ioParamsSave = (ezc.ezsalesquote.params.EzoSalesQuoteCreate)EzSalesQuote.ezCreateSalesQuote(ezcParams);
			
			orderError = (ReturnObjFromRetrieve)ioParamsSave.getReturn();
			
			ReturnObjFromRetrieve ordHeadIn = (ReturnObjFromRetrieve)ioParamsSave.getOrderHeaderIn();
			
			int orderErrorCount = orderError.getRowCount();

			log4j.log("orderErrorCount======>"+orderErrorCount, "D");
			log4j.log("orderError======>"+orderError.toEzcString(), "D");

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
			if(ordHeadIn!=null && ordHeadIn.getRowCount()>0)
			{
				log4j.log("ordHeadInordHeadIn======>"+ordHeadIn.toEzcString(), "D");
				sDocNumber = ordHeadIn.getFieldValueString(0,"DocNumber");
			}
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
      		log4j.log("sDocNumber======>"+sDocNumber, "D");
	}
	if(!PartnNum.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(SalesAreaCode,defPartnNum);
%>