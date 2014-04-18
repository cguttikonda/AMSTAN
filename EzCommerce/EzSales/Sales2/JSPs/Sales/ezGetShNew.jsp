<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<%@ page import = "ezc.ezsap.*,java.util.*,ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp" %>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp" %>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope = "page"></jsp:useBean>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%

	String backFlag = request.getParameter("backFlag");
	
	if(backFlag==null || "null".equals(backFlag)) backFlag = "";
		
	String frameFlg = request.getParameter("frameFlg");
	
	if(frameFlg==null || "null".equals(frameFlg)) frameFlg = "";
	
	String msg="";
	
	final int DATE  = 1;       
	final int MONTH = 0 ;
	final int YEAR  = 2;
	
	ezc.client.EzcUtilManager UtilManager 		= new ezc.client.EzcUtilManager(Session);
	EzcSalesOrderParams  ezcSalesOrderParams 	= new EzcSalesOrderParams();
	EzcSalesOrderParams  ezcSalesOrderParamsForSm 	= new EzcSalesOrderParams();

	// BAPI Parameters
	
	EzBapisdheadStructure 	orderHeader 	= null;
	EzBapipartnrTable 	orderPartners 	= null;
	EzBapipartnrTableRow 	aRow 		= null;
	EzBapiiteminTable 	iteminTable 	= null;
	EzBapiiteminTableRow 	aItemRow 	= null;

	EziSalesOrderCreateParams smParams 	= null; 
	EziSalesOrderCreateParams ioParams 	= null;

	EzoSalesOrderCreate 	osmParams 	= null;
	ReturnObjFromRetrieve  	itemoutTable 	= null;
	ReturnObjFromRetrieve 	priceRet 	= null;   

	//FormatDate formatDate = new FormatDate();

	java.util.GregorianCalendar fromDate = null ;
	java.util.GregorianCalendar deliveryDate = null ;
	java.util.GregorianCalendar reqDate = null ;
	java.util.GregorianCalendar reqDateH = null ;
	
	fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();

	java.math.BigDecimal  netValue =new java.math.BigDecimal("0");
	
	String PartnNum 	= (String)session.getValue("AgentCode");
	String inDate 		= FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
	String PONO 		= request.getParameter("poNo");
	
	log4j.log("inDateinDateinDateinDateinDateinDate	"+inDate,"W");

	int dateReq 	= Integer.parseInt(inDate.substring(0,2));
	int monthReq 	= Integer.parseInt(inDate.substring(3,5));
	int yearReq 	= Integer.parseInt(inDate.substring(6,10));
	reqDateH 	= new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
	
	EzcSalesOrderParams initParams = new EzcSalesOrderParams();
	EziSalesOrderCreateParams initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);
	ioParams = (EziSalesOrderCreateParams) EzSalesOrderManager.initializeSalesOrder(initParams);

	//Set values for OrderHeader
	
	log4j.log("reqDateH.getTime()reqDateH.getTime()		"+reqDateH.getTime(),"W");
	
	orderHeader = ioParams.getOrderHeaderIn();
	orderHeader.setDivision("");    	//need to set "" because hard coded in initializeSalesOrder
	orderHeader.setDistrChan("");
	orderHeader.setSalesOrg("");
	orderHeader.setLog("TRUE");
	orderHeader.setDocType((String)session.getValue("docType"));
	orderHeader.setPurchNo("PONO");
	orderHeader.setPoSupplem("WWW");
	orderHeader.setReqDateH(reqDateH.getTime());
	orderHeader.setAgentCode((String)session.getValue("SAPPRDCODE"));

	orderPartners = ioParams.getOrderPartners();
	if(PartnNum!=null)
		PartnNum = PartnNum.trim();
		
	log4j.log("TotalCountTotalCountPartnNumPartnNum		::"+PartnNum,"W");
	if(PartnNum!=null)
	{
		aRow = new EzBapipartnrTableRow();
		aRow.setPartnRole("AG"); 			//CHECK IF WE CAN GET PARTNER ROLE FROM DEFAULTS
		aRow.setPartnNumb(PartnNum);
		orderPartners.insertRow(0, aRow);
	}
	
	//Set ordered items
	
	iteminTable = ioParams.getOrderItemsIn(); // new EzBapiiteminTable();

	int j1 = 0;
	int j = 0;
	int TotalCount1 =0;
	int tc=0;
	//Get the Number Of Rows for the Sales Order
	
	String strTcount =  request.getParameter("TotalCount");

	int TotalCount = 0;

	if(strTcount!=null)
		TotalCount = (new Integer(strTcount)).intValue();
	
	log4j.log("TotalCountTotalCount::"+TotalCount,"W");
	
	String OrderQuantity = null ;
	double dproQty1	= 0;
	java.math.BigDecimal bOrderQty = null;
	int    bQty 	= 0;
	String matno	= null;
	String fmDate 	= null;
	String desc 	= null;
	String uom 	= null;
	String venCatalog= null;
	String myMatId   = null;
	String myMfrNr   = null;
	String myEanUOM   = null;
	String cnetProd_A   = null;

	String[] prodCode1		= new String[TotalCount];
	String[] prodDate1		= new String[TotalCount];
	String[] prodQty1 		= new String[TotalCount];
	String[] prodDesc1		= new String[TotalCount];
	String[] prodUom1 		= new String[TotalCount];
	String[] vendorCatalog1 	= new String[TotalCount];
	String[] matId1 		= new String[TotalCount];
	String[] mfrNr1 		= new String[TotalCount];
	String[] eanupc1 		= new String[TotalCount];
	String[] cnetProd1 		= new String[TotalCount];

	while(j1<TotalCount)
	{
		matno 		= request.getParameter("Product_"+j1);
		fmDate 		= FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
		OrderQuantity   = request.getParameter("Quantity_"+j1);
				
		desc 		= request.getParameter("ProductDesc_"+j1);
		uom 		= request.getParameter("Pack_"+j1);
		venCatalog      = request.getParameter("VendCatalog_"+j1);
		myMatId         = request.getParameter("matId_"+j1);
		myMfrNr         = request.getParameter("Brand_"+j1);
		myEanUOM        = request.getParameter("UPCNum_"+j1);
		cnetProd_A	= request.getParameter("CNETPrd_"+j1);
		
		if((OrderQuantity==null) || (OrderQuantity.trim().length()==0))
			OrderQuantity="0";	
		else
		{
			try
			{
				dproQty1=Double.parseDouble(OrderQuantity);
				OrderQuantity=String.valueOf(dproQty1);
	  		}catch(Exception ee){
	  			log4j.log("Exceptioneeee "+ee,"W");
	  		}
		}
		if("0.0".equals(OrderQuantity))
			OrderQuantity="0";
	
		prodCode1[j1]	= matno;
		prodDate1[j1]	= fmDate;
		prodQty1[j1] 	= OrderQuantity;
		prodDesc1[j1]	= desc;
		prodUom1[j1] 	= uom;
		vendorCatalog1[j1]=venCatalog;
		matId1[j1]        = myMatId;
		mfrNr1[j1]        = myMfrNr;
		eanupc1[j1]       = myEanUOM; 
		cnetProd1[j1]	= cnetProd_A;
		
		log4j.log("vendorCatalog1=================>"+venCatalog,"I");
		log4j.log("myMatIdmyMatIdmyMatId=================>"+myMatId,"I");
		log4j.log("myMfrNrmyMfrNrmyMfrNr=================>"+myMfrNr,"I");
		log4j.log("myEanUOMmyEanUOMmyEanUOM=================>"+myEanUOM,"I");
		log4j.log("cnetProd_AcnetProd_AcnetProd_A=================>"+cnetProd_A,"I");
	
		if (!"0".equals(OrderQuantity))
		{
			TotalCount1++;
		}
		j1++;
		
		
	}

        EzcShoppingCartParams params1   = new EzcShoppingCartParams();
        EziReqParams 	      reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	
	
	
	
 	reqparams.setProducts(prodCode1);
	reqparams.setReqDate(prodDate1);
     	reqparams.setReqQty(prodQty1);
     	reqparams.setVendorCatalogs(vendorCatalog1);
     	reqparams.setMatId(matId1);
     	
     	subparams.setLanguage("EN");
     	subparams.setType("AF");
     	subparams.setEziReqParams(reqparams);

	params1.setObject(subparams);
     	Session.prepareParams(params1);
     	
     	
     	try
	{
		//SCManager.saveCart(params1);
		SCManager.updateCart(params1);
	}
	catch(Exception e)
	{
		out.println("ExceptionExceptionException  "+e);
	}

	EzShoppingCart prevCart = null;
	EzcShoppingCartParams prevparams    = new EzcShoppingCartParams();
	EziShoppingCartParams prevsubparams = new EziShoppingCartParams();
	EziReqParams 	      prevreqparams = null;
	prevsubparams.setLanguage("EN");
	prevparams.setObject(prevsubparams);
	Session.prepareParams(prevparams);
	prevCart = (EzShoppingCart)SCManager.getSavedCart(prevparams);

	int rCount = prevCart.getRowCount();
	String itemCode="";
	String itemVendorCatalog="";
	String itemBrand="";
	String itemListPrice="";
	String itemMatId ="";
	String itemEanUPC ="";
	String itemmmFlag ="";
	String itemDiscCode = "";
	String itemMfrCode = "";
	String itemMfrPartNo = "";
	String itemWeight = "";
	String itemOrgPrice = "";
	String itemCnetProd = "";

	int cartItems=0;
	Hashtable itemQtys = new Hashtable();
	Hashtable itemVendorCatalogs = new Hashtable();
	Hashtable itemLPrice = new Hashtable();
	

	for(int h=0;h<rCount;h++)
	{
		itemCode	  = prevCart.getMaterialNumber(h);
		itemVendorCatalog = prevCart.getVendorCatalog(h);
		itemBrand         = prevCart.getBrand(h);
		itemListPrice     = prevCart.getUnitPrice(h);
		itemMatId         = prevCart.getMatId(h);
		itemEanUPC        = prevCart.getUPCNumber(h); 
		itemmmFlag        = prevCart.getMultiMediaFlag(h);
		itemDiscCode	  = prevCart.getDiscCode(h);
		itemMfrCode	  = prevCart.getMfrCode(h);
		itemMfrPartNo	  = prevCart.getMfrPartNo(h);
		itemWeight	  = prevCart.getWeight(h);
		itemOrgPrice	  = prevCart.getOrgPrice(h);
		itemCnetProd	  = prevCart.getVarPriceFlag(h);
		
		if(itemBrand == null || "null".equals(itemBrand) || "".equals(itemBrand))itemBrand="N/A";
		if(itemEanUPC == null || "null".equals(itemEanUPC) || "".equals(itemEanUPC))itemEanUPC="N/A";
		if(itemDiscCode == null || "null".equals(itemDiscCode) || "".equals(itemDiscCode))itemDiscCode="N/A";
		if(itemMfrCode == null || "null".equals(itemMfrCode) || "".equals(itemMfrCode))itemMfrCode="N/A";
		if(itemMfrPartNo == null || "null".equals(itemMfrPartNo) || "".equals(itemMfrPartNo))itemMfrPartNo="N/A";
		if(itemWeight == null || "null".equals(itemWeight) || "".equals(itemWeight))itemWeight="N/A";
		
		log4j.log(itemMatId+"  <<itemMatId>>>>>>"+itemVendorCatalog+"¥"+itemBrand+"¥"+itemListPrice+"¥"+itemCode+"¥"+itemEanUPC+"¥"+itemmmFlag+"¥"+itemDiscCode+"¥"+itemMfrCode+"¥"+itemMfrPartNo+"¥"+itemWeight+"¥"+itemOrgPrice+"¥"+itemCnetProd,"I");
		try{
			cartItems+=Double.parseDouble(prevCart.getOrderQty(h));
		}catch(Exception e) 
		{ 
		} 

		itemVendorCatalogs.put(itemMatId,itemVendorCatalog+"¥"+itemBrand+"¥"+itemListPrice+"¥"+itemCode+"¥"+itemEanUPC+"¥"+itemmmFlag+"¥"+itemDiscCode+"¥"+itemMfrCode+"¥"+itemMfrPartNo+"¥"+itemWeight+"¥"+itemOrgPrice+"¥"+itemCnetProd);
		itemLPrice.put(itemMatId,itemListPrice); 
	} 
     	
     	
     	
	


	String[] prodCode = new String[TotalCount1];
	String[] prodDate = new String[TotalCount1];
	String[] prodQty  = new String[TotalCount1];
	String[] prodDesc = new String[TotalCount1];
	String[] prodUom  = new String[TotalCount1];
	
	/*
	Hashtable productGroup=new Hashtable();

	java.util.ResourceBundle PrdGrpOrdTypes = java.util.ResourceBundle.getBundle("EzPrdGrpOrdTypes");
	java.util.ResourceBundle PrdGrp = java.util.ResourceBundle.getBundle("EzPrdGrp");

	java.util.Enumeration enum1=PrdGrp.getKeys();
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
			java.util.StringTokenizer   st=new java.util.StringTokenizer(metGroup,"¥");
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
	*/
	
	
	
	if(iteminTable.getRowCount() == 0 )
	{
		while (j<TotalCount)
		{
			if (!"0".equals(prodQty1[j]))
			{
				prodCode[tc] =prodCode1[j];
				prodDate[tc] =prodDate1[j];
				prodQty[tc]  =prodQty1[j];
				prodDesc[tc] =prodDesc1[j];
				prodUom[tc]  =prodUom1[j];
			
			         log4j.log("prodUomprodUomprodUomprodUom>>>>>>>>>> "+prodUom1[j],"I"); 
			         log4j.log("prodCodeprodCodeprodCode>>>>>>>>>> "+prodCode[tc],"I"); 
			
				//String prodGroup=(String)productGroup.get(prodCode[tc]);
				String itemData = (String)itemVendorCatalogs.get(matId1[j]);
				String plant = "PL01";
				String[] prdDetArr = null; 
				String itemType = "VC";
				bOrderQty  = new java.math.BigDecimal(prodQty[tc]);
				bQty =  bOrderQty.intValue();	
				bOrderQty = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
				prodDate[tc] = prodDate[tc].trim();
				log4j.log("itemDataitemDataitemDataitemData>>>>>>>>>> "+itemData,"I"); 
				if(itemData!=null)
				{
					try
					{
						prdDetArr = itemData.split("¥");
						itemType = prdDetArr[5];
					}
					catch(Exception e){}
				}
				
	
				aItemRow = new EzBapiiteminTableRow();
				aItemRow.setMaterial(prodCode[tc]);
				//aItemRow.setMaterial(cnetProd1[j]);

				log4j.log("itemTypeitemType>>>>>>>>>> "+itemType,"I"); 
				
				aItemRow.setEanUpc(eanupc1[j]);
				aItemRow.setMatExt(prodCode[tc]);
				//aItemRow.setMatExt(cnetProd1[j]);
				aItemRow.setMatlGroup(mfrNr1[j]);
				aItemRow.setBatch(matId1[j]); 
				
				log4j.log("eanupc1  "+eanupc1[j],"W");
				log4j.log("prodCode  "+prodCode[j],"W");
				log4j.log("mfrNr1  "+mfrNr1[j],"W");
				log4j.log("matId1  "+matId1[j],"W");				
				
				try{
					aItemRow.setCondValue(new java.math.BigDecimal(Double.parseDouble((String)itemLPrice.get(matId1[j]))/10));
					log4j.log("setCondValue  "+aItemRow.getCondValue(),"W");	
					aItemRow.setCondType("ZUMP");// was PR00/ZPRW before Mukesh changed   // "ZPR1" in AF
					
				}catch(Exception err){  
				
				}
				
				
				log4j.log("prodDesc  "+prodDesc[tc],"W");
				aItemRow.setShortText(prodDesc[tc]);
				aItemRow.setBillDate(fromDate.getTime());
				aItemRow.setReqQty(bOrderQty.toBigInteger());
				log4j.log("setReqQty  "+bOrderQty.toBigInteger(),"W");
				itemQtys.put(matId1[tc],prodQty[tc]);
				try{
					dateReq  = Integer.parseInt(prodDate[tc].substring(0,2));
					monthReq = Integer.parseInt(prodDate[tc].substring(3,5));
					yearReq  = Integer.parseInt(prodDate[tc].substring(6,10));
					reqDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
					aItemRow.setReqDate(reqDate.getTime());
				}catch(Exception e){
					log4j.log("dateReqdateReqdateReqdateReqinGetPrices "+e,"W");
				}

				//these are required for Multi Simulate
				aItemRow.setItmNumber(new java.math.BigInteger(String.valueOf((tc+1)*10)));
				aItemRow.setShipTo(PartnNum);
				aItemRow.setSysKey((String)session.getValue("SalesAreaCode"));
				aItemRow.setPlant(plant);				
				aItemRow.setDocType((String)session.getValue("docType"));
				aItemRow.setSalesOrg((String)session.getValue("salesOrg"));
				aItemRow.setDistributionChanel((String)session.getValue("dc"));
				aItemRow.setDivision((String)session.getValue("division"));
				iteminTable.appendRow(aItemRow);
				tc++;
			}
			bOrderQty = null;
			reqDate   = null;
			OrderQuantity = null;
			matno = null;
			fmDate = null;
			j++;
		}
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
	
	
	
	itemoutTable = (ReturnObjFromRetrieve)osmParams.getOrderItemsOut();
	log4j.log("itemoutTableitemoutTableitemoutTableitemoutTablegetPrices	::"+PartnNum+"===>"+itemoutTable.toEzcString(),"W");
	if(returnStruct.getRowCount()> 0)
	{
		for(int pc=0;pc<returnStruct.getRowCount();pc++)
		{
			if ((returnStruct.getFieldValue(pc,"Type")).equals("E"))
			{
				msg=msg+ returnStruct.getFieldValue(pc,"Message")+"<br>";
			}
		}
	}
	String Currency ="";
	if(itemoutTable !=null)
	{
		if(itemoutTable.getRowCount()!=0)
		{
			Currency =itemoutTable.getFieldValueString(0,"Currency");
			for(int i=0;i<itemoutTable.getRowCount();i++)
			{
				String netValue1= itemoutTable.getFieldValueString(i,"NetValue1");
				String ItemCat =itemoutTable.getFieldValueString(i,"ItemCat");
				if(!("KLN").equals(ItemCat))
				{
					netValue = netValue.add(new java.math.BigDecimal(netValue1));
				}
			}
		}
	}
	
	String creditChk ="";
	if(messageTable !=null)
	{
		if(messageTable.getRowCount()!=0)
		{
			for(int i=0;i<messageTable.getRowCount();i++)
			{
				String crdtChk= messageTable.getFieldValueString(i,"MESSAGE_V4");

				if("CREDIT_CHECK".equals(crdtChk))
				{
					creditChk = "Yes";
				}
			}
		}
	}
//*****************************************************************************************
	
			
	
	 
	
	
	session.putValue("itemcatalog",itemVendorCatalogs);
	session.putValue("ITEMSOUT",itemoutTable);
		
	ReturnObjFromRetrieve returnSoldTo = (ReturnObjFromRetrieve)osmParams.getSoldToParty();

	String DlvBlock="";
	String VatRegNo ="";
	String Telephone="";
		
	if(returnSoldTo.getRowCount() >0)
	{
		DlvBlock=returnSoldTo.getFieldValueString("DlvBlock"); 
		VatRegNo =returnSoldTo.getFieldValueString("VatRegNo");
		Telephone=returnSoldTo.getFieldValueString("Telephone");
	}
	ReturnObjFromRetrieve listOfShipTos =new ReturnObjFromRetrieve();
	String cstno="";
	String Lstno="";
	String drugno="";
	try{
		EzcCustomerParams customerParams = new EzcCustomerParams();
		EzCustomerStructure ezCustomerStructure = new EzCustomerStructure();
		ezCustomerStructure.setLanguage("EN");
		customerParams.setObject(ezCustomerStructure);
		Session.prepareParams(customerParams);
		listOfShipTos = (ReturnObjFromRetrieve)CustomerManager.getCustomerAddress(customerParams);
	}catch(Exception e){}

	if(listOfShipTos.getRowCount() >0)
	{
		 cstno=listOfShipTos.getFieldValueString(0,"ECA_SHIP_ADDR_1");
	 	 Lstno=listOfShipTos.getFieldValueString(0,"ECA_SHIP_ADDR_2");
		 drugno=listOfShipTos.getFieldValueString(0,"ECA_WEB_ADDR");
	}
	session.putValue("itemQtys",itemQtys);
	
	String mBack  = request.getParameter("mBack");
	if(mBack==null)
		mBack="";
		
	String fromCart  = request.getParameter("fromCart");
	if(fromCart==null)
		fromCart="";
		
		
	String flgBack  = request.getParameter("bkpflg");
	if(flgBack==null)
		flgBack="";	
		
	if(Currency==null)
		Currency="";	 
			
%>

<jsp:forward page="ezConfirmOrderSHNew.jsp">
	<jsp:param name="shipTo" value="<%=PartnNum%>"/>
	<jsp:param name="fromCart" value="<%=fromCart%>"/>
	<jsp:param name="mBack"    value="<%=mBack%>"/>
 	<jsp:param name="currency" value="<%=Currency%>"/>
	<jsp:param name="netValue" value="<%=netValue%>"/>
	<jsp:param name="drugno"   value="<%=drugno%>"/>
	<jsp:param name="cstno"    value="<%=cstno%>"/>
	<jsp:param name="Lstno"    value="<%=Lstno%>"/>
	<jsp:param name="DlvBlock" value="<%=DlvBlock%>"/>
	<jsp:param name="VatRegNo" value="<%=VatRegNo%>"/>
	<jsp:param name="Telephone"value="<%=Telephone%>"/>
	<jsp:param name="msg"      value="<%=msg%>"/>
	<jsp:param name="creditChk"value="<%=creditChk%>"/>
	<jsp:param name="backFlag" value="<%=backFlag%>"/>
	<jsp:param name="bkpflg" value="<%=flgBack%>"/>
	<jsp:param name="cartItems" value="<%=cartItems%>"/> 
	<jsp:param name="frameFlg" value="<%=frameFlg%>"/>  
</jsp:forward>
<Div id="MenuSol"></Div>   
 