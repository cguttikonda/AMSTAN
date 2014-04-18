<%@ page import="java.util.*"%>
<%
log4j.log("CRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRI0","W");

	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	String defPartnNum =UtilManager.getUserDefErpSoldTo();

	if(!PartnNum.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(UtilManager.getCurrSysKey(),PartnNum);
//BAPI Parameters	
	EzBapiiteminTable    iteminTablesim  = new EzBapiiteminTable();
	EzBapiiteminTableRow aItemRowConfirm = null;
	EzBapiiteminTableRow aItemRowsim  = null;
	EzBapiscondTable     condTable 	  = new EzBapiscondTable();
	EzBapiscondTableRow  condTableRow = null;
	EzBapischdlTable     deliveryScheduleTable = new EzBapischdlTable();
	EzBapischdlTableRow  dSTableRow   = null;
	EzBapistextTable     ezctextTable = new EzBapistextTable();
	EzBapistextTableRow  ezctextRow   = null;

//Date Format Object
	String fkey = (String)session.getValue("formatKey");
	String headerReqDate =  FormatDate.getStringFromDate(new Date(),fkey,FormatDate.MMDDYYYY);
	
	java.util.GregorianCalendar fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();	
	java.util.GregorianCalendar reqDateH = new java.util.GregorianCalendar(Integer.parseInt(headerReqDate.substring(6,10)) ,(Integer.parseInt(headerReqDate.substring(0,2))-1),Integer.parseInt(headerReqDate.substring(3,5)));

	GregorianCalendar calendar1 = new GregorianCalendar();
	calendar1.setTime(fromDate.getTime());
	calendar1.add(Calendar.DATE,5);
	Date fromDate1 =calendar1.getTime();	

	EzcSalesOrderParams initParams = new EzcSalesOrderParams();
	EziSalesOrderCreateParams initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);
	EziSalesOrderCreateParams ioParamsConfirm = (EziSalesOrderCreateParams)EzSalesOrderManager.initializeSalesOrder(initParams);

	EzBapisdheadStructure orderHeaderConfirm= ioParamsConfirm.getOrderHeaderIn(); 	
	EzBapipartnrTable orderPartnersConfirm 	= ioParamsConfirm.getOrderPartners(); 
	EzBapiiteminTable iteminTableConfirm 	= ioParamsConfirm.getOrderItemsIn();
log4j.log("CRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRI01","W");
//**********************Setting  Header Values *****************************************
	//orderHeaderConfirm.setSalesOff("AFNJ");
	//orderHeaderConfirm.setSalesGrp("INT");
	orderHeaderConfirm.setDivision(""); 
	orderHeaderConfirm.setDistrChan("");
	orderHeaderConfirm.setSalesOrg("");
	//orderHeaderConfirm.setDlvBlock("ZZ"); // "ZZ" in AF
	orderHeaderConfirm.setDocType(docType);
	orderHeaderConfirm.setIncoterms1(editSalVal.getIncoTerms1());
	orderHeaderConfirm.setIncoterms2(editSalVal.getIncoTerms2());
	orderHeaderConfirm.setPmnttrms(paymentterms);
	orderHeaderConfirm.setPurchNo(editSalVal.getPoNo()); 
	orderHeaderConfirm.setAgentCode((String)session.getValue("SAPPRDCODE"));
	//orderHeaderConfirm.setPoMethod("EB2B"); 
	
	
	if(carrierName!=null && !"null".equals(carrierName))
	{
		orderHeaderConfirm.setShipCond(carrierName);  
	}
	
	String poDate = editSalVal.getPoDate();
	try{
		int mn = Integer.parseInt(poDate.substring(0,2));
		int dt = Integer.parseInt(poDate.substring(3,5));
		int yr = Integer.parseInt(poDate.substring(6,10));
		java.util.GregorianCalendar reqDatePO = new java.util.GregorianCalendar(yr,mn-1,dt);
		orderHeaderConfirm.setPurchDate(reqDatePO.getTime());
	}
	catch(Exception e){}
	
	String curr = request.getParameter("Currency");
	if((curr != null) && (curr.trim().length()!=0))
	{
		orderHeaderConfirm.setCurrency(curr);
	}
	ReturnObjFromRetrieve retSchChangesLocal=(ReturnObjFromRetrieve)session.getValue("EzDeliveryLines");
	try
	{
		String defaultdat = retSchChangesLocal.getFieldValueString(0,"EZDS_REQ_DATE");
		int yearReq1  = Integer.parseInt(defaultdat.substring(6,10));
		int dateReq1  = Integer.parseInt(defaultdat.substring(3,5));
		int monthReq1 = Integer.parseInt(defaultdat.substring(0,2));
		java.util.GregorianCalendar reqDat = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);
		orderHeaderConfirm.setReqDateH(reqDat.getTime()); 
	}catch(Exception e)
	{
		orderHeaderConfirm.setReqDateH(fromDate.getTime()); 
	}
	String refdoc = editSalVal.getRefdoc();
