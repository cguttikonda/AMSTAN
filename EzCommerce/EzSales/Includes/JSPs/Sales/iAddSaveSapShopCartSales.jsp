<%@ page import="java.util.*,ezc.ezutil.FormatDate"%>
<%
//*************************Start of Declarations*******************************************/
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	String defPartnNum =UtilManager.getUserDefErpSoldTo();
	ReturnObjFromRetrieve drlRet = null;
	String SalesAreaCode=(String)session.getValue("SalesAreaCode");
	
	String plantVal = (String)session.getValue("PLANT");
	String soCondType = (String)session.getValue("SOCONDTYPE");
	String fCondType = (String)session.getValue("FREIGHTCONDTYPE");
	String freightInsVal = (String)session.getValue("FREIGHTINS");
	String profitCenter = (String)session.getValue("PROFITCENTER");
	String salesOffice = (String)session.getValue("CU_SALESOFFICE");
	String salesGroup = (String)session.getValue("CU_SALESGROUP");

 	java.util.ArrayList uProdOrderType = new java.util.ArrayList();
log4j.log("prodCodeLength>>>>>>"+prodCodeLength,"W");

 	for(int i=0;i<prodCodeLength;i++)
 	{

		if(!uProdOrderType.contains(itemOrderType[i]))
		{
			uProdOrderType.add(itemOrderType[i]);
		}
		log4j.log("itemOrderType[i]>>>>>>"+itemOrderType[i],"W");


	}

ArrayList multiOrders_A = new ArrayList();

log4j.log("uProdOrderType.size()>>>>>>"+uProdOrderType.size(),"W");

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
	
	// Date Format Object
	java.util.GregorianCalendar fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();
	GregorianCalendar calendar1 = new GregorianCalendar();
	calendar1.setTime(fromDate.getTime());
	calendar1.add(Calendar.DATE,5);
	Date fromDate1 =calendar1.getTime();
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
	
	String poDate = setSalVal.getPoDate();
	//String poDate = FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	String curr   = request.getParameter("Currency");
	
	if(salesOffice!=null && !"null".equals(salesOffice) && !"".equals(salesOffice.trim()))
		orderHeaderConfirm.setSalesOff(salesOffice.trim());
	if(salesGroup!=null && !"null".equals(salesGroup) && !"".equals(salesGroup.trim()))
		orderHeaderConfirm.setSalesGrp(salesGroup.trim());
	orderHeaderConfirm.setDivision("");
	orderHeaderConfirm.setDistrChan("");
	orderHeaderConfirm.setSalesOrg("");
	//orderHeaderConfirm.setDlvBlock("ZZ");  //"ZZ" in AF
	orderHeaderConfirm.setIncoterms1(incoTerms1);
	orderHeaderConfirm.setIncoterms2(incoTerms2);
	
	log4j.log("setIncoterms1  "+incoTerms1,"W");
	log4j.log("setIncoterms2  "+incoTerms2,"W");
	
	if(!(" ".equals(shippingCond)|| "null".equals(shippingCond)))
	{
		orderHeaderConfirm.setShipCond(shippingCond); 
	}
	//orderHeaderConfirm.setShipCond("");
	
	//orderHeaderConfirm.setShippingType(carrierName);
	orderHeaderConfirm.setPmnttrms(paymentterms);
	orderHeaderConfirm.setPurchNo(setSalVal.getPoNo());
	orderHeaderConfirm.setAgentCode((String)session.getValue("SAPPRDCODE"));
	
	log4j.log("setPmnttrms  "+paymentterms,"W");
	log4j.log("setPurchNo  "+setSalVal.getPoNo(),"W");
	log4j.log("setAgentCode  "+(String)session.getValue("SAPPRDCODE"),"W");
	
	try
	{
		int mn = Integer.parseInt(poDate.substring(0,2));
		int dt = Integer.parseInt(poDate.substring(3,5));
		int yr = Integer.parseInt(poDate.substring(6,10));
		java.util.GregorianCalendar reqDatePO = new java.util.GregorianCalendar(yr,mn-1,dt);
		orderHeaderConfirm.setPurchDate(reqDatePO.getTime());
		log4j.log("setPurchDate  "+reqDatePO,"W");
	}catch(Exception e){}
	if((curr != null) && (curr.trim().length()!=0))
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
		orderHeaderConfirm.setReqDateH(reqDat.getTime());
		log4j.log("setReqDateH  "+reqDat,"W");
	}catch(Exception e)
	{
		orderHeaderConfirm.setReqDateH(fromDate1);
		log4j.log("setReqDateH  "+fromDate1,"W");
	}
