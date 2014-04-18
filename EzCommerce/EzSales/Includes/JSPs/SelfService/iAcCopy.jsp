<%@ page import ="ezc.ezparam.*,java.util.*" %>
<%@ page import="ezc.client.*,ezc.ezutil.*" %>
<%@ page import="ezc.ezcustomer.params.* "%>
<%@ page import = "ezc.ezsap.*"%>
<%@ page import="ezc.ezcustomer.params.* "%>
<%@ page import="ezc.customer.invoice.csb.*" %>
<%@ page import="ezc.customer.invoice.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="session" />
<jsp:useBean id="CustManager" class="ezc.ezcustomer.client.EzCustomerManager" scope="session" />
<jsp:useBean id="OrderedDictionary" class="ezc.record.util.EzOrderedDictionary" scope = "session" />

<%
	String cust	=(String)session.getValue("AgentCode");
	String forkey 	= (String)session.getValue("formatKey");
	if(forkey==null) forkey="/";
	
	String fd = request.getParameter("FromDate");
	String td = request.getParameter("ToDate");
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();

	if(fd == null || td == null || "null".equals(fd) || "null".equals(td))
	{
		java.util.Calendar cdObj = java.util.Calendar.getInstance();
		int cYear = cdObj.get(Calendar.YEAR);
		int cMonth = cdObj.get(Calendar.MONTH);
		td = FormatDate.getStringFromDate(new Date(),forkey,FormatDate.MMDDYYYY);
		if(cMonth>2)
			fd = formatDate.getStringFromDate(new Date(cYear-1900,03,01),forkey,FormatDate.MMDDYYYY);
		else	
			fd = formatDate.getStringFromDate(new Date(cYear-1901,03,01),forkey,FormatDate.MMDDYYYY);
	}
		
	
	ReturnObjFromRetrieve custBal = null;
	ReturnObjFromRetrieve lineItems =null;
	ReturnObjFromRetrieve keybal =null;
	Date fromDate = new Date();
	Date toDate = new Date();
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	
	int lineItemsCount 	= 0;
	int keybalCount 	= 0;
	int custBalCount 	= 0;
	
	double invoiceBal 	= 0;
	double balance 		= 0;
	String currencyStr	= "";
	
		
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	String billto=(String)session.getValue("DefBillTO"); ///UtilManager.getUserDefErpBillTo();

	
	if(fd != null && td != null && !"null".equals(fd) && !"null".equals(td))
	{
		try{

			fromDate.setDate(Integer.parseInt(fd.substring(3,5)));
			fromDate.setMonth(Integer.parseInt(fd.substring(0,2))-1);
			fromDate.setYear(Integer.parseInt(fd.substring(6,10))-1900);


			toDate.setDate(Integer.parseInt(td.substring(3,5)));
			toDate.setMonth(Integer.parseInt(td.substring(0,2))-1);
			toDate.setYear(Integer.parseInt(td.substring(6,10))-1900);

			/// ************** TO FIND THE CUSTOMER BALANCE ******************* //

			EzcCustomerParams ecp = new EzcCustomerParams();
			EziCustBalanceParams eip = new EziCustBalanceParams();
			eip.setKeyDate(fromDate); // HERE WE HAVE TO SET THE FROMDATE TO THE KEY DATE
			//eip.setSelection(billto);
			ecp.setObject(eip);
			Session.prepareParams(ecp);
			EzoCustomerBalance finalRetObj = (EzoCustomerBalance)CustManager.getCustomerBalance(ecp);

			try{
				if(finalRetObj!=null) custBal = finalRetObj.getCustomerBalance();
				if(custBal != null)
				{
					for(int i=0;i<custBal.getRowCount();i++)
					{
						try{
							invoiceBal += Double.parseDouble(custBal.getFieldValueString(i,"TotalCurrentBalance"));
						}catch(Exception e){
							invoiceBal += 0;
						}
					}
				}

			}catch(Exception e)
			{

			}


			/// ************** CUSTOMER BALANCE ENDS HERE ********************* //

			ReturnObjFromRetrieve SeqInv = null;
			EzCustomerParams ioparams = new EzCustomerParams();

			ezc.customer.invoice.params.EzcCustomerInvoiceParams newParams=new  ezc.customer.invoice.params.EzcCustomerInvoiceParams();
			EziCustomerInvoiceParams ecip = new EziCustomerInvoiceParams();
			String invoiceFlag ="A";
			ecip.setInvFlag(invoiceFlag);
			ecip.setFromDate(fromDate);
			ecip.setToDate(toDate) ;
			ecip.setSelection(billto);
			newParams.createContainer();
			newParams.setObject(ioparams);
			newParams.setObject(ecip);
			Session.prepareParams(newParams);

			try{
				
				SeqInv = (ReturnObjFromRetrieve) SalesInvManager.getCustomerInvoices(newParams);
				if(SeqInv!=null)
				{
					lineItems = (ReturnObjFromRetrieve)SeqInv.getFieldValue("LINEITEMS");
					keybal = (ReturnObjFromRetrieve)SeqInv.getFieldValue("KEYBALANCE");

					if(lineItems != null)
					{	
						lineItemsCount = lineItems.getRowCount();
						currencyStr = "["+lineItems.getFieldValueString(0,"Currency")+"]";
					}	
					if(keybal != null)	keybalCount = keybal.getRowCount();
				}
			}catch(Exception e){}


			try{
				if(keybal!=null && keybal.getRowCount()>0)
				{
					balance =Double.parseDouble(keybal.getFieldValueString(0,"LcBal"));
					//invoiceBal +=balance;
					invoiceBal =balance;
				}	
			}catch(Exception e){}

		}catch(Exception e){}	
	}
	
%>