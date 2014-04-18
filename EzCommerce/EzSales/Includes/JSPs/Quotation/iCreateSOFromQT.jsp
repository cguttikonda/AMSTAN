<%@ page import="java.util.*,ezc.ezutil.FormatDate"%>
<%
//*************************Start of Declarations*******************************************/

	String plantVal = (String)session.getValue("PLANT");
	String soCondType = (String)session.getValue("SOCONDTYPE");
 	String fCondType = (String)session.getValue("FREIGHTCONDTYPE");
 	String freightInsType = (String)session.getValue("FREIGHTINS");
	String salesOffice = (String)session.getValue("CU_SALESOFFICE");
	String salesGroup = (String)session.getValue("CU_SALESGROUP");

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
	
	if(salesOffice!=null && !"null".equals(salesOffice) && !"".equals(salesOffice.trim()))
		orderHeaderConfirm.setSalesOff(salesOffice.trim());
	if(salesGroup!=null && !"null".equals(salesGroup) && !"".equals(salesGroup.trim()))
		orderHeaderConfirm.setSalesGrp(salesGroup.trim());
	//**orderHeaderConfirm.setDlvBlock("ZZ"); 
	//**orderHeaderConfirm.setCurrency(curr);
	//**orderHeaderConfirm.setLog("TRUE");
	
	orderHeaderConfirm.setShippingType(carrierName);
	//orderHeaderConfirm.setPmnttrms(paymentterms);
	orderHeaderConfirm.setPurchNo(poNo);

	orderHeaderConfirm.setDivision("");
	orderHeaderConfirm.setDistrChan("");
	orderHeaderConfirm.setSalesOrg("");
	orderHeaderConfirm.setAgentCode((String)session.getValue("SAPPRDCODE"));
	orderHeaderConfirm.setRefDoc(quoteNo);
	orderHeaderConfirm.setRefDocL(quoteNo);
	orderHeaderConfirm.setRefDocCa("B");
	orderHeaderConfirm.setRefDocType("AG");
	
	log4j.log("setPmnttrms  "+paymentterms,"W");
	log4j.log("setPurchNo  "+poNo,"W");
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
	try
	{
		int yearReq1 = Integer.parseInt(reqDate.substring(6,10));
		int dateReq1 = Integer.parseInt(reqDate.substring(3,5));
		int monthReq1 = Integer.parseInt(reqDate.substring(0,2));
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
	if(soldTo!=null)
	{
		
		
		EzBapipartnrTableRow aRow1 = new EzBapipartnrTableRow();
		aRow1.setPartnRole("AG"); //"AG" for soldto
		aRow1.setPartnNumb(soldTo);
		orderPartnersConfirm.appendRow(aRow1);
		EzBapipartnrTableRow aRow2 = new EzBapipartnrTableRow();
		aRow2.setPartnRole("WE"); //"WE" for soldto
		aRow2.setPartnNumb(soldTo);
		orderPartnersConfirm.appendRow(aRow2);
		
	}
//*************************Finished setting  Partner values******************************


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
	String schdat = "",plant="",custProd="";
	java.util.GregorianCalendar reqDatesch = null;
	int yearReq1 = 0;
	int monthReq1 = 0;
	int dateReq1 = 0;

	for(int j=0;j <prodCodeLength;j++)
	{
		plant 		= "PL01"; //** review needed **// 
		OrderQuantity 	= prodCQty_1[j];
		uom 		= prodPack_1[j];
		custProd        = custprodCode[j];
		
		log4j.log("custProdcustProdcustProdcustProd  "+custprodCode[j],"W");
		log4j.log("prodCode_1[j]>>>>>>>>...  "+prodCode_1[j],"W");
		log4j.log("lineNo_1[j]>>>>>>>>...  "+lineNo_1[j],"W");
		
		OrderQuantity 	= (OrderQuantity==null|| "".equals(OrderQuantity.trim()) || "null".equals(OrderQuantity) )?"0":OrderQuantity.trim();
		itemCat 	= prodItemCat_1[j];
		
		
		if(!OrderQuantity.equals("0")&& !"TANN".equals(itemCat) )
		{		
			line 	   = new java.math.BigInteger(String.valueOf(lineno*10));			

//******************************setting  items*********************************************
			aItemRowConfirm = new EzBapiiteminTableRow();
			aItemRowsim = new EzBapiiteminTableRow();

			aItemRowConfirm.setCustMat(custprodCode[j]);
			aItemRowConfirm.setSalesUnit(uom);
			aItemRowConfirm.setBillDate(fromDate.getTime()); // current Date as Bill Date

			aItemRowConfirm.setItmNumber(line);
			aItemRowConfirm.setMaterial(prodCode_1[j]);
			aItemRowConfirm.setShortText(prodDesc_1[j]);
			aItemRowConfirm.setRefDoc(quoteNo);
			aItemRowConfirm.setRefDocIt(new java.math.BigInteger(String.valueOf(lineNo_1[j])));
			aItemRowConfirm.setRefDocCa("B");
			
			log4j.log("setItmNumber  "+line,"W");
			log4j.log("setCustMat  "+custprodCode[j],"W");
			log4j.log("setMaterial  "+prodCode_1[j],"W");
			log4j.log("setShortText  "+prodDesc_1[j],"W");
			log4j.log("setSalesUnit  "+uom,"W");
			log4j.log("setBillDate  "+fromDate,"W");
			
			aItemRowsim.setItmNumber(line);
			aItemRowsim.setMaterial(prodCode_1[j]);
			aItemRowsim.setCustMat(custprodCode[j]);
			/*			
			aItemRowsim.setEanUpc(itemEanUPC[j]);
			aItemRowsim.setMatExt(itemMfrPart[j]);
			aItemRowsim.setMatlGroup(itemMfrNr[j]);
			aItemRowsim.setBatch(itemMatId[j]);			
			*/
			
			aItemRowsim.setSalesUnit(uom);
			aItemRowsim.setBillDate(fromDate.getTime()); // current Date as Bill Date
			aItemRowConfirm.setShipTo(shipTo);
			aItemRowConfirm.setSysKey(SalesAreaCode);
			aItemRowConfirm.setSalesOrg(SalesOrg);
			aItemRowConfirm.setDistributionChanel(DC); 
			aItemRowConfirm.setDivision(Div);
			aItemRowConfirm.setPlant(plantVal);
			aItemRowConfirm.setDocType(docType);
			aItemRowsim.setShipTo(shipTo);
			aItemRowsim.setSysKey(SalesAreaCode);	
			aItemRowsim.setSalesOrg(SalesOrg);
			aItemRowsim.setDistributionChanel(DC);
			aItemRowsim.setDivision(Div);
			aItemRowsim.setPlant(plantVal);	 	//This has to be set with material group based material code
			aItemRowsim.setDocType(docType);
			
			log4j.log("setShipTo  "+shipTo,"W");
			log4j.log("setSysKey  "+SalesAreaCode,"W");
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
				condTableRow.setCondType("PR00");   //soCondType
				condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice_1[j])/10)); 
				condTable.appendRow(condTableRow);
				log4j.log("setShipTo>>>>>>>>>>...  "+itemListPrice_1[j],"W");
			}catch(Exception err){ 
			
			}
			
			
