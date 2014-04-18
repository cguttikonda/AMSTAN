<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ page import="java.util.Set" %>
<%
	EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);

	String updateFlag 	= request.getParameter("updateFlag");
	String miscSplitKey 	= request.getParameter("miscSplitKey");
	String miscHandFee 	= request.getParameter("miscHandFee");
	String dropShipTo 	= "NO";
	boolean quickShip 	= false;
	boolean qsFaucet 	= false;

	if(updateFlag!=null && "Y".equals(updateFlag))
	{
		String cartRows = request.getParameter("cartRows");

		if(cartRows!=null)
		{
			int totCount = (new Integer(cartRows)).intValue();

			String[] products1 	= new String[totCount];
			String[] reqQtys1  	= new String[totCount];
			String[] reqDates1 	= new String[totCount];
			String[] vendCatalogs1 	= new String[totCount];
			String[] matIds1 	= new String[totCount];
			String[] division 	= new String[totCount];
			String[] distChnl 	= new String[totCount];
			String[] salesOrg 	= new String[totCount];
			String[] ordType 	= new String[totCount];

			String[] dispProd 	= new String[totCount];
			String[] vipProd 	= new String[totCount];
			String[] cat3	 	= new String[totCount];
			String[] prodSku 	= new String[totCount];
			String[] poLine 	= new String[totCount];
			String[] reftype 	= new String[totCount];
			String[] volume_A	= new String[totCount];
			String[] points_A	= new String[totCount];
			String[] brand_A	= new String[totCount];
			String[] kitComp_A	= new String[totCount];
			String[] ext1		= new String[totCount];
			String[] ext2		= new String[totCount];
			String[] ext3		= new String[totCount];

			for(int i=0;i<totCount;i++)
			{
				String lNo 	 = request.getParameterValues("lineItem")[i];

				products1[i]	 = request.getParameter("lineItem_"+lNo);
				reqQtys1[i]	 = request.getParameter("reqQty_"+lNo);
				reqDates1[i]	 = "1.11.1000";
				vendCatalogs1[i] = request.getParameter("venCat_"+lNo);
				matIds1[i]	 = request.getParameter("matId_"+lNo);
				division[i]	 = request.getParameter("division_"+lNo);
				distChnl[i]	 = request.getParameter("distChnl_"+lNo);
				salesOrg[i]	 = request.getParameter("salesOrg_"+lNo);
				ordType[i]	 = (request.getParameter("docType_"+lNo)).toUpperCase();

				dispProd[i]	 = request.getParameterValues("itemDisp")[i];
				vipProd[i]	 = request.getParameterValues("itemVip")[i];
				cat3[i]	 	 = request.getParameterValues("itemCat3")[i];
				prodSku[i]	 = request.getParameterValues("itemCustSku")[i];
				poLine[i]	 = request.getParameterValues("itemPoLine")[i];
				reftype[i]	 = request.getParameterValues("itemRefType")[i];
				volume_A[i]	 = request.getParameterValues("itemVolume")[i];
				points_A[i]	 = request.getParameterValues("itemPoints")[i];
				brand_A[i]	 = request.getParameterValues("itemPlant")[i];
				kitComp_A[i]	 = request.getParameterValues("itemComp")[i];
				ext1[i]		 = request.getParameterValues("itemClass")[i];
				ext2[i]		 = "N/A";
				ext3[i]		 = "N/A";

				/*out.println("products1::"+products1[i]);
				out.println("division::"+division[i]);
				out.println("distChnl::"+distChnl[i]);
				out.println("salesOrg::"+salesOrg[i]);
				out.println("ordType::"+ordType[i]);*/
			}

			EzcShoppingCartParams params1 = new EzcShoppingCartParams();
			EziReqParams reqparams1 = new EziReqParams();
			EziShoppingCartParams subparams1 = new EziShoppingCartParams();

			reqparams1.setProducts(products1);
			reqparams1.setReqQty(reqQtys1);
			reqparams1.setReqDate(reqDates1);
			reqparams1.setVendorCatalogs(vendCatalogs1);
			reqparams1.setMatId(matIds1);

			reqparams1.setDivision(division);
			reqparams1.setDistChnl(distChnl);
			reqparams1.setSalesOrg(salesOrg);
			reqparams1.setOrdType(ordType);

			reqparams1.setCat1(dispProd);
			reqparams1.setCat2(vipProd);
			reqparams1.setCat3(cat3);
			reqparams1.setCustSku(prodSku);
			reqparams1.setPoLine(poLine);
			reqparams1.setType(reftype);
			reqparams1.setVolume(volume_A);
			reqparams1.setPoints(points_A);

			reqparams1.setBrand(brand_A);
			reqparams1.setKitComp(kitComp_A);
			reqparams1.setExt1(ext1);
			reqparams1.setExt2(ext2);
			reqparams1.setExt3(ext3);

			subparams1.setType("AF");
			subparams1.setLanguage("EN");
			subparams1.setEziReqParams(reqparams1);
			subparams1.setObject(reqparams1);

			params1.setObject(subparams1);
			Session.prepareParams(params1);

			try
			{
				SCManager.updateCart(params1);
			}
			catch(Exception e){}
		}
	}

	String soldToCode 	= request.getParameter("selSoldTo");
	String shipToCode 	= request.getParameter("selShipTo");
	String accGroup 	= request.getParameter("accGroup");
	String sysKey	 	= (String)session.getValue("SalesAreaCode");
	String allSAreas 	= (String)session.getValue("ALLSALES_AREAS");
	String shStateToAct 	= request.getParameter("shipToState");

	EzcParams soldParamsMisc = new EzcParams(false);
	EziMiscParams soldParams = new EziMiscParams();

	ezc.ezparam.ReturnObjFromRetrieve soldToOverRetObj = null;
	ezc.ezparam.ReturnObjFromRetrieve soldToPriceGrpRetObj = null;	

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

		String sysQuery = "";
		if("CU".equals(userRole))
			sysQuery = "AND EC_SYS_KEY IN ('"+allSAreas+"')";

		//query_S="SELECT EC_ERP_CUST_NO,EC_PARTNER_NO,ECA_EXT1 CUSTGROUP,EC_SYS_KEY FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR  WHERE ECA_NO=EC_NO AND  EC_ERP_CUST_NO ='"+soldToCode+"' AND EC_PARTNER_NO='"+shipToCode+"' AND EC_SYS_KEY='"+sysKey+"'";
		query_S="SELECT EC_ERP_CUST_NO,EC_PARTNER_NO,ECA_EXT1 CUSTGROUP,ECA_BLOCK_CODE,EC_SYS_KEY,(SELECT ECAD_VALUE FROM EZC_CAT_AREA_DEFAULTS WHERE ECAD_SYS_KEY=EC_SYS_KEY AND ECAD_KEY='DISTRIBUTION') DC FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE ECA_NO=EC_NO AND  EC_ERP_CUST_NO ='"+soldToCode+"' AND EC_PARTNER_NO='"+shipToCode+"' "+sysQuery+" GROUP BY EC_ERP_CUST_NO,EC_PARTNER_NO,ECA_EXT1,ECA_BLOCK_CODE,EC_SYS_KEY ORDER BY ECA_BLOCK_CODE";
		soldParams.setQuery(query_S);

		try
		{
			soldToPriceGrpRetObj = (ezc.ezparam.ReturnObjFromRetrieve)ezMiscManager.ezSelect(soldParamsMisc);
		}
		catch(Exception e){}
	}

	String splitKey_S = "";
	String ordOverVal = "";
	String ordCustGrp = "";

	if(soldToOverRetObj!=null && soldToOverRetObj.getRowCount()>0)
	{
		String overRideCode = (soldToOverRetObj.getFieldValueString(0,"EAO_OVERRIDE_TYPE")).trim();
		String overRideVal = soldToOverRetObj.getFieldValueString(0,"EAO_VALUE");

		if("ORDER_TYPE".equals(overRideCode))
			ordOverVal = overRideVal;
	}

	String blkCode	= "";
	String distCh	= "";
	String custGrp	= "";

	java.util.ArrayList blklist = new java.util.ArrayList();
 	if(soldToPriceGrpRetObj!=null && soldToPriceGrpRetObj.getRowCount()>0)
	{
		for(int i=0;i<soldToPriceGrpRetObj.getRowCount();i++)
		{
			blkCode	= soldToPriceGrpRetObj.getFieldValueString(i,"ECA_BLOCK_CODE");
			String distCh_A = soldToPriceGrpRetObj.getFieldValueString(i,"DC");

			if("05".equals(blkCode) || "01".equals(blkCode))
			{
				if(!blklist.contains(distCh_A))
					blklist.add(distCh_A);
			}
		}
		log4j.log("blklist >>>"+blklist,"I");
		for(int i=0;i<soldToPriceGrpRetObj.getRowCount();i++)
		{
			String distCh_A = soldToPriceGrpRetObj.getFieldValueString(i,"DC");

			if(!blklist.contains(distCh_A))
			{
				custGrp = soldToPriceGrpRetObj.getFieldValueString(i,"CUSTGROUP");
				distCh = distCh_A;
				break;
			}
		}
		log4j.log("custGrp >>>"+custGrp,"I");
		log4j.log("distCh >>>"+distCh,"I");
		if(custGrp.startsWith("P")) ordCustGrp = "Z1";
	}

	String msg="";

	final int DATE  = 1;
	final int MONTH = 0;
	final int YEAR  = 2;

 	java.util.ArrayList uProdOrderType = new java.util.ArrayList();
	ArrayList multiOrders_A = new ArrayList();

	EzShoppingCart viewCart = null;
	EzcShoppingCartParams prevparams    = new EzcShoppingCartParams();
	EziShoppingCartParams prevsubparams = new EziShoppingCartParams();
	prevsubparams.setLanguage("EN");
	prevparams.setObject(prevsubparams);
	Session.prepareParams(prevparams);
	viewCart = (EzShoppingCart)SCManager.getSavedCart(prevparams);

	int rCount = viewCart.getRowCount();
	java.math.BigDecimal bOrderQty = null;
	int totPOQty = 0;

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
	String itemCat2_C = "";
	String itemComp_C = "";
	String itemCust_C = "";
	String itemPoline_C = "";
	String itemSalesOrg_C = "";
	String itemDivision_C = "";
	String itemDistChnl_C = distCh;
	String itemOrdType_C = "";
	String itemVolume_C = "";
	String itemPoints_C = "";
	String itemClass_C = "";

	String soldToIncoTerm = request.getParameter("soldToIncoTerm");

	if(soldToIncoTerm==null || "null".equalsIgnoreCase(soldToIncoTerm)) soldToIncoTerm = "";

	Hashtable totPointsCatHT = new Hashtable();
	Hashtable totPointsCatHT_Std = new Hashtable();

	//Hashtable itemVendorCatalogs = new Hashtable();
	//Hashtable itemLPrice = new Hashtable();
	boolean dispFlag_S = false;
	boolean vipFlag_S = false;
	ArrayList flagList = new ArrayList();
	ArrayList progType_AL = new ArrayList();

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
		itemCat2_C 	  = viewCart.getCat2(h);
		itemCust_C 	  = viewCart.getCustSku(h);
		itemPoline_C 	  = viewCart.getPoLine(h);
		itemSalesOrg_C 	  = viewCart.getSalesOrg(h);
		itemDivision_C    = viewCart.getDivision(h);
		//itemDistChnl_C    = viewCart.getDistChnl(h);
		itemOrdType_C     = viewCart.getOrdType(h);
		itemVolume_C	  = viewCart.getVolume(h);
		itemPoints_C	  = viewCart.getPoints(h);
		itemClass_C	  = viewCart.getExt1(h);
		//out.println("itemVolume_C::"+itemVolume_C);
		//out.println("itemPoints_C::"+itemPoints_C);

		if(itemBrand_C == null || "null".equals(itemBrand_C) || "".equals(itemBrand_C))itemBrand_C="N/A";
		if(itemEanUPC_C == null || "null".equals(itemEanUPC_C) || "".equals(itemEanUPC_C))itemEanUPC_C="N/A";
		if(itemDiscCode_C == null || "null".equals(itemDiscCode_C) || "".equals(itemDiscCode_C))itemDiscCode_C="N/A";
		if(itemMfrCode_C == null || "null".equals(itemMfrCode_C) || "".equals(itemMfrCode_C))itemMfrCode_C="N/A";
		if(itemMfrPartNo_C == null || "null".equals(itemMfrPartNo_C) || "".equals(itemMfrPartNo_C))itemMfrPartNo_C="N/A";
		if(itemWeight_C == null || "null".equals(itemWeight_C) || "".equals(itemWeight_C))itemWeight_C="N/A";

		if(itemDisp_C == null || "null".equals(itemDisp_C) || "".equals(itemDisp_C))itemDisp_C="N/A";
		if(itemCat2_C == null || "null".equals(itemCat2_C) || "".equals(itemCat2_C))itemCat2_C="N/A";
		if(itemCust_C == null || "null".equals(itemCust_C) || "".equals(itemCust_C))itemCust_C="N/A";
		if(itemPoline_C == null || "null".equals(itemPoline_C) || "".equals(itemPoline_C))itemPoline_C="N/A";
		if(itemCode_C == null || "null".equals(itemCode_C) || "".equals(itemCode_C))itemCode_C="N/A";
		if(itemVolume_C == null || "null".equals(itemVolume_C) || "".equals(itemVolume_C))itemVolume_C="N/A";
		if(itemPoints_C == null || "null".equals(itemPoints_C) || "".equals(itemPoints_C))itemPoints_C="0";
		if(itemQty_C == null || "null".equals(itemQty_C) || "".equals(itemQty_C) || "N/A".equals(itemQty_C))itemQty_C="0";

		if("FOC".equals(itemDisp_C))
			itemDistChnl_C = "70";

		if("QS".equals(itemDisp_C))
			quickShip = true;

		if("QS".equals(itemDisp_C) && ("LUX".equals(itemClass_C) || "COM".equals(itemClass_C)))
			qsFaucet = true;

		/*
		if(("TPB".equals(soldToIncoTerm) || "PCO".equals(soldToIncoTerm)) && ("OR".equals(itemOrdType_C)))
			itemOrdType_C = "OR";//ZLTL

		if(("25".equals(itemCat2_C) || "26".equals(itemCat2_C)) && !"".equals(ordCustGrp))
			itemOrdType_C = ordCustGrp;

		if(!"".equals(ordOverVal))
			itemOrdType_C = ordOverVal;
		*/

		if(itemDisp_C!=null)
		{
			if("DISP".equals(itemDisp_C))
			{
				dispFlag_S = true;
				flagList.add(itemMatId_C);
			}
			if("VIP".equals(itemDisp_C))
			{
				vipFlag_S = true;
				flagList.add(itemMatId_C);
			}
		}

		java.math.BigDecimal totItemPointsBD = new java.math.BigDecimal("0");

		if(totPointsCatHT.containsKey(itemVendorCatalog_C))
			totItemPointsBD = new java.math.BigDecimal((String)totPointsCatHT.get(itemVendorCatalog_C));

		totItemPointsBD = totItemPointsBD.add(new java.math.BigDecimal(itemPoints_C));

		totPointsCatHT.put(itemVendorCatalog_C,totItemPointsBD.toString());

		if(!("DISP".equals(itemDisp_C) || "VIP".equals(itemDisp_C) || "FOC".equals(itemDisp_C) || "QS".equals(itemDisp_C) || "CS".equals(itemDisp_C)))
		{
			java.math.BigDecimal totItemPointsBD_Std = new java.math.BigDecimal("0");

			if(totPointsCatHT_Std.containsKey(itemVendorCatalog_C))
				totItemPointsBD_Std = new java.math.BigDecimal((String)totPointsCatHT_Std.get(itemVendorCatalog_C));

			totItemPointsBD_Std = totItemPointsBD_Std.add(new java.math.BigDecimal(itemPoints_C));

			totPointsCatHT_Std.put(itemVendorCatalog_C,totItemPointsBD_Std.toString());

			try
			{
				if("Marble".equals(itemVendorCatalog_C) 	|| 
				   "Enamel Steel".equals(itemVendorCatalog_C)	|| 
				   "Acrylux".equals(itemVendorCatalog_C) 	|| 
				   "Chinaware".equals(itemVendorCatalog_C)	|| 
				   "Americast & Acrylics (Excludes Acrylux)".equals(itemVendorCatalog_C))
				{
					itemQty_C = eliminateDecimals(itemQty_C);
					totPOQty = totPOQty+Integer.parseInt(itemQty_C);
				}
			}
			catch(Exception e){}
		}

		if(!progType_AL.contains(itemDisp_C))
		{
			progType_AL.add(itemDisp_C);
		}

		/*
		itemVendorCatalogs.put(itemMatId_C+itemCode_C,itemVendorCatalog_C+"¥"+itemBrand_C+"¥"+itemListPrice_C+"¥"+itemCode_C+"¥"+itemEanUPC_C+"¥"+itemMatId_C+"¥"+itemDiscCode_C+"¥"+itemMfrCode_C+"¥"+itemMfrPartNo_C+"¥"+itemWeight_C+"¥"+itemOrgPrice_C+"¥"+itemCnetProd_C+"¥"+itemDisp_C+"¥"+itemCat2_C+"¥"+itemCust_C+"¥"+itemPoline_C+"¥"+itemSalesOrg_C+"¥"+itemDivision_C+"¥"+itemDistChnl_C+"¥"+itemOrdType_C+"¥"+itemVolume_C+"¥"+itemPoints_C);
		itemLPrice.put(itemMatId_C+itemCode_C,itemListPrice_C);

		log4j.log("itemVendorCatalogs in Simulation >>>"+itemVendorCatalogs.get(itemMatId_C+itemCode_C),"I");

		if(!("56".equals(itemBrand_C) || "36".equals(itemBrand_C) || "5L".equals(itemBrand_C) || "55".equals(itemBrand_C)))
			itemBrand_C = itemDivision_C;

		splitKey_S = itemOrdType_C+"¥"+itemSalesOrg_C+"¥"+itemDivision_C+"¥"+itemDistChnl_C+"¥"+itemBrand_C;

		if(!uProdOrderType.contains(splitKey_S))
		{
			uProdOrderType.add(splitKey_S);
		}
		*/
	}

	/*************** Expedite Shipping Method - Start ***************/

	boolean prodInStock = true;
	String expOrdType = "";
	String incoTerms_O = "";
	String custGrp5 = "";
	String custCondGrp3 = "";

	String shipMethod = request.getParameter("shipMethod");
	ArrayList quickShip_M = new ArrayList();

	quickShip_M.add("UP1A");
	quickShip_M.add("UP1B");
	quickShip_M.add("UP1C");
	quickShip_M.add("UP2B");
	quickShip_M.add("UP2C");
	quickShip_M.add("UP3C");
	quickShip_M.add("FE1A");
	quickShip_M.add("FE1B");
	quickShip_M.add("FE1C");
	quickShip_M.add("FE2B");
	quickShip_M.add("FE2C");
	quickShip_M.add("FE3C");

	boolean expShipMethod = false;
	boolean shipCycle_E = false;

	for(int pt=0;pt<progType_AL.size();pt++)
	{
		String progType_A = (String)progType_AL.get(pt);

		if(!("DISP".equals(progType_A) || "VIP".equals(progType_A) || "FOC".equals(progType_A) || "QS".equals(progType_A) || "CS".equals(progType_A)))
		{
			expOrdType = "OR";
			//custGrp5 = "EVE";	// This is applicable only for sales org 1001 when order type OR and other than best way is selected

			if(rCount>0 && shipMethod!=null && !"STD".equals(shipMethod))
			{
				shipCycle_E = true;

				if(quickShip_M.contains(shipMethod))
				{
					expShipMethod = true;

					//DateFormat formatter1;
					Date DateFrom = new Date();
					//formatter1 = new SimpleDateFormat("MM/dd/yyyy");

					//DateFrom = (Date)formatter1.parse(atpion); 

					JCO.Client client = null;
					JCO.Function functionEx = null;	

					String site_S = (String)session.getValue("Site");
					String skey_S = "998";

					try
					{
						functionEx 		  = EzSAPHandler.getFunction("Z_EZ_GET_MATERIAL_AVAILABILITY",site_S+"~"+skey_S);
						JCO.ParameterList atpProc = functionEx.getImportParameterList();
						JCO.Table zMat 		  = functionEx.getTableParameterList().getTable("ZMATERIAL");

						atpProc.setValue((String)session.getValue("salesOrg"),"SALES_ORGANIZATION");
						atpProc.setValue((String)session.getValue("dc"),"DISTRI_CHANNEL");
						atpProc.setValue((String)session.getValue("division"),"DIVISON");
						atpProc.setValue(soldToCode,"KUNNR");
						atpProc.setValue(shipToCode,"KUNWE");
						atpProc.setValue(shStateToAct,"REGIO");

						for(int h=0;h<rCount;h++)
						{
							String prodCode = viewCart.getMatId(h).trim();
							String prodQty  = viewCart.getOrderQty(h).trim();
							itemDisp_C 	= viewCart.getCat1(h);

							if(!("DISP".equals(itemDisp_C) || "VIP".equals(itemDisp_C) || "FOC".equals(itemDisp_C) || "QS".equals(itemDisp_C) || "CS".equals(itemDisp_C)))
							{
								zMat.appendRow();
								zMat.setValue(prodCode,"MATERIAL");
								zMat.setValue(DateFrom,"REQ_DATE");
								zMat.setValue(prodQty,"REQ_QTY");
							}
						}

						try
						{
							client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
							client.execute(functionEx);
						}
						catch(Exception ec){}

						JCO.Table atpResultTable = functionEx.getTableParameterList().getTable("RESULT");
						JCO.Table atpZMatTable 	 = functionEx.getTableParameterList().getTable("ZMATERIAL");

						HashMap zMatHM = new HashMap();

						if(atpZMatTable!=null && atpZMatTable.getNumRows()>0)
						{
							do
							{
								zMatHM.put(atpZMatTable.getValue("MATERIAL"),atpZMatTable.getValue("REQ_QTY"));
							}
							while(atpZMatTable.nextRow());
						}
						if(atpResultTable!=null && atpResultTable.getNumRows()>0)
						{
							do
							{
								String retQty = (String)atpResultTable.getValue("AVAIL_QTY");
								String reqQty = (String)zMatHM.get(atpResultTable.getValue("MATERIAL"));

								int reqQtyInt=0,retQtyInt=0;
								if(reqQty!=null && !"null".equals(reqQty) && !"".equals(reqQty))
								{
									reqQty = eliminateDecimals(reqQty);
									reqQtyInt = Integer.parseInt(reqQty);
								}
								if(retQty!=null && !"null".equals(retQty) && !"".equals(retQty))
								{
									retQty = eliminateDecimals(retQty);
									retQtyInt = Integer.parseInt(retQty);
								}
								if(retQtyInt<reqQtyInt)
								{
									prodInStock = false;
									break;
								}
							}
							while(atpResultTable.nextRow());
						}
					}
					catch(Exception e){}
					finally
					{
						if(client!=null)
						{
							JCO.releaseClient(client);
							client = null;
							functionEx=null;
						}
					}
				}
			}

			if(expShipMethod)
			{
				if(prodInStock)
				{
					java.math.BigDecimal totPOPointsBD = new java.math.BigDecimal("0");

					if(totPointsCatHT_Std.containsKey("Marble"))
						totPOPointsBD = totPOPointsBD.add(new java.math.BigDecimal((String)totPointsCatHT_Std.get("Marble")));
					if(totPointsCatHT_Std.containsKey("Enamel Steel"))
						totPOPointsBD = totPOPointsBD.add(new java.math.BigDecimal((String)totPointsCatHT_Std.get("Enamel Steel")));
					if(totPointsCatHT_Std.containsKey("Acrylux"))
						totPOPointsBD = totPOPointsBD.add(new java.math.BigDecimal((String)totPointsCatHT_Std.get("Acrylux")));
					if(totPointsCatHT_Std.containsKey("Chinaware"))
						totPOPointsBD = totPOPointsBD.add(new java.math.BigDecimal((String)totPointsCatHT_Std.get("Chinaware")));
					if(totPointsCatHT_Std.containsKey("Americast & Acrylics (Excludes Acrylux)"))
						totPOPointsBD = totPOPointsBD.add(new java.math.BigDecimal((String)totPointsCatHT_Std.get("Americast & Acrylics (Excludes Acrylux)")));

					int pointCond1 = (totPOPointsBD).compareTo(new java.math.BigDecimal("2.50"));
					int pointCond2 = (totPOPointsBD).compareTo(new java.math.BigDecimal("3.50"));
					int pointCond3 = (totPOPointsBD).compareTo(new java.math.BigDecimal("50.00"));

					if(!"0".equals(totPOPointsBD.toString()))
					{
						if(totPOQty==1 && (pointCond1==0 || pointCond1==-1))
						{
							expOrdType = "Z1";
							custGrp5 = "";
						}
						else if(totPOQty>1 && (pointCond2==0 || pointCond2==-1))
						{
							expOrdType = "Z1";
							custGrp5 = "";
						}
						/*else if(pointCond3==0 || pointCond3==-1)
						{
							expOrdType = "Z1";
							custGrp5 = "";
						}*/
					}
				}
			}
		}
	}

	/*************** Expedite Shipping Method - End ***************/

	for(int h=0;h<rCount;h++)
	{
		itemBrand_C	  = viewCart.getBrand(h);
		itemCat2_C 	  = viewCart.getCat2(h);
		itemSalesOrg_C 	  = viewCart.getSalesOrg(h);
		itemDivision_C    = viewCart.getDivision(h);
		//itemDistChnl_C    = viewCart.getDistChnl(h);
		itemOrdType_C     = viewCart.getOrdType(h);
		itemDisp_C	  = viewCart.getCat1(h);

		if(itemBrand_C == null || "null".equals(itemBrand_C) || "".equals(itemBrand_C))itemBrand_C="N/A";
		if(itemCat2_C == null || "null".equals(itemCat2_C) || "".equals(itemCat2_C))itemCat2_C="N/A";

		if(!("DISP".equals(itemDisp_C) || "VIP".equals(itemDisp_C) || "FOC".equals(itemDisp_C) || "QS".equals(itemDisp_C) || "CS".equals(itemDisp_C)))
		{
			if(("25".equals(itemCat2_C) || "26".equals(itemCat2_C)) && !"".equals(ordCustGrp))
				itemOrdType_C = ordCustGrp;

			if(!"".equals(expOrdType))
				itemOrdType_C = expOrdType;

			if(expShipMethod && prodInStock && ("1002".equals(itemSalesOrg_C) || "1004".equals(itemSalesOrg_C)))
			{
				itemOrdType_C = "Z1";
				custGrp5 = "";
			}

			if(!"".equals(ordOverVal))
				itemOrdType_C = ordOverVal;
		}

		if(!("56".equals(itemBrand_C) || "36".equals(itemBrand_C) || "5L".equals(itemBrand_C) || "55".equals(itemBrand_C)))
			itemBrand_C = itemDivision_C;

		splitKey_S = itemOrdType_C+"¥"+itemSalesOrg_C+"¥"+itemDivision_C+"¥"+itemDistChnl_C+"¥"+itemBrand_C;

		if(!uProdOrderType.contains(splitKey_S))
		{
			uProdOrderType.add(splitKey_S);
		}
	}

	String dvToAct = "";
	String dvActBy = "";

	if((dispFlag_S || vipFlag_S) && "CU".equals(userRole))
	{
		EzcParams shipParamsMisc = new EzcParams(false);
		EziMiscParams shipParams = new EziMiscParams();

		ezc.ezparam.ReturnObjFromRetrieve shipToActRetObj = null;

		if(shStateToAct!=null && !"null".equals(shStateToAct) && !"".equals(shStateToAct))
		{
			shStateToAct = "US"+(shStateToAct.trim());
			String query_S = "";
			shipParams.setIdenKey("MISC_SELECT");

			query_S="SELECT VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='STATEOPSMGR' AND VALUE1='"+shStateToAct+"'";

			shipParams.setQuery(query_S);

			shipParamsMisc.setLocalStore("Y");
			shipParamsMisc.setObject(shipParams);
			Session.prepareParams(shipParamsMisc);	

			try
			{
				shipToActRetObj = (ezc.ezparam.ReturnObjFromRetrieve)ezMiscManager.ezSelect(shipParamsMisc);
				//out.println(shipToActRetObj.toEzcString());
			}
			catch(Exception e)
			{
				//out.println("Exception in Getting Data"+e);
			}
		}

		if(shipToActRetObj!=null)
		{
			dvToAct = shipToActRetObj.getFieldValueString(0,"VALUE2");
			//dvToAct = dvToAct.substring(0,dvToAct.indexOf("@"));

			if(!"".equals(dvToAct)) dvActBy = "CUST";
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
	String complDlv 	= request.getParameter("shipComplete");
	String comments 	= request.getParameter("comments");
	String shipInst 	= request.getParameter("shipInst");
	String desiredDate 	= request.getParameter("desiredDate");
	String inDate	 	= request.getParameter("desiredDate");
	String promoCode 	= request.getParameter("promoCode");

	if(poNumber!=null)
	{
		poNumber = poNumber.trim();
		poNumber = poNumber.replaceAll("\'","`");
		poNumber = poNumber.toUpperCase();
	}

	String billToAddress = "";

	String isResidential = request.getParameter("isResidential");
	String carrierName 	= shipMethod;//request.getParameter("carrierName");
	String useMyCarrier 	= request.getParameter("useMyCarrier");
	String carrierId 	= "";
	String billToName 	= "";
	String billToStreet 	= "";
	String billToCity 	= "";
	String billToState 	= "";
	String billToZipCode 	= "";

	if(useMyCarrier!=null && "YES".equals(useMyCarrier))
	{
		carrierId 	= request.getParameter("carrierId");
		billToName 	= request.getParameter("billToName");
		billToStreet 	= request.getParameter("billToStreet");
		billToCity 	= request.getParameter("billToCity");
		billToState 	= request.getParameter("billToState");
		billToZipCode 	= request.getParameter("billToZipCode");
	}

	if(useMyCarrier==null || "null".equalsIgnoreCase(useMyCarrier)) useMyCarrier = "NOSEL";
	if(shipMethod==null || "null".equalsIgnoreCase(shipMethod)) shipMethod = "";
	if(carrierName==null || "null".equalsIgnoreCase(carrierName)) carrierName = "";
	if(carrierId==null || "null".equalsIgnoreCase(carrierId)) carrierId = "";
	if(billToName==null || "null".equalsIgnoreCase(billToName)) billToName = "";
	if(billToStreet==null || "null".equalsIgnoreCase(billToStreet)) billToStreet = "";
	if(billToCity==null || "null".equalsIgnoreCase(billToCity)) billToCity = "";
	if(billToState==null || "null".equalsIgnoreCase(billToState)) billToState = "";
	if(billToZipCode==null || "null".equalsIgnoreCase(billToZipCode)) billToZipCode = "";
	if(comments==null || "null".equalsIgnoreCase(comments)) comments = "";
	if(shipInst==null || "null".equalsIgnoreCase(shipInst)) shipInst = "";
	if(isResidential==null || "null".equalsIgnoreCase(isResidential) || "".equals(isResidential)) isResidential = "NOSEL";

	if(!"".equals(comments)) comments = comments.trim();
	if(!"".equals(shipInst)) shipInst = shipInst.trim();

	//String newLine = "\n";

	if(!"FOC".equals(catType_C) && useMyCarrier!=null && "YES".equals(useMyCarrier))
		billToAddress = "A/c Id with Carrier: "+carrierId+"\n"+"Bill To Name: "+billToName+"\n"+"Street: "+billToStreet+"\n"+"City/State/Zip:"+billToCity+","+billToState+","+billToZipCode;

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

	if(promoCode==null || "null".equalsIgnoreCase(promoCode) || "".equals(promoCode.trim()))
		promoCode = "";
	else
		promoCode = promoCode.toUpperCase();

	boolean setEDD = true;
	String eDDFlag = "Y";
	String expEDDFlag = "N";
	if(inDate==null || "null".equalsIgnoreCase(inDate) || "".equals(inDate))
	{
		eDDFlag = "N";
		setEDD = false;
		inDate = FormatDate.getStringFromDate(new Date(),".",FormatDate.MMDDYYYY);
	}

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

	int retStrucCnt = 0;

	EzcSalesOrderParams  ezcSalesOrderParams 	= new EzcSalesOrderParams();

	// BAPI Parameters

	//EzBapisdheadStructure 	orderHeader 		= null;
	EzBapisdheadTable	orderHeader	 	= null;
	EzBapisdheadTableRow	ordHeadRow	 	= null;
	EzBapipartnrTable 	orderPartners 		= null;
	EzBapipartnrTableRow 	orderPartnersRow	= null;
	EzBapiiteminTable 	iteminTable 		= null;
	EzBapiiteminTableRow 	iteminTableRow 		= null;

	EziSalesOrderCreateParams ioParams 	= null;
	EzoSalesOrderCreate 	osmParams 	= null;

	EzcSalesOrderParams initParams = new EzcSalesOrderParams();
	EziSalesOrderCreateParams initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);
	ioParams = (EziSalesOrderCreateParams) EzSalesOrderManager.initializeSalesOrder(initParams);

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

	if(expShipMethod && prodInStock && "Z1".equals(ordType_S))
	{
		eDDFlag = "Y";
		setEDD = true;
		expEDDFlag = "Y";

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

		inDate = newDate.format(cal.getTime());

		dateReq 	= Integer.parseInt(inDate.substring(3,5));
		monthReq 	= Integer.parseInt(inDate.substring(0,2));
		yearReq 	= Integer.parseInt(inDate.substring(6,10));
		reqDateH 	= new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
		desShipDate = new Date(yearReq,monthReq-1,dateReq);
	}

	//Set values for OrderHeader

	orderHeader = ioParams.getOrderHeaderTableIn();

	ordHeadRow = new EzBapisdheadTableRow();

	ordHeadRow.setSplitKey(splitKey_A);
	ordHeadRow.setDivision(division_S);    	//need to set "" because hard coded in initializeSalesOrder
	ordHeadRow.setDistrChan(distChnl_S);
	ordHeadRow.setSalesOrg(salesOrg_S);
	ordHeadRow.setLog("TRUE");
	ordHeadRow.setDocType(ord_T);
	ordHeadRow.setPurchNo(poNumber);
	ordHeadRow.setPoSupplem("WWW");

	if(setEDD)
	{
		ordHeadRow.setReqDateH(reqDateH.getTime());
	}

	ordHeadRow.setAgentCode((String)session.getValue("SAPPRDCODE"));
	ordHeadRow.setPromoCode(promoCode);
	ordHeadRow.setComplDlv(dlvChk);
	//ordHeadRow.setShipCond(incoTerms_O);
	ordHeadRow.setIncoterms1(incoTerms_O);
	if("PCO".equals(incoTerms_O))
	{
		ordHeadRow.setIncoterms2("Ppd & Charge");
	}
	if("YES".equals(isResidential))
	{
		ordHeadRow.setShippingType("Y");
	}
	if(quickShip)
	{
		ordHeadRow.setShipCond("ZQ");
	}

	if(miscSplitKey!=null && splitKey_A.equals(miscSplitKey))
	{
		if(miscHandFee!=null && !"null".equalsIgnoreCase(miscHandFee) && !"".equals(miscHandFee))
		{
			try
			{
				ordHeadRow.setCdType1("ZMSC");
				ordHeadRow.setCdValue1(new java.math.BigDecimal(Double.parseDouble(miscHandFee)/10));
			}
			catch(Exception e){}
		}
	}

	orderPartners = ioParams.getOrderPartners();

	if(soldToCode!=null)
	{
		soldToCode = "0000000000"+soldToCode;
		soldToCode = soldToCode.substring(soldToCode.length()-10,soldToCode.length());
		soldToCode = soldToCode.trim();

		orderPartnersRow = new EzBapipartnrTableRow();
		orderPartnersRow.setSplitKey(splitKey_A);
		orderPartnersRow.setPartnRole("AG"); 			//CHECK IF WE CAN GET PARTNER ROLE FROM DEFAULTS
		orderPartnersRow.setPartnNumb(soldToCode);
		orderPartners.insertRow(0, orderPartnersRow);
	}
	if(shipToCode!=null)
	{
		shipToCode = shipToCode.trim();

		orderPartnersRow = new EzBapipartnrTableRow();
		orderPartnersRow.setSplitKey(splitKey_A);
		orderPartnersRow.setPartnRole("WE"); 			//CHECK IF WE CAN GET PARTNER ROLE FROM DEFAULTS
		orderPartnersRow.setPartnNumb(shipToCode);
		orderPartners.insertRow(1, orderPartnersRow);
	}
	if(shipMethod!=null && !"STD".equals(shipMethod) && !"FOC".equals(catType_C))
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
		orderPartnersRow.setSplitKey(splitKey_A);
		orderPartnersRow.setPartnRole(shipPartnRole);
		orderPartnersRow.setPartnNumb(shipMethod);
		orderPartners.insertRow(2, orderPartnersRow);
	}

	//if(shipToCode.endsWith("9999")) dropShipTo = "YES";
	if((accGroup!=null && "CPDA".equalsIgnoreCase(accGroup)) || "FOC".equals(catType_C)) dropShipTo = "YES";

	//Set ordered items

	iteminTable = ioParams.getOrderItemsIn(); // new EzBapiiteminTable();

	int lineno = 1;
	java.math.BigInteger line = null;
	java.math.BigDecimal itemPointsBD = new java.math.BigDecimal("0");

	Hashtable pointsCatHT = new Hashtable();
	ArrayList itemCat_A = new ArrayList();

	String splitKeyChk_I = "";
	String qsFreightVal = "0";

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
		itemCat2_C 	  = viewCart.getCat2(h);
		itemComp_C	  = viewCart.getKitComp(h);
		itemCust_C 	  = viewCart.getCustSku(h);
		itemPoline_C 	  = viewCart.getPoLine(h);
		itemSalesOrg_C 	  = viewCart.getSalesOrg(h);
		itemDivision_C    = viewCart.getDivision(h);
		//itemDistChnl_C    = viewCart.getDistChnl(h);
		itemOrdType_C     = viewCart.getOrdType(h);
		itemVolume_C	  = viewCart.getVolume(h);
		itemPoints_C	  = viewCart.getPoints(h);
		itemClass_C	  = viewCart.getExt1(h);

		String stdMulti_A = request.getParameter("stdMulti_"+itemCode_C);
		String netPrice_A = request.getParameter("netPrice_"+itemCode_C);
		String stdMultiChng = request.getParameter("stdMultiChng_"+itemCode_C);
		String netPriceChng = request.getParameter("netPriceChng_"+itemCode_C);

		if(itemBrand_C == null || "null".equals(itemBrand_C) || "".equals(itemBrand_C))itemBrand_C="N/A";
		if(itemEanUPC_C == null || "null".equals(itemEanUPC_C) || "".equals(itemEanUPC_C))itemEanUPC_C="N/A";
		if(itemDiscCode_C == null || "null".equals(itemDiscCode_C) || "".equals(itemDiscCode_C))itemDiscCode_C="N/A";
		if(itemMfrCode_C == null || "null".equals(itemMfrCode_C) || "".equals(itemMfrCode_C))itemMfrCode_C="N/A";
		if(itemMfrPartNo_C == null || "null".equals(itemMfrPartNo_C) || "".equals(itemMfrPartNo_C))itemMfrPartNo_C="N/A";
		if(itemWeight_C == null || "null".equals(itemWeight_C) || "".equals(itemWeight_C))itemWeight_C="N/A";

		if(itemDisp_C == null || "null".equals(itemDisp_C) || "".equals(itemDisp_C))itemDisp_C="N/A";
		if(itemCat2_C == null || "null".equals(itemCat2_C) || "".equals(itemCat2_C))itemCat2_C="N/A";
		if(itemCust_C == null || "null".equals(itemCust_C) || "".equals(itemCust_C))itemCust_C="N/A";
		if(itemPoline_C == null || "null".equals(itemPoline_C) || "".equals(itemPoline_C))itemPoline_C="N/A";
		if(itemComp_C == null || "null".equals(itemComp_C) || "".equals(itemComp_C) || "N/A".equals(itemComp_C))itemComp_C="0";

		if(("TPB".equals(soldToIncoTerm) || "PCO".equals(soldToIncoTerm)) && ("OR".equals(itemOrdType_C)))
			itemOrdType_C = "OR";//ZLTL

		if(!("DISP".equals(itemDisp_C) || "VIP".equals(itemDisp_C) || "FOC".equals(itemDisp_C) || "QS".equals(itemDisp_C) || "CS".equals(itemDisp_C)))
		{
			if(("25".equals(itemCat2_C) || "26".equals(itemCat2_C)) && !"".equals(ordCustGrp))
				itemOrdType_C = ordCustGrp;

			if(!"".equals(expOrdType))
				itemOrdType_C = expOrdType;

			if(expShipMethod && prodInStock && ("1002".equals(itemSalesOrg_C) || "1004".equals(itemSalesOrg_C)))
			{
				itemOrdType_C = "Z1";
				custGrp5 = "";
			}

			if(!"".equals(ordOverVal))
				itemOrdType_C = ordOverVal;

			if("OR".equals(itemOrdType_C) && shipCycle_E && "1001".equals(itemSalesOrg_C))
				custGrp5 = "EVE";
		}

		bOrderQty  = new java.math.BigDecimal(itemQty_C);
		bOrderQty = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));

		if(!("56".equals(itemBrand_C) || "36".equals(itemBrand_C) || "5L".equals(itemBrand_C) || "55".equals(itemBrand_C)))
			itemBrand_C = itemDivision_C;

		String splitKeyChk = itemOrdType_C+"¥"+itemSalesOrg_C+"¥"+itemDivision_C+"¥"+itemDistChnl_C+"¥"+itemBrand_C;

		if(splitKeyChk.equals(splitKey_A))
		{
			splitKeyChk_I = splitKeyChk;

			line 	   = new java.math.BigInteger(String.valueOf(lineno*10));

			iteminTableRow = new EzBapiiteminTableRow();

			//out.println("itemMatId_C::"+itemMatId_C);
			//out.println("itemEanUPC_C::"+itemEanUPC_C);
			//out.println("itemDesc_C::"+itemDesc_C);
			//out.println("itemListPrice_C::"+itemListPrice_C);

			//if(itemMatId_C.indexOf(".")==4) itemMatId_C = "0"+itemMatId_C;
			//out.println("itemMatId_C::"+itemMatId_C);

			//if((itemMatId_C.length())-(itemMatId_C.indexOf("."))==3) itemMatId_C = itemMatId_C+"0";
			//out.println("itemMatId_C::"+itemMatId_C);

			iteminTableRow.setSplitKey(splitKey_A);
			iteminTableRow.setMaterial(itemMatId_C);
			iteminTableRow.setEanUpc(itemEanUPC_C);
			iteminTableRow.setMatExt(itemMatId_C);
			iteminTableRow.setMatlGroup("AST");
			iteminTableRow.setBatch(itemMatId_C);
			iteminTableRow.setPoItmNoS(itemCode_C);  // Used for unique identification

			String pointBased = "";
			if("Marble".equals(itemVendorCatalog_C) 	||
			   "Enamel Steel".equals(itemVendorCatalog_C) 	||
			   "Acrylux".equals(itemVendorCatalog_C) 	||
			   "Chinaware".equals(itemVendorCatalog_C) 	||
			   "Americast & Acrylics (Excludes Acrylux)".equals(itemVendorCatalog_C))
				pointBased = "X";

			if("X".equals(pointBased))
				iteminTableRow.setPointBased(pointBased);

			//out.println("itemCode_C::"+itemCode_C);

			String soCondType = (String)session.getValue("SOCONDTYPE");

			if(!"N/A".equals(itemMfrPartNo_C))
			{
				soCondType = "ZJOB";

				try
				{
					iteminTableRow.setRefDoc(itemMfrPartNo_C);
					iteminTableRow.setRefDocIt(new java.math.BigInteger(itemWeight_C));

					//iteminTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice_C)/10));
					//iteminTableRow.setCondType(soCondType);
				}
				catch(Exception err){}
			}
			else if(updateFlag!=null && "Y".equals(updateFlag))
			{
				String soCondVal = "";
				soCondType = "";

				if(stdMultiChng!=null && "Y".equals(stdMultiChng))
				{
					if(stdMulti_A!=null && !"N/A".equals(stdMulti_A) && !"0".equals(stdMulti_A))
					{
						if("ZDPO".equals(itemOrdType_C) || "ZIDP".equals(itemOrdType_C))
						{
							if("1001".equals(itemSalesOrg_C))
								soCondType = "ZUVP";
							else if("1002".equals(itemSalesOrg_C))
								soCondType = "Z706";
							else if("1004".equals(itemSalesOrg_C))
								soCondType = "ZMPM";
						}
						else
							soCondType = "ZMPM";

						soCondVal = stdMulti_A;
						try
						{
							iteminTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(soCondVal)*100));
							iteminTableRow.setCondType(soCondType);
						}
						catch(Exception err){}
					}
				}
				else
				{
					if(netPriceChng!=null && "Y".equals(netPriceChng))
					{
						if(netPrice_A!=null && !"N/A".equals(netPrice_A) && !"0".equals(netPrice_A))
						{
							if("ZDPO".equals(itemOrdType_C) || "ZIDP".equals(itemOrdType_C))
							{
								if("1001".equals(itemSalesOrg_C))
									soCondType = "ZUMP";
								else if("1002".equals(itemSalesOrg_C))
									soCondType = "ZMPR";
								else if("1004".equals(itemSalesOrg_C))
									soCondType = "ZMPR";
							}
							else
								soCondType = "ZMPR";

							soCondVal = netPrice_A;
							try
							{
								iteminTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(soCondVal)/10));
								iteminTableRow.setCondType(soCondType);
							}
							catch(Exception err){}
						}
					}
				}
			}

			//iteminTableRow.setShortText(itemDesc_C);
			iteminTableRow.setBillDate(fromDate.getTime());
			iteminTableRow.setReqQty(bOrderQty.toBigInteger());

			try
			{
				dateReq  = Integer.parseInt(inDate.substring(3,5));
				monthReq = Integer.parseInt(inDate.substring(0,2));
				yearReq  = Integer.parseInt(inDate.substring(6,10));
				reqDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);

				if(setEDD)
				{
					iteminTableRow.setReqDate(reqDate.getTime());
				}
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

			try
			{
				lineno = lineno+Integer.parseInt(itemComp_C);
			}
			catch(Exception e){}
			
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

			if(qsFaucet && (useMyCarrier!=null && !"YES".equals(useMyCarrier)))
			{
				if("FEGC".equals(shipMethod) || "UPGC".equals(shipMethod))
				{
					if("LUX".equals(itemClass_C))
					{
						qsFreightVal = ((new java.math.BigDecimal(qsFreightVal)).add((new java.math.BigDecimal("6")).multiply(new java.math.BigDecimal(itemQty_C)))).toString();
					}
					else if("COM".equals(itemClass_C))
					{
						qsFreightVal = ((new java.math.BigDecimal(qsFreightVal)).add((new java.math.BigDecimal("6")).multiply(new java.math.BigDecimal(itemQty_C)))).toString();
					}
				}
				else if("FE1C".equals(shipMethod) || "UP1C".equals(shipMethod))
				{
					if("LUX".equals(itemClass_C))
					{
						qsFreightVal = ((new java.math.BigDecimal(qsFreightVal)).add((new java.math.BigDecimal("15")).multiply(new java.math.BigDecimal(itemQty_C)))).toString();
					}
					else if("COM".equals(itemClass_C))
					{
						qsFreightVal = ((new java.math.BigDecimal(qsFreightVal)).add((new java.math.BigDecimal("20")).multiply(new java.math.BigDecimal(itemQty_C)))).toString();
					}
				}
				else if("FE2C".equals(shipMethod) || "UP2C".equals(shipMethod))
				{
					if("LUX".equals(itemClass_C))
					{
						qsFreightVal = ((new java.math.BigDecimal(qsFreightVal)).add((new java.math.BigDecimal("10")).multiply(new java.math.BigDecimal(itemQty_C)))).toString();
					}
					else if("COM".equals(itemClass_C))
					{
						qsFreightVal = ((new java.math.BigDecimal(qsFreightVal)).add((new java.math.BigDecimal("15")).multiply(new java.math.BigDecimal(itemQty_C)))).toString();
					}
				}
			}
		}
	}

	for(int ic=0;ic<itemCat_A.size();ic++)
	{
		String itemCatSel = (String)itemCat_A.get(ic);

		//String catPoints = (String)session.getValue(itemCatSel);
		String catPoints = (String)totPointsCatHT.get(itemCatSel);
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
				int cp_1000 = catPointsBD.compareTo(new java.math.BigDecimal("999"));
				int cp_300 = catPointsBD.compareTo(new java.math.BigDecimal("299"));

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

					iteminTableRow = new EzBapiiteminTableRow();

					iteminTableRow.setSplitKey(splitKey_A);
					iteminTableRow.setMaterial(dProdCode);
					iteminTableRow.setEanUpc("");
					iteminTableRow.setMatExt(dProdCode);
					iteminTableRow.setMatlGroup("AST");
					iteminTableRow.setBatch(dProdCode);
					iteminTableRow.setPoItmNoS("");  // Used for unique identification
					iteminTableRow.setShortText("");
					iteminTableRow.setBillDate(fromDate.getTime());
					iteminTableRow.setReqQty(new java.math.BigInteger(dQuantity));

					if(setEDD)
					{
						iteminTableRow.setReqDate(reqDate.getTime());
					}

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

	if(qsFaucet && (useMyCarrier!=null && !"YES".equals(useMyCarrier)))
	{
		try
		{
			ordHeadRow.setCdType2("HD00");
			ordHeadRow.setCdValue2(new java.math.BigDecimal(Double.parseDouble(qsFreightVal)/10));
		}
		catch(Exception err){}
	}
	if("EVE".equals(custGrp5))
	{
		ordHeadRow.setCustGrp5(custGrp5);
	}

	orderHeader.appendRow(ordHeadRow);
}

