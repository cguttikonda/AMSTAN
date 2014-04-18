<%@ page import="java.util.*"%>
<%@ page import = "ezc.shopping.cart.params.*,ezc.shopping.cart.client.*,ezc.shopping.cart.common.*,ezc.sales.params.*" %>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ include file="../Lables/iAddModifyInfo_Lables.jsp" %>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp" %>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="UAdminManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%@ page import = "ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager1" class="ezc.ezmisc.client.EzMiscManager" scope="session" />
<% 
	String headerReqDate = request.getParameter("requiredDate");
	GregorianCalendar reqDateH = null;
	try{
		reqDateH =new GregorianCalendar(Integer.parseInt(headerReqDate.substring(6,10)),(Integer.parseInt(headerReqDate.substring(0,2))-1),Integer.parseInt(headerReqDate.substring(3,5)));
	}catch(Exception e){
		reqDateH =(GregorianCalendar)GregorianCalendar.getInstance();
	}
	String PartnNum = (String)session.getValue("AgentCode");
	String firstName = (String)session.getValue("FIRSTNAME");
	String lastName = (String)session.getValue("LASTNAME");
	String firlastName="";
	if(firstName!=null)
	{
		firlastName +=firstName;
	} 
	if(lastName!=null)
	{
		firlastName +=""+lastName;
	}
	if(firlastName!=null) firlastName.trim(); 
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
	
	String floorNo   	= request.getParameter("shipToAddr2");		//Floor
	String createdBy 	= request.getParameter("createdBy");
	String createdBy_Email  = "";
	ReturnObjFromRetrieve retUserData_E=null;
	
	if(createdBy!=null && !"null".equals(createdBy) && !"".equals(createdBy))
	{
		
		EzcUserParams uparamsN= new EzcUserParams();
		EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
		ezcUserNKParamsN.setLanguage("EN");
		uparamsN.setUserId(createdBy);
		uparamsN.createContainer();
		uparamsN.setObject(ezcUserNKParamsN);
		Session.prepareParams(uparamsN);
		try
		{					
			retUserData_E = (ReturnObjFromRetrieve)UAdminManager.getUserData(uparamsN);
			session.putValue("USEREMAIL",retUserData_E.getFieldValueString("EU_EMAIL"));
		}
		catch(Exception e)
		{
			log4j.log("Failed to Get User MailId.Probably b'coz wrong UserId","I");
		}
	}
	
		
	log4j.log("roomNo>>>>>>>>>>>>>>"+roomNo,"W"); 
	log4j.log("floorNo>>>>>>"+floorNo,"W");   
	log4j.log("city_freq>>>>>>>>>>"+city_freq,"W");
	log4j.log("state_freq>>>>>>"+state_freq,"W");
	log4j.log("pcode_freq>>>>>>"+pcode_freq,"W");
	log4j.log("createdBy>>>>>>"+createdBy,"W");
	log4j.log("statusstatusstatusstatusstatus::iEdit::"+status,"W");
	
	if(("TRANSFERED").equals(status)) 
	{  
%>		
		<%@ include file="iAddSaveSapShopCartSales.jsp" %> 
<%
	}
	if(("NEGOTIATED").equals(status))    
	{
		weborno = soNum;
%>		
		<%@ include file="iAddSaveNegotiate.jsp" %>       
<%
	}  
		log4j.log("after iAddSaveNegotiate>>>>>>","D");

	 
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
	
			log4j.log("SAPnumberSAPnumber::"+SAPnumber,"D");


	if(SAPnumber)
	{
		int dateReq=0,monthReq=0,yearReq=0;
		java.util.GregorianCalendar reqDate = null;
		java.util.GregorianCalendar desDate = null;
		java.util.GregorianCalendar comDate = null;

		EzcSalesOrderParams ezcParams = new EzcSalesOrderParams();
		ezcParams.setLocalStore("Y"); 
		Session.prepareParams(ezcParams);

		EziSalesOrderChangeParams soParams 	= new EziSalesOrderChangeParams();
		EzBapisdheadStructure ezHeader 	   	= new EzBapisdheadStructure();
		EzBapishiptoStructure ezShipToStructure = new EzBapishiptoStructure();
		EzBapisoldtoStructure ezSoldToStructure = new EzBapisoldtoStructure();
		EzBapipartnrTable partnerTable 		= new EzBapipartnrTable();
		EzBapipartnrTableRow prtnrTblRow 	= new EzBapipartnrTableRow();
		EzBapiiteminTable itemInTable 		= new EzBapiiteminTable();
		EzDeliverySchedulesTable  delTable 	= new EzDeliverySchedulesTable();
		EzDeliverySchedulesTableRow delRow 	= new EzDeliverySchedulesTableRow();

		ezcParams.setObject(soParams);
		ezcParams.setObject(delTable);

		soParams.setOrderHeaderIn(ezHeader);
		soParams.setShipToParty(ezShipToStructure);
		soParams.setSoldToParty(ezSoldToStructure);
		soParams.setOrderPartners(partnerTable);
		soParams.setOrderItemsIn(itemInTable);

		ezHeader.setDocNumber(soNum);
		ezHeader.setRef1(carrierName);
		ezHeader.setAgentCode(setSalVal.getSoldTo());

		ezSoldToStructure.setSoldTo(setSalVal.getSoldTo());
		ezSoldToStructure.setName(setSalVal.getSoldToName());
		ezSoldToStructure.setStreet(setSalVal.getSoldToAddress1());
		ezSoldToStructure.setCity(setSalVal.getSoldToAddress2());
		ezSoldToStructure.setRegion(setSalVal.getSoldToState());
		ezSoldToStructure.setPostlCode(setSalVal.getSoldToZipcode());
		ezSoldToStructure.setCountry(setSalVal.getSoldToCountry());

		ebComp=setSalVal.getSoldToName();
		ebSt=setSalVal.getSoldToAddress1();
		ebCity=setSalVal.getSoldToAddress2();
		ebState=setSalVal.getSoldToState();
		ebCou=setSalVal.getSoldToCountry();
		ebPCode=setSalVal.getSoldToZipcode();
		

		ezShipToStructure.setShipTo(setSalVal.getShipTo());
		ezShipToStructure.setName(setSalVal.getShipToName());
		
		esComp=setSalVal.getShipToName();

		if(streetName!=null)
		{
			ezShipToStructure.setStreet(streetName);
			ezShipToStructure.setCity(city_freq);
			ezShipToStructure.setRegion(state_freq);
			ezShipToStructure.setPostlCode(pcode_freq);
			
			esSt=streetName;
			esCity=city_freq;
			esState=state_freq;
			esPCode=pcode_freq;
			
		}
		else
		{
			ezShipToStructure.setStreet(setSalVal.getShipToAddress1());
			ezShipToStructure.setCity(setSalVal.getShipToAddress2());
			ezShipToStructure.setRegion(setSalVal.getShipToState());
			ezShipToStructure.setPostlCode(setSalVal.getShipToZipcode()); 
			
			esSt=setSalVal.getShipToAddress1();
			esCity=setSalVal.getShipToAddress2();
			esState=setSalVal.getShipToState();
			esPCode=setSalVal.getShipToZipcode();
			
		}

		ezShipToStructure.setCountyCde(setSalVal.getShipToCountry());
		esCou=setSalVal.getShipToCountry();
		
		eAttn=shAttn;
		eTel1=shTel;
		eTel2=shMobi;
		eFax=shFax;
		efType=fServType;
		eshiIns=specialShIns;

		epoNumber = setSalVal.getPoNo();
		epoDate=setSalVal.getPoDate();
		ereqDelvDate=headerReqDate;
		
		log4j.log("soNumsoNumsoNum::"+soNum,"D");


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
		

		ezHeader.setPoNr(setSalVal.getPoNo());
		ezHeader.setDiscountCash(" ".equals(setSalVal.getDisCash()) || "".equals(setSalVal.getDisCash())?"0":setSalVal.getDisCash());
		ezHeader.setDiscountPercentage(" ".equals(setSalVal.getDisPercentage())||"".equals(setSalVal.getDisPercentage())?"0":setSalVal.getDisPercentage());
		ezHeader.setFreightCharges(fServType);	//Setting freight type
		ezHeader.setIncoterms1(incoTerms1);
		ezHeader.setIncoterms2(incoTerms2);
		ezHeader.setPmnttrms(paymentterms);
		ezHeader.setText1(generalNotesAll);
		ezHeader.setText2(generalNotes1);
		ezHeader.setText3(generalNotes2);
		ezHeader.setText4(generalNotes3);
		ezHeader.setDocCurrency(setSalVal.getDocCurrency());
		ezHeader.setSalesArea(salesAreaCode);
		ezHeader.setDelFlag("N");
		ezHeader.setReqDateH(reqDateH.getTime());
		ezHeader.setPromoCode(promoCode);
		ezHeader.setFreightWeight(freightWeight);
		ezHeader.setFreightPrice(freightPrice);
		ezHeader.setFreightIns(freightIns);

		String statusDate = setSalVal.getStatusDate();

		if(("1").equals(statusDate))
		{	
			ezHeader.setStatusDate(new Date());
		}
		else
		{
			if(statusDate != null)
			{	
				try
				{
					monthReq = Integer.parseInt(statusDate.substring(0,2));
					dateReq  = Integer.parseInt(statusDate.substring(3,5));
					yearReq  = Integer.parseInt(statusDate.substring(6,10));
					reqDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
					ezHeader.setStatusDate(reqDate.getTime());
				}
				catch(Exception e){}
			}
		}

		if(!((sDocNumber==null) || (sDocNumber.trim().length()==0)))
			ezHeader.setTransferDate(new Date());
		else
			ezHeader.setTransferDate(new Date());

		log4j.log("statusstatusstatusstatusstatus11111111::"+status,"W");

		ezHeader.setModifiedBy(user);
		ezHeader.setStatus(status);

		if("TRANSFERED".equals(status))
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

		ezHeader.setReserved1(setSalVal.getPoDate());

		try
		{
			String poDat = setSalVal.getPoDate();
			int mn = Integer.parseInt(poDat.substring(0,2));
			int dt = Integer.parseInt(poDat.substring(3,5));
			int yr = Integer.parseInt(poDat.substring(6,10));
			java.util.GregorianCalendar reqDatePO = new java.util.GregorianCalendar(yr,mn-1,dt);
			ezHeader.setPurchDate(reqDatePO.getTime());
		}
		catch(Exception e)
		{
			log4j.log("poDatpoDatpoDatpoDat::"+e,"W");
		}
		if("SUBMITTED".equals(status))
		{
			ezHeader.setOrderDate(new Date());
		}
		else
		{
			try
			{
				monthReq  = Integer.parseInt(orderDate.substring(0,2));
				dateReq   = Integer.parseInt(orderDate.substring(3,5));
				yearReq   = Integer.parseInt(orderDate.substring(6,10));
				reqDate   = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
				ezHeader.setOrderDate(reqDate.getTime());
			}
			catch(Exception e)
			{
				log4j.log("monthReqmonthReqmonthReq::"+e,"W");
			}
		}

		if(("REJECTED".equalsIgnoreCase(status) ) || ("RETURNEDBYCM".equalsIgnoreCase(status)) || ("RETURNEDBYLF".equalsIgnoreCase(status)) || ("SUBMITTEDTOBP".equalsIgnoreCase(status)) || ("RETURNEDBYBP".equalsIgnoreCase(status)))
			ezHeader.setReserved2(setSalVal.getReasonForRejection());
		else
			ezHeader.setReserved2("");	

		String line,commitedQty,commitedDate,commitedPrice,value,custMat,itemVendCatalog;
		String strFOC 	= "";
		int newRows 	= 1;
		int delcount	= 0;

		java.math.BigDecimal tValue = new java.math.BigDecimal("0");
		java.math.BigDecimal hNetValue = new java.math.BigDecimal("0");

		log4j.log("RowsRowsRowsRows::"+Rows,"W");

		for(int i=0;i<Rows;i++)
		{
			EzBapiiteminTableRow itemRow = new EzBapiiteminTableRow();
			line 		= lineNo_1[i];
			product 	= prodCode_1[i];	
			custMat         = custprodCode[i];
			productDesc 	= prodDesc_1[i];
			name 		= prodPack_1[i];
			desiredQty 	= prodDQty_1[i];
			itemVendCatalog = ((itemVenCatalog[i]==null)||(("").equals(itemVenCatalog[i])))?"":itemVenCatalog[i];
			log4j.log("itemVendCatalogitemVendCatalog************::"+itemVendCatalog,"I");
			commitedQty 	= prodCQty_1[i];
			log4j.log("commitedQtycommitedQty************::"+commitedQty,"I");
			desiredDate	= ((desiredDate_1[i]==null)||(("").equals(desiredDate_1[i])))?"":desiredDate_1[i];
			commitedDate	= ((desiredDate_1[i]==null)||(("").equals(desiredDate_1[i])))?"":desiredDate_1[i];
			log4j.log("commitedDatecommitedDate************::"+commitedDate,"I");
			desiredPrice	= desiredPrice_1[i];
			commitedPrice   = itemListPrice[i];
			strFOC 		= ((fOC_1[i]==null)||(("").equals(fOC_1[i])))?"":fOC_1[i];
			value 		= desiredPrice_1[i];

			log4j.log("productDescproductDescproductDesc************::"+productDesc,"I");
			log4j.log("custMatcustMatcustMatcustMatcustMat**********::"+custMat,"I");

			desiredQty 	= ((desiredQty==null)||(("").equals(desiredQty)))?"0":desiredQty;
			commitedQty 	= ((commitedQty==null)||(("").equals(commitedQty)))?"0":commitedQty;
			desiredPrice    = ((desiredPrice == null) || (("").equals(desiredPrice)))?"0":desiredPrice;
			commitedPrice   = ((commitedPrice == null) || (("").equals(commitedPrice)))?"0":commitedPrice;
			
			String itemDiscCodeVal 	= itemDiscCode[i];
			String itemPromoCodeVal = itemPromoCode[i];
			String itemCnetProdVal	= itemCnetProd[i];
			
			if(itemDiscCodeVal==null || "null".equals(itemDiscCodeVal) || "N/A".equals(itemDiscCodeVal)) itemDiscCodeVal = "";
			if(itemPromoCodeVal==null || "null".equals(itemPromoCodeVal)) itemPromoCodeVal = "";
			if(itemCnetProdVal==null || "null".equals(itemCnetProdVal)) itemCnetProdVal = "";

			java.math.BigDecimal dDQty = new java.math.BigDecimal(desiredQty);
			java.math.BigDecimal dCQTY = new java.math.BigDecimal(commitedQty);
			java.math.BigDecimal cPrice= new java.math.BigDecimal(commitedPrice); 
			java.math.BigDecimal iValue= dCQTY.multiply(cPrice);
			tValue=tValue.add(iValue);
			strFOC = ((strFOC==null)||(strFOC.trim().length()==0) )?"0":strFOC;
			
			log4j.log("strFOCstrFOCstrFOC**********::"+strFOC,"I");

			monthReq = Integer.parseInt(desiredDate.substring(0,2));
			dateReq  = Integer.parseInt(desiredDate.substring(3,5));
			yearReq  = Integer.parseInt(desiredDate.substring(6,10));
			desDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);  

			monthReq = Integer.parseInt(commitedDate.substring(0,2));
			dateReq  = Integer.parseInt(commitedDate.substring(3,5));
			yearReq  = Integer.parseInt(commitedDate.substring(6,10));
			comDate = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
			
			log4j.log("comDatecomDatecomDatecomDate**********::"+comDate,"I");
			log4j.log("itemEanUPCitemEanUPC**********::"+itemEanUPC[i],"I");
			log4j.log("itemMfrCodeitemMfrCode**********::"+itemMfrCode[i],"I");

			itemRow.setDocNumber(soNum);
			itemRow.setItmNumber(new java.math.BigInteger(line));
			itemRow.setMaterial(product);
			itemRow.setCustMat(custMat);
			itemRow.setIncoterms2(itemMfrCode[i]);	//itemEanUPC -- EanUPC
			itemRow.setInvoice(itemMfrNr[i]);	//MfrNR
			itemRow.setMatlGroup(itemVendCatalog);
			itemRow.setShortText(productDesc);
			itemRow.setSalesUnit(name);
			itemRow.setQtyInSalesUnit(dDQty);
			itemRow.setReqQty1(dDQty);
			itemRow.setConfirmedQty(dCQTY);
			itemRow.setReqDate(desDate.getTime());
			itemRow.setDlvDate(comDate.getTime());
			itemRow.setReqPrice(new java.math.BigDecimal(desiredPrice));
			itemRow.setConfirmedPrice(cPrice);
			itemRow.setItemFOC(strFOC);
			itemRow.setNetPrice(iValue);
			itemRow.setNotes(itemCnetProdVal);
			itemRow.setDiscCode(itemDiscCodeVal);
			itemRow.setPromoCode(itemPromoCodeVal);
			itemRow.setItemWeight(itemWeight[i]);
			itemRow.setItemIns("0");

			if("TRANSFERED".equalsIgnoreCase(status))
			{
				String backorderno = "";
				String actLine = "";
				for(int ord = 0;ord<orders.getRowCount();ord++)
				{
					String sDocLine = orders.getFieldValueString(ord,"LineNo");
					if(line.equals(sDocLine))
					{
						backorderno=orders.getFieldValueString(ord,"SalesOrder");
						actLine=orders.getFieldValueString(ord,"BackLineNo");
						break;
					}
				}
				itemRow.setBackEndOrder(backorderno);
				itemRow.setBackEndItem(actLine);
			}
			else
			{
				itemRow.setBackEndOrder(sDocNumber);
				itemRow.setBackEndItem(line);
			}

			itemInTable.insertRow(i,itemRow);
			
			eMailData += "<Tr><Td width=\"10%\" align=\"left\"   "+tdBGColor+">"+custprodCode[i]+"</Td><Td width=\"28%\" align=\"left\"   "+tdBGColor+">"+prodDesc_1[i]+"</Td><Td width=\"10%\" align=\"center\" "+tdBGColor+">"+itemMfrNr[i]+"</Td><Td width=\"10%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(itemOrgPrice[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"8%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(prodDQty_1[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"10%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(desiredPrice)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"8%\" align=\"right\"  "+tdBGColor+">"+(cPrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(finalPriceVal_1[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td></Tr>";
		}

		log4j.log("itemInTableitemInTableitemInTable::","W");
		
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Freight</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+freightPrice+"</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Freight Insurance</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+freightIns+"</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Tax</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">TBD</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Total</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+grandTotalVal+"</Td></Tr>";
		
		eMailData +="</Table>";
		

		ReturnObjFromRetrieve retSchChangesLocal=(ReturnObjFromRetrieve)session.getValue("EzDeliveryLines");

		log4j.log("retSchChangesLocalretSchChangesLocal::"+retSchChangesLocal.toEzcString(),"W");

		if(retSchChangesLocal!=null) 
		{
			for(int k=0;k<retSchChangesLocal.getRowCount();k++)
			{
				String qtyCon	= retSchChangesLocal.getFieldValueString(k,"EZDS_CON_QTY");
				String qtyreq 	= retSchChangesLocal.getFieldValueString(k,"EZDS_REQ_QTY");
				line   		= retSchChangesLocal.getFieldValueString(k,"EZDS_ITM_NUMBER");
				qtyCon		= (qtyCon==null || "".equals(qtyCon))?"0":qtyCon;
				qtyreq		= (qtyreq==null || "".equals(qtyreq))?"0":qtyreq;
				delRow 		= new EzDeliverySchedulesTableRow();

				if("TRANSFERED".equalsIgnoreCase(status) && (sDocNumber!=null) && (sDocNumber.trim().length()!=0 ) && (!"null".equals(sDocNumber)))
				{
					String backorderno = "";
					String actLine = "";
					for(int ord = 0;ord<orders.getRowCount();ord++)
					{
						String sDocLine = orders.getFieldValueString(ord,"LineNo");
						if(line.equals(sDocLine))
						{
							backorderno=orders.getFieldValueString(ord,"SalesOrder");
							actLine=orders.getFieldValueString(ord,"BackLineNo");
							break;
						}
					}	
					
					delRow.setBackEndNumber(backorderno); 
					delRow.setBackEndItem(actLine);
				}
				else
				{
					delRow.setBackEndNumber(sDocNumber);
					delRow.setBackEndItem(retSchChangesLocal.getFieldValueString(k,"EZDS_ITM_NUMBER"));
				}

				delRow.setSalesDocNumber(soNum);
				delRow.setItemNumber(retSchChangesLocal.getFieldValueString(k,"EZDS_ITM_NUMBER"));
				delRow.setScheduleLine(retSchChangesLocal.getFieldValueString(k,"EZDS_SCHED_LINE"));
				delRow.setRequiredQty(qtyreq);
				delRow.setRequiredDate(headerReqDate);
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
				delRow.setStatus("N");
				delRow.setReserved1(qtyreq);
				delRow.setReserved2(retSchChangesLocal.getFieldValueString(k,"EZDS_REQ_DATE"));
				delRow.setConfirmedQty("0");
				delRow.setConfirmedDate("");
				delTable.appendRow(delRow);
			}
		}

		ezHeader.setNetValue(tValue.toString());
		ezc.ezworkflow.params.EziWFParams eziWfparams = new ezc.ezworkflow.params.EziWFParams();
		ezc.ezworkflow.params.EziWFDocHistoryParams eziWfDocHis =new ezc.ezworkflow.params.EziWFDocHistoryParams();
		Hashtable wfActions = new Hashtable();

		wfActions.put("NEW","100065");
		wfActions.put("NEGOTIATED","100064");
		wfActions.put("SUBMITTED","100066");
		wfActions.put("APPROVED","100067");
		wfActions.put("REJECTED","100068");
		wfActions.put("TRANSFERED","100070");
		wfActions.put("RETURNEDBYCM","100074");
		wfActions.put("RETURNEDBYLF","100075");
		wfActions.put("APPROVEDBYBP","100076");
		wfActions.put("RETURNEDBYBP","100077");
		wfActions.put("RETNEW","100076");
		wfActions.put("RETTRANSFERED","100077");
		wfActions.put("RETCMTRANSFER","100078");

		log4j.log("(statusstatusstatusstatus)::"+status,"W");
		log4j.log("(String)wfActions.get(status)::"+(String)wfActions.get(status),"W");
		log4j.log("TempletTempletTemplet::"+(String)session.getValue("Templet"),"W");

		String wfeditParticipant = (String)session.getValue("Participant");
		eziWfDocHis.setParticipant(wfeditParticipant);
		eziWfparams.setParticipant(wfeditParticipant);
		eziWfparams.setRole((String)session.getValue("WFRole"));
		eziWfDocHis.setSysKey(salesAreaCode);
		eziWfDocHis.setTemplateCode((String)session.getValue("Template"));
		eziWfDocHis.setAuthKey("SO_CREATE");
		eziWfDocHis.setModifiedBy(user);
		eziWfDocHis.setSoldTo((String)session.getValue("AgentCode"));
		eziWfDocHis.setAction((String)wfActions.get(status));
		eziWfDocHis.setDocId(soNum);
		ezcParams.setObject(eziWfparams);
		ezcParams.setObject(eziWfDocHis);

		try
		{
			log4j.log("ezChangeWebSalesOrder======>", "D");

			EzSalesOrderManager.ezChangeWebSalesOrder(ezcParams);

			//** email triggering **//

			if("CM".equals(UserRole.toUpperCase()))
			{
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

								//if(isSubUser!=null && ("Y".equals(isSubUser) || "".equals(isSubUser)) && userStatus!=null && "A".equals(userStatus))
								//	sendToUser = sendToUser + "," + tmpSendToUser;
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
						}
					}
				}
			}
			else if("CU".equals(UserRole.toUpperCase()))
			{
				if(("NEW").equalsIgnoreCase(status))
					sendToUser = saveEmail;
				else
				{
					String salesRep = (String)session.getValue("SALESREPRES");

					try
					{
						StringTokenizer stEcadVal = new StringTokenizer(salesRep,"¥");

						while(stEcadVal.hasMoreTokens())
						{
							String salesRep_A = (String)stEcadVal.nextElement();
							String salesRep_AId = salesRep_A.split("¤")[0];

							sendToUser = sendToUser+","+salesRep_AId;
						}
					}
					catch(Exception e){}
				}
			}

			if(sendToUser.startsWith(","))
				sendToUser = sendToUser.substring(1);

			//** email triggering **//

		}
		catch(Exception e)
		{
			log4j.log("Exception in ezChangeWebSalesOrder"+e,"W");
		}
	}
	
	String custName_M = "";

	if("CU".equals(UserRole.toUpperCase()))
		custName_M = "("+agent+")";
		
	else 
		custName_M = "("+firlastName+")";

	log4j.log("statusstatusstatus======>"+status, "D");
	
	
	for(int i=0;i<prodCodeLength;i++)
	{

		String line 	= String.valueOf((i+1)*10);


		EzcParams plantMainParams = new EzcParams(false);
		EziMiscParams miscParams = new EziMiscParams();

		miscParams.setQuery("UPDATE EZC_SALES_DOC_ITEMS SET ESDI_PLANT='"+itemPlant[i]+"' WHERE ESDI_SALES_DOC='"+weborno+"' AND ESDI_SALES_DOC_ITEM='"+(new java.math.BigInteger(line))+"'");
		plantMainParams.setLocalStore("Y");
		plantMainParams.setObject(miscParams);
		Session.prepareParams(plantMainParams);

		ezMiscManager1.ezUpdate(plantMainParams);
	
	}

	if("TRANSFERED".equalsIgnoreCase(status))
	{
		if(sDocNumber == null || sDocNumber.trim().length()==0)
       		{
       			if(SAPnumber)
       				msg = "Web Order: <font color=red>"+soNum+"</font> has not been posted into SAP <br><font color=red> Error:"+ ErrorMessage +"</font>";
			else
				msg = "Order has not been posted into SAP <br><font color=red> Error:"+ ErrorMessage +"</font>";
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
						}
						else
						{
							numbers = numbers+","+String.valueOf(Integer.parseInt(a));
						}
						cnt++;
					}
					//numbers=numbers.substring(0,(numbers.length()-1));
					sDocNumber=numbers;
					sTempDocNumber=sDocNumber;
				}
				catch(Exception e){}
			}
			else
			{
				try
				{
					sTempDocNumber = sDocNumber;
					sDocNumber = String.valueOf(Integer.parseInt(sDocNumber));
				}
				catch(Exception e){}
			}
	
			if(SAPnumber)
			{
				if(cnt==0)cnt=1;
				
				msg = "Order Number for Your Reference is <font color=red>"+soNum+"</font><BR><BR>";
				msg = msg+"It has resulted in <font color=red>"+cnt+"</font> ERP Order(s). ERP Order Number(s) : <font color=red>"+sDocNumber+"</font>";//: <font color=red>"+soNum+"</font>
				sendMail = true;

				msgSubject = "New Sales Order "+sDocNumber+" has been created";
				msgText = "Dear Concerned<br><br>New Sales Order has been created with reference no(s): "+sDocNumber+".<br>";
				msgText += "<br>";
				msgText += eMailData;
				msgText += "<br>";
				msgText += "<br>Regards,<br>"+Session.getUserId()+" "+custName_M;
			}
       		}
        }

	if("NEGOTIATED".equalsIgnoreCase(status))
	{
		if(SAPnumber)
		{
			String subBy = "sent to Customer";
			if("CU".equals(UserRole.toUpperCase())) subBy = "submitted to Sales Rep";

			msg ="Web Order No: <font color=red>"+soNum+"</font> has been "+subBy;//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
			sendMail = true;

			msgSubject = "Web Order "+soNum+" has been submitted for Review";
			msgText = "Dear Concerned<br><br>Web Order has been submitted for Review with reference no: "+soNum+".<br>";
			msgText += "<br>";
			msgText += eMailData;
			msgText += "<br>";
			msgText += "<br>Regards,<br>"+Session.getUserId()+" "+custName_M;
		}
		else
			msg ="Web Order has not been Negotiated";
	}
	if(sendMail)
	{
%>
		<%@ include file="../../../Sales2/JSPs/Misc/ezSendMail.jsp" %>
<%
	} 
	
	session.putValue("EzMsg",msg);
%>
