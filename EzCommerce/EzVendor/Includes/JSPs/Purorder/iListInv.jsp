
<%@ page import ="ezc.ezparam.*" %>
<%//@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>

<%@ page import="ezc.ezvendinvoice.csb.*" %>
<%@ page import="ezc.ezvendor.params.*" %>
<%!
	public java.util.Date getDateFormat(String fromDate){
	
		ezc.ezutil.FormatDate formatDate=new ezc.ezutil.FormatDate();
		int dateArray[] = formatDate.getMMDDYYYY(fromDate, true);
				
		dateArray[0]=dateArray[0]-1;
		Date FromDate=new java.sql.Date(dateArray[2]-1900,dateArray[0],dateArray[1]);
		
		return FromDate;
	
	}

%>
<%

	ezc.client.EzVendorInvManager VendInvManager = new ezc.client.EzVendorInvManager();

	final String feild1 = "PURCHASEORDER";
	final String feild2 = "POSITIONNUMBER";
	final String feild3 = "SEQUENCENUMBERPO";
	final String feild4 = "SUPPLIER";
	final String feild5 = "NAME";
	final String feild6 = "ITEM";
	final String feild7 = "QUANTITYONPACKINGSLIP";
	final String feild8 = "RECEIPTDATE";
	final String feild9 = "DELIVEREDQTY";
	final String feild10 = "BACKORDERQTY";
	final String feild11 = "PURCHASEUNIT";
	final String feild12 = "AMOUNT";
	final String feild13 = "INVOICEDAMOUNT";
	final String feild14 = "INVOICEDATE";
	final String feild15 = "INVOICENUMBER";
	final String feild16 = "INVOICEDQUANTITY";
	final String feild17 = "ORDERLINEDISCOUNTAMOUNT";
	final String feild18 = "RECORDSTATUS";
	final String feild19 = "DESCRIPTION";

	String orno = "";
	String pono = "";
	String seqn = "";
	String supp = "";
	String name = "";
	String item = "";
	String desc = "";
	String qty = "";
	String rdate = "";
	String ddate = "";
	String bqty = "";
	String punit = "";
	String amnt = "";
	String iamnt = "";
	String idate = "";
	String inum = "";
	String iqty = "";
	String odis = "";



	//EzInvoice SeqInv = new EzInvoice();

	EzVendorParams ioparams = new EzVendorParams();
	ezc.ezparam.EzcVendorParams newParams = new ezc.ezparam.EzcVendorParams();
	EziVendorInvoiceInputParams eviip = new EziVendorInvoiceInputParams();

	ezc.client.EzcPurchaseUtilManager utilManager = new ezc.client.EzcPurchaseUtilManager(Session);
	String currSysKey = utilManager.getDefaultPurArea();
	String invoiceDesc = "";
	
	if ( invoiceFlag.equals("A") ) invoiceDesc = "Invoices";
	if ( invoiceFlag.equals("O") ) invoiceDesc = "Open Invoices";
	if ( invoiceFlag.equals("C") ) invoiceDesc = "Closed Invoices";
	if ( invoiceFlag.equals("P") ) invoiceDesc = "Invoices ";
	
	//String fromDate	= request.getParameter("FromDate");
	//String toDate	= request.getParameter("ToDate");
	
	if( ((!"null".equals(fromDate)) && (!"null".equals(toDate)) && (fromDate!=null && toDate!=null )   ) && ("A".equals(invoiceFlag) || "C".equals(invoiceFlag) )){
			
		ezc.ezcommon.EzLog4j.log("Date to be set For Invoices","I");
		ioparams.setFromDate(getDateFormat(fromDate));
		ioparams.setToDate(getDateFormat(toDate));
		ezc.ezcommon.EzLog4j.log("Given Dates range for INVOICES>"+fromDate+"--to-->"+toDate,"I");
	}
	
	
	eviip.setInvoiceFlag(invoiceFlag);
	newParams.createContainer();
	newParams.setObject(ioparams);
	newParams.setObject(eviip);
	Session.prepareParams(newParams);

	if(invoiceFlag.equals("D")){
		/// THIS IS FOR GETTING A/C STATEMENT.
		SeqInv = (EzInvoice)VendInvManager.getListOfInvoicesAndDocuments(newParams);
	}	
	else{
		SeqInv = (EzInvoice)VendInvManager.getListOfInvoices(newParams);	
	}
	
	//out.println("No of Rows: "+SeqInv.getRowCount());
	//out.println(SeqInv.toEzcString());
	/////////////// THE FOLLOWING CODE IS ADDED BY SOMA AT 11:29 AM 16/07/2001 FOR GETTING PO PAYMENT DETAILS. \\\\\\\\\\\\\\\\
	
	double totBalance=0;
	EzInvoice ezPOPayDetails = new EzInvoice();
	if(invoiceFlag.equals("P") )
	{
		ezPOPayDetails = SeqInv;
		for(int i=0;i<ezPOPayDetails.getRowCount();i++)
		{
			try
			{
				totBalance += Double.parseDouble(ezPOPayDetails.getFieldValueString(i,"AMOUNT"));
			}catch(Exception e)
			{
				totBalance += 0;
			}
		}
	}

	String docType = null;
	
	//System.out.println("There are "+SeqInv.getRowCount()+" items in the Inv List");
	///// THE FOLLOWING CODE IS ADDED TO FILTER LIST OF INVOICES ON DOCTYPE.
	///// IF DOCTYPE IS NOT EQUAL TO 'AB','RE','OV','KR' 
	///// THEN WE ARE DELETING THAT INVOICE FOR THE LIST.
	
	Vector vInvDocTypes = new Vector();	// DO NOTHING VECTOR.The DocTypes which are in this vector
	vInvDocTypes.addElement("AB");		// will not be filtered.The others will be stopped from displaying.
	vInvDocTypes.addElement("KD");
	//vInvDocTypes.addElement("KG");
	vInvDocTypes.addElement("KR");
	vInvDocTypes.addElement("OV");
	vInvDocTypes.addElement("RC");
	vInvDocTypes.addElement("RE");
	vInvDocTypes.addElement("RI");
	vInvDocTypes.addElement("RJ");
	vInvDocTypes.addElement("RS");
	vInvDocTypes.addElement("SA");
		
	for(int i=SeqInv.getRowCount()-1;i>=0;i--)
	{
		docType = SeqInv.getFieldValueString(i,"DOCTYPE");
		docType = docType.trim();
		if(docType!=null)
		{
			if(vInvDocTypes.contains(docType))
			{
				//// DO NOTHING. ////

			}
			else
			{
				SeqInv.deleteRow(i);

			}
		}
	}
	
	ezc.ezcommon.EzLog4j.log("Given>>>>>>>>>>>>>"+SeqInv.toEzcString() ,"I");
%>


