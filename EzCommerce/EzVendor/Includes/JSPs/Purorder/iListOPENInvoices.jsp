<%@ page import ="ezc.ezparam.*" %>
<%@ page import="ezc.ezvendinvoice.csb.*" %>
<%@ page import="ezc.ezvendor.params.*" %>
<%
	ezc.client.EzVendorInvManager VendInvManager = new ezc.client.EzVendorInvManager();
	EzVendorParams ioparams = new EzVendorParams();
	ezc.ezparam.EzcVendorParams newParams = new ezc.ezparam.EzcVendorParams();
	EziVendorInvoiceInputParams eviip = new EziVendorInvoiceInputParams();
	ezc.client.EzcPurchaseUtilManager utilManager = new ezc.client.EzcPurchaseUtilManager(Session);
	String currSysKey = utilManager.getDefaultPurArea();
	eviip.setInvoiceFlag("O");
	newParams.createContainer();
	newParams.setObject(ioparams);
	newParams.setObject(eviip);
	Session.prepareParams(newParams);
	EzInvoice SeqInv = (EzInvoice)VendInvManager.getListOfInvoices(newParams);	
%>