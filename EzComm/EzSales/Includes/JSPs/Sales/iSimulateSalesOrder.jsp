<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%
	String soldToCode 	= request.getParameter("selSoldTo");

	EzcParams soldParamsMisc = new EzcParams(false);
	EziMiscParams soldParams = new EziMiscParams();

	ezc.ezparam.ReturnObjFromRetrieve soldToOverRetObj = null;

	if(soldToCode!=null && !"null".equals(soldToCode) && !"".equals(soldToCode))
	{
		String query_S = "";
		soldParams.setIdenKey("MISC_SELECT");

		query_S="SELECT EAO_OVERRIDE_TYPE,EAO_VALUE FROM EZC_AMS_SPLIT_OVERRIDES WHERE EAO_VALUE_BASIS='"+soldToCode+"' AND EAO_BASED_ON='4_SOLD_TO'";

		soldParams.setQuery(query_S);

		soldParamsMisc.setLocalStore("Y");
		soldParamsMisc.setObject(soldParams);
		Session.prepareParams(soldParamsMisc);	

		try
		{
			soldToOverRetObj = (ezc.ezparam.ReturnObjFromRetrieve)ezMiscManager.ezSelect(soldParamsMisc);
			//out.println(soldToOverRetObj.toEzcString());
		}
		catch(Exception e)
		{
			//out.println("Exception in Getting Data"+e);
		}
	}

	String msg="";

	final int DATE  = 1;
	final int MONTH = 0;
	final int YEAR  = 2;

 	java.util.ArrayList uProdOrderType = new java.util.ArrayList();
	ArrayList multiOrders_A = new ArrayList();

	EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);

	EzShoppingCart viewCart = null;
	EzcShoppingCartParams prevparams    = new EzcShoppingCartParams();
	EziShoppingCartParams prevsubparams = new EziShoppingCartParams();
	prevsubparams.setLanguage("EN");
	prevparams.setObject(prevsubparams);
	Session.prepareParams(prevparams);
	viewCart = (EzShoppingCart)SCManager.getSavedCart(prevparams);

	int rCount = viewCart.getRowCount();
	java.math.BigDecimal bOrderQty = null;

	String itemCode_C = "";
	String itemVendorCatalog_C = "";
	String itemBrand_C = "";
	String itemListPrice_C = "";
	String itemMatId_C = "";
	String itemEanUPC_C = "";
	String itemmmFlag_C = "";
	String itemDiscCode_C = "";
	String itemMfrCode_C = "";
	String itemMfrPartNo_C = "";
	String itemWeight_C = "";
	String itemOrgPrice_C = "";
	String itemCnetProd_C = "";
	String itemDesc_C = "";
	String itemQty_C = "";

	String itemDisp_C = "";
	String itemVip_C = "";
	String itemCust_C = "";
	String itemPoline_C = "";
	String itemSalesOrg_C = "";
	String itemDivision_C = "";
	String itemDistChnl_C = "";
	String itemOrdType_C = "";
	String itemVolume_C = "";
	String itemPoints_C = "";

	String splitKey_S = "";

	String soldToIncoTerm = request.getParameter("soldToIncoTerm");

	if(soldToIncoTerm==null || "null".equalsIgnoreCase(soldToIncoTerm)) soldToIncoTerm = "";

	Hashtable itemVendorCatalogs = new Hashtable();
	Hashtable itemLPrice = new Hashtable();
	ArrayList flagList = new ArrayList();

	for(int h=0;h<rCount;h++)
	{
		itemCode_C	    = viewCart.getMaterialNumber(h);
		itemVendorCatalog_C = viewCart.getVendorCatalog(h);
		itemBrand_C         = viewCart.getBrand(h);
		itemListPrice_C     = viewCart.getUnitPrice(h);
		itemMatId_C         = viewCart.getMatId(h).trim();
		itemEanUPC_C        = viewCart.getUPCNumber(h); 
		itemmmFlag_C        = viewCart.getMultiMediaFlag(h);
		itemDiscCode_C	  = viewCart.getDiscCode(h);
		itemMfrCode_C	  = viewCart.getMfrCode(h);
		itemMfrPartNo_C	  = viewCart.getMfrPartNo(h);
		itemWeight_C	  = viewCart.getWeight(h);
		itemOrgPrice_C	  = viewCart.getOrgPrice(h);
		itemCnetProd_C	  = viewCart.getVarPriceFlag(h);
		itemDesc_C	  = viewCart.getMaterialDesc(h);
		itemQty_C 	  = viewCart.getOrderQty(h);

		itemDisp_C 	  = viewCart.getCat1(h);
		itemVip_C 	  = viewCart.getCat2(h);
		itemCust_C 	  = viewCart.getCustSku(h);
		itemPoline_C 	  = viewCart.getPoLine(h);
		itemSalesOrg_C 	  = viewCart.getSalesOrg(h);
		itemDivision_C    = viewCart.getDivision(h);
		itemDistChnl_C    = viewCart.getDistChnl(h);
		itemOrdType_C     = viewCart.getOrdType(h);
		itemVolume_C	  = viewCart.getVolume(h);
		itemPoints_C	  = viewCart.getPoints(h);
		//out.println("itemVolume_C::"+itemVolume_C);
		//out.println("itemPoints_C::"+itemPoints_C);

		if(("TPB".equals(soldToIncoTerm) || "PCO".equals(soldToIncoTerm)) && ("OR".equals(itemOrdType_C)))
			itemOrdType_C = "ZLTL";

		String ordOverVal = "";

		if(soldToOverRetObj!=null)
		{
			String overRideCode = (soldToOverRetObj.getFieldValueString(0,"EAO_OVERRIDE_TYPE")).trim();
			String overRideVal = soldToOverRetObj.getFieldValueString(0,"EAO_VALUE");

			if("ORDER_TYPE".equals(overRideCode))
				ordOverVal = overRideVal;
		}

		if(!"".equals(ordOverVal))
			itemOrdType_C = ordOverVal;

		if(itemBrand_C == null || "null".equals(itemBrand_C) || "".equals(itemBrand_C))itemBrand_C="N/A";
		if(itemEanUPC_C == null || "null".equals(itemEanUPC_C) || "".equals(itemEanUPC_C))itemEanUPC_C="N/A";
		if(itemDiscCode_C == null || "null".equals(itemDiscCode_C) || "".equals(itemDiscCode_C))itemDiscCode_C="N/A";
		if(itemMfrCode_C == null || "null".equals(itemMfrCode_C) || "".equals(itemMfrCode_C))itemMfrCode_C="N/A";
		if(itemMfrPartNo_C == null || "null".equals(itemMfrPartNo_C) || "".equals(itemMfrPartNo_C))itemMfrPartNo_C="N/A";
		if(itemWeight_C == null || "null".equals(itemWeight_C) || "".equals(itemWeight_C))itemWeight_C="N/A";

		if(itemDisp_C == null || "null".equals(itemDisp_C) || "".equals(itemDisp_C))itemDisp_C="N/A";
		if(itemVip_C == null || "null".equals(itemVip_C) || "".equals(itemVip_C))itemVip_C="N/A";
		if(itemCust_C == null || "null".equals(itemCust_C) || "".equals(itemCust_C))itemCust_C="N/A";
		if(itemPoline_C == null || "null".equals(itemPoline_C) || "".equals(itemPoline_C))itemPoline_C="N/A";
		if(itemCode_C == null || "null".equals(itemCode_C) || "".equals(itemCode_C))itemCode_C="N/A";
		if(itemVolume_C == null || "null".equals(itemVolume_C) || "".equals(itemVolume_C))itemVolume_C="N/A";
		if(itemPoints_C == null || "null".equals(itemPoints_C) || "".equals(itemPoints_C))itemPoints_C="N/A";

		if((itemDisp_C!=null && "YES".equals(itemDisp_C)) || (itemVip_C!=null && "YES".equals(itemVip_C)))
			flagList.add(itemMatId_C);	

		itemVendorCatalogs.put(itemMatId_C+itemCode_C,itemVendorCatalog_C+"¥"+itemBrand_C+"¥"+itemListPrice_C+"¥"+itemCode_C+"¥"+itemEanUPC_C+"¥"+itemMatId_C+"¥"+itemDiscCode_C+"¥"+itemMfrCode_C+"¥"+itemMfrPartNo_C+"¥"+itemWeight_C+"¥"+itemOrgPrice_C+"¥"+itemCnetProd_C+"¥"+itemDisp_C+"¥"+itemVip_C+"¥"+itemCust_C+"¥"+itemPoline_C+"¥"+itemSalesOrg_C+"¥"+itemDivision_C+"¥"+itemDistChnl_C+"¥"+itemOrdType_C+"¥"+itemVolume_C+"¥"+itemPoints_C);
		itemLPrice.put(itemMatId_C+itemCode_C,itemListPrice_C);

		log4j.log("itemVendorCatalogs in Simulation >>>"+itemVendorCatalogs.get(itemMatId_C+itemCode_C),"I");

		if(!"56".equals(itemBrand_C))
			itemBrand_C = itemDivision_C;

		splitKey_S = itemOrdType_C+"¥"+itemSalesOrg_C+"¥"+itemDivision_C+"¥"+itemDistChnl_C+"¥"+itemBrand_C;

		if(!uProdOrderType.contains(splitKey_S))
		{
			uProdOrderType.add(splitKey_S);
		}
	}
	//out.println("splitKey_S::"+splitKey_S);

	//FormatDate formatDate = new FormatDate();

	java.util.GregorianCalendar fromDate = null ;
	java.util.GregorianCalendar deliveryDate = null ;
	java.util.GregorianCalendar reqDate = null ;
	java.util.GregorianCalendar reqDateH = null ;

	fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();

	java.math.BigDecimal  netValue = new java.math.BigDecimal("0");

	String PartnNum 	= (String)session.getValue("AgentCode");
	//String inDate 		= FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
	String poNumber		= request.getParameter("poNumber");
	String poDate		= request.getParameter("poDate");
	String shipToCode 	= request.getParameter("selShipTo");
	String complDlv 	= request.getParameter("shipComplete");
	String shipMethod 	= request.getParameter("shipMethod");
	String comments 	= request.getParameter("comments");
	String shipInst 	= request.getParameter("shipInst");
	String desiredDate 	= request.getParameter("desiredDate");
	String inDate	 	= request.getParameter("desiredDate");
	String promoCode 	= request.getParameter("promoCode");

	if(promoCode==null || "null".equalsIgnoreCase(promoCode)) promoCode = "";

	if(inDate==null || "null".equalsIgnoreCase(inDate) || "".equals(inDate))
		inDate = FormatDate.getStringFromDate(new Date(),".",FormatDate.MMDDYYYY);

	String shipPartnRole 	= "";

	String dlvCheck = "";
	String dlvChk = "";
	if(complDlv!=null && "on".equalsIgnoreCase(complDlv))
	{
		dlvCheck = "checked=checked";
		dlvChk = "X";
	}

	int dateReq 	= Integer.parseInt(inDate.substring(3,5));
	int monthReq 	= Integer.parseInt(inDate.substring(0,2));
	int yearReq 	= Integer.parseInt(inDate.substring(6,10));
	reqDateH 	= new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);

	Date desShipDate = new Date(yearReq,monthReq-1,dateReq);

	ReturnObjFromRetrieve itemoutTable = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retCond = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retSched = new ReturnObjFromRetrieve();

	int retStrucCnt = 0;

