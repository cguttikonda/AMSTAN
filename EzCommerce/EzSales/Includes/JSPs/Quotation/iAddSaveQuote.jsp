<%@ page import="java.util.*"%>
<%@ page import = "ezc.shopping.cart.params.*,ezc.shopping.cart.client.*,ezc.shopping.cart.common.*,ezc.sales.params.*" %>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ include file="../Lables/iAddModifyInfo_Lables.jsp" %>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp" %>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="UAdminManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%!
	public static String replaceString(String theString,String from,String to)
	{
		int go=0;
		String ret=theString;
		while (ret.indexOf(from,go)>=0)
		{
		go=ret.indexOf(from,go);
		ret=ret.substring(0,go)+to+ret.substring(go+from.length());
		go=go+to.length();
		}
		return ret;
	}
%>
<% 
	String headerReqDate = request.getParameter("requiredDate");
	
	//String validFromQT = request.getParameter("validFrom");
	//String validToQT = request.getParameter("validTo");
	
	String validFromQT = FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	
	Date valTo = new Date();
	Date valTo_1 = new Date(valTo.getYear(),valTo.getMonth(),valTo.getDate()+30);	//30 days from today
	
	String validToQT = FormatDate.getStringFromDate(valTo_1,"/",FormatDate.MMDDYYYY);
	
	GregorianCalendar reqDateH = null;
	try{
		reqDateH =new GregorianCalendar(Integer.parseInt(headerReqDate.substring(6,10)),(Integer.parseInt(headerReqDate.substring(0,2))-1),Integer.parseInt(headerReqDate.substring(3,5)));
	}catch(Exception e){
		reqDateH =(GregorianCalendar)GregorianCalendar.getInstance();
	}
	
	GregorianCalendar fromQTDate = null;
	try{
		fromQTDate = new GregorianCalendar(Integer.parseInt(validFromQT.substring(6,10)),(Integer.parseInt(validFromQT.substring(0,2))-1),Integer.parseInt(validFromQT.substring(3,5)));
	}catch(Exception e){
		fromQTDate =(GregorianCalendar)GregorianCalendar.getInstance();
	}
	
	GregorianCalendar toQTDate = null;
	try{
		toQTDate = new GregorianCalendar(Integer.parseInt(validToQT.substring(6,10)),(Integer.parseInt(validToQT.substring(0,2))-1),Integer.parseInt(validToQT.substring(3,5)));
	}catch(Exception e){
		toQTDate =(GregorianCalendar)GregorianCalendar.getInstance();
	}
	
	
	String PartnNum = (String)session.getValue("AgentCode");
	String msgExt ="";
	String msgInt = "";
	String subject= "";
	
	String shipToName_freq = request.getParameter("shipToName"); 
	String roomNo = request.getParameter("shipToAddress1");		//Room or House No
	String city_freq = request.getParameter("shipToAddress2");
	String state_freq = request.getParameter("shipToState");
	String pcode_freq = request.getParameter("shipToZipcode");
	
	String buildingName = request.getParameter("buildingName");
	String streetName = request.getParameter("streetName");
	
	String floorNo = request.getParameter("shipToAddr2");		//Floor
	
	log4j.log("PartnNum>>>>>>>>>>>>>>"+PartnNum,"W"); 
	log4j.log("roomNo>>>>>>>>>>>>>>"+roomNo,"W");
	log4j.log("floorNo>>>>>>"+floorNo,"W");	
	log4j.log("city_freq>>>>>>>>>>"+city_freq,"W");
	log4j.log("state_freq>>>>>>"+state_freq,"W");
	log4j.log("pcode_freq>>>>>>"+pcode_freq,"W");   

	
	
	if(("SUBMITTED").equals(status)) 
	{
%>
		<%@ include file="iAddSaveSapQuote.jsp" %>         
<%
	}

	String msgText		= "";
	String msgSubject	= "";
	String sendToUser	= "";
	
	ReturnObjFromRetrieve retObj=null;  
	EzcSalesOrderParams ezcParams = new EzcSalesOrderParams();      
	ezcParams.setLocalStore("Y");
	Session.prepareParams(ezcParams);      
	
	EzBapisdheadStructure ezHeader  = new EzBapisdheadStructure(); 
	EzBapisoldtoStructure ezSoldTo  = new EzBapisoldtoStructure();
	EzBapishiptoStructure ezShipTo  = new EzBapishiptoStructure();
	EzBapipartnrTable partnerTable 	= new EzBapipartnrTable();
	EzBapipartnrTableRow prtnrTblRow= new EzBapipartnrTableRow();

  	if(SAPnumber) 
  	{
		EzDeliverySchedulesTable  delTable = new  EzDeliverySchedulesTable();
		EzDeliverySchedulesTableRow delRow = null;

		partnerTable.insertRow(0,prtnrTblRow);
		EzBapiiteminTable tblRow = new EzBapiiteminTable();
		EziSalesOrderCreateParams iSOCrParams = new EziSalesOrderCreateParams();
	
		iSOCrParams.setOrderHeaderIn(ezHeader);
		iSOCrParams.setShipToParty(ezShipTo);
		iSOCrParams.setSoldToParty(ezSoldTo);
		iSOCrParams.setOrderPartners(partnerTable);
		iSOCrParams.setOrderItemsIn(tblRow);

	 	ezHeader.setDocType("AG");	//docType
		ezHeader.setRefDoc(setSalVal.getScDoc());  	//this is customer sales contract no
		ezHeader.setRefDocNr(setSalVal.getRefDocNr());	//setRefDoc.This is customer sap no
		ezHeader.setRef1(shipType);

		if((setSalVal.getRefDocNr() == null)||(setSalVal.getRefDocNr().trim().length()!=0))
		{
			ezHeader.setRefDocType("P");
		}
		else
		{
			ezHeader.setRefDocType("S");
		}	
		ezHeader.setDocCurrency(setSalVal.getDocCurrency());
		String netvalueH = setSalVal.getEstNetValue();
		netvalueH=(netvalueH== null|| netvalueH.trim().length()==0)?"0":netvalueH;
		//ezHeader.setNetValue(netvalueH);
		ezHeader.setPoNr("");	//setSalVal.getPoNo()
		ezHeader.setAgentCode(setSalVal.getAgent());
		ezHeader.setStatus(status);
		ezHeader.setOrderDate(new Date());
		ezHeader.setCreatedBy(user);
		ezHeader.setModifiedBy(user);

		if(("SUBMITTED").equals(status))
		{
			if(sDocNumber.trim().length()>10)
				ezHeader.setBackEndOrder("Multi Orders");
			else
				ezHeader.setBackEndOrder(sDocNumber);
		}
		else
		{
			ezHeader.setBackEndOrder("");
		}
		ezHeader.setTransferDate(new Date());	//this will be entered at the time of posting to sap
		ezHeader.setCreatedOn(new Date());	//this will be defaulted to today
		ezHeader.setModifiedOn(new Date());	//this will be defaulted to today
		ezHeader.setStatusDate(new Date());	//this will be defaulted to today
		//ezHeader.setPoMethod("EB2B");
		ezHeader.setIncoterms1(incoTerms1);
		ezHeader.setIncoterms2(incoTerms2);
		//ezHeader.setShipCond(shippingCond);
		//ezHeader.setPmnttrms(setSalVal.getPaymentTerms());
		ezHeader.setPmnttrms(paymentTerm);
		ezHeader.setText1(generalNotesAll); 
		ezHeader.setText2(generalNotes1);
		ezHeader.setText3(generalNotes2);
		ezHeader.setSalesArea(salesAreaCode);
		ezHeader.setReserved1(setSalVal.getPoDate());
		ezHeader.setFreightWeight(freightWeight);
		ezHeader.setFreightPrice(freightPrice);
		ezHeader.setFreightCharges(fServType);	//Setting freight type
		ezHeader.setFreightIns(freightIns);
		//ezHeader.setINCOTerms3("");		
		//ezHeader.setReserved2();		//this is for reason for rejection
		try
		{
			//String poDat = setSalVal.getPoDate();
			String poDat = FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
			int mn = Integer.parseInt(poDat.substring(0,2));
			int dt = Integer.parseInt(poDat.substring(3,5));
			int yr = Integer.parseInt(poDat.substring(6,10));
			GregorianCalendar reqDatePO = new GregorianCalendar(yr,mn-1,dt);
			ezHeader.setPurchDate(reqDatePO.getTime());
		}
		catch(Exception e){}
		/*try
		{
			String poDat = setSalVal.getPoDate();
			int mn = Integer.parseInt(poDat.substring(0,2));
			int dt = Integer.parseInt(poDat.substring(3,5));
			int yr = Integer.parseInt(poDat.substring(6,10));
			GregorianCalendar reqDatePO = new GregorianCalendar(yr,mn-1,dt);
			ezHeader.setPurchDate(reqDatePO.getTime());
		}catch(Exception e){}*/
		ezHeader.setReqDateH(reqDateH.getTime());
		ezHeader.setDelFlag("N");
		
		ezHeader.setQtValidF(fromQTDate.getTime());	//Valid From
		ezHeader.setQtValidT(toQTDate.getTime());	//Valid To
		
	// SOLDTO
		ezSoldTo.setSoldTo(setSalVal.getSoldTo());
		ezSoldTo.setName(setSalVal.getSoldToName());
		ezSoldTo.setStreet(setSalVal.getSoldToAddress1());
		ezSoldTo.setCity(setSalVal.getSoldToAddress2());
		ezSoldTo.setRegion(setSalVal.getSoldToState());
		ezSoldTo.setPostlCode(setSalVal.getSoldToZipcode());
		ezSoldTo.setCountry(setSalVal.getSoldToCountry());
	// SHIPTO
		
		ezShipTo.setShipTo(setSalVal.getShipTo());
		ezShipTo.setName(setSalVal.getShipToName());

		
		if(streetName!=null)
		{
			if(floorNo==null || "null".equals(floorNo) || "".equals(floorNo)) floorNo = "N/A";
			if(buildingName==null || "null".equals(buildingName) || "".equals(buildingName)) buildingName = "N/A";
			
			//String shipAddress = roomNo+"¥"+floorNo+"¥"+buildingName+"¥"+streetName;
		
			ezShipTo.setStreet(streetName);	//shipAddress
			ezShipTo.setCity(city_freq);
			ezShipTo.setRegion(state_freq);
			ezShipTo.setPostlCode(pcode_freq);
		}
		else
		{
			ezShipTo.setStreet(setSalVal.getShipToAddress1());
			ezShipTo.setCity(setSalVal.getShipToAddress2());
			ezShipTo.setRegion(setSalVal.getShipToState());
			ezShipTo.setPostlCode(setSalVal.getShipToZipcode());

		}
			ezShipTo.setCountyCde(setSalVal.getShipToCountry());

		EzBapiiteminTableRow rowItm = null;
		int rows = Integer.parseInt(setSalVal.getTotal());
		int dateReq=0,monthReq=0,yearReq=0;
		int delcount=0;
	       	java.math.BigDecimal tValue = new java.math.BigDecimal("0");

		for(int i=0;i<prodCodeLength;i++)
		{
			rowItm = new EzBapiiteminTableRow();
			prodDesc_1[i] 	= EzReplace.setReplace(prodDesc_1[i]);
			String ItemCat 	= prodItemCat_1[i];
			ItemCat 	= ((ItemCat==null)||(("").equals(ItemCat)))?"TAN":ItemCat;
			prodUomQty[i] 	= ((prodUomQty[i]==null)||(("").equals(prodUomQty[i])))?"1":prodUomQty[i];
			prodDQty_1[i] 	= ((prodDQty_1[i]==null)||(("").equals(prodDQty_1[i])))?"0":prodDQty_1[i];
			custprodCode[i]	= ((custprodCode[i]==null)||(("").equals(custprodCode[i])))?"":custprodCode[i];
			itemVenCatalog[i]	= ((itemVenCatalog[i]==null)||(("").equals(itemVenCatalog[i])))?"":itemVenCatalog[i];
			
			String itemFlag = itemMmFlag[i];
			String itemFlagType = "";
			
			if(itemFlag!=null && "Y".equals(itemFlag))
				itemFlagType = "VC";
			else if(itemFlag!=null && "CNET".equals(itemFlag))
				itemFlagType = "CNET";
			
			String itemDiscCodeVal = itemDiscCode[i];
			
			if(itemDiscCodeVal==null || "null".equals(itemDiscCodeVal) || "N/A".equals(itemDiscCodeVal)) itemDiscCodeVal = "";
			
			prodUomQty[i]	= prodUomQty[i].trim();
			desiredPrice 	= desiredPrice_1[i];
			desiredPrice 	= ((desiredPrice == null) || (("").equals(desiredPrice)))?"0":desiredPrice;
			
			itemOrgPrice 	= itemOrgPrice_1[i];
			itemOrgPrice 	= ((itemOrgPrice == null) || (("").equals(itemOrgPrice)))?"0":itemOrgPrice;
			
			itemPrice	= itemListPrice[i];
			itemPrice 	= ((itemPrice == null) || (("").equals(itemPrice)))?"0":itemPrice;
			
			listPrice	= listPrice_1[i];
			listPrice 	= ((listPrice == null) || (("").equals(listPrice)))?"0":listPrice;
			
			netValue 		= lineValue_1[i];
			String line 	= String.valueOf((i+1)*10);
			
			rowItm.setItmNumber(new java.math.BigInteger(line));	// Line numbers will be 10,20,30...
			
			rowItm.setMaterial(prodCode_1[i]);
			rowItm.setCustMat(custprodCode[i]);
			
			rowItm.setIncoterms2(itemEanUPC[i]);  //EanUPC
			rowItm.setInvoice(itemMfrNr[i]);     //MfrNR 
			
			rowItm.setMatlGroup(itemVenCatalog[i]);
			rowItm.setShortText(prodDesc_1[i]);
			rowItm.setSalesUnit(prodPack_1[i]);
			rowItm.setReqQty1(new java.math.BigDecimal(prodDQty_1[i]));
			rowItm.setConfirmedQty(new java.math.BigDecimal(prodDQty_1[i]));
			try{
				rowItm.setQtyInSalesUnit(new java.math.BigDecimal(prodUomQty[i]));
			}catch(Exception e){
				rowItm.setQtyInSalesUnit(new java.math.BigDecimal("1"));
			}
			
			log4j.log("in iAddSave prodCode_1prodCode_1prodCode_1 5"+prodCode_1[i],"W");
			log4j.log("in iAddSave custprodCodecustprodCodecustprodCode 5"+custprodCode[i],"W");

			
			log4j.log("desiredPricedesiredPriceIMPIMP	"+desiredPrice,"W");
			java.math.BigDecimal dCQTY = new java.math.BigDecimal(prodDQty_1[i]);
			java.math.BigDecimal cPrice= new java.math.BigDecimal(desiredPrice);
			java.math.BigDecimal iValue= dCQTY.multiply(cPrice);

			tValue=tValue.add(iValue); 
			
			try
			{
				monthReq = Integer.parseInt(desiredDate_1[i].substring(0,2));
				dateReq = Integer.parseInt(desiredDate_1[i].substring(3,5));
				yearReq = Integer.parseInt(desiredDate_1[i].substring(6,10));
				GregorianCalendar reqDateI = new GregorianCalendar(yearReq,monthReq-1,dateReq);

				rowItm.setReqDate( reqDateI.getTime());
				rowItm.setDlvDate( reqDateI.getTime());
			}catch(Exception e){
				rowItm.setReqDate( reqDateH.getTime());
				rowItm.setDlvDate( reqDateH.getTime());
			}
			rowItm.setListPrice(new java.math.BigDecimal(listPrice));		//portal list price
			rowItm.setSapPrice(new java.math.BigDecimal(itemOrgPrice));		//sap price
			rowItm.setReqPrice(new java.math.BigDecimal(itemPrice));		//customer neg price
			rowItm.setNetPrice(new java.math.BigDecimal(netValue));
			rowItm.setConfirmedPrice(new java.math.BigDecimal(desiredPrice));	//sap price
			rowItm.setCurrency(setSalVal.getDocCurrency());
			rowItm.setDelFlag("N");
			rowItm.setItemCateg(ItemCat);
			rowItm.setItemFOC("0");
			rowItm.setRefDocIt(new java.math.BigInteger("0"));
			rowItm.setBackEndOrder("");
			rowItm.setBackEndItem("");
			rowItm.setDiscCode(itemDiscCodeVal);
			rowItm.setItemType(itemFlagType);
			rowItm.setItemWeight(itemWeight[i]);
			rowItm.setItemIns("0");

			tblRow.insertRow(i,rowItm);

			String s = String.valueOf((i+1)*10);
			String desDate = request.getParameter("DesiredDate_"+i);

			if(!"0".equals(prodDQty_1[i]))
			{
				delRow = new EzDeliverySchedulesTableRow();
				
				delcount=delcount+1;
				delRow.setItemNumber(s);
				delRow.setScheduleLine(String.valueOf(delcount));
				delRow.setRequiredQty(prodDQty_1[i]);
				delRow.setRequiredDate(desDate);
				delRow.setDateType("");
				delRow.setRequiredTime("");
				delRow.setBlockedDelLine("");
				delRow.setScheduleLineCat("");
				delRow.setTransPlanningDate("");
				delRow.setMaterialAvailDate("");
				delRow.setLoadDate("");
				delRow.setGoodsIssueDate("");
				delRow.setTransportPlanningTime("");
				delRow.setMaterialStagingTime("");
				delRow.setLoadTime("");
				delRow.setGoodsIssueTime("");
				delRow.setRefObjectType("");
				delRow.setReserved1("");
				delRow.setReserved2("");
				delRow.setBackEndNumber("");
				delRow.setBackEndItem("");

				delTable.insertRow((delcount-1),delRow);
			}
		}
	       	ezHeader.setNetValue(tValue.toString());

//*************************Work Flow Calls Start***********************************

		ezc.ezworkflow.params.EziWFParams 		eziWfparams = new ezc.ezworkflow.params.EziWFParams();
		ezc.ezworkflow.params.EziWFDocHistoryParams 	eziWfDocHis = new ezc.ezworkflow.params.EziWFDocHistoryParams();
		Hashtable wfActions = new Hashtable();

		wfActions.put("NEW","100065");
		wfActions.put("SUBMITTED","100066");
		wfActions.put("APPROVED","100067");
		wfActions.put("REJECTED","100068");
		wfActions.put("TRANSFERED","100070");
		wfActions.put("RETURNEDBYCM","100074");
		wfActions.put("RETURNEDBYLF","100075");
		wfActions.put("RETNEW","100076");
		wfActions.put("RETTRANSFERED","100077");
		wfActions.put("RETCMTRANSFER","100078");

		String wfParticipant = (String)session.getValue("Participant");		
		eziWfparams.setParticipant(wfParticipant);
		eziWfparams.setRole((String)session.getValue("WFRole"));
		eziWfDocHis.setParticipant(wfParticipant);
		eziWfDocHis.setSysKey(salesAreaCode);
		eziWfDocHis.setTemplateCode((String)session.getValue("Template"));
		
		eziWfDocHis.setStatus(status);
		eziWfDocHis.setAuthKey("SQ_CREATE");
		eziWfDocHis.setCreatedBy(user);
		eziWfDocHis.setModifiedBy(user);
		eziWfDocHis.setSoldTo((String) session.getValue("AgentCode"));
		eziWfDocHis.setAction((String)wfActions.get(status));
		eziWfDocHis.setRef1("Y#0");
		if("SUBMITTED".equalsIgnoreCase(status))
			eziWfDocHis.setComments(sDocNumber);
		ezcParams.setObject(eziWfparams);
		ezcParams.setObject(eziWfDocHis);
		
		log4j.log("setTemplateCodesetTemplateCodesetTemplateCode::"+wfParticipant+"-->"+(String)session.getValue("WFRole")+"-->"+salesAreaCode+"-->"+(String)session.getValue("Template")+"-->"+user+"-->"+(String) session.getValue("AgentCode"),"W");

//*************************Work Flow Calls End***********************************

		ezcParams.setObject(iSOCrParams);
		ezcParams.setObject(delTable);
		try
		{
			log4j.log("ezCreateWebSalesOrderezCreateWebSalesOrderezCreateWebSalesOrder","D");
			
			EzoSalesOrderCreate   soCreate  = (EzoSalesOrderCreate) EzSalesOrderManager.ezCreateWebSalesOrder(ezcParams);
			
			log4j.log("ezCreateWebSalesOrderezCreateWebSalesOrderezCreateWebSalesOrder","D");
			
			EzoSalesOrderHeaderParams headerIn  = (EzoSalesOrderHeaderParams) soCreate.getOrderHeaderIn();
			
			log4j.log("headerIn>>>>>>>>>>>"+headerIn.toEzcString(),"D");	
			log4j.log("11111111111111111111111","W");
			
			ReturnObjFromRetrieve retShipTo = soCreate.getShipToParty(); 
			
			log4j.log("2222222222222222222222","W");
			
			ReturnObjFromRetrieve retSoldTo = soCreate.getSoldToParty();
			
			log4j.log("33333333333","W");

			weborno = headerIn.getFieldValueString(0,"WEB_ORNO");
			
			//log4j.log("headerInheaderIn:"+headerIn.toEzcString(),"W");
			
			String reason = request.getParameter("reasons");

			//** add comments to DB **//

			if(reason!=null && !"".equals(reason) && reason.trim().length()>0)
			{
				reason = replaceString(reason,"'","`");    //reason.replace("'","`");

				ezc.ezsalesquote.client.EzSalesQuoteManager qcfManager = new ezc.ezsalesquote.client.EzSalesQuoteManager();
				ezc.ezparam.EzcParams qcfMainParams = new ezc.ezparam.EzcParams(true);
				qcfMainParams.setLocalStore("Y");
				ezc.ezsalesquote.params.EziQcfCommentParams qcfParams= new ezc.ezsalesquote.params.EziQcfCommentParams();
				qcfParams.setQcfCode(weborno);
				qcfParams.setCommentNo("1");
				qcfParams.setQcfUser(Session.getUserId());
				qcfParams.setQcfComments(reason);
				qcfParams.setQcfType("COMMENTS");
				qcfParams.setQcfDestUser(Session.getUserId());
				qcfParams.setQcfExt1("$$");
				qcfMainParams.setObject(qcfParams);
				Session.prepareParams(qcfMainParams);
				qcfManager.addComment(qcfMainParams);
			}

			//** add comments to DB **//
			
			//** email triggering **//

			ReturnObjFromRetrieve partnersRet = null;
			String soldToCode = (String)session.getValue("AgentCode");
			
			if(soldToCode!=null)
			{
				soldToCode = soldToCode.trim();

				String mySoldTo = "";
				
				try
				{
					soldToCode = Long.parseLong(soldToCode)+"";
					mySoldTo = "0000000000"+soldToCode;
					mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
				}
				catch(Exception ex)
				{
					mySoldTo = soldToCode;
				}

				EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
				adminUtilsParams.setSyskeys(salesAreaCode);
				adminUtilsParams.setPartnerValueBy(mySoldTo);

				EzcParams mainParams_A = new EzcParams(false);
				mainParams_A.setObject(adminUtilsParams);
				Session.prepareParams(mainParams_A);

				partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams_A);
				
				if(partnersRet!=null && partnersRet.getRowCount()>0)
				{
					for(int l=0;l<partnersRet.getRowCount();l++)
					{
						String tmpSendToUser = partnersRet.getFieldValueString(l,"EU_ID");
						
						if(tmpSendToUser!=null && !"null".equals(tmpSendToUser)) 
						{
							tmpSendToUser = tmpSendToUser.trim();

							ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
							EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
							ezcUserNKParams.setLanguage("EN");
							ezcUserNKParams.setSys_Key("0");
							uparams.createContainer();
							uparams.setUserId(tmpSendToUser);
							uparams.setObject(ezcUserNKParams);
							Session.prepareParams(uparams);
							ReturnObjFromRetrieve retObjSubUser = (ReturnObjFromRetrieve)(UAdminManager.getAddUserDefaults(uparams));

							String isSubUser = null;
							String userStatus = null;

							if(retObjSubUser!=null && retObjSubUser.getRowCount()>0)
							{
								for(int i=0;i<retObjSubUser.getRowCount();i++)
								{
									if("ISSUBUSER".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
									{
										isSubUser=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
									}
									if("STATUS".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
									{
										userStatus=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
									}
								}
							}

							if("Y".equals(isSubUser))
							{
								if("A".equals(userStatus))
									sendToUser = sendToUser + "," + tmpSendToUser;
							}
							else
							{
								sendToUser = sendToUser + "," + tmpSendToUser;
							}
						}
						//if(tmpSendToUser!=null && !"null".equals(tmpSendToUser)) tmpSendToUser = tmpSendToUser.trim();
						//sendToUser = sendToUser + "," + tmpSendToUser;
					}
				}
			}			
			
			msgSubject = "New Sales Quotation "+sDocNumber+" has been created";
			msgText = "Dear Concerned<br><br>New Sales Quotation "+sDocNumber+" has been created and submitted for further processing.<br>";
			msgText += "<br>Regards,<br>"+Session.getUserId();

			//** email triggering **//
%>
			<%@ include file="../../../Sales2/JSPs/Misc/ezSendMail.jsp" %>
<%

			if(!(("NEW").equalsIgnoreCase(status)))
			{
				ezHeader.setDocNumber(weborno);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception In Sending Mail=======>"+e.getMessage());
			log4j.log("Exception In Sending Mail=======>"+e.getMessage(),"W");
		}

//***********************this part is to remove variables from session**********************

		if(session.getAttribute("getprices")!=null)
			session.removeAttribute("getprices");
		if(session.getAttribute("getValues")!=null)
			session.removeAttribute("getValues");
		if(session.getAttribute("itemNo")!=null)
			session.removeAttribute("itemNo");
		if(session.getValue("groups")!=null)
			session.removeValue("groups");
		if(session.getValue("retsoldto")!=null)
			session.removeValue("retsoldto");
		if(session.getAttribute("SELECTEDMET")!=null)
			session.removeAttribute("SELECTEDMET");
		if(session.getValue("ITEMSOUT")!=null)
			session.removeValue("ITEMSOUT"); 

		FormatDate formatDate = new FormatDate();
		EzcShoppingCartParams ezcShoppingCartParams = new EzcShoppingCartParams();
		EziReqParams eziReqParams  = new EziReqParams();
		EziShoppingCartParams eziShoppingCartParams = new EziShoppingCartParams();
		EzShoppingCartManager SCManager = new EzShoppingCartManager( Session );
		//eziReqParams.setProducts(prodCode_1);
		eziReqParams.setMatId(itemMatId); 
		eziReqParams.setProducts(custprodCode);
	   	eziReqParams.setReqDate(desiredDate_1);
	   	eziReqParams.setReqQty(prodDQty_1);
	     	eziShoppingCartParams.setLanguage("EN");
	     	eziShoppingCartParams.setEziReqParams(eziReqParams );
	     	eziShoppingCartParams.setObject(eziReqParams);
	        ezcShoppingCartParams.setObject(eziShoppingCartParams);
	        Session.prepareParams(ezcShoppingCartParams);
		try
		{
	             Object retObjDelete = SCManager.deleteCartElement(ezcShoppingCartParams);
		}catch(Exception e){}
	}

	if(sDocNumber == null || sDocNumber.trim().length()==0)
	{
		if(SAPnumber)
			msg = "Sales Quote: <font color=red>"+weborno+"</font> has not been posted into SAP <br><font color=red> Error:"+ ErrorMessage +"</font>";
		else
			msg = "Sales Quote has not been posted into SAP <br><font color=red> Error:"+ ErrorMessage +"</font>";
	}
	else
	{
		if(sDocNumber.trim().length()>10)
		{       				
			try
			{
				StringTokenizer sDocToken=new StringTokenizer(sDocNumber,",");
				String numbers="";
				while(sDocToken.hasMoreElements())
				{
					String a= (String)sDocToken.nextElement();
					numbers =String.valueOf(Integer.parseInt(a))+",";
				}
				numbers=numbers.substring(0,(numbers.length()-1));
				sDocNumber=numbers;
				sTempDocNumber=sDocNumber;
			}catch(Exception e){}

		}
		else
		{
			try
			{
				sTempDocNumber = sDocNumber;
				sDocNumber=String.valueOf(Integer.parseInt(sDocNumber));
			}catch(Exception e){}
		}

		if(SAPnumber)
		{
			msg = "Quotation has been created with Sales Quote no(s): <font color=red>"+sDocNumber+"</font>";
		}
		else
		{
			msg = "Quotation has not been saved but Posted into SAP with Sales Quote no(s): <font color=red>"+sDocNumber+"</font>";
		}       			
	}
        
      	session.putValue("EzMsg",msg);
%>