log4j.log("CRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRI1","W");

//*******************Finished setting header values*************************************

//*************************Setting Partners**********************************************
	if(PartnNum!=null)
	{
	    
		String agentCode	=(String)session.getValue("AgentCode");
		String tpZone ="";
		String jurisdiction ="";
		
		log4j.log("agentCodeagentCodeagentCodeagentCodeagentCodeagentCode"+agentCode,"I");

		//For Ship To
		ReturnObjFromRetrieve  listShipTos = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(agentCode);

               //log4j.log("listShipTos"+listShipTos.toEzcString(),"I");
               
		if(listShipTos!=null && listShipTos.getRowCount()>0)
		{

			EzBapipartnrTableRow aRow2 = new EzBapipartnrTableRow();
			aRow2.setPartnRole("WE"); //"WE" for shipto
			aRow2.setPartnNumb(PartnNum);
			aRow2.setName1(listShipTos.getFieldValueString(0,"ECA_NAME"));
			aRow2.setFirstTelephoneNo(listShipTos.getFieldValueString(0,"ECA_PHONE"));
			if(address1_freq!=null)
			{
			     aRow2.setHouseNumberAndStreet(address1_freq.replace('¥',','));
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



			/*if(tpZone!=null && !"null".equals(tpZone) && !"".equals(tpZone.trim())){
				aRow2.setTransportationZone(tpZone);
				log4j.log("tpZonetpZonetpZone===>  "+tpZone,"I");
			}

			if(jurisdiction!=null && !"null".equals(jurisdiction) && !"".equals(jurisdiction.trim())){
				aRow2.setTaxJurisdictionCode(jurisdiction);
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
			
			
			
			//aRow2.setTransportationZone(listShipTos.getFieldValueString(0,"ECA_TRANSORT_ZONE"));
			//aRow2.setTransportationZone("0000000001");  

			orderPartnersConfirm.appendRow(aRow2);

		}
	    
		
		EzBapipartnrTableRow aRow1 = new EzBapipartnrTableRow(); 
		aRow1.setPartnRole("AG"); 	//"AG" for soldto
		aRow1.setPartnNumb(PartnNum);
		orderPartnersConfirm.appendRow(aRow1);
		//aRow1 = new EzBapipartnrTableRow();
		//aRow1.setPartnRole("ZC"); 	//"ZC" for carrierName
		//aRow1.setPartnNumb(carrierName);
		//orderPartnersConfirm.appendRow(aRow1);

	}
//***************************Finished setting  Partner values********************************

//****************************Setting Items conditions and delivery schedules ***************
	java.math.BigDecimal bOrderQty = null;
	double bCommitedPrice =0;
	for (int j=0;j < Rows;j++) 
	{ 
		String strMaterialField = product_1[j];	
		String custMaterialField = custprodCode[j];
		
		System.out.println("strMaterialField>>>>>>>>>>"+strMaterialField);
		System.out.println("custMaterialField>>>>>>>>>>"+custMaterialField);
		
		String plant = "PL01";  //QU in AF
		String strOrderField 	= commitedQty_1[j];
		String CommitPriceReq 	= commitedPrice_1[j]; 
		String strFOC 		= fOC_1[j];
		String  item 		= lineNo_1[j];		
		strFOC 			= ((strFOC==null) || (strFOC.trim().length()==0))?"0":strFOC;
		long IntFOC 		= Integer.parseInt(strFOC);
		String OrderQuantity 	= strOrderField;
		int delcount = 0;
		String uom = pack_1[j];
		if(!OrderQuantity.equals(""))
		{ 
			CommitPriceReq = ( (CommitPriceReq==null) || (CommitPriceReq.trim().length()==0) )?"0":CommitPriceReq;
			double CommitPriceDob = Double.parseDouble(CommitPriceReq); 
			bOrderQty  = new  java.math.BigDecimal(OrderQuantity);
			bOrderQty  = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
			bCommitedPrice = new Double( CommitPriceReq ).doubleValue();
			java.math.BigInteger line = new java.math.BigInteger(item);

//************************setting  items*********************************************
		
			reqQtyHT.put(item.trim(),desiredQty_1[j]);
		 
			aItemRowConfirm = new EzBapiiteminTableRow();
			aItemRowsim = new EzBapiiteminTableRow();	
			aItemRowConfirm.setItmNumber(line);
			aItemRowConfirm.setMaterial(strMaterialField); 
			aItemRowConfirm.setCustMat(custMaterialField);
			aItemRowConfirm.setShortText(prodDesc_1[j]); 
			aItemRowConfirm.setSalesUnit(uom);
			aItemRowConfirm.setBillDate(fromDate.getTime());
			aItemRowConfirm.setShipTo(editSalVal.getShipTo());
			aItemRowConfirm.setSysKey(sysKey);
			aItemRowConfirm.setSalesOrg(SalesOrg);
			aItemRowConfirm.setDistributionChanel(DC);
			aItemRowConfirm.setDivision(Div);
			aItemRowConfirm.setDocType(docType);			
			aItemRowConfirm.setPlant(plant);
			
			aItemRowsim.setShipTo(editSalVal.getShipTo());			
			aItemRowsim.setSysKey(sysKey);
			aItemRowsim.setSalesOrg(SalesOrg);
			aItemRowsim.setDistributionChanel(DC);
			aItemRowsim.setDivision(Div);
			aItemRowsim.setDocType(docType);
			aItemRowsim.setPlant(plant);		//this has to be set with material group based material code			
			aItemRowsim.setItmNumber(line);
			aItemRowsim.setMaterial(strMaterialField); 
			aItemRowsim.setCustMat(custMaterialField);
			
			aItemRowsim.setEanUpc(EanUPC[j]);
			aItemRowsim.setMatExt(custMaterialField);
			aItemRowsim.setMatlGroup(mfrNr[j]);
			aItemRowsim.setBatch(matId[j]);	
						 
			aItemRowsim.setBillDate(fromDate.getTime());			
			aItemRowsim.setSalesUnit(uom);
			iteminTableConfirm.appendRow(aItemRowConfirm); 
			iteminTablesim.appendRow(aItemRowsim); 	 
			
			
			try{
				condTableRow =new EzBapiscondTableRow();
				condTableRow.setItmNumber(line);
				condTableRow.setCondType("PR00");
				condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice[j])/10));
				condTable.appendRow(condTableRow); 
			}catch(Exception err){

			}
			

			
			
//*********************finished setting Items*************************************
		}
		bOrderQty = null;
		OrderQuantity = null;
  	} 	
  	
  	log4j.log("After finishing setting items","I");
	if(retSchChangesLocal!=null)
	{
		log4j.log("retSchChangesLocal ","I");
		int locCount = retSchChangesLocal.getRowCount(); 
		log4j.log("retSchChangesLocal"+locCount,"I");
		
		log4j.log("locCountlocCountlocCount"+locCount,"D");
		log4j.log("commitedQty_1commitedQty_1commitedQty_1"+commitedQty_1.length,"D");
		
		if(locCount>1)
		locCount = 1;
		
		for(int k=0;k< locCount ;k++)
		{
			
			dSTableRow 	= new EzBapischdlTableRow();
			String itNo 	= retSchChangesLocal.getFieldValueString(k,"EZDS_ITM_NUMBER");
			String dreqqty 	= retSchChangesLocal.getFieldValueString(k,"EZDS_REQ_QTY");
			
			dreqqty = (String)reqQtyHT.get(itNo.trim()); 
			
			/*if(commitedQty_1[k]!=null && !"null".equals(commitedQty_1))
				dreqqty	= commitedQty_1[k]; */
			
			String dschline = retSchChangesLocal.getFieldValueString(k,"EZDS_SCHED_LINE");
			String schdat 	= retSchChangesLocal.getFieldValueString(k,"EZDS_REQ_DATE");
			java.util.GregorianCalendar reqDatesch = null;
			try
			{
				int yearReq1  	= Integer.parseInt(schdat.substring(6,10));
				int dateReq1  	= Integer.parseInt(schdat.substring(3,5));
				int monthReq1 	= Integer.parseInt(schdat.substring(0,2));
				reqDatesch 	= new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);
				dSTableRow.setReqQty(new java.math.BigDecimal(dreqqty)); 
				dSTableRow.setReqDate(reqDatesch.getTime());	
			}catch(Exception e){}
			dSTableRow.setItmNumber(new java.math.BigInteger(itNo)); 						
			dSTableRow.setShortText(dschline);
			//dSTableRow.setDlvBlock("ZZ"); //"ZZ" in AF 
			deliveryScheduleTable.appendRow(dSTableRow);
		}
	}
