<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>
<%@ include file="../../Lib/DateFunctions.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page">
</jsp:useBean>


<%

	final String ORDER = "ORDER";
	final String LINENO = "POSITION";
	final String UOM = "UOMPURCHASE";
	final String PRICE = "PRICE";
	final String MATERIAL = "ITEM";
	final String MATDESC = "ITEMDESCRIPTION";
	final String AMOUNT = "AMOUNT";
	final String DELDATE = "PLANNEDDELIVERYDATE";
	final String ORDDATE = "ORDERDATE";
	final String ORDQTY = "ORDEREDQUANTITY";
	final String DISCOUNT = "ORDERLINEDISCOUNT1";
	final String DDATE = "CONFIRMDELIVERYDATE";
	final String INDICATOR = "INDICATOR";

	String poNum=request.getParameter("PurchaseOrder");
	// To make PO No 10 digits
	poNum = "0000000000"+poNum;
	poNum = poNum.substring(poNum.length()-10,poNum.length());

	
	EzPurchDtlXML dtlXML = null;
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	iparams.setOrderNumber(poNum);
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurOrderDetailsParams testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testparams);
	Session.prepareParams(newParams);

	dtlXML =  (EzPurchDtlXML)PoManager.ezPurchaseOrderStatus(newParams);
	ReturnObjFromRetrieve retPoHistory= dtlXML.getPoHistoryTotals();

	Hashtable historyTable=new Hashtable();
	for(int i=0;i<retPoHistory.getRowCount();i++)
		historyTable.put(retPoHistory.getFieldValueString(i,"PO_ITEM"),retPoHistory.getFieldValueString(i,"DELIV_QTY"));

	String OrderType="Open";
	Date ordDate = (Date)dtlXML.getFieldValue(0, ORDDATE);
%>

