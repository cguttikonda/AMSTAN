<%@page import = "java.util.*" %>
<%@page import = "ezc.ezcommon.*" %>
<%@page import = "ezc.ezparam.*" %>
<%@page import = "ezc.ezshipment.params.*,ezc.ezvendorapp.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<jsp:useBean id="mainObj" class="ezc.ezshipment.client.EzShipmentManager" />
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page" />
<jsp:useBean id="PcManager" class ="ezc.client.EzPurContractManager" scope="page" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />


<%
	String userType =(String)session.getValue("UserType");
 	String sysKey = (String) session.getValue("SYSKEY");
 	String soldTo = (String) session.getValue("SOLDTO");

   	if(userType == null)
     		userType="";

	/*
		Open Purchase Order List getting from SAP.
	*/
	final String ORDER = "ORDER";
	final String ORDERDATE = "ORDERDATE";
	final String CURRENCY = "CURRENCY";
	final String NETAMOUNT = "NETAMOUNT";

	EzPurchHdrXML hdrXML =null;
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurchaseInputParams testParams = new ezc.ezpurchase.params.EziPurchaseInputParams();
	newParams.setObject(testParams);
	newParams.setObject(iparams);
	Session.prepareParams(newParams);
	hdrXML = (EzPurchHdrXML)PoManager.ezGetOpenPurchaseOrderList(newParams);

	/*
		Open Purchase Contracts List getting from SAP.
	*/

	final String contract = "CONTRACT";
	final String CONTRACTDATE= "CONTRACTDATE";
	final String CURRENCY1= "CURRENCY";
	final String NETAMOUNT1= "NETAMOUNT";
	EzPSIInputParameters ioparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newCOParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurcontract.params.EziPurchaseInputParams testParams1 = new ezc.ezpurcontract.params.EziPurchaseInputParams();
	newCOParams.createContainer();
	newCOParams.setObject(testParams1);
	newCOParams.setObject(ioparams);
	Session.prepareParams(newCOParams);
	EzPurchCtrHdrXML purchctrhdr=new EzPurchCtrHdrXML();
	purchctrhdr = (EzPurchCtrHdrXML)PcManager.ezOpenPurchaseContractList(newCOParams);

	/*
		Getting Order Nos from Acknowledgement Table -Local DB
	*/
	
 	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
 	mainParams.setLocalStore("Y");	    
 	EziPurchaseOrderParams iParams =  new EziPurchaseOrderParams();

 	iParams.setSysKey(sysKey);
 	iParams.setSoldTo(soldTo);
 	mainParams.setObject(iParams);	
 	Session.prepareParams(mainParams);
 	ReturnObjFromRetrieve retAck= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams);

	/*
		We need to show Open Orders List that are acknowledged by the Vendor.
		So to filter the Open Orders, preparing a Vector of Not Acknowledged and Rejectd Orders.
	*/
	
	Vector	ackOrders = new java.util.Vector();
	int retCount =  retAck.getRowCount(); 
	for(int j=0;j<retCount;j++)
	{
     		if(retAck.getFieldValueString(j,"DOCSTATUS").equals("A") || retAck.getFieldValueString(j,"DOCSTATUS").equals("B")) 
			ackOrders.addElement(retAck.getFieldValueString(j,"DOCNO"));	
	}	

%>