//************************* Finished Setting Items *******************************
   	try
   	{
		EzcSalesOrderParams  ezcSalesOrderParamsSim 	= new EzcSalesOrderParams();
        	EziSalesOrderCreateParams escpSim 		= new EziSalesOrderCreateParams();
	        ezcSalesOrderParamsSim.setObject(escpSim);
	        escpSim.setCreditChkFlag("Y");
		escpSim.setOrderHeaderIn(orderHeaderConfirm);
		escpSim.setOrderPartners(orderPartnersConfirm);
		escpSim.setOrderItemsIn(iteminTablesim);
		escpSim.setOrderDelSchedule(deliveryScheduleTable);
		escpSim.setType("BULK"); // if this is set to bulk or RBPG(if RBPG plant has to be set material group),for every sales area one sap order is simulated
	        Session.prepareParams(ezcSalesOrderParamsSim);
		EzoSalesOrderCreate  ioParamsSim = (EzoSalesOrderCreate) EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParamsSim); 
						
		ReturnObjFromRetrieve orderErrorSim =(ReturnObjFromRetrieve)ioParamsSim.getReturn();
		
		log4j.log("After ezSimulateWebSalesOrder in *************************************"+orderErrorSim.getRowCount(),"W");
		
		for(int pc=0;pc<orderErrorSim.getRowCount();pc++)
		{
			ErrorType =orderErrorSim.getFieldValueString(pc,"Type").trim();
			if("E".equalsIgnoreCase(ErrorType) )
			{
				ErrorMessage = ErrorMessage+"<br>simulate"+ErrorType+":"+orderErrorSim.getFieldValueString(pc,"Message");
				SAPnumber="NO";
			}
		}
	}catch(Exception e)
	{ 
		System.out.println("Exception occured in iAddSaveSapSales.jsp:"+e);
		SAPnumber="NO";
	}
	
	if("Yes".equals(SAPnumber))
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
		 	escpSave.setType("BULK"); // if this is set to bulk or RBPG(if RBPG plant has to be set material group),for every sales area one sap order is simulated
		        Session.prepareParams(ezcSalesOrderParamsSave);
		        EzoSalesOrderCreate ioParamsSave = (EzoSalesOrderCreate) EzSalesOrderManager.ezCreateWebSalesOrder(ezcSalesOrderParamsSave); 
		        orderError = ioParamsSave.getReturn();
			orders =(ReturnObjFromRetrieve) ioParamsSave.getObject("SalesOrders");

			for(int pc=0;pc<orderError.getRowCount();pc++)
			{
				ErrorType =orderError.getFieldValueString(pc,"Type");
				if("E".equalsIgnoreCase(ErrorType))
				{
					ErrorMessage = ErrorMessage +"<br>"+orderError.getFieldValueString(pc,"Message");
					SAPnumber="NO";
				}
			}
			
			System.out.println("SAPnumber::"+SAPnumber);
			System.out.println("Orders:::"+orders.toEzcString());
			System.out.println("sDocNumbersDocNumber:::"+sDocNumber);
						
			Vector chkWaste = new Vector();
			for(int ord = 0;ord<orders.getRowCount();ord++)
			{
				String s =orders.getFieldValueString(ord,"SalesOrder");
				if(!chkWaste.contains(s))
				{
					chkWaste.addElement(s);
					if((sDocNumber == null) || (sDocNumber.trim().length()==0))
					{
						sDocNumber = s;
					}
					else
					{
						sDocNumber = sDocNumber+ "," + s;
					}
				}
			}
			
			System.out.println("sDocNumbersDocNumber::"+sDocNumber);
			
			if((sDocNumber ==null ) || (sDocNumber.trim().length()==0))
			{
				SAPnumber="No";
			}
			
			System.out.println("sDocNumbersDocNumber:SAPnumber:"+SAPnumber);
			
	     	}
      		catch(Exception e)
      		{
      			System.out.println("exception occured while executing ezCreateWebSalesOrder::"+e);
			e.printStackTrace();
			SAPnumber="No";
      		}
	}
	if(!PartnNum.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(UtilManager.getCurrSysKey(),defPartnNum);
log4j.log("CRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRICRI2","W");
		
%>