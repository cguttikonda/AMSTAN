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
	
	String floorNo = request.getParameter("shipToAddr2");		//Floor
	String sel_Ship = request.getParameter("sel_Ship");
	
	log4j.log("sel_Ship>>>>>>>>>>>>>>"+sel_Ship,"W"); 
	log4j.log("roomNo>>>>>>>>>>>>>>"+roomNo,"W"); 
	log4j.log("floorNo>>>>>>"+floorNo,"W");   
	log4j.log("city_freq>>>>>>>>>>"+city_freq,"W");
	log4j.log("state_freq>>>>>>"+state_freq,"W");
	log4j.log("pcode_freq>>>>>>"+pcode_freq,"W");  

	
	
	if(("TRANSFERED").equals(status)) 
	{
%>		<%@ include file="iAddSaveSapShopCartSales.jsp" %>      
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
	
	log4j.log("****SAPnumber*****", "D");

  	if(SAPnumber) 
  	{
		EzDeliverySchedulesTable  delTable = new  EzDeliverySchedulesTable();
		EzDeliverySchedulesTableRow delRow = new EzDeliverySchedulesTableRow();

		partnerTable.insertRow(0,prtnrTblRow);
		EzBapiiteminTable tblRow = new EzBapiiteminTable();
		EziSalesOrderCreateParams iSOCrParams = new EziSalesOrderCreateParams();
	
		iSOCrParams.setOrderHeaderIn(ezHeader);
		iSOCrParams.setShipToParty(ezShipTo);	//ezShipTo
		iSOCrParams.setSoldToParty(ezSoldTo);
		iSOCrParams.setOrderPartners(partnerTable);
		iSOCrParams.setOrderItemsIn(tblRow);

	 	ezHeader.setDocType(docType);
		ezHeader.setRefDoc(setSalVal.getScDoc());  	//this is customer sales contract no
		ezHeader.setRefDocNr(setSalVal.getRefDocNr());	//setRefDoc.This is customer sap no
		ezHeader.setRef1(carrierName);
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
		ezHeader.setPoNr(setSalVal.getPoNo());
		ezHeader.setAgentCode(setSalVal.getAgent());
		ezHeader.setStatus(status);
		ezHeader.setOrderDate(new Date());
		ezHeader.setCreatedBy(user);
		ezHeader.setModifiedBy(user);
		
		epoNumber = setSalVal.getPoNo();
		epoDate=setSalVal.getPoDate();
		ereqDelvDate=headerReqDate;

		if(("TRANSFERED").equals(status))
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
		
		if(promoCode==null || "null".equals(promoCode) || "".equals(promoCode)) promoCode = "";
		
		ezHeader.setTransferDate(new Date());	//this will be entered at the time of posting to sap
		ezHeader.setCreatedOn(new Date());	//this will be defaulted to today
		ezHeader.setModifiedOn(new Date());	//this will be defaulted to today
		ezHeader.setStatusDate(new Date());	//this will be defaulted to today 
		//ezHeader.setPoMethod("EB2B");
		ezHeader.setIncoterms1(incoTerms1);
		ezHeader.setIncoterms2(incoTerms2);
		ezHeader.setShipCond(shippingCond);
		ezHeader.setPmnttrms(setSalVal.getPaymentTerms());
		ezHeader.setText1(generalNotesAll); 
		ezHeader.setText2(generalNotes1); 
		ezHeader.setText3(generalNotes2);
		ezHeader.setSalesArea(salesAreaCode);
		ezHeader.setReserved1(setSalVal.getPoDate());
		ezHeader.setPromoCode(promoCode);
		ezHeader.setFreightCharges(fServType);	//Setting freight type
		ezHeader.setFreightWeight(freightWeight);
		ezHeader.setFreightPrice(freightPrice);
		ezHeader.setFreightIns(freightIns);
		//ezHeader.setINCOTerms3(""); 		
		//ezHeader.setReserved2();		//this is for reason for rejection
		try
		{
			String poDat = setSalVal.getPoDate();
			//String poDat = FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
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
	// SOLDTO
		ezSoldTo.setSoldTo(setSalVal.getSoldTo());
		ezSoldTo.setName(setSalVal.getSoldToName()); 
		ezSoldTo.setStreet(setSalVal.getSoldToAddress1());
		ezSoldTo.setCity(setSalVal.getSoldToAddress2());
		ezSoldTo.setRegion(setSalVal.getSoldToState());
		ezSoldTo.setPostlCode(setSalVal.getSoldToZipcode());
		ezSoldTo.setCountry(setSalVal.getSoldToCountry());
		
		ebComp=setSalVal.getSoldToName();
		ebSt=setSalVal.getSoldToAddress1();
		ebCity=setSalVal.getSoldToAddress2();
		ebState=setSalVal.getSoldToState();
		ebCou=setSalVal.getSoldToCountry();
		ebPCode=setSalVal.getSoldToZipcode();
		
		
		
		
	// SHIPTO
		
		ezShipTo.setShipTo(sel_Ship);	//setSalVal.getShipTo()
		ezShipTo.setName(shipToName_freq);		//setSalVal.getShipToName()
		
		log4j.log("****sel_Ship*****"+sel_Ship, "D");
		log4j.log("****shipToName_freq*****"+shipToName_freq, "D");
		
		esComp=setSalVal.getShipToName();
		
		if(streetName!=null) 
		{
			//if(floorNo==null || "null".equals(floorNo) || "".equals(floorNo)) floorNo = "N/A";
			//if(buildingName==null || "null".equals(buildingName) || "".equals(buildingName)) buildingName = "N/A";
			
			//String shipAddress = roomNo+"¥"+floorNo+"¥"+buildingName+"¥"+streetName;
			
			ezShipTo.setStreet(streetName);
			ezShipTo.setCity(city_freq);
			ezShipTo.setRegion(state_freq);
			ezShipTo.setPostlCode(pcode_freq);
			
			esSt=streetName;
			esCity=city_freq;
			esState=state_freq;
			esPCode=pcode_freq;
			
			
		}
		else
		{
			ezShipTo.setStreet(setSalVal.getShipToAddress1());
			ezShipTo.setCity(setSalVal.getShipToAddress2());
			ezShipTo.setRegion(setSalVal.getShipToState());
			ezShipTo.setPostlCode(setSalVal.getShipToZipcode());

			esSt=setSalVal.getShipToAddress1();
			esCity=setSalVal.getShipToAddress2();
			esState=setSalVal.getShipToState();
			esPCode=setSalVal.getShipToZipcode();

		}
			ezShipTo.setCountyCde(setSalVal.getShipToCountry());    
			esCou=setSalVal.getShipToCountry();

		eAttn=shAttn;
		eTel1=shTel;
		eTel2=shMobi;
		eFax=shFax;
		efType=fServType;
		eshiIns=specialShIns;



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
			
			String itemDiscCodeVal 	= itemDiscCode[i];
			String itemPromoCodeVal = itemPromoCode[i];
			String itemCnetProdVal	= itemCnetProd[i];
			
			if(itemDiscCodeVal==null || "null".equals(itemDiscCodeVal) || "N/A".equals(itemDiscCodeVal)) itemDiscCodeVal = "";
			if(itemPromoCodeVal==null || "null".equals(itemPromoCodeVal)) itemPromoCodeVal = "";
			if(itemCnetProdVal==null || "null".equals(itemCnetProdVal)) itemCnetProdVal = "";
			
			prodUomQty[i]	= prodUomQty[i].trim();
			desiredPrice 	= desiredPrice_1[i];
			itemPrice 	= itemListPrice[i];
			if(desiredPrice!=null)desiredPrice=desiredPrice.trim();
			desiredPrice 	= ((desiredPrice == null) || (("").equals(desiredPrice)))?"0":desiredPrice;
			
			if(itemPrice!=null)itemPrice=itemPrice.trim();
			itemPrice 	= ((itemPrice == null) || (("").equals(itemPrice)))?"0":itemPrice;
			
			value_Net 	= lineValue_1[i];
			String line 	= String.valueOf((i+1)*10);
			
			rowItm.setItmNumber(new java.math.BigInteger(line));	// Line numbers will be 10,20,30...
			
			rowItm.setMaterial(prodCode_1[i]);
			rowItm.setCustMat(custprodCode[i]);
			
			rowItm.setIncoterms2(itemMfrCode[i]);  //itemEanUPC -- EanUPC
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
			rowItm.setReqPrice(new java.math.BigDecimal(desiredPrice));
			rowItm.setNetPrice(new java.math.BigDecimal(value_Net));
			rowItm.setConfirmedPrice(new java.math.BigDecimal(itemPrice));
			rowItm.setCurrency(setSalVal.getDocCurrency());
			rowItm.setDelFlag("N");
			rowItm.setItemCateg(ItemCat);
			rowItm.setItemFOC("0");
			rowItm.setItemType(itemFlagType);
			rowItm.setRefDocIt(new java.math.BigInteger("0"));
			rowItm.setDiscCode(itemDiscCodeVal);
			rowItm.setPromoCode(itemPromoCodeVal);
			rowItm.setItemWeight(itemWeight[i]);
			rowItm.setItemIns("0");
			rowItm.setNotes(itemCnetProdVal);
			if(("TRANSFERED").equals(status))
			{
				String backorderno="";
				String actLine ="";
				for(int ord = 0;ord<orders.getRowCount();ord++)
				{
					String sDocLine = orders.getFieldValueString(ord,"LineNo");
					String sMatCode = orders.getFieldValueString(ord,"MatCode");
					if(prodCode_1[i].equals(sMatCode))
					{
						backorderno	=orders.getFieldValueString(ord,"SalesOrder");
						actLine		=orders.getFieldValueString(ord,"BackLineNo");
						break;
					}
				}
				rowItm.setBackEndOrder(backorderno);
				rowItm.setBackEndItem(actLine);
			}
			else
			{
				rowItm.setBackEndOrder("");
				rowItm.setBackEndItem("");
			}
			tblRow.insertRow(i,rowItm);
			String del_Qty 		     = ((del_sch_qty_1[i]==null)||(("").equals(del_sch_qty_1[i])))?"0":del_sch_qty_1[i];
			String del_Dates 	     = ((del_sch_date_1[i]==null)||(("").equals(del_sch_date_1[i])))?" ":del_sch_date_1[i];
			StringTokenizer del_Dates_St = new StringTokenizer(del_Dates,"@@");
			StringTokenizer del_Qty_ST   = new StringTokenizer(del_Qty,"@@");
			int del_Qty_Count 	     = del_Qty_ST.countTokens();
			String schqty1[]  	     = new String[del_Qty_Count];
			String schdate1[] 	     = new String[del_Qty_Count];
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
						for(int ord = 0;ord<orders.getRowCount();ord++)
						{
							String sDocLine = orders.getFieldValueString(ord,"LineNo");
							String sMatCode =orders.getFieldValueString(ord,"MatCode");
							if(prodCode_1[i].equals(sMatCode))
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
						delRow.setBackEndNumber("");
						delRow.setBackEndItem("");
					}	
					delTable.insertRow((delcount-1),delRow);
				}
			}
			
			eMailData += "<Tr><Td width=\"10%\" align=\"left\"   "+tdBGColor+">"+custprodCode[i]+"</Td><Td width=\"28%\" align=\"left\"   "+tdBGColor+">"+prodDesc_1[i]+"</Td><Td width=\"10%\" align=\"center\" "+tdBGColor+">"+itemMfrNr[i]+"</Td><Td width=\"10%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(itemOrgPrice[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"8%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(prodDQty_1[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"10%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(desiredPrice)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"8%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(itemPrice)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+(new java.math.BigDecimal(finalPriceVal_1[i])).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()+"</Td></Tr>";
			
			
			
			
			log4j.log("for loop end>>>>>>"+i,"W");
		}
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Freight</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+freightPrice+"</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Freight Insurance</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+freightIns+"</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Tax</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">TBD</Td></Tr>";
		eMailData += "<Tr><Td width=\"58%\" align=\"left\" colspan=5   "+tdBGColorWh+">&nbsp;</Td><Th width=\"26%\" align=\"right\" colspan=2 "+thBGColor+">Total</Th><Td width=\"16%\" align=\"right\"  "+tdBGColor+">"+grandTotalVal+"</Td></Tr>";
		
		eMailData +="</Table>";
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
		eziWfDocHis.setSysKey(salesAreaCode);
		eziWfDocHis.setTemplateCode((String)session.getValue("Template"));
		
		log4j.log("wfActions>>>>>>>>>>>"+(String)wfActions.get(status)+":::status:::"+status,"D");
		
		eziWfDocHis.setAuthKey("SO_CREATE");
		eziWfDocHis.setCreatedBy(user);
		eziWfDocHis.setModifiedBy(user);
		eziWfDocHis.setSoldTo((String) session.getValue("AgentCode"));
		eziWfDocHis.setAction((String)wfActions.get(status));
		if("TRANSFERED".equalsIgnoreCase(status))
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
				/*java.util.ArrayList desiredStep_mail =new java.util.ArrayList();
				desiredStep_mail.add("-1");

				ezc.ezparam.EzcParams mainParams_Q = new ezc.ezparam.EzcParams(false);
				ezc.ezworkflow.params.EziWFParams params_Q= new ezc.ezworkflow.params.EziWFParams();
				params_Q.setTemplate((String)session.getValue("Template"));
				params_Q.setSyskey(salesAreaCode);
				params_Q.setParticipant(wfParticipant);
				params_Q.setDesiredSteps(desiredStep_mail);
				mainParams_Q.setObject(params_Q);
				Session.prepareParams(mainParams_Q);

				ezc.ezparam.ReturnObjFromRetrieve retsoldto_Q = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams_Q);

				if(retsoldto_Q!=null && retsoldto_Q.getRowCount()>0)
				{
					for(int l=0;l<retsoldto_Q.getRowCount();l++)
					{
						String tmpSendToUser = retsoldto_Q.getFieldValueString(l,"EU_ID");
						if(tmpSendToUser!=null && !"null".equals(tmpSendToUser)) tmpSendToUser = tmpSendToUser.trim();
						sendToUser = sendToUser + "," + tmpSendToUser;
					}
				}

				if(sendToUser.startsWith(","))
					sendToUser = sendToUser.substring(1);*/
					
				if(("NEW").equalsIgnoreCase(status))
				{
					sendToUser = saveEmail;
				}
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
	
	if(("NEGOTIATED").equals(status))
	{
%>
		<%@ include file="iAddSaveNegotiate.jsp" %>
<%
	}

	if("NEW".equalsIgnoreCase(status))
	{
		if(SAPnumber)
		{
			msg ="Web Order No: <font color=red>"+weborno+"</font> has been Saved";//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
			sendMail = true;
			
			msgSubject = "New Web Order "+weborno+" has been Saved";
			msgText = "Dear Concerned<br><br>New Web Order has been saved with reference no: "+weborno+".<br>";
			msgText += "<br>";
			msgText += eMailData;
			msgText += "<br>";
			msgText += "<br>Regards,<br>"+Session.getUserId()+" "+custName_M;
		}
		else
			msg ="Web Order has not been Saved";
	}
	else if("NEGOTIATED".equalsIgnoreCase(status))
	{
		if(SAPnumber) 
		{
			String subBy = "sent to Customer";
			if("CU".equals(UserRole.toUpperCase())) subBy = "submitted to Sales Rep";
			
			msg ="Web Order No: <font color=red>"+weborno+"</font> has been "+subBy;//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
			sendMail = true;

			msgSubject = "New Web Order "+weborno+" has been submitted for Review";
			msgText = "Dear Concerned<br><br>New Web Order has been submitted for Review with reference no: "+weborno+".<br>";
			msgText += "<br>";
			msgText += eMailData;
			msgText += "<br>";
			msgText += "<br>Regards,<br>"+Session.getUserId()+" "+custName_M;
		}
		else
			msg ="Web Order has not been Negotiated";
	}
	else if("SUBMITTED".equalsIgnoreCase(status))
	{
		 msg ="Web Order No: <font color=red>"+weborno+"</font> has been submitted for further processing.<br>"+"You can track the status of the order by using the <br>" + "above reference number in the  Orders menu"; 
	}
	else
	{
		if(sDocNumber == null || sDocNumber.trim().length()==0)
       		{
       			if(SAPnumber)
       				msg = "Web Order: <font color=red>"+weborno+"</font> has not been posted into SAP <br><font color=red> Error:"+ ErrorMessage +"</font>";
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
				}catch(Exception e){}
					
			}else  
			{
				try
				{
					sTempDocNumber = sDocNumber;
					sDocNumber=String.valueOf(Integer.parseInt(sDocNumber));
				}catch(Exception e){}
			}
	
			if(SAPnumber)
			{
				if(cnt==0)cnt=1;
				
				msg = "Order Number for Your Reference is <font color=red>"+weborno+"</font><BR><BR>";
				msg = msg+"It has resulted in <font color=red>"+cnt+"</font> ERP Order(s). ERP Order Number(s) : <font color=red>"+sDocNumber+"</font>";//: <font color=red>"+weborno+"</font>
				sendMail = true;

				if("CU".equals(UserRole.toUpperCase()))
				{
				 	subject= "New Web Sales Order "+weborno+" ("+sDocNumber+") has been created.";				
					msgExt = "New Web Sales Order "+weborno+" ("+sDocNumber+") has been created. <BR> PO NO &nbsp;&nbsp;: "+ ezHeader.getPoNr()+". <BR> Customer  : " + ezSoldTo.getName()  + "(" + ezSoldTo.getSoldTo() + ")<BR><BR> Regards,<BR> <BR> **email from <a  href='mailto:b2bsupport@sapusa.com'>b2bsupport@sapusa.com</a> is a real order.<BR> **email from <a  href='mailto:b2bdev@sapusa.com'>b2bdev@sapusa.com</a> is a testing order from QA sever";

					if(msgExt!=null)
					{
						msgInt = "New Web Sales Order "+weborno+" ("+sDocNumber+") has been created. <BR> PO NO &nbsp;&nbsp;: "+ ezHeader.getPoNr()+". <BR> Customer  : " + ezSoldTo.getName()  + "(" + ezSoldTo.getSoldTo() + ")<BR><BR> Regards,<BR> <BR> **email from b2bsupport@sapusa.com is a real order.<BR> **email from b2bdev@sapusa.com is a testing order from QA sever.".trim();					
						msgInt = msgInt.replaceAll("<BR>","\n");
					}
				 
%>				 	
					<%//@ include file="../Inbox/iSendMail.jsp"%>
<%				 
				}

				msgSubject = "New Sales Order "+sDocNumber+" has been created";
				msgText = "Dear Concerned<br><br>New Sales Order has been created with reference no(s): "+sDocNumber+".<br>";
				msgText += "<br>";
				msgText += eMailData;
				msgText += "<br>";
				msgText += "<br>Regards,<br>"+Session.getUserId()+" "+custName_M;
			}
			else
			{
				msg = "Web Order has not been saved but Posted into SAP with Sales Order no(s): <font color=red>"+sDocNumber+"</font>";
			}       			
       		}
        }

	if(sendMail)
	{
%>
		<%@ include file="../../../Sales2/JSPs/Misc/ezSendMail.jsp" %>
<%
	}
	
      	session.putValue("EzMsg",msg);
%>