//*******************Finished setting headervalues**************************************

//*************************SettingPartners**********************************************
	if(PartnNum!=null)
	{
		
		String agentCode	=(String)session.getValue("AgentCode");
		log4j.log("agentCodeagentCodeagentCodeagentCodeagentCodeagentCode"+agentCode,"I");
		log4j.log("PartnNumPartnNumPartnNumPartnNumPartnNumPartnNumPartnNum"+PartnNum,"I");
		String tpZone ="";
		String jurisdiction ="";

		//For Ship To
		ReturnObjFromRetrieve  listShipTos = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(agentCode);
		ReturnObjFromRetrieve  listBillTos = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos(agentCode);

		if(listShipTos!=null && listShipTos.getRowCount()>0)
		{

			EzBapipartnrTableRow aRow2 = new EzBapipartnrTableRow();
			aRow2.setPartnRole("AG"); //"WE" for shipto 
			aRow2.setPartnNumb(PartnNum); 	//PartnNum
			log4j.log("PartnNumPartnNumPartnNumPartnNumPartnNumPartnNumPartnNum"+aRow2.getPartnNumb(),"I");
			aRow2.setFirstTelephoneNo(listShipTos.getFieldValueString(0,"ECA_PHONE"));
			aRow2.setName1(setSalVal.getSoldToName());
			aRow2.setHouseNumberAndStreet(listBillTos.getFieldValueString(0,"ECA_ADDR_1"));
			aRow2.setPostalCode(listBillTos.getFieldValueString(0,"ECA_PIN").trim());
			aRow2.setCity(listBillTos.getFieldValueString(0,"ECA_CITY"));
			aRow2.setRegion(listBillTos.getFieldValueString(0,"ECA_STATE"));
			aRow2.setCountrykey(listBillTos.getFieldValueString(0,"ECA_COUNTRY"));			
			
			
			orderPartnersConfirm.appendRow(aRow2); 

		}
		
		EzBapipartnrTableRow aRow1 = new EzBapipartnrTableRow();
		aRow1.setPartnRole("WE"); //"AG" for soldto
		aRow1.setPartnNumb(sel_Ship);	//PartnNum //Added to set multiple ship to by chanakya 
		log4j.log("sel_Shipsel_Shipsel_Shipsel_Shipsel_Ship"+sel_Ship,"I");
		if(streetName!=null)
		{
			//if(floorNo==null || "null".equals(floorNo)) floorNo = "";
			//if(buildingName==null || "null".equals(buildingName)) buildingName = "";

			//aRow2.setRoom(roomNo);
			//aRow2.setFloor(floorNo);
			//aRow2.setBuilding(buildingName);

			aRow1.setHouseNumberAndStreet(streetName);
			aRow1.setPostalCode(pcode_freq);
			aRow1.setCity(city_freq);
			aRow1.setRegion(state_freq);
			aRow1.setName1(shipToName_freq);
			aRow1.setCountrykey(setSalVal.getShipToCountry());
		}
		else
		{
			aRow1.setHouseNumberAndStreet(listShipTos.getFieldValueString(0,"ECA_ADDR_1"));
			aRow1.setPostalCode(listShipTos.getFieldValueString(0,"ECA_PIN").trim());
			aRow1.setCity(listShipTos.getFieldValueString(0,"ECA_CITY"));
			aRow1.setRegion(listShipTos.getFieldValueString(0,"ECA_STATE"));
			aRow1.setCountrykey(listShipTos.getFieldValueString(0,"ECA_COUNTRY"));
		}


		tpZone       = listShipTos.getFieldValueString(0,"ECA_TRANSORT_ZONE");
		jurisdiction = listShipTos.getFieldValueString(0,"ECA_JURISDICTION_CODE");



		/*if(tpZone!=null && !"null".equals(tpZone) && !"".equals(tpZone.trim())){
			aRow1.setTransportationZone(tpZone);
			log4j.log("tpZonetpZonetpZone===>  "+tpZone,"I");
		}

		if(jurisdiction!=null && !"null".equals(jurisdiction) && !"".equals(jurisdiction.trim())){
			aRow1.setTaxJurisdictionCode(jurisdiction);
			log4j.log("jurisdictionjurisdictionjurisdiction===>  "+jurisdiction,"I");
		}*/

		String finalTPZone = null;
		String finalJurCode = null;

		/*

		String finalSearchKey = null;

		try{

			java.util.ResourceBundle tpzonerb =java.util.ResourceBundle.getBundle("Transportationzones"); 
			if(pcode_freq!=null){
				pcode_freq = pcode_freq.trim();
			}

			if(state_freq!=null){
				state_freq = state_freq.trim();
			}

			if("NY".equals(state_freq) || "NJ".equals(state_freq)){
				finalSearchKey = state_freq +"_"+pcode_freq;
			}else{
				finalSearchKey = state_freq;
			}		



			String keyVal = tpzonerb.getString(finalSearchKey);
			java.util.StringTokenizer st = new java.util.StringTokenizer(keyVal,"¥");
			finalTPZone  = (String)st.nextElement();
			finalJurCode = (String)st.nextElement();				


		}catch(Exception err){}

		*/ 


		//if(finalTPZone==null || "null".equals(finalTPZone)){
			finalTPZone  = billTPZone;
			finalJurCode = billJurCode;
		//}

		log4j.log("finalTPZonefinalTPZone===>  "+finalTPZone,"I"); 
		log4j.log("finalJurCodefinalJurCode===>  "+finalJurCode,"I"); 
		//log4j.log("finalSearchKeyfinalSearchKey===>  "+finalSearchKey,"I"); 


		if(finalTPZone!=null && !"null".equals(finalTPZone) && !"".equals(finalTPZone.trim())){
			aRow1.setTransportationZone(finalTPZone);
			log4j.log("finalTPZonefinalTPZone===>  "+finalTPZone,"I");
		}
		if(finalJurCode!=null && !"null".equals(finalJurCode) && !"".equals(finalJurCode.trim())){
			aRow1.setTaxJurisdictionCode(finalJurCode);
			log4j.log("finalJurCodefinalJurCode===>  "+finalJurCode,"I"); 
		} 

		if(shFax!=null && !"null".equals(shFax) && !"".equals(shFax.trim())){
			shFax = shFax.trim();
			aRow1.setFaxNumber(shFax);
			log4j.log("shFaxshFaxshFax===>  "+shFax,"I");
		} 

		if(shAttn!=null && !"null".equals(shAttn) && !"".equals(shAttn.trim())){
			aRow1.setName2(shAttn);
			log4j.log("shAttnshAttn===>  "+shAttn,"I");
		} 



		if(shTel!=null && !"null".equals(shTel) && !"".equals(shTel.trim())){
			shTel = shTel.trim();
			aRow1.setTelexNumber(shTel);
			log4j.log("shTelshTelshTel===>  "+shTel,"I");
		} 
		if(shMobi!=null && !"null".equals(shMobi) && !"".equals(shMobi.trim())){
			shMobi = shMobi.trim();
			aRow1.setTeletexNumber(shMobi);
			log4j.log("shMobishMobishMobi===>  "+shMobi,"I");
		} 





		orderPartnersConfirm.appendRow(aRow1);
		//aRow2.setTransportationZone(listShipTos.getFieldValueString(0,"ECA_TRANSORT_ZONE"));
		//aRow2.setTransportationZone("0000000001"); /*Comment in AF*/		
		
		
		
		/*aRow1.setName1(setSalVal.getSoldToName());
		aRow1.setHouseNumberAndStreet(listBillTos.getFieldValueString(0,"ECA_ADDR_1"));
		aRow1.setPostalCode(listBillTos.getFieldValueString(0,"ECA_PIN").trim());
		aRow1.setCity(listBillTos.getFieldValueString(0,"ECA_CITY"));
		aRow1.setRegion(listBillTos.getFieldValueString(0,"ECA_STATE"));
		aRow1.setCountrykey(listBillTos.getFieldValueString(0,"ECA_COUNTRY"));*/
		
		
		//aRow1 = new EzBapipartnrTableRow();
		//aRow1.setPartnRole("ZC"); //"AG" for soldto
		//aRow1.setPartnNumb(carrierName);
		//orderPartnersConfirm.appendRow(aRow1);
	}
	
	log4j.log("Finished setting  Partner values","I");
	