//******************************************************

	EzBapischdlTable deliveryScheduleTable = new EzBapischdlTable();
	ioParams.setOrderDelSchedule(deliveryScheduleTable);
	ioParams.setType("SPLIT");
	ioParams.setCreditChkFlag("Y");
	ezcSalesOrderParams.setObject(ioParams);
	Session.prepareParams(ezcSalesOrderParams);

	long start = System.currentTimeMillis();
	log4j.log("Simulate Sales Order Before Creation Start>>>"+poNumber,"F");
	osmParams = (EzoSalesOrderCreate)EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParams);
	log4j.log("Simulate Sales Order Before Creation End>>>"+poNumber,"F");
	long finish = System.currentTimeMillis();

	log4j.log("Simulate Sales Order Before Creation>>>"+(finish-start)/1000,"F");

	ReturnObjFromRetrieve returnStruct = (ReturnObjFromRetrieve)osmParams.getReturn();
	ReturnObjFromRetrieve messageTable = (ReturnObjFromRetrieve)osmParams.getMessageTable();
	ReturnObjFromRetrieve itemsIn = (ReturnObjFromRetrieve)osmParams.getOrderItemsIn();

	ReturnObjFromRetrieve itemoutTable = (ReturnObjFromRetrieve)osmParams.getOrderItemsOut();
	ReturnObjFromRetrieve retCond = (ReturnObjFromRetrieve)osmParams.getOrderConditionsOut();
	ReturnObjFromRetrieve retSched = (ReturnObjFromRetrieve)osmParams.getScheduleTable();

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
	//out.println("returnStruct::"+returnStruct.toEzcString());
	//out.println("itemoutTable::"+itemoutTable.toEzcString());
	//out.println("retCond::"+retCond.toEzcString());
	//out.println("retSched::"+retSched.toEzcString());

	int itemOutCnt = 0;
	int retSchedCnt = 0;

	if(itemoutTable!=null) itemOutCnt = itemoutTable.getRowCount();
	if(retSched!=null) retSchedCnt = retSched.getRowCount();

//*****************************************************************************************
%>
