<%@ page import = "ezc.ezsap.*"%>
<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import ="ezc.ezparam.*,ezc.client.*,java.util.*"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<jsp:useBean id="Manager" class="ezc.sales.local.client.EzSalesManager" />

<jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />

<%
ezc.ezbasicutil.EzCurrencyFormat myFormat 	= new ezc.ezbasicutil.EzCurrencyFormat();
ezc.client.EzcUtilManager UtilManager 		= new ezc.client.EzcUtilManager(Session);

String strSalesOrder		= request.getParameter("SONumber");
String customer			= (String)session.getValue("docSoldTo");
String fCondType = (String)session.getValue("FREIGHTCONDTYPE");
String freightVal = "0";

int retHeaderCount = 0,retItemsCount=0;

FormatDate formatDate = new FormatDate();

String fromDate 		= request.getParameter("FromDate"); 
String toDate 			= request.getParameter("ToDate");
String newFilter 		= request.getParameter("newFilter");

// these two variables are for sales contract purpose. please dont remove

String SCDoc 			= request.getParameter("SCDoc");
String SCDocNr 			= request.getParameter("SCDocNr");

java.math.BigDecimal totTax = new java.math.BigDecimal("0");

if((SCDocNr != null) && (!"null".equals(SCDocNr)) && (SCDocNr.trim().length() !=0)) strSalesOrder = SCDocNr;


	ReturnObjFromRetrieve sodetails= null;
	
	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	ezcSalesOrderParams.setSalesDocNum(strSalesOrder);
	ezcSalesOrderParams.setCustomer(customer);
	ezc.sales.local.params.EziUserList userList= new ezc.sales.local.params.EziUserList();
	ezcSalesOrderParams.setObject(userList);
	Session.prepareParams(ezcSalesOrderParams);
	sodetails = (ReturnObjFromRetrieve)Manager.ezGetSODetails(ezcSalesOrderParams);
      
	ReturnObjFromRetrieve retHeader	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("HEADER");
	ReturnObjFromRetrieve retItems	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("ITEMS");	
	ReturnObjFromRetrieve retPartners = (ReturnObjFromRetrieve)sodetails.getFieldValue("PARTNERS");
	ReturnObjFromRetrieve retLineText = (ReturnObjFromRetrieve)sodetails.getFieldValue("ITEMTEXT");
	ReturnObjFromRetrieve retStatus   = (ReturnObjFromRetrieve)sodetails.getFieldValue("STATUS");
	ReturnObjFromRetrieve retCond     = (ReturnObjFromRetrieve)sodetails.getFieldValue("SDCOND");
	//out.print(retCond.toEzcString());
	if(retHeader!=null && retHeader.getRowCount()>0)
		retHeaderCount = retHeader.getRowCount();
	if(retItems!=null && retItems.getRowCount()>0)
		retItemsCount = retItems.getRowCount();
	
	String delivStatus = "";
	
	Hashtable dStatusHT = new Hashtable();
	
	dStatusHT.put(" ","Not relevant");
	dStatusHT.put("A","Not delivered");
	dStatusHT.put("B","Partially delivered");
	dStatusHT.put("C","Fully delivered");
	
	
	
	if(retStatus!=null && retStatus.getRowCount()>0){
		delivStatus = (String) dStatusHT.get(retStatus.getFieldValueString(0,"DELIV_STAT"));
		
		if(delivStatus == null || "null".equals(delivStatus)){
			delivStatus = "";
		}
		
		
	}
	
	Vector types = new Vector();
	Vector names = new Vector();
	types.addElement("currency");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	names.addElement("NET_VALUE");
	names.addElement("PO_DATE");
	names.addElement("CT_VALID_F");
	names.addElement("CT_VALID_T");
	names.addElement("REQ_DATE");
	
	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);
	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(retHeader);

	types = new Vector();
	names = new Vector();
	types.addElement("currency");
	types.addElement("date");
	types.addElement("currency");
	names.addElement("VALUE");
	names.addElement("REQUIREDDATE");
	names.addElement("NET_PRICE");
	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);
	                          
	ezc.ezparam.ReturnObjFromRetrieve ret1 = EzGlobal.getGlobal(retItems); 
	
	String soldto=(String) session.getValue("docSoldTo");
	
	
	String syskey=(String) session.getValue("SalesAreaCode");
	UtilManager = new ezc.client.EzcUtilManager(Session);
	String defPartnNum =UtilManager.getUserDefErpSoldTo();
	if(!soldto.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(syskey,soldto);
	EzcCustomerInvoiceParams ecparams = new EzcCustomerInvoiceParams();
	EziCustomerInvoiceParams eiParams = new EziCustomerInvoiceParams();
	eiParams.setCustInvoiceNo("1");
	eiParams.setSalesDocNum(strSalesOrder);
	eiParams.setSelection("H");  
	ecparams.setObject( eiParams );
	Session.prepareParams(ecparams);
	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)CustInvManager.getCustomerInvoiceDetails(ecparams);
	ReturnObjFromRetrieve billHeaders = (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_HEADERS_OUT");

	if(!soldto.equals(defPartnNum))
	UtilManager.setSysKeyAndSoldTo(syskey,defPartnNum);
	
	
	
	if(billHeaders!=null && billHeaders.getRowCount()>0){
		if(!"".equals(delivStatus)){
			delivStatus += ", Invoiced";
		}else{
			delivStatus = "Invoiced";
		}
	
	}
	
	if(retCond!=null && retCond.getRowCount()>0)
	{
		for(int a=0;a<retCond.getRowCount();a++)
		{
			String itemNo = retCond.getFieldValueString(a,"ItmNumber");
			String condType = retCond.getFieldValueString(a,"CondType");
			String condVal = retCond.getFieldValueString(a,"Condvalue");
			
			int itm = -1;
			try
			{
				itm = Integer.parseInt(itemNo);
			}
			catch(Exception e)
			{
				itm = -1;
			}
			if(itm==0 && condType.equals(fCondType))
			{
				freightVal = condVal;
				break;
			}
		}
		try
		{
			freightVal = new java.math.BigDecimal(freightVal).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}
		catch(Exception e)
		{
		
		}
	}
		
	
%>