for(int us=0;us<uProdOrderType.size();us++)
{
	EzcSalesOrderParams  ezcSalesOrderParams 	= new EzcSalesOrderParams();

	// BAPI Parameters

	EzBapisdheadStructure 	orderHeader 		= null;
	EzBapipartnrTable 	orderPartners 		= null;
	EzBapipartnrTableRow 	orderPartnersRow	= null;
	EzBapiiteminTable 	iteminTable 		= null;
	EzBapiiteminTableRow 	iteminTableRow 		= null;

	EziSalesOrderCreateParams ioParams 	= null;

	EzoSalesOrderCreate 	osmParams 	= null;
	ReturnObjFromRetrieve  	itemoutTable_I 	= null;
	ReturnObjFromRetrieve  	retCond_I 	= null;
	ReturnObjFromRetrieve  	retSched_I 	= null;

	EzcSalesOrderParams initParams = new EzcSalesOrderParams();
	EziSalesOrderCreateParams initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);
	ioParams = (EziSalesOrderCreateParams) EzSalesOrderManager.initializeSalesOrder(initParams);

	//Set values for OrderHeader

	orderHeader = ioParams.getOrderHeaderIn();
	orderHeader.setDivision("");    	//need to set "" because hard coded in initializeSalesOrder
	orderHeader.setDistrChan("");
	orderHeader.setSalesOrg("");
	orderHeader.setLog("TRUE");
	orderHeader.setDocType((String)session.getValue("docType"));
	orderHeader.setPurchNo(poNumber);
	orderHeader.setPoSupplem("WWW");
	orderHeader.setReqDateH(reqDateH.getTime());
	orderHeader.setAgentCode((String)session.getValue("SAPPRDCODE"));
	//orderHeader.setPromoCode(promoCode);
	orderHeader.setComplDlv(dlvChk);

	orderPartners = ioParams.getOrderPartners();

	if(soldToCode!=null)
	{
		soldToCode = "0000000000"+soldToCode;
		soldToCode = soldToCode.substring(soldToCode.length()-10,soldToCode.length());
		soldToCode = soldToCode.trim();

		orderPartnersRow = new EzBapipartnrTableRow();
		orderPartnersRow.setPartnRole("AG"); 			//CHECK IF WE CAN GET PARTNER ROLE FROM DEFAULTS
		orderPartnersRow.setPartnNumb(soldToCode);
		orderPartners.insertRow(0, orderPartnersRow);
	}
	if(shipToCode!=null)
	{
		shipToCode = shipToCode.trim();

		orderPartnersRow = new EzBapipartnrTableRow();
		orderPartnersRow.setPartnRole("WE"); 			//CHECK IF WE CAN GET PARTNER ROLE FROM DEFAULTS
		orderPartnersRow.setPartnNumb(shipToCode);
		orderPartners.insertRow(1, orderPartnersRow);
	}
	if(shipMethod!=null && !"STD".equals(shipMethod))
	{
		shipMethod = shipMethod.trim();

		if("CLTL".equals(shipMethod))
		{
			shipPartnRole = "ZF";
			shipMethod = "271578";
		} else {
			shipPartnRole = "ZC";
		}

		orderPartnersRow = new EzBapipartnrTableRow();
		orderPartnersRow.setPartnRole(shipPartnRole);
		orderPartnersRow.setPartnNumb(shipMethod);
		orderPartners.insertRow(2, orderPartnersRow);
	}

	//Set ordered items

	iteminTable = ioParams.getOrderItemsIn(); // new EzBapiiteminTable();

	int lineno = 1;
	java.math.BigInteger line = null;
	java.math.BigDecimal itemPointsBD = new java.math.BigDecimal("0");

	Hashtable pointsCatHT = new Hashtable();
	ArrayList itemCat_A = new ArrayList();

	String splitKeyChk_I = "";

	for(int h=0;h<rCount;h++)
	{
		itemCode_C	    = viewCart.getMaterialNumber(h);
		itemVendorCatalog_C = viewCart.getVendorCatalog(h);
		itemBrand_C         = viewCart.getBrand(h);
		itemListPrice_C     = viewCart.getUnitPrice(h);
		itemMatId_C         = viewCart.getMatId(h);
		itemEanUPC_C        = viewCart.getUPCNumber(h); 
		itemmmFlag_C        = viewCart.getMultiMediaFlag(h);
		itemDiscCode_C	  = viewCart.getDiscCode(h);
		itemMfrCode_C	  = viewCart.getMfrCode(h);
		itemMfrPartNo_C	  = viewCart.getMfrPartNo(h);
		itemWeight_C	  = viewCart.getWeight(h);
		itemOrgPrice_C	  = viewCart.getOrgPrice(h);
		itemCnetProd_C	  = viewCart.getVarPriceFlag(h);
		itemDesc_C	  = viewCart.getMaterialDesc(h);
		itemQty_C 	  = viewCart.getOrderQty(h);

		itemDisp_C 	  = viewCart.getCat1(h);
		itemVip_C 	  = viewCart.getCat2(h);
		itemCust_C 	  = viewCart.getCustSku(h);
		itemPoline_C 	  = viewCart.getPoLine(h);
		itemSalesOrg_C 	  = viewCart.getSalesOrg(h);
		itemDivision_C    = viewCart.getDivision(h);
		itemDistChnl_C    = viewCart.getDistChnl(h);
		itemOrdType_C     = viewCart.getOrdType(h);
		itemVolume_C	  = viewCart.getVolume(h);
		itemPoints_C	  = viewCart.getPoints(h);

		if(("TPB".equals(soldToIncoTerm) || "PCO".equals(soldToIncoTerm)) && ("OR".equals(itemOrdType_C)))
			itemOrdType_C = "ZLTL";

		if(!"".equals(ordOverVal))
			itemOrdType_C = ordOverVal;

		if(itemBrand_C == null || "null".equals(itemBrand_C) || "".equals(itemBrand_C))itemBrand_C="N/A";
		if(itemEanUPC_C == null || "null".equals(itemEanUPC_C) || "".equals(itemEanUPC_C))itemEanUPC_C="N/A";
		if(itemDiscCode_C == null || "null".equals(itemDiscCode_C) || "".equals(itemDiscCode_C))itemDiscCode_C="N/A";
		if(itemMfrCode_C == null || "null".equals(itemMfrCode_C) || "".equals(itemMfrCode_C))itemMfrCode_C="N/A";
		if(itemMfrPartNo_C == null || "null".equals(itemMfrPartNo_C) || "".equals(itemMfrPartNo_C))itemMfrPartNo_C="N/A";
		if(itemWeight_C == null || "null".equals(itemWeight_C) || "".equals(itemWeight_C))itemWeight_C="N/A";

		if(itemDisp_C == null || "null".equals(itemDisp_C) || "".equals(itemDisp_C))itemDisp_C="N/A";
		if(itemVip_C == null || "null".equals(itemVip_C) || "".equals(itemVip_C))itemVip_C="N/A";
		if(itemCust_C == null || "null".equals(itemCust_C) || "".equals(itemCust_C))itemCust_C="N/A";
		if(itemPoline_C == null || "null".equals(itemPoline_C) || "".equals(itemPoline_C))itemPoline_C="N/A";

		bOrderQty  = new java.math.BigDecimal(itemQty_C);
		bOrderQty = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));

		if(!"56".equals(itemBrand_C))
			itemBrand_C = itemDivision_C;

		String splitKeyChk = itemOrdType_C+"¥"+itemSalesOrg_C+"¥"+itemDivision_C+"¥"+itemDistChnl_C+"¥"+itemBrand_C;

		if(splitKeyChk.equals((String)uProdOrderType.get(us)))
		{
			splitKeyChk_I = splitKeyChk;

			line 	   = new java.math.BigInteger(String.valueOf(lineno*10));

			String ord_T = itemOrdType_C;
			if("OR".equals(ord_T)) ord_T = "TA";
			if("FD".equals(ord_T)) ord_T = "KL";

			iteminTableRow = new EzBapiiteminTableRow();

			//out.println("itemMatId_C::"+itemMatId_C);
			//out.println("itemEanUPC_C::"+itemEanUPC_C);
			//out.println("itemDesc_C::"+itemDesc_C);
			//out.println("itemListPrice_C::"+itemListPrice_C);

			//if(itemMatId_C.indexOf(".")==4) itemMatId_C = "0"+itemMatId_C;
			//out.println("itemMatId_C::"+itemMatId_C);

			//if((itemMatId_C.length())-(itemMatId_C.indexOf("."))==3) itemMatId_C = itemMatId_C+"0";
			//out.println("itemMatId_C::"+itemMatId_C);

			iteminTableRow.setMaterial(itemMatId_C);
			iteminTableRow.setEanUpc(itemEanUPC_C);
			iteminTableRow.setMatExt(itemMatId_C);
			iteminTableRow.setMatlGroup("AST");
			iteminTableRow.setBatch(itemMatId_C);
			iteminTableRow.setPoItmNoS(itemCode_C);  // Used for unique identification
			//out.println("itemCode_C::"+itemCode_C);

			String soCondType = (String)session.getValue("SOCONDTYPE");

			if(!"N/A".equals(itemMfrPartNo_C))
			{
				soCondType = "ZJOB";

				try
				{
					iteminTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice_C)/10));
					iteminTableRow.setCondType(soCondType);
				}
				catch(Exception err){}
			}

			iteminTableRow.setShortText(itemDesc_C);
			iteminTableRow.setBillDate(fromDate.getTime());
			iteminTableRow.setReqQty(bOrderQty.toBigInteger());

			try
			{
				dateReq  = Integer.parseInt(inDate.substring(3,5));
				monthReq = Integer.parseInt(inDate.substring(0,2));
				yearReq  = Integer.parseInt(inDate.substring(6,10));
				reqDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
				iteminTableRow.setReqDate(reqDate.getTime());
			}
			catch(Exception e){}

			//these are required for Multi Simulate

			iteminTableRow.setItmNumber(line);
			iteminTableRow.setShipTo(shipToCode);
			iteminTableRow.setSysKey((String)session.getValue("SalesAreaCode"));
			iteminTableRow.setPlant("");
			iteminTableRow.setDocType(ord_T);				//(String)session.getValue("docType")
			iteminTableRow.setSalesOrg(itemSalesOrg_C);			//(String)session.getValue("salesOrg")
			iteminTableRow.setDistributionChanel(itemDistChnl_C);		//(String)session.getValue("dc")
			iteminTableRow.setDivision(itemDivision_C);			//(String)session.getValue("division")
			iteminTable.appendRow(iteminTableRow);

			lineno++;

			try
			{
				log4j.log(">>>>>>>>>>>>simulate>>1>>","D");

				if(!itemCat_A.contains(itemVendorCatalog_C))
					itemCat_A.add(itemVendorCatalog_C);

				if(pointsCatHT.containsKey(itemVendorCatalog_C))
					itemPointsBD = new java.math.BigDecimal((String)pointsCatHT.get(itemVendorCatalog_C));

				log4j.log(">>>>>>>>>>>>simulate>>2>>","D");

				itemPointsBD = itemPointsBD.add(new java.math.BigDecimal(itemPoints_C));

				pointsCatHT.put(itemVendorCatalog_C,itemPointsBD.toString());
			}
			catch(Exception e){}
		}
	}

	for(int ic=0;ic<itemCat_A.size();ic++)
	{
		String itemCatSel = (String)itemCat_A.get(ic);

		String catPoints = (String)session.getValue(itemCatSel);
		String itemPointsSel = (String)pointsCatHT.get(itemCatSel);

		log4j.log(">>>>>>>>>>>>simulate>>3>>","D");

		java.math.BigDecimal catPointsBD = new java.math.BigDecimal("0");
		java.math.BigDecimal itemSelBD = new java.math.BigDecimal("0");

		try
		{
			catPointsBD = new java.math.BigDecimal(catPoints);
			itemSelBD = new java.math.BigDecimal(itemPointsSel);
		}
		catch(Exception e){}

		log4j.log(">>>>>>>>>>>>simulate>>4>>","D");

		int compBD = catPointsBD.compareTo(itemSelBD);

		if(compBD==1)
		{
			boolean dPoint = false;

			String dProdCode = "";
			String dQuantity = "";

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
				}
				else if(cp_90==1 && ip_90==-1)
				{
					dPoint = true;
					dQuantity = "90000";
				}
				else if(cp_48==1 && ip_48==-1)
				{
					dPoint = true;
					dQuantity = "48000";
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

					String ord_T = itemOrdType_C;
					if("OR".equals(ord_T)) ord_T = "TA";
					if("FD".equals(ord_T)) ord_T = "KL";

					iteminTableRow = new EzBapiiteminTableRow();

					iteminTableRow.setMaterial(dProdCode);
					iteminTableRow.setEanUpc("");
					iteminTableRow.setMatExt(dProdCode);
					iteminTableRow.setMatlGroup("AST");
					iteminTableRow.setBatch(dProdCode);
					iteminTableRow.setPoItmNoS("");  // Used for unique identification
					iteminTableRow.setShortText("");
					iteminTableRow.setBillDate(fromDate.getTime());
					iteminTableRow.setReqQty(new java.math.BigInteger(dQuantity));
					iteminTableRow.setReqDate(reqDate.getTime());

					String plant = "";

					iteminTableRow.setItmNumber(line);
					iteminTableRow.setShipTo(shipToCode);
					iteminTableRow.setSysKey((String)session.getValue("SalesAreaCode"));
					iteminTableRow.setPlant("");
					iteminTableRow.setDocType(ord_T);				//(String)session.getValue("docType")
					iteminTableRow.setSalesOrg(itemSalesOrg_C);			//(String)session.getValue("salesOrg")
					iteminTableRow.setDistributionChanel(itemDistChnl_C);		//(String)session.getValue("dc")
					iteminTableRow.setDivision(itemDivision_C);			//(String)session.getValue("division")
					iteminTable.appendRow(iteminTableRow);

					lineno++;
				}
			}
		}
		//out.println("pointsCatHT::"+pointsCatHT);
		//out.println("compBD::"+compBD);
		//out.println("catPointsBD::"+catPointsBD);
		//out.println("itemPointsBD::"+itemPointsBD);
	}

