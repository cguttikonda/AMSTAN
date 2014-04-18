<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import ="ezc.ezparam.*,java.util.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import="ezc.ezshipment.params.*" %>
<%@ page import="ezc.ezpurchase.params.*" %>
<%@ page import="ezc.ezshipment.client.*" %>
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />	


<%
	EzcParams ezparams=new EzcParams(true);
	EzShipmentManager shManager=new EzShipmentManager();

	String QtnDt = request.getParameter("QtnDate");
	String Remk = request.getParameter("Remarks");

	int j=0;
	Date fromDate = new Date();
	fromDate.setDate(Integer.parseInt(QtnDt.substring(0,2)));
	fromDate.setMonth(Integer.parseInt(QtnDt.substring(3,5))-1);
	fromDate.setYear(Integer.parseInt(QtnDt.substring(6,10))-1900);

	EzBapiekkocStructure header = new EzBapiekkocStructure();

	header.setPoNumber(request.getParameter("RfqNo"));
	header.setDocType("A");
	header.setAgreement(request.getParameter("QtnRef"));
	header.setDocDate(fromDate);

	EzBapiekkoaStructure headerAdd = new EzBapiekkoaStructure();

	headerAdd.setIncoterms1(request.getParameter("IncoTerms"));
	headerAdd.setIncoterms2("DRL");
	headerAdd.setPmnttrms(request.getParameter("PaymentTerms"));

	String [] items = request.getParameterValues("ItemNo");
	String [] prices = request.getParameterValues("Price");
	String [] currs = request.getParameterValues("Curr");
	String [] rfqQty = request.getParameterValues("rfqQty");
	double price_JCO=0.0d;
	
	
	
	ezc.ezpurchase.params.EzBapiekpocTable itemTable = new ezc.ezpurchase.params.EzBapiekpocTable();
	ezc.ezpurchase.params.EzBapiekpocTableRow itemTableRow = null;
	for (int i=0 ; i < items.length ; i++){
		itemTableRow = new ezc.ezpurchase.params.EzBapiekpocTableRow(); 
		//if ((prices[i]!=null)&&(prices[i].length()!=0)){
			price_JCO = Double.parseDouble(prices[i]);
			price_JCO = price_JCO/100.0;
			itemTableRow.setPoItemString(items[i]);
			//itemTableRow.setNetPrice(new java.math.BigDecimal(prices[i]));
			itemTableRow.setNetPrice(new java.math.BigDecimal(price_JCO));
			itemTableRow.setDispQuanString(rfqQty[i]);
		//}
		itemTable.appendRow(itemTableRow);
	}
	EzBapicondTable sapCond =  new EzBapicondTable();
	/*
		for (int i=0 ; i < items.length ; i++)
		{
			EzBapicondTableRow sapCondRow = new EzBapicondTableRow();
			if ((prices[i]!=null)&&(prices[i].length()!=0)){
				sapCondRow.setItmNumberString(items[i]);
				sapCondRow.setCondType("PBXX");
				sapCondRow.setCondValueString(prices[i]);
				sapCondRow.setCondvalueString(prices[i]);
				sapCondRow.setCurrency(currs[i]);
				sapCond.insertRow(j,sapCondRow);
				j++;
			}
		}
	*/	
	/*	
		log("CondClass>>"+condRow.getCondclass());
		log("CondNo>>>>>"+condRow.getCondNo());
	*/

	String Conditions = request.getParameter("allconditions");
	//System.out.println("All Cond>>>>>"+Conditions);
	if ((Conditions!=null)&&(Conditions.trim().length()!=0))
	{
		StringTokenizer st1=new StringTokenizer(Conditions,"#");
		while (st1.hasMoreTokens())
		{
			//System.out.println("All Cond>>>>>");
			StringTokenizer st2=new StringTokenizer(st1.nextToken(),"*");
			String str = st2.nextToken();
			//System.out.println("All Cond>>>>>"+str);

			if (!"NA".equalsIgnoreCase(str)){
				EzBapicondTableRow sapCondRow = new EzBapicondTableRow();
				//sapCondRow.setCondtype(str);	//length 1
				sapCondRow.setCondType(str);
				String condVal= st2.nextToken();
				sapCondRow.setCondvalueString(condVal);
				sapCondRow.setCondValueString(condVal);
				sapCond.appendRow(sapCondRow);
			}
		}
	}	
		
	EzBapieslltxTable slltxTable = new EzBapieslltxTable();
	EzBapieslltxTableRow slltxRow = new EzBapieslltxTableRow();
	slltxRow.setTextLine(Remk);
	//slltxRow.setTextId("00");
	slltxTable.insertRow(0,slltxRow);

	ezparams.setObject(header);
	ezparams.setObject(headerAdd);
	ezparams.setObject(itemTable);
	ezparams.setObject(sapCond);
	ezparams.setObject(slltxTable);
	Session.prepareParams(ezparams);

	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)shManager.ezPostQuotation(ezparams);
	System.out.println(ret.toEzcString()+">>>");
	String retMsg = "";
	for ( int i=0;i<ret.getRowCount();i++){
		String Msg = ret.getFieldValueString(i,"MSG");
		String Type = ret.getFieldValueString(i,"TYPE");
		String Code = ret.getFieldValueString(i,"CODE");
		String MsgNo = ret.getFieldValueString(i,"MSGNO");
		if ("E".equalsIgnoreCase(Type.trim())){
			retMsg= "ERROR : "+Msg;
			break;
		}
	}
	if ("".equals(retMsg))
		retMsg = "Quotation Posted Successfully";
	
	/***********Added to update status to Y if quoted***********/
	ezc.ezcommon.EzLog4j.log("****==before Update RFQ Details=====**"+retMsg,"I");
	ezc.ezparam.EzcParams updateRFQParams	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderTable updateezirfqheadertable	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
	ezc.ezpreprocurement.params.EziRFQHeaderTableRow updateezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();

	ezc.ezpreprocurement.params.EziRFQItemQtyTable ezirfqqtystable = new ezc.ezpreprocurement.params.EziRFQItemQtyTable();
	ezc.ezpreprocurement.params.EziRFQItemQtyTableRow ezirfqqtystablerow =  new ezc.ezpreprocurement.params.EziRFQItemQtyTableRow();


	updateezirfqheadertablerow.setRFQNo(request.getParameter("RfqNo")); 
	updateezirfqheadertablerow.setStatus("Y"); 
	updateezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
	updateezirfqheadertable.appendRow(updateezirfqheadertablerow);

	ezc.ezcommon.EzLog4j.log("****=items.length=====**"+items.length,"I");
	for (int i=0 ; i < items.length ; i++)
	{
		ezirfqqtystablerow.setRemarks(Remk+"', ERD_PRICE='"+prices[i]);
		ezirfqqtystablerow.setRFQNo(request.getParameter("RfqNo"));
		ezirfqqtystablerow.setItmNo(items[i]);
		ezirfqqtystable.appendRow(ezirfqqtystablerow);	

	}


	updateRFQParams.setObject(ezirfqqtystable);
	updateRFQParams.setObject(updateezirfqheadertable);
	updateRFQParams.setLocalStore("Y");
	Session.prepareParams(updateRFQParams);
	ezc.ezcommon.EzLog4j.log("****==before Update RFQ Details=====**","I");
	Manager.ezUpdateRFQ(updateRFQParams);
	ezc.ezcommon.EzLog4j.log("****==After Update RFQ Details=====**","I");
	
	response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+retMsg);

%>
