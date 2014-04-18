<%
	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();

	boolean authCheck = true;

	if("TRANSFERED".equals(status))
	{
		if(!"FD".equals(docType) && !userAuth_R.containsKey("SUBMIT_ORDER")) authCheck = false;
		else if("FD".equals(docType) && !userAuth_R.containsKey("FOC_APPR")) authCheck = false;

		if("true".equalsIgnoreCase(dispFlag_S) && userAuth_R.containsKey("DISP_ORDER")) authCheck = true;
	}
	else if("SUBMITTED".equals(status) && !userAuth_R.containsKey("FOC_ORDER")) authCheck = false;
	else if("NEGOTIATED".equals(status))
	{
		if(!"true".equalsIgnoreCase(vipFlag_S) && !"true".equalsIgnoreCase(dispFlag_S) && !userAuth_R.containsKey("SUBMIT_ORDER")) authCheck = false;
		if("true".equalsIgnoreCase(vipFlag_S) && !userAuth_R.containsKey("VIP_ORDER"))
			authCheck = false;
		if("true".equalsIgnoreCase(dispFlag_S) && !userAuth_R.containsKey("DISP_ORDER"))
			authCheck = false;
	}

if(authCheck)
{
	EzShoppingCartManager SCManager = new EzShoppingCartManager( Session );

	EzcShoppingCartParams params_C = new EzcShoppingCartParams();
	EziShoppingCartParams subparams_C = new EziShoppingCartParams();

	EzShoppingCart Cart_C = null;
	subparams_C.setLanguage("EN");
	params_C.setObject(subparams_C);
	Session.prepareParams(params_C);

	try
	{
		Cart_C = (EzShoppingCart)SCManager.getSavedCart(params_C);
	}
	catch(Exception err){}

	if(Cart_C!=null && Cart_C.getRowCount()==0)
	{
		msg = "<h2>YOUR ORDER HAS BEEN ALREADY SUBMITTED</h2>";
	}
	else
	{

	String product,productDesc,name,desiredQty,desiredDate,desiredPrice,value_Net,plant,Currency,custProd,itemPrice;
	String msgExt ="";
	String msgInt = "";
	String subject= "";

 	java.util.ArrayList uProdOrderType = new java.util.ArrayList();

 	for(int i=0;i<prodCodeLength;i++)
 	{
		if(!uProdOrderType.contains(splitKey[i]))
		{
			uProdOrderType.add(splitKey[i]);
		}
	}

	if(("TRANSFERED").equals(status))
	{
%>
		<%@ include file="iAddSaveSalesSapMulti.jsp"%>
<%
	}

	String msgText		= "";
	String msgSubject	= "";
	String sendToUser	= "";
	boolean sendMail	= false;

	String bgColor = "bgcolor=\"#FFFFFF\"";
	String thBGColor = " style=\"background-color: #227A7A;color: #FFFFFF;font-family: arial,sans-serif;font-size: 12px\"";
	String tdBGColor = " style=\"background-color: #ABCDCE;color: #000000;font-family: arial,sans-serif;font-size: 12px\"";
	String tdBGColorWh = " style=\"background-color: #FFFFFF;color: #FFFFFF;font-family: arial,sans-serif;font-size: 12px\"";
	String eMailData = "";

	String epoNumber = "&nbsp;",epoDate="&nbsp;",ereqDelvDate="&nbsp;";
	String ebComp="&nbsp;",ebSt="&nbsp;",ebCity="&nbsp;",ebState="&nbsp;",ebCou="&nbsp;",ebPCode="&nbsp;";
	String esComp="&nbsp;",esSt="&nbsp;",esCity="&nbsp;",esState="&nbsp;",esCou="&nbsp;",esPCode="&nbsp;";
	String eAttn="&nbsp;",eTel1="&nbsp;",eTel2="&nbsp;",eFax="&nbsp;",efType="&nbsp;",eshiIns="&nbsp;";

	ReturnObjFromRetrieve retObj=null;  
	EzcSalesOrderParams ezcParams = new EzcSalesOrderParams();      
	ezcParams.setLocalStore("Y");
	Session.prepareParams(ezcParams);      

	EzBapisdheadStructure ezHeader  = new EzBapisdheadStructure();
	EzBapisoldtoStructure ezSoldTo  = new EzBapisoldtoStructure();
	EzBapishiptoStructure ezShipTo  = new EzBapishiptoStructure();
	EzBapipartnrTable partnerTable 	= new EzBapipartnrTable();
	
	EzBapipartnrTableRow prtnrTblRow= new EzBapipartnrTableRow();

	log4j.log("****SAPnumber*****","D");

  	if(SAPnumber)
  	{
		EzDeliverySchedulesTable  delTable = new  EzDeliverySchedulesTable();
		EzDeliverySchedulesTableRow delRow = new EzDeliverySchedulesTableRow();

		prtnrTblRow.setPartnRole("AG");
		prtnrTblRow.setPartnNumb(soldToCode);

		partnerTable.insertRow(0,prtnrTblRow);
		EzBapiiteminTable tblRow = new EzBapiiteminTable();
		EziSalesOrderCreateParams iSOCrParams = new EziSalesOrderCreateParams();

		iSOCrParams.setOrderHeaderIn(ezHeader);
		iSOCrParams.setShipToParty(ezShipTo);	//ezShipTo
		iSOCrParams.setSoldToParty(ezSoldTo);
		iSOCrParams.setOrderPartners(partnerTable);
		iSOCrParams.setOrderItemsIn(tblRow);

	 	ezHeader.setDocType(docType);
		ezHeader.setRefDoc("");  	//this is customer sales contract no -- setSalVal.getScDoc()
		ezHeader.setRefDocNr("");	//setRefDoc.This is customer sap no -- setSalVal.getRefDocNr()
		ezHeader.setRef1(carrierName);

		//if((setSalVal.getRefDocNr() == null) || (setSalVal.getRefDocNr().trim().length()!=0))
		//{
			ezHeader.setRefDocType("P");
		/*}
		else
		{
			ezHeader.setRefDocType("S");
		}*/	

		ezHeader.setDocCurrency(curr);
		ezHeader.setPoNr(poNumber);
		ezHeader.setAgentCode(soldToCode);	//setSalVal.getAgent()
		ezHeader.setStatus(status);
		ezHeader.setOrderDate(new Date());
		ezHeader.setCreatedBy(user_L);
		ezHeader.setModifiedBy(user_L);

		epoNumber 	= poNumber;
		epoDate		= poDate;
		ereqDelvDate	= headerReqDate;

	log4j.log("soldToCode in DB creation call::::"+soldToCode,"I");

	log4j.log("****SAPnumber*****1","D");

		if(("TRANSFERED").equals(status))
		{
			try
			{
				if(sDocNumber.trim().length()>10)
					ezHeader.setBackEndOrder("Multi Orders");
				else
					ezHeader.setBackEndOrder(sDocNumber);
			}
			catch(Exception e)
			{
				ezHeader.setBackEndOrder("");
			}
		}
		else
		{
			ezHeader.setBackEndOrder("");
		}

	log4j.log("****SAPnumber*****2","D");


		ezHeader.setTransferDate(new Date());	//this will be entered at the time of posting to sap
		ezHeader.setCreatedOn(new Date());	//this will be defaulted to today
		ezHeader.setModifiedOn(new Date());	//this will be defaulted to today
		ezHeader.setStatusDate(new Date());	//this will be defaulted to today 
		//ezHeader.setPoMethod("EB2B");
		ezHeader.setIncoterms1(incoTerms1);
		ezHeader.setIncoterms2(incoTerms2);
		ezHeader.setShipCond(shippingCond);
		ezHeader.setPmnttrms("");		//setSalVal.getPaymentTerms()
		ezHeader.setText1(generalNotesAll); 
		ezHeader.setText2(generalNotes1); 
		ezHeader.setText3(generalNotes2);
		ezHeader.setSalesArea(sysKey);
		ezHeader.setReserved1(poDate);
		ezHeader.setPromoCode(promoCode);
		ezHeader.setFreightCharges("");		//Setting freight type   fServType
		ezHeader.setFreightWeight("0");		//freightWeight
		ezHeader.setFreightPrice(freightTotal);		//freightPrice
		ezHeader.setFreightIns("0");		//freightIns
		//ezHeader.setINCOTerms3(""); 		
		//ezHeader.setReserved2();		//this is for reason for rejection
		ezHeader.setToAct(dvToAct);
		ezHeader.setActBy(dvActBy);
		ezHeader.setDefCatL1(defCat1);	//three defect categories are added for FOC (not mandatory if requestor and approver are different)
		ezHeader.setDefCatL2(defCat2);
		ezHeader.setDefCatL3(defCat3);

		if(billToName!=null && !"null".equals(billToName))
		{
			ezHeader.setBillToName(billToName);
			ezHeader.setBillToAddr1("");//billToAddress
			ezHeader.setBillToAddr2("");
			ezHeader.setBillToStreet(billToStreet);
			ezHeader.setBillToCity(billToCity);
			ezHeader.setBillToState(billToState);
			ezHeader.setBillToZipCode(billToZipCode);
			//ezHeader.setBillToPHNO("");
			
			/*** To Log Start ***/ 
			log4j.log("****carrierName,carrierID*****"+carrierName+"***"+carrierId,"D");
			log4j.log("****billToName*****"+billToName,"D");
			log4j.log("****setBillToAddr1*****"+billToAddress,"D");
			log4j.log("****billToStreet*****"+billToStreet,"D");
			log4j.log("****billToCity*****"+billToCity,"D");
			log4j.log("****billToState*****"+billToState,"D");
			log4j.log("****billToZipCode*****"+billToZipCode,"D");
			/*** To Log End ***/
		}
		if(carrierName!=null && !"null".equals(carrierName))
		{
			ezHeader.setShipComplete(shipComplete);
			ezHeader.setShipMethod(shipMethod);
			ezHeader.setCarrierId(carrierId);
			
			/*** To Log Start ***/ 
			log4j.log("****shipComplete*****"+shipComplete,"D");
			log4j.log("****shipMethod*****"+shipMethod,"D");
			log4j.log("****carrierId*****"+carrierId,"D");
			/*** To Log End ***/
		}

	log4j.log("****SAPnumber*****3","D");

		try
		{
			String poDat = poDate;	//setSalVal.getPoDate()
			//String poDat = FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
			int mn = Integer.parseInt(poDat.substring(0,2));
			int dt = Integer.parseInt(poDat.substring(3,5));
			int yr = Integer.parseInt(poDat.substring(6,10));
			GregorianCalendar reqDatePO = new GregorianCalendar(yr,mn-1,dt);
			ezHeader.setPurchDate(reqDatePO.getTime());
		}
		catch(Exception e){}
		if("Y".equals(eddFlag)){
			ezHeader.setReqDateH(reqDateH.getTime());
		}
		ezHeader.setDelFlag("N");

	log4j.log("****SAPnumber*****4","D");

		if(soldToCode!=null)
		{
			// SOLDTO

			ezSoldTo.setSoldTo(soldToCode);
			ezSoldTo.setName(soldToName);
			ezSoldTo.setStreet(soldToStreet);
			ezSoldTo.setCity(soldToCity);
			ezSoldTo.setRegion(soldToState);
			ezSoldTo.setPostlCode(soldToZipCode);
			ezSoldTo.setCountry(soldToCountry);

			ebComp	= soldToName;
			ebSt	= soldToStreet;
			ebCity	= soldToCity;
			ebState	= soldToState;
			ebCou	= soldToCountry;
			ebPCode	= soldToZipCode;

			// SHIPTO

			ezShipTo.setShipTo(shipToCode);
			ezShipTo.setName(shipToName);
			ezShipTo.setStreet(shipToStreet);
			ezShipTo.setCity(shipToCity);
			ezShipTo.setRegion(shipToState);
			ezShipTo.setPostlCode(shipToZipCode);
			ezShipTo.setCountyCde(shipToCountry);
			ezHeader.setBillToPHNO(shipToPhNum);	//Setting ship to phone

			esComp	= shipToName;
			esSt	= shipToStreet;
			esCity	= shipToCity;
			esState	= shipToState;
			esPCode	= shipToZipCode;
			esCou	= shipToCountry;
		}
		if(templateName!=null && !"null".equals(templateName) && !"".equals(templateName))		
		{
			ezHeader.setTemplateName(templateName);
			
		}
		ezHeader.setSavedFlag(webOrdNo_C);
	log4j.log("****SAPnumber*****5","D");

		//eAttn	= shAttn;
		//eTel1	= shTel;
		//eTel2	= shMobi;
		//eFax	= shFax;
		//efType	= fServType;
		//eshiIns	= specialShIns;

		eMailData = "<Table width=\"95%\" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=1 cellSpacing=0>";
		eMailData += "<Tr><th align=\"left\" width=\"15%\" "+thBGColor+">PO No</th><td width=\"15%\" "+tdBGColor+">"+epoNumber+"</td><th align=\"left\" width=\"15%\" colSpan=2 "+thBGColor+">PO Date</th><td width=\"25%\" colSpan=2 "+tdBGColor+">"+epoDate+"</td>";
		eMailData += "<th align=\"left\" width=\"15%\" "+thBGColor+">Required Delivery Date</th><td width=\"15%\" "+tdBGColor+">"+ereqDelvDate+"</td></Tr>";
		eMailData += "<Tr><th align=\"left\" colspan = 4 "+thBGColor+">Sold To  Address</th><Th align=\"left\" colspan = 4 cellPadding=3 cellSpacing=0 "+thBGColor+">Ship To Address</Th></Tr>";
		eMailData += "<Tr><Td align=right "+tdBGColor+">Company:</Td><td colspan=2 "+tdBGColor+">"+ebComp+"</Td><Td align=right "+tdBGColor+">Company:</Td><Td colspan = 2 "+tdBGColor+">"+esComp+"</Td><Td align=right "+tdBGColor+">Attn.:</Td><Td "+tdBGColor+">"+eAttn+"</Td></Tr>";
		eMailData += "<Tr><Td align=right "+tdBGColor+">Street:</Td><td colspan=2 "+tdBGColor+">"+ebSt+"</Td><Td align=right "+tdBGColor+">Street:</Td><Td  colspan=2 "+tdBGColor+">"+esSt+"</Td><Td align=right "+tdBGColor+">Tel# 1</Td><Td "+tdBGColor+">"+eTel1+"</Td></Tr>";
		eMailData += "<Tr><Td align=right "+tdBGColor+">City:</Td><td colspan=2 "+tdBGColor+">"+ebCity+"</Td><Td align=right "+tdBGColor+">City:</Td><Td colspan=2 "+tdBGColor+">"+esCity+"</Td><Td align=right "+tdBGColor+">Tel# 2</Td><Td "+tdBGColor+">"+eTel2+"</Td></Tr>";
		eMailData += "<Tr><Td align=right "+tdBGColor+">State:</Td><td colspan=2 "+tdBGColor+">"+ebState+"</Td><Td align=right "+tdBGColor+">State:</Td><Td  colspan=2 "+tdBGColor+">"+esState+"</Td><Td align=right "+tdBGColor+">Fax #</Td><Td "+tdBGColor+">"+eFax+"</Td></Tr>";
		eMailData += "<Tr><Td align=right "+tdBGColor+">Country:</Td><td colspan=2 "+tdBGColor+">"+ebCou+"</Td><Td align=right "+tdBGColor+">Country:</Td><Td  colspan=2 "+tdBGColor+">"+esCou+"</td><Td align=right "+tdBGColor+">Freight Type</Td><Td "+tdBGColor+">"+efType+"</Td></Tr>";
		eMailData += "<Tr><Td align=right "+tdBGColor+">Postal Code:</Td><td colspan=2 "+tdBGColor+">"+ebPCode+"</Td><Td align=right "+tdBGColor+">Postal Code:</Td><Td colspan=4 "+tdBGColor+">"+esPCode+"</Td></Tr></Table>";
		//eMailData += "<Tr><Th colspan=8 "+thBGColor+">Special Shipping Instructions (for Freight Type - Special Only)</Th></Tr>";
		//eMailData += "<Tr><Td colspan=8 "+tdBGColor+">"+eshiIns+"</Td></Tr></Table>";
		eMailData += "<Table width=\"95%\"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=1 cellSpacing=0 >";
		eMailData += "<Tr><th width=\"10%\" valign=\"top\" "+thBGColor+">Product</th><th width=\"28%\" valign=\"top\" "+thBGColor+">Description</th><th width=\"10%\" valign=\"top\" "+thBGColor+">Manufacturer</th><th width=\"10%\" valign=\"top\" align=\"right\" "+thBGColor+">List Price</th><th width=\"8%\" valign=\"top\" align=\"right\" "+thBGColor+">Quantity</th><th width=\"10%\" valign=\"top\" align=\"right\" "+thBGColor+">Discount Price [USD]</th><th width=\"8%\" valign=\"top\" align=\"right\" "+thBGColor+">Anticipated Price [USD]</th><Th width=\"16%\" valign=\"top\" align=\"right\" "+thBGColor+">Total Price [USD]</Th></Tr>";

		EzBapiiteminTableRow rowItm = null;
		//int rows = Integer.parseInt(setSalVal.getTotal());
		int dateReq=0,monthReq=0,yearReq=0;
		int delcount=0;
	       	java.math.BigDecimal tValue = new java.math.BigDecimal("0");
	log4j.log("****SAPnumber*****6","D");

	for(int us=0;us<uProdOrderType.size();us++)
	{
		String splitKey_A = (String)uProdOrderType.get(us);

		for(int i=0;i<prodCodeLength;i++)
		{
			if(splitKey[i].equals(splitKey_A))
			{
			rowItm = new EzBapiiteminTableRow();
			prodDesc_1[i] 	= EzReplace.setReplace(prodDesc_1[i]);
			prodDesc_1[i]	= prodDesc_1[i].replaceAll("'","`");
			String ItemCat 	= prodItemCat_1[i];
			ItemCat 	= ((ItemCat==null)||(("").equals(ItemCat)))?"TAN":ItemCat;
			prodUomQty[i] 	= ((prodUomQty[i]==null)||(("").equals(prodUomQty[i])))?"1":prodUomQty[i];
			prodCQty_1[i] 	= ((prodCQty_1[i]==null)||(("").equals(prodCQty_1[i])))?"0":prodCQty_1[i];
			custprodCode[i]	= ((custprodCode[i]==null)||(("").equals(custprodCode[i])))?"":custprodCode[i];
			itemVenCatalog[i]= ((itemVenCatalog[i]==null)||(("").equals(itemVenCatalog[i])))?"":itemVenCatalog[i];
			itemVenCatalog[i]= itemVenCatalog[i].replaceAll("'","`");
			listPrice[i]	= ((listPrice[i]==null)||(("").equals(listPrice[i])))?"":listPrice[i];
			quoteNum_1[i]	= ((quoteNum_1[i]==null)||(("").equals(quoteNum_1[i])))?"":quoteNum_1[i];
			lineNum_1[i]	= ((lineNum_1[i]==null)||(("").equals(lineNum_1[i])))?"":lineNum_1[i];
			dispFlag[i]	= ((dispFlag[i]==null)||(("").equals(dispFlag[i])))?"":dispFlag[i];
			vipFlag[i]	= ((vipFlag[i]==null)||(("").equals(vipFlag[i])))?"":vipFlag[i];
			qsFlag[i]	= ((qsFlag[i]==null)||(("").equals(qsFlag[i])))?"":qsFlag[i];
			itemCustSku[i]	= ((itemCustSku[i]==null)||(("").equals(itemCustSku[i])))?"":itemCustSku[i];
			itemPoLine[i]	= ((itemPoLine[i]==null)||(("").equals(itemPoLine[i])))?"":itemPoLine[i];
			splitKey[i]	= ((splitKey[i]==null)||(("").equals(splitKey[i])))?"":splitKey[i];
			itemEanUPC[i]	= ((itemEanUPC[i]==null)||(("").equals(itemEanUPC[i])))?"":itemEanUPC[i];
			itemMultiplier[i]= ((itemMultiplier[i]==null)||(("").equals(itemMultiplier[i])))?"":itemMultiplier[i];
			kitComp_1[i]	= ((kitComp_1[i]==null)||(("").equals(kitComp_1[i])))?"0":kitComp_1[i];
			
				
			
			String itemFlag = itemMmFlag[i];
			String itemFlagType = "";
	log4j.log("****SAPnumber*****7","D");
			
			if(itemFlag!=null && "Y".equals(itemFlag))
				itemFlagType = "VC";
			else if(itemFlag!=null && "CNET".equals(itemFlag))
				itemFlagType = "CNET";
	log4j.log("****SAPnumber*****8","D");
			
			String itemDiscCodeVal 	= itemDiscCode[i];
			String itemPromoCodeVal = itemPromoCode[i];
			String itemCnetProdVal	= itemCnetProd[i];
			
			if(itemDiscCodeVal==null || "null".equals(itemDiscCodeVal) || "N/A".equals(itemDiscCodeVal)) itemDiscCodeVal = "";
			if(itemPromoCodeVal==null || "null".equals(itemPromoCodeVal)) itemPromoCodeVal = "";
			if(itemCnetProdVal==null || "null".equals(itemCnetProdVal)) itemCnetProdVal = "";

	log4j.log("****SAPnumber*****8","D");

			prodUomQty[i]	= prodUomQty[i].trim();

	log4j.log("****SAPnumber*****8","D");

			//desiredPrice = ((desiredPrice_1[i]==null) || (("").equals(desiredPrice_1[i])))?"0":desiredPrice_1[i];

	log4j.log("****SAPnumber*****8","D");

			itemPrice = ((itemListPrice[i]==null) || (("").equals(itemListPrice[i])))?"0":itemListPrice[i];
			desiredPrice = itemPrice;

	log4j.log("****SAPnumber*****8","D");

			if(desiredPrice!=null)desiredPrice=desiredPrice.trim();
			if(itemPrice!=null)itemPrice=itemPrice.trim();

	log4j.log("****SAPnumber*****8","D");
			String lNo	  = itemLineItem[i];
			String stdMulti_L = request.getParameter("stdMulti_"+lNo);
			String netPrice_L = request.getParameter("netPrice_"+lNo);
			String listPriceF = request.getParameter("listPriceF_"+lNo);

			value_Net 	= lineValue_1[i];
			String line 	= String.valueOf((i+1)*10);
			String backline = splitItemNo_1[i];

			rowItm.setItmNumber(new java.math.BigInteger(line));	// Line numbers will be 10,20,30...
			
			rowItm.setMaterial(prodCode_1[i]);
			rowItm.setCustMat(custprodCode[i]);
	log4j.log("****SAPnumber*****9","D");
			
			rowItm.setIncoterms2(itemMfrCode[i]);  //itemMfrCode
			rowItm.setInvoice(itemMfrNr[i]);  	//MfrNR 
			rowItm.setItemUPC(itemEanUPC[i]); //itemEanUPC -- EanUPC 
	log4j.log("****SAPnumber*****9","D");
	log4j.log(">>>>>>prodDesc_1>>>>"+prodDesc_1[i],"D");

			rowItm.setMatlGroup(itemVenCatalog[i]);
			rowItm.setShortText(prodDesc_1[i]);
			rowItm.setSalesUnit(prodPack_1[i]);
			rowItm.setReqQty1(new java.math.BigDecimal(prodCQty_1[i]));
			rowItm.setConfirmedQty(new java.math.BigDecimal(prodCQty_1[i]));
	log4j.log("****SAPnumber*****9","D");

			try{
				rowItm.setQtyInSalesUnit(new java.math.BigDecimal(prodUomQty[i]));
			}catch(Exception e){
				rowItm.setQtyInSalesUnit(new java.math.BigDecimal("1"));
			}
			
			log4j.log("in iAddSave prodCode_1prodCode_1prodCode_1 5"+prodCode_1[i],"W");
			log4j.log("in iAddSave custprodCodecustprodCodecustprodCode 5"+custprodCode[i],"W");

			
			log4j.log("desiredPricedesiredPriceIMPIMP	"+desiredPrice,"W");
			java.math.BigDecimal dCQTY = new java.math.BigDecimal(prodCQty_1[i]);
			java.math.BigDecimal cPrice= new java.math.BigDecimal(netPrice_L);	//desiredPrice
			java.math.BigDecimal itemListPrice_S= new java.math.BigDecimal(listPrice[i]);
			java.math.BigDecimal iValue= dCQTY.multiply(cPrice); //cPrice
			tValue=tValue.add(iValue); 
	log4j.log("****SAPnumber*****10","D");
			
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
			rowItm.setReqPrice(new java.math.BigDecimal(desiredPrice)); //itemListPrice_S
			rowItm.setNetPrice(new java.math.BigDecimal(value_Net));
			rowItm.setConfirmedPrice(new java.math.BigDecimal(netPrice_L));	//itemPrice
			
			rowItm.setItemListPrice(itemListPrice_S.toString());
			rowItm.setListPrice(new java.math.BigDecimal(listPriceF));
			rowItm.setItemMultiplier(stdMulti_L);
			
			/*log4j.log("rowItm.setReqPrice::::::::"+rowItm.getReqPrice(),"D");
			log4j.log("rowItm.setNetPrice::::::::"+rowItm.getNetPrice(),"D");
			log4j.log("rowItm.setConfirmedPrice::::::::"+rowItm.getConfirmedPrice(),"D");
			log4j.log("rowItm.setItemListPrice::::::::"+rowItm.getItemListPrice(),"D");*/
			
			rowItm.setCurrency(curr);
			rowItm.setDelFlag("N");
			rowItm.setItemCateg(ItemCat);
			rowItm.setItemFOC("0");
			rowItm.setItemType(itemFlagType);
			rowItm.setRefDocIt(new java.math.BigInteger("0"));
			rowItm.setDiscCode(itemDiscCodeVal);
			rowItm.setPromoCode(itemPromoCodeVal);
			rowItm.setItemWeight("0");	//itemWeight[i]
			rowItm.setItemIns(kitComp_1[i]);	//No. of kit components for this product
			rowItm.setNotes(itemCnetProdVal);
			rowItm.setPlant(itemPlant[i]);	//Split exceptions
			
			String orderType_O="";
			String salesOrg_O ="";
			String div_O = "";
			String dc_O ="";
			try
			{
				orderType_O = splitKey[i].split("¥")[0];
				salesOrg_O = splitKey[i].split("¥")[1];
				div_O 	= splitKey[i].split("¥")[2];
				dc_O 	= splitKey[i].split("¥")[3];
			}
			catch(Exception e){log4j.log(">>>>>>Exception in splitting>>>>"+e,"D");}
					
			/******* To LOG *****/
			log4j.log(">>>>>>orderType>>>>"+orderType_O,"D");
			log4j.log(">>>>>>salesOrg>>>>"+salesOrg_O,"D");
			log4j.log(">>>>>>div_O>>>>"+div_O,"D");
			log4j.log(">>>>>>dc_O>>>>"+dc_O,"D");
			log4j.log(">>>>>>quoteNum_1[i]>>>>"+quoteNum_1[i],"D");
			log4j.log(">>>>>>lineNum_1[i]>>>>"+lineNum_1[i],"D");
			log4j.log(">>>>>>dispFlag[i]>>>>"+dispFlag[i],"D");
			log4j.log(">>>>>>vipFlag[i]>>>>"+vipFlag[i],"D");
			log4j.log(">>>>>>qsFlag[i]>>>>"+qsFlag[i],"D");
			log4j.log(">>>>>>itemCustSku[i]>>>>"+itemCustSku[i],"D");
			log4j.log(">>>>>>itemPoLine[i]>>>>"+itemPoLine[i],"D");
			log4j.log(">>>>>>itemVenCatalog[i]>>>>"+itemVenCatalog[i],"D");
			log4j.log(">>>>>>Points[i]>>>>"+session.getValue(itemVenCatalog[i]),"D");
			log4j.log(">>>>>>itemMultiplier[i]>>>>"+itemMultiplier[i],"D");
			/******* To LOG *****/			
						
			rowItm.setSalesOrg(salesOrg_O);
			rowItm.setDivision(div_O);
			rowItm.setDistributionChanel(dc_O);
			rowItm.setItemOrderType(orderType_O);
			
			rowItm.setVipFlag(vipFlag[i]);
			rowItm.setDispFlag(dispFlag[i]);
			rowItm.setSplFlag(qsFlag[i]);	// Need to set for products from specail catalogs like quick ship etc..
			rowItm.setQuoteREFNO(quoteNum_1[i]);
			rowItm.setQuoteLineNO(lineNum_1[i]);
			rowItm.setPoints(itemPoints[i]);	//(String)session.getValue(itemVenCatalog[i])
			rowItm.setPointsCatalog(itemVenCatalog[i]);
			rowItm.setCustSKU(itemCustSku[i]);
			rowItm.setCustPOLineNO(itemPoLine[i]);
			//rowItm.setItemMultiplier(itemMultiplier[i]);
			rowItm.setQuestionRefNO("");	//This need to bet set once ASK A QUESTION is developed.
			
	log4j.log("****SAPnumber*****11","D");

			if(("TRANSFERED").equals(status))
			{
				String backorderno="";
				String actLine ="";
				if(orders!=null && orders.getRowCount()>0)
				{
					if(ordItems!=null && ordItems.getRowCount()>0)
					{
						for(int ordItm = 0;ordItm<ordItems.getRowCount();ordItm++)
						{
							String ordItmSpKey = ordItems.getFieldValueString(ordItm,"SplitKey");
							String sMatCode = ordItems.getFieldValueString(ordItm,"Material");

							if(ordItmSpKey.equals(splitKey_A) && prodCode_1[i].equals(sMatCode))
							{
								actLine = ordItems.getFieldValueString(ordItm,"ItmNumber");

								for(int ord = 0;ord<orders.getRowCount();ord++)
								{
									String ordHSpKey = orders.getFieldValueString(ord,"SplitKey");

									if(ordItmSpKey.equals(ordHSpKey))
									{
										backorderno = orders.getFieldValueString(ord,"DocNumber");
										break;
									}
								}
							}
						}
					}
				}
				rowItm.setBackEndOrder(backorderno);
				rowItm.setBackEndItem(actLine);
			}
			else
			{
				rowItm.setBackEndOrder("");
				rowItm.setBackEndItem(backline);
			}
	log4j.log("****SAPnumber*****11","D");

			tblRow.appendRow(rowItm);
			String del_Qty 		     = ((del_sch_qty_1[i]==null)||(("").equals(del_sch_qty_1[i])))?"0":del_sch_qty_1[i];
			String del_Dates 	     = ((del_sch_date_1[i]==null)||(("").equals(del_sch_date_1[i])))?" ":del_sch_date_1[i];
			StringTokenizer del_Dates_St = new StringTokenizer(del_Dates,"@@");
			StringTokenizer del_Qty_ST   = new StringTokenizer(del_Qty,"@@");
			int del_Qty_Count 	     = del_Qty_ST.countTokens();
			String schqty1[]  	     = new String[del_Qty_Count];
			String schdate1[] 	     = new String[del_Qty_Count];

	log4j.log("****SAPnumber*****12","D");

			if(del_Qty_Count>0)
			{
				for(int d=0;d<del_Qty_Count;d++)
				{
					delRow = new  EzDeliverySchedulesTableRow();
					schqty1[d] 	= del_Qty_ST.nextToken();
					schdate1[d] 	= del_Dates_St.nextToken();
					schqty1[d] 	= ((schqty1[d] == null) || ("null".equals(schqty1[d]) ) ||(schqty1[d].trim().length() ==0) )?"0":schqty1[d];
					String s 	= String.valueOf( (i+1)*10);

					if(!"0".equals(schqty1[d]))
					{
						delcount=delcount+1;
						delRow.setItemNumber(s);
						delRow.setScheduleLine(String.valueOf(delcount));
						delRow.setRequiredQty(schqty1[d]);
						delRow.setRequiredDate(schdate1[d]);
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
						if((("TRANSFERED").equals(status)) && (sDocNumber!=null) && (sDocNumber.trim().length()!=0) && (!"null".equals(sDocNumber)))
						{
							String backorderno="";
							String actLine ="";
							if(orders!=null && orders.getRowCount()>0)
							{
								if(ordItems!=null && ordItems.getRowCount()>0)
								{
									for(int ordItm = 0;ordItm<ordItems.getRowCount();ordItm++)
									{
										String ordItmSpKey = ordItems.getFieldValueString(ordItm,"SplitKey");
										String sMatCode = ordItems.getFieldValueString(ordItm,"Material");

										if(ordItmSpKey.equals(splitKey_A) && prodCode_1[i].equals(sMatCode))
										{
											actLine = ordItems.getFieldValueString(ordItm,"ItmNumber");

											for(int ord = 0;ord<orders.getRowCount();ord++)
											{
												String ordHSpKey = orders.getFieldValueString(ord,"SplitKey");

												if(ordItmSpKey.equals(ordHSpKey))
												{
													backorderno = orders.getFieldValueString(ord,"DocNumber");
													break;
												}
											}
										}
									}
								}
							}
							delRow.setBackEndNumber(backorderno);
							delRow.setBackEndItem(actLine);
						}
						else
						{
							delRow.setBackEndNumber("");
							delRow.setBackEndItem(backline);
						}	
						delTable.insertRow((delcount-1),delRow);
					}
				}
			}
			//eMailData += "<Tr><Td width=\"10%\" align=\"left\"   "+tdBGColor+">"+custprodCode[i]+"</Td><Td width=\"28%\" align=\"left\"   "+tdBGColor+">"+prodDesc_1[i]+"</Td><Td width=\"10%\" align=\"center\" "+tdBGColor+">"+itemMfrNr[i]+"</Td><Td width=\"10%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(itemOrgPrice[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"8%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(prodCQty_1[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"10%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(desiredPrice)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"8%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(itemPrice)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(finalPriceVal_1[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td></Tr>";
			log4j.log("for loop end>>>>>>"+i,"W");
			}
		}
	}
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Freight</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+freightPrice+"</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Freight Insurance</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+freightIns+"</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Tax</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">TBD</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Total</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+grandTotalVal+"</Td></Tr>";
		
		eMailData +="</Table>";
		eMailData = "";
	       	ezHeader.setNetValue(tValue.toString());
	       	log4j.log("for loop out#####","W");

//*************************Work Flow Calls Start***********************************

		ezc.ezworkflow.params.EziWFParams 		eziWfparams = new ezc.ezworkflow.params.EziWFParams();
		ezc.ezworkflow.params.EziWFDocHistoryParams 	eziWfDocHis = new ezc.ezworkflow.params.EziWFDocHistoryParams();
		Hashtable wfActions = new Hashtable();

		wfActions.put("NEW","100065");
		wfActions.put("NEGOTIATED","100064");
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
		eziWfDocHis.setSysKey(sysKey);
		eziWfDocHis.setTemplateCode((String)session.getValue("Template"));
		eziWfDocHis.setAuthKey("SO_CREATE");
		eziWfDocHis.setCreatedBy(user_L);
		eziWfDocHis.setModifiedBy(user_L);
		eziWfDocHis.setSoldTo(soldToCode); //(String) session.getValue("AgentCode")
		eziWfDocHis.setAction((String)wfActions.get(status.trim()));
		//eziWfDocHis.setStatus(status);
		eziWfDocHis.setComments("ESCALATED");	//This will not allow to enter into audit trail table
		
		//if("TRANSFERED".equalsIgnoreCase(status))
			//eziWfDocHis.setComments(sDocNumber);
		ezcParams.setObject(eziWfparams);
		ezcParams.setObject(eziWfDocHis);
		
		//log4j.log("setTemplateCodesetTemplateCodesetTemplateCode::"+wfParticipant+"-->"+(String)session.getValue("WFRole")+"-->"+sysKey+"-->"+(String)session.getValue("Template")+"-->"+user_L+"-->"+(String) session.getValue("AgentCode")+"-->"+soldToCode,"W");

//*************************Work Flow Calls End***********************************
/*************************Negotiated Order Status Update Start***********************************/
		EzNegotiationManager ezNegotiationManager=null;
		EziOrderNegotiateParams ezOrderNegotiateParams=null;
		EzcParams negParams = null;
		EziMiscParams miscParamsNeg = new EziMiscParams();
		if("TRANSFERED".equalsIgnoreCase(status))
		{
			ezNegotiationManager = new EzNegotiationManager();
			ezOrderNegotiateParams = new EziOrderNegotiateParams();
			negParams = new EzcParams(false);
			ReturnObjFromRetrieve retNeg = null;

			/*ezOrderNegotiateParams.setType("GET_ORDER_NEGOTIATE_DETAILS");
			ezOrderNegotiateParams.setOrderNo(webOrdNo_S);
			negParams.setLocalStore("Y");
			negParams.setObject(ezOrderNegotiateParams);
			Session.prepareParams(negParams);
			log4j.log("<<<<setOrderNo>>>>>"+ezOrderNegotiateParams.getOrderNo(),"I");
			try
			{
				retNeg = (ReturnObjFromRetrieve)ezNegotiationManager.ezGetOrderNegotiate(negParams);
			}
			catch(Exception e)
			{
				log4j.log("Exception in ezGetOrderNegotiate"+e,"E");
			}*/
			
			miscParamsNeg.setIdenKey("MISC_SELECT");
			miscParamsNeg.setQuery("SELECT * FROM EZC_ORDER_NEGOTIATE WHERE EON_ORDER_NO = '"+webOrdNo_S+"'" );

			negParams.setLocalStore("Y");
			negParams.setObject(miscParamsNeg);
			Session.prepareParams(negParams);	

			try
			{		
				ezc.ezcommon.EzLog4j.log("miscParamsNeg.getQuery()::::::::"+miscParamsNeg.getQuery() ,"I");
				retNeg = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(negParams);
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}			
			
			if(retNeg!=null && retNeg.getRowCount()>0)
			{
				/*ezOrderNegotiateParams.setOrderNo(webOrdNo_S);
				ezOrderNegotiateParams.setStatus("ACCEPTED");
				negParams.setLocalStore("Y");
				negParams.setObject(ezOrderNegotiateParams);
				Session.prepareParams(negParams);*/
				
				miscParamsNeg.setIdenKey("MISC_UPDATE");
 				miscParamsNeg.setQuery("UPDATE EZC_ORDER_NEGOTIATE SET EON_MODIFIED_BY='"+Session.getUserId()+"', EON_STATUS='ACCEPTED' WHERE EON_ORDER_NO='"+webOrdNo_S+"'");
 				negParams.setLocalStore("Y");
				negParams.setObject(miscParamsNeg);
				Session.prepareParams(negParams);				
				//log4j.log("<<<<setOrderNo>>>>>"+ezOrderNegotiateParams.getOrderNo(),"I");
				//log4j.log("<<<<setStatus>>>>>"+ezOrderNegotiateParams.getStatus(),"I");
			}
		}
/*************************Negotiated Order Status Update End***********************************/

		ezcParams.setObject(iSOCrParams);
		ezcParams.setObject(delTable);
		try
		{
		log4j.log("ezCreateWebSalesOrderezCreateWebSalesOrderezCreateWebSalesOrder","D");
			EzoSalesOrderCreate   soCreate  = (EzoSalesOrderCreate) EzSalesOrderManager.ezCreateWebSalesOrder(ezcParams);
			try
			{
				ezMiscManager.ezUpdate(negParams);
			}
			catch(Exception e)
			{
				log4j.log("Exception in ezUpdateOrderNegotiate"+e,"E");
			}			
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

			//** file attachment **//

			String attachString = (String)session.getValue("ATTACHEDFILES");//request.getParameter("attachString");

			if(attachString != null)
			{
				if(!"".equals(attachString))
				{
					String objNo 		= weborno;
					String documentType 	= "SO";
%>
					<%@ include file="../../../Sales/JSPs/UploadFiles/ezSaveAttachFiles.jsp" %>
<%
				}
			}

			//** file attachment **//

			sendToUser = user_L;

			if(!(("NEW").equalsIgnoreCase(status)) && !(("NEGOTIATED").equalsIgnoreCase(status)))
			{
				ezHeader.setDocNumber(weborno);
			}
			if(("SUBMITTED").equals(status))
			{
	      	 		/*String mailMessage="New Sales Order ( "  + weborno + ") has been created.";
				String mailMessageDetails=" PO NO : " + ezHeader.getPoNr()  + "\n";
				mailMessageDetails= mailMessageDetails + "Customer  : " + ezSoldTo.getName()  + "(" + ezSoldTo.getSoldTo() + ")\n";*/
				
				subject= "New Sales Order ("+ weborno+") has been created.";				
				msgExt = "New Sales Order ("+ weborno+") has been created.<BR> PO NO : "+ ezHeader.getPoNr()+".<BR>Customer  : " + ezSoldTo.getName()  + "(" + ezSoldTo.getSoldTo() + ")<BR>";
				
				if(msgExt!=null)
				{
					msgInt = msgExt.replaceAll("<BR>","\n");					
				}

				/*ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
		   	   	mailParams.setGroupId("Ezc");
				mailParams.setMsgText(mailMessage + "\nDetails are as follows\n" + mailMessageDetails);
				java.util.ResourceBundle toMail = java.util.ResourceBundle.getBundle("EzSalesMail");
				mailParams.setTo(toMail.getString("TO"));
				mailParams.setCC(toMail.getString("CC"));
				mailParams.setBCC(toMail.getString("BCC"));
   		   		mailParams.setSubject("New Web Sales Order(" +  weborno + ") has been submitted by " + Session.getUserId());
				ezc.ezmail.EzMail soMails=new ezc.ezmail.EzMail();
				soMails.ezSend(mailParams,Session);*/
			}
		}catch(Exception e)
		{
			System.out.println("Exception In Sending Mail=======>"+e.getMessage());
			log4j.log("Exception In Sending Mail=======>"+e.getMessage(),"W");
		}

//***********************this part is to remove variables from session**********************

		session.removeValue("Faucets(incl. Flush Valves)-Non Luxury");
		session.removeValue("Faucets(incl. Flush Valves)-Luxury"); 
		session.removeValue("Chinaware"); 
		session.removeValue("Americast & Acrylics (Excludes Acrylux)"); 
		session.removeValue("Acrylux");
		session.removeValue("Enamel Steel"); 
		session.removeValue("Marble"); 
		session.removeValue("Shower Doors-Standard"); 
		session.removeValue("Shower Doors-Custom"); 
		session.removeValue("Walk In Baths"); 
		session.removeValue("Repair Parts"); 
		session.removeValue("JADO"); 
		session.removeValue("FIAT");

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

		if(session.getValue("PURP_PREP")!=null)
			session.removeValue("PURP_PREP"); 
		if(session.getValue("REASON_PREP")!=null)
			session.removeValue("REASON_PREP"); 
		if(session.getValue("EXPL_PREP")!=null)
			session.removeValue("EXPL_PREP"); 
		if(session.getValue("APPR_PREP")!=null)
			session.removeValue("APPR_PREP"); 
		if(session.getValue("DEFCAT1_PREP")!=null)
			session.removeValue("DEFCAT1_PREP"); 
		if(session.getValue("DEFCAT2_PREP")!=null)
			session.removeValue("DEFCAT2_PREP"); 
		if(session.getValue("DEFCAT3_PREP")!=null)
			session.removeValue("DEFCAT3_PREP"); 

		if(session.getValue("PONUM_PREP")!=null)
			session.removeValue("PONUM_PREP"); 
		if(session.getValue("PODATE_PREP")!=null)
			session.removeValue("PODATE_PREP"); 
		if(session.getValue("SOLDTO_PREP")!=null)
			session.removeValue("SOLDTO_PREP"); 
		if(session.getValue("COMMENTS_PREP")!=null)
			session.removeValue("COMMENTS_PREP"); 
		if(session.getValue("SHIPINST_PREP")!=null)
			session.removeValue("SHIPINST_PREP"); 
		if(session.getValue("SHIPCOMP_PREP")!=null)
			session.removeValue("SHIPCOMP_PREP"); 
		if(session.getValue("SHIPMETHOD_PREP")!=null)
			session.removeValue("SHIPMETHOD_PREP"); 
		if(session.getValue("DESDATE_PREP")!=null)
			session.removeValue("DESDATE_PREP"); 
		if(session.getValue("CARRNAME_PREP")!=null)
			session.removeValue("CARRNAME_PREP"); 
		if(session.getValue("CARRID_PREP")!=null)
			session.removeValue("CARRID_PREP"); 
		if(session.getValue("BNAME_PREP")!=null)
			session.removeValue("BNAME_PREP"); 
		if(session.getValue("BSTREET_PREP")!=null)
			session.removeValue("BSTREET_PREP"); 
		if(session.getValue("BCITY_PREP")!=null)
			session.removeValue("BCITY_PREP"); 
		if(session.getValue("BSTATE_PREP")!=null)
			session.removeValue("BSTATE_PREP"); 
		if(session.getValue("BZIPCODE_PREP")!=null)
			session.removeValue("BZIPCODE_PREP"); 
		if(session.getValue("SHIPTO_PREP")!=null)
			session.removeValue("SHIPTO_PREP");
		if(session.getValue("ATTACHEDFILES")!=null)
			session.removeValue("ATTACHEDFILES");
		if(session.getValue("CARRUSE_PREP")!=null)
			session.removeValue("CARRUSE_PREP"); 
		if(session.getValue("SHIPNA_PREP")!=null)
			session.removeValue("SHIPNA_PREP"); 
		if(session.getValue("SHIPSR_PREP")!=null)
			session.removeValue("SHIPSR_PREP"); 
		if(session.getValue("SHIPCT_PREP")!=null)
			session.removeValue("SHIPCT_PREP"); 
		if(session.getValue("SHIPST_PREP")!=null)
			session.removeValue("SHIPST_PREP"); 
		if(session.getValue("SHIPCN_PREP")!=null)
			session.removeValue("SHIPCN_PREP"); 
		if(session.getValue("SHIPZC_PREP")!=null)
			session.removeValue("SHIPZC_PREP"); 
		if(session.getValue("SHIPPH_PREP")!=null)
			session.removeValue("SHIPPH_PREP");
		if(session.getValue("ISRESID_PREP")!=null)
			session.removeValue("ISRESID_PREP");

		EzcShoppingCartParams ezcShoppingCartParams = new EzcShoppingCartParams();
		EziReqParams eziReqParams  = new EziReqParams();
		EziShoppingCartParams eziShoppingCartParams = new EziShoppingCartParams();
		eziReqParams.setProducts(itemLineItem);
		eziReqParams.setMatId(itemMatId);
		//eziReqParams.setProducts(custprodCode);
	   	eziReqParams.setReqDate(desiredDate_1);
	   	eziReqParams.setReqQty(prodCQty_1);
	     	eziShoppingCartParams.setLanguage("EN");
	     	eziShoppingCartParams.setEziReqParams(eziReqParams );
	     	eziShoppingCartParams.setObject(eziReqParams);
	        ezcShoppingCartParams.setObject(eziShoppingCartParams);
	        Session.prepareParams(ezcShoppingCartParams);
		try
		{
			Object retObjDelete = SCManager.deleteCartElement(ezcShoppingCartParams);
			//Object retObjDelete1 = SCManager.deletePersistentCartElement(ezcShoppingCartParams);
%>
			<%@ include file="iDeletePersistentCart.jsp"%>
<%
		}catch(Exception e){}				
	}

	String custName_M = "";

	log4j.log("statusstatusstatus======>"+status, "D");
	

	/*for(int i=0;i<prodCodeLength;i++)
	{
	
		String line 	= String.valueOf((i+1)*10);
				
		
		EzcParams plantMainParams = new EzcParams(false);
		EziMiscParams miscParams_A = new EziMiscParams();

		miscParams_A.setQuery("UPDATE EZC_SALES_DOC_ITEMS SET ESDI_PLANT='"+itemPlant[i]+"' WHERE ESDI_SALES_DOC='"+weborno+"' AND ESDI_SALES_DOC_ITEM='"+(new java.math.BigInteger(line))+"'");
		plantMainParams.setLocalStore("Y");
		plantMainParams.setObject(miscParams_A);
		Session.prepareParams(plantMainParams);

		ezMiscManager.ezUpdate(plantMainParams);

	}*/
	String mySoldTo_A = "";
	String offLink = "";
	String toEncryp = "";
	String encrypText = "";

	try
	{
		soldToCode = Long.parseLong(soldToCode)+"";
		mySoldTo_A = "0000000000"+soldToCode;
		mySoldTo_A = mySoldTo_A.substring((mySoldTo_A.length()-10),mySoldTo_A.length());
	}
	catch(Exception ex)
	{
		mySoldTo_A = soldToCode;
	}	
	
	if((("NEGOTIATED").equals(status) || "Y".equals(NegFlag)) && !("SUBMITTED").equals(status)) // (NFlag && "3".equals((String)session.getValue("UserType")))
	{
%>
		<%@ include file="iAddSaveNegotiate.jsp" %>
<%
	}
	else if(("SUBMITTED").equals(status) || "FD".equals(docType))
	{
%>
		<%@ include file="iAddSaveApproval.jsp" %>
<%
	}

	HashMap soldToHash = (HashMap)session.getValue("SOLDTONAMES");
    	String soldToName_N = soldToName;
	if(soldToHash!=null && soldToHash.size()>0)
		soldToName_N = (String)soldToHash.get(mySoldTo_A);

	if(soldToName_N==null || "null".equalsIgnoreCase(soldToName_N) || "".equals(soldToName_N))
		soldToName_N = "Customer";

	Properties prop=new Properties();

	try
	{
		String fileName = "ezAddSaveSales.jsp";
		String filePath = request.getRealPath(fileName);
		filePath = filePath.substring(0,filePath.indexOf(fileName));
		filePath +="ezEmailText.properties";

		prop.load(new java.io.FileInputStream(filePath));
	}
	catch(Exception e){}

	String mainURL = prop.getProperty("MAINURL");

	if("NEW".equalsIgnoreCase(status))
	{
		if(SAPnumber)
		{
			sendMail = true;
			toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezEditSaveSalesOrderDetails.jsp?webOrNo="+weborno+"&soldTo="+mySoldTo_A+"&sysKey="+sysKey+"&status="+status;
			log4j.log("toEncryptoEncryptoEncryp======>"+toEncryp, "D");
			encrypText = MD5(toEncryp);
			log4j.log("encrypTextencrypTextencrypText======>"+encrypText, "D");
			offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;
			String docNoInOffLine = "";

			if(templateName!=null && !"null".equals(templateName) && !"".equals(templateName))
			{
				msg ="Your Order with Template <font color=white>"+templateName+"</font> has been Saved";//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
				msgSubject = "New Template  "+templateName+" has been Saved";
				docNoInOffLine = templateName;
			}
			else
			{
				msg ="Your Order with PO No <font color=white> "+poNumber+"</font>  has been Saved";//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
				msgSubject = "New Purchase Order "+poNumber+" has been saved for Review";
				docNoInOffLine = poNumber;
			}

			msgText = "Dear Concerned<br><br>New Purchase Order created by  "+soldToName_N+"("+mySoldTo_A+") has been created and saved with reference name: <a href='"+offLink+"'>"+docNoInOffLine+"</a>.<br>";
			msgText += "<br>";
			msgText += eMailData;
			msgText += "<br>";
			msgText += "<br>Regards,<br>"+soldToName_N+"("+Session.getUserId() +") "+custName_M;
		}
		else
			msg ="Web Order has not been Saved";
	}
	else if("NEGOTIATED".equalsIgnoreCase(status))
	{
		if(SAPnumber) 
		{
			sendMail = true;
			toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezNegotiateOrderDetails.jsp?webOrNo="+weborno+"&soldTo="+mySoldTo_A+"&sysKey="+sysKey+"&status="+status;
			log4j.log("toEncryptoEncryptoEncryp======>"+toEncryp, "D");
			encrypText = MD5(toEncryp);
			log4j.log("encrypTextencrypTextencrypText======>"+encrypText, "D");
			offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

			msg = "Your Order with PO No<font color=white>  "+poNumber+"</font>  has been received .";//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
			msg = msg+"<br>It will be reviewed by American Standard , and acceptance/rejection information will be sent to you in email<br>";
			msg = msg+"On receipt of email notification, please login to the Portal and Submit Approved Orders to American Standard";

			String custEmailSign = soldToName_N+"<br>"+soldToStreet+"<br>"+soldToCity+" "+soldToState+"<br>"+soldToZipCode;

			if("CU".equals(UserRole.toUpperCase()) && ("true".equalsIgnoreCase(vipFlag_S) || "true".equalsIgnoreCase(dispFlag_S)))
			{
				String dvToAct_M = dvToAct.substring(0,dvToAct.indexOf("@"));//getUserName(Session,dvToAct);
				String actedBy_M = getUserName(Session,user_L);

				msgSubject = prop.getProperty("EMAILSUB_DISPVIP_APPR");
				msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
				msgSubject = msgSubject.replaceAll("%CustomerName%",shipToName);
				msgSubject = msgSubject.replaceAll("%ShipToState%",shipToState);
				msgText = prop.getProperty("EMAILBODY_DISPVIP_APPR");
				msgText = msgText.replaceAll("%ConcernedUser%",dvToAct_M);
				msgText = msgText.replaceAll("%ActedUser%",actedBy_M);
				msgText = msgText.replaceAll("%OffLineURL%",offLink);
				msgText = msgText.replaceAll("%CustomerInfo%",custEmailSign);

				String toEmail = dvToAct;//getUserEmail(Session,dvToAct);
				//String ccEmail = getOpsCCEmail(Session,shipToState);
				String ccEmail = "";

				log4j.log("toEmailtoEmailtoEmail======>"+toEmail, "D");
				log4j.log("ccEmailccEmailccEmail======>"+ccEmail, "D");
				log4j.log("msgTextmsgTextmsgText======>"+msgText, "D");
				log4j.log("msgSubjectmsgSubject======>"+msgSubject, "D");

				//toEmail = "georgesa@AmericanStandard.com";
				//ccEmail = "chanumanthu@answerthink.com,mbablani@answerthink.com";

				sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);

				//sendToUser = user_L+","+sendToUser;

				msgSubject = prop.getProperty("EMAILSUB_DISPVIP");
				msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
				msgSubject = msgSubject.replaceAll("%CustomerName%",shipToName);
				msgSubject = msgSubject.replaceAll("%ShipToState%",shipToState);
				msgText = prop.getProperty("EMAILBODY_DISPVIP");
				msgText = msgText.replaceAll("%ConcernedUser%",soldToName_N);
				msgText = msgText.replaceAll("%OffLineURL%",offLink);
			}
			else if("CU".equals(UserRole.toUpperCase()) && "Y".equals(NegFlag))
			{
				msgSubject = prop.getProperty("EMAILSUB_QUES_CU");
				msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
				msgText = prop.getProperty("EMAILBODY_QUES_CU");
				msgText = msgText.replaceAll("%ConcernedUser%",soldToName_N);
				msgText = msgText.replaceAll("%MainURL%",mainURL);
				msgText = msgText.replaceAll("%OffLineURL%",offLink);

				String toEmail = getUserEmail(Session,user_L);
				String ccEmail = "";
				//ccEmail = "chanumanthu@answerthink.com,mbablani@answerthink.com";

				sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);

				String custCareEmail = (String)session.getValue("CCEMAIL");
				sendToUser = sendToUser+","+custCareEmail;

				if(sendToUser.startsWith(","))
					sendToUser = sendToUser.substring(1);

				msgSubject = prop.getProperty("EMAILSUB_QUES_CC");
				msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
				msgSubject = msgSubject.replaceAll("%CustomerName%",shipToName);
				msgSubject = msgSubject.replaceAll("%ShipToState%",shipToState);
				msgText = prop.getProperty("EMAILBODY_QUES_CC");
				msgText = msgText.replaceAll("%MainURL%",mainURL);
				msgText = msgText.replaceAll("%OffLineURL%",offLink);
				msgText = msgText.replaceAll("%CustomerInfo%",custEmailSign);
			}
			else
			{
				msgSubject = "New Purchase Order "+poNumber+" has been submitted for Review";
				msg = "Your Order with PO No<font color=white>  "+poNumber+"</font>  has been received .";//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
				msg = msg+"<br>It will be reviewed by American Standard , and acceptance/rejection information will be sent to you in email<br>";
				msg = msg+"On receipt of email notification, please login to the Portal and Submit Approved Orders to American Standard";

				msgText = "Dear Concerned<br><br>New Purchase Order created by  "+soldToName_N+"("+mySoldTo_A+") has been submitted for Review with reference no: <a href='"+offLink+"'>"+poNumber+"</a>.<br>";
				msgText += "<br>";
				msgText += eMailData;
				msgText += "<br>";
				msgText += "<br>Regards,<br>"+soldToName_N+"("+Session.getUserId() +") "+custName_M;
			}
		}
		else
			msg ="Web Order has not been Negotiated";
	}
	else if("SUBMITTED".equalsIgnoreCase(status))
	{
		if(SAPnumber)
		{
			msg   = "Your Order with PO No<font color=white>  "+poNumber+"</font>  has been sent for Approval.";
			msg   = msg+"<br>It will be reviewed by Approver , and acceptance/rejection information will be sent to you in email<br>";
			//msg   = msg+"On receipt of email notification, please login to the Portal and Submit Approved Orders to American Standard";

			sendMail = true;

			//sendToUser = sendToUser+","+approver;

			if("".equals(approver))
				sendToUser = apprEmail;
			else
				sendToUser = approver;

			if(sendToUser.startsWith(","))
				sendToUser = sendToUser.substring(1);

			toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezApprovalOrderDetails.jsp?webOrNo="+weborno+"&soldTo="+mySoldTo_A+"&sysKey="+sysKey+"&status="+status;
			log4j.log("toEncryptoEncryptoEncryp======>"+toEncryp, "D");
			encrypText = MD5(toEncryp);
			log4j.log("encrypTextencrypTextencrypText======>"+encrypText, "D");
			offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

			String approverName = "Team";
			if(!"".equals(approver)) approverName = getUserName(Session,approver);

			String userName_F = getUserName(Session,user_L);

			msgSubject = prop.getProperty("EMAILSUB_FOC_TOAPPR");
			msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
			msgSubject = msgSubject.replaceAll("%CustomerName%",shipToName);
			msgSubject = msgSubject.replaceAll("%ShipToState%",shipToState);
			msgText = prop.getProperty("EMAILBODY_FOC_TOAPPR");
			msgText = msgText.replaceAll("%ConcernedUser%",approverName);
			msgText = msgText.replaceAll("%UserName%",userName_F);
			msgText = msgText.replaceAll("%OffLineURL%",offLink);

			/*
			msgSubject = "New Purchase Order "+poNumber+" has been submitted for Approval";
			msgText = "Dear Concerned<br><br>New Purchase Order created by  "+Session.getUserId()+" has been submitted for Approval with reference no: <a href='"+offLink+"'>"+poNumber+"</a>.<br>";
			msgText += "<br>";
			msgText += eMailData;
			msgText += "<br>";
			msgText += "<br>Regards,<br>"+Session.getUserId();
			*/
		}
		else
			msg   = "Web Order has not been Saved";
	}
	else
	{
		if(sDocNumber == null || sDocNumber.trim().length()==0)
       		{
       			if(SAPnumber)
       				msg = "Web Order: <font color=white>"+weborno+"</font> has not been posted into SAP <br><font color=white> Error:"+ ErrorMessage +"</font>";
			else
				msg = "Order has not been posted into SAP <br><font color=white> Error:"+ ErrorMessage +"</font>";
       		}
       		else
       		{
       			int cnt = 0;
       			if(sDocNumber.trim().length()>10)
       			{       				
       				try
       				{
       					StringTokenizer sDocToken=new StringTokenizer(sDocNumber,",");
					String numbers="";
					
					while(sDocToken.hasMoreElements())
					{
						String a= (String)sDocToken.nextElement();
						
						if(cnt==0)
						{
							numbers = String.valueOf(Integer.parseInt(a));
							sTempDocNumber = a;
						}
						else
						{
							numbers = numbers+","+String.valueOf(Integer.parseInt(a));
							sTempDocNumber = sTempDocNumber+"ÿ"+a;
						}
						cnt++;
					}
					//numbers=numbers.substring(0,(numbers.length()-1));
					sDocNumber=numbers;
					//sTempDocNumber=sDocNumber;
				}catch(Exception e){}
					
			}else  
			{
				try
				{
					sTempDocNumber = sDocNumber;
					sDocNumber=String.valueOf(Integer.parseInt(sDocNumber));
				}catch(Exception e){}
			}

			String tempSDoc = sTempDocNumber;

			/*
			try
			{
				tempSDoc = tempSDoc.replaceAll(",","#");
			}
			catch(Exception e){out.println("Exception::::"+e);}
			*/
			

			if(SAPnumber)
			{
				toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezSalesOrderDetails.jsp?poNo="+poNumber+"&soldTo="+mySoldTo_A+"&shipTo="+shipToCode+"&status="+status+"&poDate="+poDate;
				log4j.log("toEncryptoEncryptoEncryp======>"+toEncryp, "D");
				encrypText = MD5(toEncryp);
				log4j.log("encrypTextencrypTextencrypText======>"+encrypText, "D");
				offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

				if(cnt==0)cnt=1;

				msg = "<h2>YOUR ORDER HAS BEEN RECEIVED AND SAVED WITH PO# <a href=\"javascript:getDetails(\'"+poNumber+"\',\'"+mySoldTo_A+"\',\'"+shipToCode+"\',\'"+poDate+"\',\'N\')\">"+poNumber+"</a></h2>";

				if("CU".equals(UserRole.toUpperCase()))
				{
					msg = msg+"<p> You can view your Templates in Orders Menu sub option Open Orders.</p>";
					msg = msg+"<p> You will receive an acknowledgment within 48 hours if the order is accepted by American Standard and is ready for Processing. </p>";
				}

				msg = msg+"<p> Click here to <a href=\"javascript:getDetails(\'"+poNumber+"\',\'"+mySoldTo_A+"\',\'"+shipToCode+"\',\'"+poDate+"\',\'Y\')\">Print</a> the Submitted Order for your Records </p>";

				sendMail = true;

				msgSubject = prop.getProperty("EMAILSUB_TOSAP");
				msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
				msgText = prop.getProperty("EMAILBODY_TOSAP");
				msgText = msgText.replaceAll("%ConcernedUser%",soldToName_N);
				msgText = msgText.replaceAll("%MainURL%",mainURL);
				msgText = msgText.replaceAll("%OffLineURL%",offLink);
			}
			else
			{
				msg = "Web Order has not been saved but Posted into SAP with Sales Order no(s): <font color=white>"+sDocNumber+"</font>";
			}
       		}
        }

	if(sendMail)
	{
		/******************************/
		EzcParams mainParamsURL = new EzcParams(false);
		EziMiscParams miscParamsURL = new EziMiscParams();

		miscParamsURL.setIdenKey("MISC_INSERT");
		miscParamsURL.setQuery("INSERT INTO EZC_URL_MAPPING(EUM_SHORT_URL,EUM_ACTUAL_URL) VALUES('"+encrypText+"','"+toEncryp+"')");

		mainParamsURL.setLocalStore("Y");
		mainParamsURL.setObject(miscParamsURL);
		Session.prepareParams(mainParamsURL);	

		try
		{
			ezMiscManager.ezAdd(mainParamsURL);
		}
		catch(Exception e){}

		/******************************/

		try
		{
			String tempDocNo_U = "";
			String tempUrlLink_U = offLink;
			String tempDocType_U = "SO";

			StringTokenizer sDocToken = new StringTokenizer(sDocNumber,",");
			while(sDocToken.hasMoreElements())
			{
				tempDocNo_U = (String)sDocToken.nextElement();
				tempDocNo_U = "0000000000"+tempDocNo_U;
				tempDocNo_U = tempDocNo_U.substring(tempDocNo_U.length()-10,tempDocNo_U.length());
				log4j.log("tempDocNo_UtempDocNo_U======>"+tempDocNo_U, "D");
%>
			<%@ include file="../../../Sales/JSPs/UploadFiles/ezSendURLToSap.jsp"%>
<%
			}
		}
		catch(Exception e){}
%>
		<%@ include file="../../../Sales/JSPs/Misc/ezSendMail.jsp" %>
<%
	}
	}
}
else
{
	msg = "<h2>You are not authorized to perform this action.<br>Please contact Administrator requesting Authorization Key.</h2>";
}
      	session.putValue("EzMsg",msg);
%>