//******************************************************

	EzBapischdlTable deliveryScheduleTable = new EzBapischdlTable();
	ioParams.setOrderDelSchedule(deliveryScheduleTable);
	ioParams.setType("RBPG");
	ioParams.setCreditChkFlag("Y");
	ezcSalesOrderParams.setObject(ioParams);
	Session.prepareParams(ezcSalesOrderParams);

	long start = System.currentTimeMillis();
	osmParams = (EzoSalesOrderCreate)EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParams);
	long finish = System.currentTimeMillis();

	log4j.log("Simulate Sales Order >>>"+(finish-start)/1000,"I");

	ReturnObjFromRetrieve returnStruct = (ReturnObjFromRetrieve)osmParams.getReturn();
	ReturnObjFromRetrieve messageTable = (ReturnObjFromRetrieve)osmParams.getMessageTable();
	ReturnObjFromRetrieve itemsIn = (ReturnObjFromRetrieve)osmParams.getOrderItemsIn();

	ReturnObjFromRetrieve orderHeaderIn = (ReturnObjFromRetrieve)osmParams.getOrderHeaderIn();


	if(us==0)
	{
		itemoutTable = (ReturnObjFromRetrieve)osmParams.getOrderItemsOut();
		retCond = (ReturnObjFromRetrieve)osmParams.getOrderConditionsOut();
		retSched = (ReturnObjFromRetrieve)osmParams.getScheduleTable();
		//out.println("retSched::"+retSched.toEzcString());

		itemoutTable.addColumn("SPLITKEY");
		retCond.addColumn("SPLITKEY");
		retSched.addColumn("SPLITKEY");
		//out.println("splitKeyChk3::"+splitKeyChk_I);

		for(int k=0;k<itemoutTable.getRowCount();k++)
		{
			itemoutTable.setFieldValueAt("SPLITKEY",splitKeyChk_I,k);
		}
		for(int k=0;k<retCond.getRowCount();k++)
		{
			retCond.setFieldValueAt("SPLITKEY",splitKeyChk_I,k);
		}
		for(int k=0;k<retSched.getRowCount();k++)
		{
			retSched.setFieldValueAt("SPLITKEY",splitKeyChk_I,k);
		}
	}
	else
	{
		itemoutTable_I = (ReturnObjFromRetrieve)osmParams.getOrderItemsOut();
		retCond_I = (ReturnObjFromRetrieve)osmParams.getOrderConditionsOut();
		retSched_I = (ReturnObjFromRetrieve)osmParams.getScheduleTable();

		itemoutTable_I.addColumn("SPLITKEY");
		retCond_I.addColumn("SPLITKEY");
		retSched_I.addColumn("SPLITKEY");
		//out.println("splitKeyChk4::"+splitKeyChk_I);

		for(int k=0;k<itemoutTable_I.getRowCount();k++)
		{
			itemoutTable_I.setFieldValueAt("SPLITKEY",splitKeyChk_I,k);
		}
		for(int k=0;k<retCond_I.getRowCount();k++)
		{
			retCond_I.setFieldValueAt("SPLITKEY",splitKeyChk_I,k);
		}
		for(int k=0;k<retSched_I.getRowCount();k++)
		{
			retSched_I.setFieldValueAt("SPLITKEY",splitKeyChk_I,k);
		}

		itemoutTable.append(itemoutTable_I);
		retCond.append(retCond_I);
		retSched.append(retSched_I);
	}

	if(returnStruct.getRowCount()> 0)
	{
		for(int pc=0;pc<returnStruct.getRowCount();pc++)
		{
			if((returnStruct.getFieldValue(pc,"Type")).equals("E"))
			{
				retStrucCnt = returnStruct.getRowCount();
				msg=msg+ returnStruct.getFieldValue(pc,"Message")+"<br>";
			}
		}
	}
	//out.println("itemoutTable::"+itemoutTable.toEzcString());
}
	//out.println("itemoutTable::"+itemoutTable.toEzcString());
	//out.println("retCond::"+retCond.toEzcString());
	//out.println("retSched::"+retSched.toEzcString());

	int itemOutCnt = 0;

	if(itemoutTable!=null) itemOutCnt = itemoutTable.getRowCount();

	int retSchedCnt = 0;

	if(retSched!=null) retSchedCnt = retSched.getRowCount();

//*****************************************************************************************
%>