//***********************************finished setting Items***********************************
			
			dSTableRow = new EzBapischdlTableRow();
			try
			{
				yearReq1  = Integer.parseInt(delDate_1[j].substring(6,10));
				dateReq1  = Integer.parseInt(delDate_1[j].substring(3,5));
				monthReq1 = Integer.parseInt(delDate_1[j].substring(0,2));
				reqDatesch = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);
				dSTableRow.setReqQty(new java.math.BigDecimal(OrderQuantity) );
				dSTableRow.setReqDate(reqDatesch.getTime());
				log4j.log("OrderQuantity>>>>>>>>>>...  "+OrderQuantity,"W");
				log4j.log("reqDatesch>>>>>>>>>>...  "+reqDatesch,"W");
			}catch(Exception e){}
			dSTableRow.setItmNumber(line);
			dSTableRow.setShortText("1");
			log4j.log("line>>>>>>>>>>...  "+line,"W");
			//dSTableRow.setDlvBlock("ZZ");
			
			deliveryScheduleTable.appendRow(dSTableRow);
			lineno++;
		}
  	}
  	
  	//***********************Freight************************//
  	/*
	try
	{
		condTableRow =new EzBapiscondTableRow();
		condTableRow.setItmNumber(new java.math.BigInteger("00"));
		condTableRow.setCondType(fCondType);	//"ZD00"
		condTableRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(freightPrice)/10));
		condTable.appendRow(condTableRow);
	}
	catch(Exception err){}
	*/
	//***********************Freight Insurance************************//
	/*
	try
	{
		condTableRow =new EzBapiscondTableRow();
		condTableRow.setItmNumber(new java.math.BigInteger("00"));
		condTableRow.setCondType(freightInsType);	
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
		EzoSalesOrderCreate  ioParamsSim = (EzoSalesOrderCreate)EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParamsSim);
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
		log4j.log("Exception occured>>>>>>>>"+e,"E");
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
			EzoSalesOrderCreate ioParamsSave = (EzoSalesOrderCreate)EzSalesOrderManager.ezCreateWebSalesOrder(ezcSalesOrderParamsSave);
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
%>