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
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
<jsp:useBean id="CustManager" class="ezc.ezcustomer.client.EzCustomerManager" scope="session" />
<jsp:useBean id="OrderedDictionary" class="ezc.record.util.EzOrderedDictionary" scope = "session" />

<%
	String cust=(String)session.getValue("AgentCode");
	String forkey = (String)session.getValue("formatKey");
	if(forkey==null) forkey="/";
	
	String fd = request.getParameter("FromDate");
	String td = request.getParameter("ToDate");
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();

	if(fd == null || td == null || "null".equals(fd) || "null".equals(td))
	{
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

	if(fd != null && td != null)
	{

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
			custBal = finalRetObj.getCustomerBalance();


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

		EzoCustomerInvoice SeqInv = new EzoCustomerInvoice();
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
			SeqInv = (EzoCustomerInvoice) SalesInvManager.getCustomerInvoices(newParams);
			lineItems = SeqInv.getLineItems();
			keybal = SeqInv.getKeyBalance();

			if(lineItems != null)
			{	
				lineItemsCount = lineItems.getRowCount();
				currencyStr = "["+lineItems.getFieldValueString(0,"Currency")+"]";
			}	
			if(keybal != null)	keybalCount = keybal.getRowCount();

		}catch(Exception e){}


		try{
			if(keybal!=null)
			{
				balance =Double.parseDouble(keybal.getFieldValueString(0,"LcBal"));
				invoiceBal +=balance;
			}	
		}catch(Exception e){}
		}

	
				/// ************** AC DESIGN STARTS HERE ********************* //
				
		ArrayList dispColumns= new ArrayList();
		ArrayList dispLabels= new ArrayList();
		ArrayList dispSizes= new ArrayList();
		ArrayList dispAlign= new ArrayList();
		
		dispColumns.add("TRANSDATE");	dispLabels.add(transDate_L);
		dispColumns.add("PARTICULARS");	dispLabels.add(particulars_L);
		dispColumns.add("DOCNO");	dispLabels.add(docNo_L);
		dispColumns.add("DEBIT");	dispLabels.add("Trans "+debit_L);
		dispColumns.add("CREDIT");	dispLabels.add("Trans "+credit_L);
		dispColumns.add("BALANCE");	dispLabels.add(bal_L+currencyStr);
		

		dispSizes.add("'16%'");   dispAlign.add("align=center");
		dispSizes.add("'16%'");   dispAlign.add("align=left");
		dispSizes.add("'16%'");   dispAlign.add("align=center");
		dispSizes.add("'16%'");   dispAlign.add("align=right");
		dispSizes.add("'16%'");   dispAlign.add("align=right");
		dispSizes.add("'16%'");   dispAlign.add("align=right");

		Hashtable myValues = null;
		Hashtable myIndex  = new Hashtable();

		if(fd != null && td != null)
		{

			Date invDt = null;
			String invAmount = null;
			String docNo = null;
			String dbcrInd = null;
			String docType = null;
			String fontColor = null;
			String acType = "";
			for(int i=0;i<lineItemsCount;i++)
			{
				invDt 		= (Date)lineItems.getFieldValue(i,"PstngDate");
				docNo 		= lineItems.getFieldValueString(i,"DocNo");
				docType 	= lineItems.getFieldValueString(i,"DocType");
				invAmount 	= lineItems.getFieldValueString(i,"Amount");

				if("H".equals(lineItems.getFieldValueString(i,"DbCrInd")))
				{
					fontColor 	= "<font color='red'>";
					balance 	=  invoiceBal - Double.parseDouble(invAmount);
					dbcrInd 	= "";
				}
				else
				{
					fontColor 	= "<font color='black'>";
					balance 	=  invoiceBal + Double.parseDouble(invAmount);
					dbcrInd 	= "-";
				}

				if("DZ".equals(docType))
					acType = "Receipt";
				else if("DA".equals(docType))
					acType = "Bill Of Exchange";
				else if("RV".equals(docType))
					acType = "Invoice";
				else if("AB".equals(docType))
					acType = "Adjustment";
				else if("OC".equals(docType))
					acType = "Opening Balance";

				if((fromDate.compareTo(invDt) <= 0) && (toDate.compareTo(invDt) >=0))
				{	
				
				 	myValues = new Hashtable();
					try{
						docNo = ""+Long.parseLong(docNo);
					}catch(Exception e){}
					
				
					myValues.put("TRANSDATE",fontColor + formatDate.getStringFromDate(invDt,forkey,formatDate.MMDDYYYY)+"</FONT>");
					myValues.put("PARTICULARS",fontColor + "<input type ='text' class=tx readonly size='15' value='"+acType+"'></FONT>");
					myValues.put("DOCNO", fontColor + "<input type ='text' size='15' readonly class=tx value='"+docNo+"'></FONT>");
					if (dbcrInd.equals("-"))
					{
						myValues.put("DEBIT",fontColor + myFormat.getCurrencyString(lineItems.getFieldValueString(i,"Amount")) +"</FONT>&nbsp;");
						myValues.put("CREDIT","&nbsp;");
					}else{

						myValues.put("DEBIT","&nbsp;");
						myValues.put("CREDIT",fontColor + myFormat.getCurrencyString(lineItems.getFieldValueString(i,"Amount")) +"</FONT>&nbsp;");
					}
					if(balance<0)
					{
						myValues.put("BALANCE", "<font color='red'>" + myFormat.getCurrencyString(balance));
					}else{
						myValues.put("BALANCE", fontColor + myFormat.getCurrencyString(balance));
					}
					/// THE FOLLOWING IS THE CRUCIAL STEP IN CUMULATING THE VENDOR BALANCES.
					invoiceBal = balance;															
					myIndex.put(i+"",myValues);
				}				
			}
			
		}			
		
%>