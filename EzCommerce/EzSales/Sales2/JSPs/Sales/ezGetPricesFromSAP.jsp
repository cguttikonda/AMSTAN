<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<%@ page import = "ezc.ezsap.*,java.util.*,ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp" %>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp" %>
<%//@ include file="../../../Includes/JSPs/Sales/iGetMaterials.jsp" %>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope="page"></jsp:useBean>
<%
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

	java.util.GregorianCalendar fromDate 	= null ;
	java.util.GregorianCalendar reqDate 	= null ;
	java.util.GregorianCalendar reqDateH 	= null ;

	fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();

	java.math.BigDecimal  netValue =new java.math.BigDecimal("0");
	
	
	String PartnNum 	= request.getParameter("soldTo");
	String inDate 		= request.getParameter("orderDate");
	String PONO 		= request.getParameter("poNo");
	String SCDocNr 		= request.getParameter("scDocNr");
	
	int dateReq 	= Integer.parseInt(inDate.substring(0,2));
	int monthReq 	= Integer.parseInt(inDate.substring(3,5));
	int yearReq 	= Integer.parseInt(inDate.substring(6,10));
	reqDateH 	= new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);

	EzcSalesOrderParams 		initParams 	 = new EzcSalesOrderParams();
	EziSalesOrderCreateParams 	initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);
	ioParams = (EziSalesOrderCreateParams)EzSalesOrderManager.initializeSalesOrder(initParams);

	//Set values for OrderHeader
	orderHeader = ioParams.getOrderHeaderIn();
	orderHeader.setDivision("");
	orderHeader.setDistrChan("");
	orderHeader.setSalesOrg("");
	orderHeader.setDocType((String)session.getValue("docType"));
	orderHeader.setPurchNo(PONO);
	orderHeader.setPoSupplem("WWW");
	orderHeader.setReqDateH(reqDateH.getTime());
	orderPartners = ioParams.getOrderPartners();
	
	if(PartnNum!=null)
	{
		aRow = new EzBapipartnrTableRow();
		aRow.setPartnRole("AG"); 	
		aRow.setPartnNumb(PartnNum);
		orderPartners.insertRow(0, aRow);
	}
	
	iteminTable = ioParams.getOrderItemsIn();
	int j1 = 0;
	int j = 0;
	int TotalCount1 =0;
	int tc=0;

	//Get the Number Of Rows for the Sales Order
	
	int TotalCount 		= Integer.parseInt(request.getParameter("cartCount"));
	String OrderQuantity    = null;
	double dproQty1	= 0;
	java.math.BigDecimal bOrderQty = null;
	//int    bQty 	= 0;
	String matno	= null;
	String fmDate 	= null;
	String desc 	= null;
	String uom 	= null;

	String[] prodCode1	= new String[TotalCount];
	String[] prodDate1	= new String[TotalCount];
	String[] prodQty1 	= new String[TotalCount];
	String[] prodDesc1	= new String[TotalCount];
	String[] prodUom1 	= new String[TotalCount];

	String product_1[] 	= request.getParameterValues("product");
	String desiredDate_1[] 	= request.getParameterValues("desiredDate");
	String desiredQty_1[] 	= request.getParameterValues("desiredQty");
	String productDesc_1[] 	= request.getParameterValues("prodDesc");
	String uom_1[] 		= request.getParameterValues("pack");
	while(j1<TotalCount)
	{
		matno 	= product_1[j1];
		fmDate 	= desiredDate_1[j1];
		OrderQuantity = desiredQty_1[j1];
		desc 	= productDesc_1[j1];
		uom 	= uom_1[j1];
		if( (OrderQuantity==null) || (OrderQuantity.trim().length()==0))
			OrderQuantity="0";	
		else
		{
			try
			{
				dproQty1=Double.parseDouble(OrderQuantity);
				OrderQuantity=String.valueOf(dproQty1);
	  		}catch(Exception ee){}
		}
		if("0.0".equals(OrderQuantity))
			OrderQuantity="0";
	
		prodCode1[j1]= matno;
		prodDate1[j1]=fmDate;
		prodQty1[j1]=OrderQuantity;
		prodDesc1[j1]=desc;
		prodUom1[j1] = uom;
	
		if (!"0".equals(OrderQuantity))
		{
			TotalCount1++;
		}
		j1++;
	}

        EzcShoppingCartParams cartParams = new EzcShoppingCartParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
 	
 	cartParams.setObject(subparams);
     	Session.prepareParams(cartParams);

     	subparams.setLanguage("EN");
     	subparams.setEziReqParams(reqparams);
     	subparams.setObject(reqparams);

	reqparams.setProducts(prodCode1);
	reqparams.setReqDate(prodDate1);
     	reqparams.setReqQty(prodQty1);

	//SCManager.deleteCartElement(params1);
	//EzShoppingCart Cart1 = (EzShoppingCart)SCManager.getSavedCart(params1);

	String[] prodCode = new String[TotalCount1];
	String[] prodDate = new String[TotalCount1];
	String[] prodQty  = new String[TotalCount1];
	String[] prodDesc = new String[TotalCount1];
	String[] prodUom  = new String[TotalCount1];

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
	
	Hashtable itemQtys = new Hashtable();
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
			
				String prodGroup=(String)productGroup.get(prodCode[tc]);
				String plant = "ORD_"+prodGroup;
				bOrderQty  = new java.math.BigDecimal(prodQty[tc]);
				//bQty =  bOrderQty.intValue();	
				bOrderQty = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
				prodDate[tc] = prodDate[tc].trim();
	
				aItemRow = new EzBapiiteminTableRow();
				aItemRow.setMaterial(prodCode[tc]);	
				aItemRow.setBillDate(fromDate.getTime());
				aItemRow.setReqQty(bOrderQty.toBigInteger());
				itemQtys.put(prodCode[tc],prodQty[tc]);
				try{
					dateReq  = Integer.parseInt(prodDate[tc].substring(0,2));
					monthReq = Integer.parseInt(prodDate[tc].substring(3,5));
					yearReq  = Integer.parseInt(prodDate[tc].substring(6,10));
					reqDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
					aItemRow.setReqDate(reqDate.getTime());
				}catch(Exception e){}

				//these are required for Multi Simulate
				aItemRow.setItmNumber(new java.math.BigInteger(String.valueOf((tc+1)*10)));
				aItemRow.setShipTo(PartnNum);
				aItemRow.setSysKey((String)session.getValue("SalesAreaCode"));
				aItemRow.setPlant("1000");
				//String doc=PrdGrpOrdTypes.getString(plant);
				//aItemRow.setItemCateg(PrdGrpOrdTypes.getString(doc));
				//aItemRow.setDocType(PrdGrpOrdTypes.getString(plant));
				aItemRow.setDocType("ZOR");
				aItemRow.setSalesOrg((String)session.getValue("salesOrg"));
				aItemRow.setDistributionChanel((String)session.getValue("dC"));
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
//log4j.log("getRequestURIgetRequestURIgetRequestURIgetRequestURIgetRequestURI"+request.getRequestURI(),"W");
//log4j.log("getRequestURIgetRequestURIgetRequestURIgetRequestURIgetRequestURI"+request.getServletPath(),"W");
	

	EzBapischdlTable deliveryScheduleTable = new EzBapischdlTable();
	ioParams.setOrderDelSchedule(deliveryScheduleTable);
	ioParams.setType("RBPG");
	ezcSalesOrderParams.setObject(ioParams);
	Session.prepareParams(ezcSalesOrderParams);
	osmParams = (EzoSalesOrderCreate)EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParams);
	ReturnObjFromRetrieve returnStruct = (ReturnObjFromRetrieve)osmParams.getReturn();
	ReturnObjFromRetrieve messageTable = (ReturnObjFromRetrieve)osmParams.getMessageTable();
	log4j.log("returnStructreturnStructreturnStructreturnStructreturnStruct","W");
	messageTable.toEzcString();
	log4j.log("returnStructreturnStructreturnStructreturnStructreturnStruct","W");

	itemoutTable = (ReturnObjFromRetrieve)osmParams.getOrderItemsOut();
	if(returnStruct.getRowCount()>0)
	{
		for(int pc=0;pc<returnStruct.getRowCount();pc++)
		{
			if((returnStruct.getFieldValue(pc,"Type")).equals("E"))
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
	String Message ="";
	
	if(messageTable !=null)
	{
		if(messageTable.getRowCount()!=0)
		{
			for(int i=0;i<messageTable.getRowCount();i++)
			{
				Message   = messageTable.getFieldValueString(i,"MESSAGE_V4");
				if("CREDIT_CHECK".equals(Message))
				{
					creditChk = messageTable.getFieldValueString(i,"MESSAGE");
					break;
				}
			}
		}
	}
	log4j.log("creditChkcreditChkcreditChkcreditChkcreditChk"+creditChk,"W");
	log4j.log("MessageMessageMessageMessageMessageMessageMessageMessage"+Message,"W");


//*****************************************************************************************
	reqparams = new EziReqParams();
	subparams = new EziShoppingCartParams();
	cartParams= new EzcShoppingCartParams();
	
	reqparams.setProducts(prodCode1);
	reqparams.setReqDate(prodDate1);
	reqparams.setReqQty(prodQty1);
	subparams.setLanguage("EN");
	subparams.setEziReqParams(reqparams);
  	subparams.setObject(reqparams);
     	cartParams.setObject(subparams);
	Session.prepareParams(cartParams);
	SCManager.saveCart(cartParams);		

	session.putValue("ITEMSOUT",itemoutTable);		
	ReturnObjFromRetrieve returnSoldTo = (ReturnObjFromRetrieve)osmParams.getSoldToParty();
	session.putValue("itemQtys",itemQtys);
%>
<Div id="MenuSol"></Div>