//*************************Finished setting  Partner values******************************

	String[] notesAll = new String[]{specialShIns,generalNotes1}; 
	String notesHId[] = new String[]{"0012","0002"};
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
	java.math.BigDecimal bOrderQty = null;
	int lineno = 1;
	String OrderQuantity="";
	String uom="";
	String itemCat="";
	java.math.BigInteger line=null;
	java.math.BigDecimal ordqty=null;

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
	Hashtable groupDoc=new Hashtable();
	
	String prdGroup="";
	java.util.StringTokenizer stk=null;

	Hashtable productGroup=new Hashtable();
	
	log4j.log("PrdGrpOrdTypesPrdGrpOrdTypes","I");
	
	java.util.ResourceBundle PrdGrpOrdTypes = java.util.ResourceBundle.getBundle("EzPrdGrpOrdTypes");
	java.util.ResourceBundle PrdGrp 	= java.util.ResourceBundle.getBundle("EzPrdGrp");
	java.util.Enumeration 	enum1		= PrdGrp.getKeys();
	Hashtable prdTypesHash= new Hashtable();
	Vector prdTypesVector=new Vector();
	while(enum1.hasMoreElements())
	{
		String prdElement=(String)enum1.nextElement();
		String prdCode=PrdGrp.getString(prdElement);
		java.util.StringTokenizer   prdCode_1=new java.util.StringTokenizer(prdCode,",");
		ArrayList prdVector=new ArrayList();
		while(prdCode_1.hasMoreTokens())
		{
			prdVector.add(prdCode_1.nextElement());
		}
		prdTypesHash.put(prdElement,prdVector);
		prdTypesVector.addElement(prdElement);	
	}
	Hashtable selectdMet=new Hashtable();
	
	if(session.getAttribute("SELECTEDMET")!=null)
	{
		selectdMet =(Hashtable)session.getAttribute("SELECTEDMET");
		java.util.Enumeration enum11=selectdMet.keys();
		for(int m=0;m<selectdMet.size();m++)
		{
			String metCode=(String)enum11.nextElement();
			String metGroup=(String)selectdMet.get(metCode);
			java.util.StringTokenizer   st=new java.util.StringTokenizer(metGroup,",");
			metGroup=(String)st.nextElement();
			boolean prdFlag=false;
			for(int q=0;q<prdTypesHash.size();q++)
			{
				for(int r=0;r<prdTypesVector.size();r++)
				{
					ArrayList  prdCodeVec = (ArrayList)prdTypesHash.get((String)(prdTypesVector.elementAt(r)));
					prdFlag=prdCodeVec.contains(metGroup);
					if(prdFlag)
					{
						productGroup.put(metCode,prdTypesVector.elementAt(r));
						break;
					}
				}
				if(prdFlag)
					break;
			}
		}
	}
	
	log4j.log("prodCodeLengthprodCodeLength"+prodCodeLength,"I");

	for(int j=0;j <prodCodeLength;j++)
	{
		if(itemOrderType[j].equals((String)uProdOrderType.get(us)))
		{

		String prodGroup = (String)productGroup.get(prodCode_1[j]);
		//plant 		= "PL01"; //"ORD_"+prodGroup; /***QU in AF***/
		OrderQuantity 	= prodCQty_1[j];
		OrderQuantity 	= "1";
		log4j.log("OrderQuantity"+OrderQuantity,"I");
		uom 		= prodPack_1[j];
		log4j.log("uom"+uom,"I");
		custProd        = custprodCode[j];
		log4j.log("custProd"+custProd,"I");
		
		log4j.log("custProdcustProdcustProdcustProd  "+custprodCode[j],"W");
		log4j.log("prodCode_1[j]>>>>>>>>...  "+prodCode_1[j],"W");
		log4j.log("itemOrderType[j]>>>>>>>>...  "+itemOrderType[j],"D");
		
		OrderQuantity 	= (OrderQuantity==null|| "".equals(OrderQuantity.trim()) || "null".equals(OrderQuantity) )?"0":OrderQuantity.trim();
		itemCat 	= prodItemCat_1[j];
		
		if(!OrderQuantity.equals("0")&& !"TANN".equals(itemCat) )
		{		
			bOrderQty  = new  java.math.BigDecimal(OrderQuantity);
			bOrderQty  = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
			line 	   = new java.math.BigInteger(String.valueOf(lineno*10));			
			ordqty 	   = new java.math.BigDecimal(OrderQuantity);
			ordqty     = ordqty .multiply(new java.math.BigDecimal(Integer.toString(1000)));

//******************************setting  items*********************************************
			aItemRowConfirm = new EzBapiiteminTableRow();
			aItemRowsim = new EzBapiiteminTableRow();
			aItemRowConfirm.setItmNumber(line);
			aItemRowConfirm.setCustMat(custprodCode[j]);
			aItemRowConfirm.setMaterial(prodCode_1[j]);
			aItemRowConfirm.setShortText(prodDesc_1[j]);
			aItemRowConfirm.setSalesUnit(uom);
			aItemRowConfirm.setBillDate(fromDate.getTime()); // current Date as Bill Date
			aItemRowConfirm.setProfitCenter(profitCenter);
			
			log4j.log("setItmNumber  "+line,"W");
			log4j.log("setCustMat  "+custprodCode[j],"W");
			log4j.log("setMaterial  "+prodCode_1[j],"W");
			log4j.log("setShortText  "+prodDesc_1[j],"W");
			log4j.log("setSalesUnit  "+uom,"W");
			log4j.log("setBillDate  "+fromDate,"W");
			
			aItemRowsim.setItmNumber(line);
			aItemRowsim.setMaterial(prodCode_1[j]);
			aItemRowsim.setCustMat(custprodCode[j]);
						
			aItemRowsim.setEanUpc(itemEanUPC[j]);
			aItemRowsim.setMatExt(itemMfrPart[j]);
			aItemRowsim.setMatlGroup(itemMfrNr[j]);
			aItemRowsim.setBatch(itemMatId[j]);			
			
			log4j.log("itemEanUPC  "+itemEanUPC[j],"W");
			log4j.log("itemMfrPart  "+itemMfrPart[j],"W");
			log4j.log("itemMfrNr  "+itemMfrNr[j],"W");
			log4j.log("itemMatId  "+itemMatId[j],"W");
			
			String ord_T = itemOrderType[j];
			if("OR".equals(ord_T)) ord_T = "TA";
			
			aItemRowsim.setSalesUnit(uom);
			aItemRowsim.setBillDate(fromDate.getTime()); // current Date as Bill Date
			aItemRowConfirm.setShipTo(sel_Ship);	//setSalVal.getShipTo()
			log4j.log("aItemRowConfirm::::::::::::::::::::::"+aItemRowConfirm.getShipTo(),"W");
			aItemRowConfirm.setSysKey(salesAreaCode);
			aItemRowConfirm.setSalesOrg(SalesOrg);
			aItemRowConfirm.setDistributionChanel(DC); 
			aItemRowConfirm.setDivision(Div);
			aItemRowConfirm.setPlant(plantVal);
			//aItemRowConfirm.setDocType(docType);
			aItemRowConfirm.setDocType(ord_T);
			aItemRowsim.setShipTo(sel_Ship);	//setSalVal.getShipTo()
			aItemRowsim.setSysKey(salesAreaCode);	
			aItemRowsim.setSalesOrg(SalesOrg);
			aItemRowsim.setDistributionChanel(DC);
			aItemRowsim.setDivision(Div);
			aItemRowsim.setPlant(plantVal);	 	//This has to be set with material group based material code
			//aItemRowsim.setDocType(docType);
			aItemRowsim.setDocType(ord_T);
			
			log4j.log("setShipTo  "+sel_Ship,"W");
			log4j.log("setShipTo  "+setSalVal.getShipTo(),"W");
			log4j.log("setSysKey  "+salesAreaCode,"W");
			log4j.log("SalesOrg  "+SalesOrg,"W");
			log4j.log("setDistributionChanel  "+DC,"W");
			log4j.log("setDivision  "+Div,"W");
			log4j.log("setPlant  "+plantVal,"W");
			log4j.log("setDocType  "+docType,"W");
			
	
	                //log4j.log("setShipTo>>>>>>>>>>...  "+setSalVal.getShipTo(),"W");
	                
			iteminTableConfirm.appendRow(aItemRowConfirm);
			iteminTablesim.appendRow(aItemRowsim);
			
			try{
				condTableRow =new EzBapiscondTableRow();
				condTableRow.setItmNumber(line);
				condTableRow.setCondType(soCondType);   //"PR00"
				//condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(desiredPrice_1[j])/10)); 
				condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice[j])/10)); 
				condTable.appendRow(condTableRow);
			}catch(Exception err){ 
			
			}
			
			
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
						
						log4j.log("setReqQty  "+dreqqty,"W");
						log4j.log("setReqDate  "+schdat,"W");
						
					}catch(Exception e){}
					dSTableRow.setItmNumber(line);
					dSTableRow.setShortText(String.valueOf(dschline));
					
					log4j.log("setItmNumber  "+line,"W");
					log4j.log("setShortText  "+dschline,"W");
					
					//dSTableRow.setDlvBlock("ZZ"); //"ZZ" in AF
					deliveryScheduleTable.appendRow(dSTableRow);
					dschline++;
				}
			}
			lineno++;
		}
		}
  	}
  	
  	//***********************Freight************************//
	try
	{
		condTableRow =new EzBapiscondTableRow();
		condTableRow.setItmNumber(new java.math.BigInteger("00"));
		condTableRow.setCondType(fCondType);	//"ZD00"
		condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(freightPrice)/10));
		condTable.appendRow(condTableRow);
	}
	catch(Exception err){}
	//***********************Freight Insurance************************//

	/*
	try
	{
		condTableRow =new EzBapiscondTableRow();
		condTableRow.setItmNumber(new java.math.BigInteger("00"));
		condTableRow.setCondType(freightInsVal);	
		condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(freightIns)/10));
		condTable.appendRow(condTableRow);
	}
	catch(Exception err){}
	*/
  	
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
		escpSim.setOrderDelSchedule(deliveryScheduleTable);
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
}
log4j.log("sDocNumber CHECK======>"+sDocNumber, "D");

	if(!PartnNum.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(SalesAreaCode,defPartnNum);
%>