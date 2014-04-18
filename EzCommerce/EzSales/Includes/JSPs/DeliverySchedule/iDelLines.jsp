<%
	String AGCode=(String) session.getValue("AgentCode");
	
	String CustCode=(String) session.getValue("docSoldTo");
	CustCode=(CustCode== null || "null".equals(CustCode))?AGCode:CustCode;
	
	//CustCode = AGCode;
	
	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	FormatDate formatDate = new FormatDate();
	ezc.sales.params.EziSalesOrderStatusParams testParams=new ezc.sales.params.EziSalesOrderStatusParams();
		
	testParams.setDocNumber(delNo);
	testParams.setSelection("I");
	testParams.setCustomerNumber(CustCode);
     	ezcSalesOrderParams.createContainer();
	ezcSalesOrderParams.setObject(testParams);

	String oqty="";
	Session.prepareParams(ezcSalesOrderParams);
	
	//out.println("========>"+delNo);
	//out.println("========>"+CustCode);
	//out.println("========>"+AGCode);
	/*
	EzoSalesOrderDelivery params =(EzoSalesOrderDelivery)	EzSalesOrderManager.getSalesOrderDelivery(ezcSalesOrderParams);
	ReturnObjFromRetrieve delivHead = params.getDelivHeader();
	ReturnObjFromRetrieve delivTable = params.getDelivDetail();
	*/	
	
	//ReturnObjFromRetrieve params =(ReturnObjFromRetrieve)	EzSalesOrderManager.getSalesOrderDelivery(ezcSalesOrderParams);
	ReturnObjFromRetrieve finalRetObject=null;
	String sDoc_JCO = delNo;
	String sSoldTo_JCO = CustCode;
	String sSorg_JCO = "BP01";
	String sSel_JCO = "I";
%>		
		<%@ include file="iInvoiceJCO.jsp"%>
<%		

	ReturnObjFromRetrieve delivHead = (ReturnObjFromRetrieve)finalRetObject.getFieldValue("DELIV_HEADER");
	ReturnObjFromRetrieve delivTable = (ReturnObjFromRetrieve)finalRetObject.getFieldValue("DELIV_DETAILS");
	
	//ReturnObjFromRetrieve delivHead = (ReturnObjFromRetrieve)params.getFieldValue("DELIV_HEADER");
	//ReturnObjFromRetrieve delivTable = (ReturnObjFromRetrieve)params.getFieldValue("DELIV_DETAILS");

	
	try{
	String[] so =new String[1];  
		so[0]="PO_NO";
	delivTable.sort(so,true);
	}catch(Exception e){}
	int delivHeadCount = delivHead.getRowCount();
	int delivTableCount = delivTable.getRowCount();

%>
