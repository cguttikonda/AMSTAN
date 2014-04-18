<%@page import="ezc.sapconnection.EzSAPHandler"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>



<%
	String r3SysSID="243~999";
	String contractNo=request.getParameter("SalesOrder");
	String poNo=request.getParameter("poNo") ;
	String poDate=request.getParameter("poDate");
	String requiredDate=request.getParameter("requiredDate");
	String currency=request.getParameter("currency");
	
	String lineItemNo[]=request.getParameterValues("lineNo");
	String prodCode[]=request.getParameterValues("Product");
	String requiredQty[]=request.getParameterValues("Reqqty");
	String requiredPrice[]=request.getParameterValues("requiredPrice");
	
	
	String SalesAreaCode=(String)session.getValue("SalesAreaCode");
	
	String docType	=(String)session.getValue("docType");
	String Div	=(String)session.getValue("division");
	String DC 	=(String)session.getValue("dc");
	String SalesOrg	=(String)session.getValue("salesOrg");
	
	
	EzcSalesOrderParams       initParams 	   = new EzcSalesOrderParams();
	EziSalesOrderCreateParams initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);
	EziSalesOrderCreateParams ioParamsConfirm 	= (EziSalesOrderCreateParams)EzSalesOrderManager.initializeSalesOrder(initParams);
	EzBapisdheadStructure     orderHeaderConfirm 	= ioParamsConfirm.getOrderHeaderIn();
	EzBapipartnrTable 	  orderPartnersConfirm  = ioParamsConfirm.getOrderPartners();
	EzBapiiteminTable 	  iteminTableConfirm    = ioParamsConfirm.getOrderItemsIn();
	
	EzBapiiteminTableRow aItemRowConfirm = null;
	
	EzBapiscondTable condTable = new EzBapiscondTable();
	EzBapiscondTableRow condTableRow = null;
	EzBapischdlTable deliveryScheduleTable = new EzBapischdlTable();
	EzBapischdlTableRow dSTableRow = null;
	EzBapistextTable ezctextTable = new EzBapistextTable();
	EzBapistextTableRow ezctextRow = null;
		
	orderHeaderConfirm.setRefDocCa("G");
	orderHeaderConfirm.setRefDoc(contractNo);
	orderHeaderConfirm.setPurchNo(poNo);
	
	
	orderHeaderConfirm.setSalesOrg("BP01");
	orderHeaderConfirm.setDistrChan("02");
	orderHeaderConfirm.setDivision("01");
	
	
	
	
	
	JCO.Function function= ezc.sapconnection.EzSAPHandler.getFunction("BAPI_SALESORDER_CREATEFROMDAT2",r3SysSID);
	JCO.ParameterList input = function.getImportParameterList();
	
	//setting header
				
	JCO.Structure headerStructure = input.getStructure("ORDER_HEADER_IN");
	
	try
	{
		int mn = Integer.parseInt(poDate.substring(0,2));
		int dt = Integer.parseInt(poDate.substring(3,5));
		int yr = Integer.parseInt(poDate.substring(6,10));
		java.util.GregorianCalendar reqDatePO = new java.util.GregorianCalendar(yr,mn-1,dt);
		orderHeaderConfirm.setPurchDate(reqDatePO.getTime());
		headerStructure.setValue(reqDatePO.getTime(),"PURCH_DATE");
	}catch(Exception e){}
	java.util.GregorianCalendar reqDat = null;
	try
	{
		int mn = Integer.parseInt(requiredDate.substring(0,2));
		int dt = Integer.parseInt(requiredDate.substring(3,5));
		int yr = Integer.parseInt(requiredDate.substring(6,10));
		reqDat = new java.util.GregorianCalendar(yr,mn-1,dt);
		orderHeaderConfirm.setReqDateH(reqDat.getTime());
		headerStructure.setValue(reqDat.getTime(),"REQ_DATE_H");
	}catch(Exception e){}
	
	headerStructure.setValue("QC","REFDOCTYPE");
	headerStructure.setValue(contractNo,"REF_DOC");
	headerStructure.setValue("G","REFDOC_CAT");
	headerStructure.setValue(docType,"DOC_TYPE");
	headerStructure.setValue(poNo,"PURCH_NO_C");
	
	headerStructure.setValue("BP01","SALES_ORG");
	headerStructure.setValue("02","DISTR_CHAN");
	headerStructure.setValue("01","DIVISION");
	
	JCO.Table orderItemsTable = function.getTableParameterList().getTable("ORDER_ITEMS_IN");
	JCO.Table schTable = function.getTableParameterList().getTable("ORDER_SCHEDULES_IN");
	JCO.Table  partnerTable = function.getTableParameterList().getTable("ORDER_PARTNERS");
	partnerTable.appendRow();
	
	partnerTable.setValue("C6100","PARTN_NUMB");
	partnerTable.setValue("AG","PARTN_ROLE");
	java.math.BigDecimal condValue=null;
	for(int i=0;i<lineItemNo.length;i++){
		if(Double.parseDouble(requiredQty[i])==0)
		continue;
		aItemRowConfirm = new EzBapiiteminTableRow();
		aItemRowConfirm.setItmNumber(new java.math.BigInteger(lineItemNo[i]));
		aItemRowConfirm.setMaterial(prodCode[i]);
		aItemRowConfirm.setSysKey(SalesAreaCode);
		aItemRowConfirm.setSalesOrg(SalesOrg);
		aItemRowConfirm.setDistributionChanel(DC);
		aItemRowConfirm.setDivision(Div);
		aItemRowConfirm.setDocType(docType);
		aItemRowConfirm.setPlant("");
		iteminTableConfirm.appendRow(aItemRowConfirm);
		
		dSTableRow = new EzBapischdlTableRow();
		dSTableRow.setReqQty(new java.math.BigDecimal(requiredQty[i]) );
		dSTableRow.setReqDate(reqDat.getTime());
		
		dSTableRow.setItmNumber(new java.math.BigInteger(lineItemNo[i]));
		deliveryScheduleTable.appendRow(dSTableRow);
		
		orderItemsTable.appendRow();
		orderItemsTable.setValue(new java.math.BigInteger(lineItemNo[i]),"ITM_NUMBER");
		orderItemsTable.setValue(prodCode[i],"MATERIAL");
		
		schTable.appendRow();
		schTable.setValue(new java.math.BigInteger(lineItemNo[i]),"ITM_NUMBER");
		schTable.setValue("1","SCHED_LINE");
		schTable.setValue(new java.math.BigDecimal(requiredQty[i]),"REQ_QTY");
		schTable.setValue(reqDat.getTime(),"REQ_DATE");
		
		condValue=new java.math.BigDecimal(Double.parseDouble(requiredPrice[i]));
		condTableRow =new EzBapiscondTableRow();
		condTableRow.setItmNumber(new java.math.BigInteger(lineItemNo[i]));
		condTableRow.setCondType("PR00");
		condTableRow.setCondValue(condValue);
		condTableRow.setCurrency(currency);
		condTable.appendRow(condTableRow);
		
		
				
	}
	
	
	EzBapipartnrTableRow aRow1 = new EzBapipartnrTableRow();
	aRow1.setPartnRole("AG"); //"AG" for soldto
	aRow1.setPartnNumb("C6100");
	orderPartnersConfirm.appendRow(aRow1);
	
	
	EzcSalesOrderParams  ezcSalesOrderParamsSave = new EzcSalesOrderParams();
	EziSalesOrderCreateParams escpSave = new EziSalesOrderCreateParams();
	ezcSalesOrderParamsSave.setObject(escpSave);
	escpSave.setOrderHeaderIn(orderHeaderConfirm);
	escpSave.setOrderPartners(orderPartnersConfirm);
	escpSave.setOrderItemsIn(iteminTableConfirm);
	escpSave.setOrderDelSchedule(deliveryScheduleTable);
	escpSave.setOrderText(ezctextTable);
	escpSave.setOrderConditions(condTable);
	escpSave.setType("RFF"); 	//if this is set to bulk or RBPG(if RBPG plant has to be set material group),for every sales area one sap order is simulated
	Session.prepareParams(ezcSalesOrderParamsSave);
	String myMesg="";
	try
	{
		EzoSalesOrderCreate ioParamsSave = (EzoSalesOrderCreate)EzSalesOrderManager.ezCreateWebSalesOrder(ezcSalesOrderParamsSave);
		ReturnObjFromRetrieve orderError=ioParamsSave.getReturn();
		
		ReturnObjFromRetrieve orders =(ReturnObjFromRetrieve) ioParamsSave.getOrderHeaderIn();

		int orderErrorCount = orderError.getRowCount();
		String ErrorMessage="";
		boolean SAPnumber=true;
		String ErrorType="";
		for(int pc=0;pc<orderErrorCount;pc++)
		{
			ErrorType =orderError.getFieldValueString(pc,"Type");
			if("E".equalsIgnoreCase(ErrorType))
			{
				ErrorMessage = ErrorMessage+"<br>Post:"+orderError.getFieldValueString(pc,"Message");
				SAPnumber=false;
			}
		}
		
		//out.println("===========>"+orders.toEzcString());
		//out.println("===========>"+orderError.toEzcString());
		
		if(SAPnumber){
			if(orders!=null&&orders.getRowCount()>0)
			myMesg="Order has been Submitted to sap with document number:"+orders.getFieldValueString(0,"DocNumber");
		}else{
			myMesg=ErrorMessage;
		}
		session.putValue("EzMsg",myMesg);  
		
		
	}catch(Exception err){}
	
	
	/*
	
	try{
		JCO.Client client1 = ezc.sapconnection.EzSAPHandler.getSAPConnection();
		client1.execute(function);
		ezc.sapconnection.EzSAPHandler.commit(client1);
		
				
		JCO.Table returnTable = function.getTableParameterList().getTable("RETURN");
		JCO.Table ordKeyTable = function.getTableParameterList().getTable("ORDER_KEYS");
		if (ordKeyTable.getNumRows() > 0)
		{
			out.println("==========>"+ordKeyTable.toString());
		}
			
		
		
		if (returnTable.getNumRows() > 0)
		{
			out.println("==========>"+returnTable.toString());	
		}
		
		if (client1!=null) 
		{
			JCO.releaseClient(client1);
			client1 = null;
			function=null;
		}
	}catch(Exception err){System.out.println("=====>"+err);}
	*/
	
	
%>

<Div id="MenuSol"></Div>
<jsp:forward page="../Misc/ezOutMsg.jsp"></jsp:forward>