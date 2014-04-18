<%@ page import ="java.math.*"%>
<%@ page import ="ezc.ezparam.*" %>
<%@ page import="ezc.ezpurchase.csb.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import="ezc.ezvendinvoice.csb.*" %>
<%@ page import="ezc.ezvendor.params.*" %>
<%@ include file="../../Lib/DateFunctions.jsp"%>
<jsp:useBean id="VendInvManager" class ="ezc.client.EzVendorInvManager" scope="page" />
<%	
	double totBalance=0;
	int retCount = 0;
	EzVendorParams ioparams = new EzVendorParams();
	EziVendorInvoiceInputParams eviip = new EziVendorInvoiceInputParams();
	ezc.ezparam.EzcVendorParams newParams = new ezc.ezparam.EzcVendorParams();
	newParams.createContainer();
	eviip.setInvoiceFlag("P");
	ioparams.setPurOrdNo(purNum);
	newParams.setObject(ioparams);
	newParams.setObject(eviip);
	Session.prepareParams(newParams);
	EzInvoice ezPOPayDetails = (EzInvoice)VendInvManager.getListOfInvoices(newParams);
	if(ezPOPayDetails != null)
	{
		retCount = ezPOPayDetails.getRowCount();
		for(int i=0;i<retCount;i++)
		{
			try
			{
				totBalance += Double.parseDouble(ezPOPayDetails.getFieldValueString(i,"AMOUNT"));
			}
			catch(Exception e)
			{
				totBalance = 0;
			}
		}
	}	
%>
