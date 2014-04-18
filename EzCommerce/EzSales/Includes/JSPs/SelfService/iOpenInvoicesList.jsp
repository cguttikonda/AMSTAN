<%
	ReturnObjFromRetrieve lineItems =null;
	ReturnObjFromRetrieve dlineItems =null;

	if(base!=null && !"null".equals(base) && !"".equals(base))
	{
		ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
		String billto=(String)session.getValue("DefBillTO");
		int invcount = 0;

		FormatDate formatDate = new FormatDate();

		ReturnObjFromRetrieve SeqInv = null;
		EzCustomerParams ioparams = new EzCustomerParams();


		ezc.customer.invoice.params.EzcCustomerInvoiceParams newParams=new ezc.customer.invoice.params.EzcCustomerInvoiceParams();
		EziCustomerInvoiceParams ecip = new EziCustomerInvoiceParams();

		ecip.setKeyDate(new Date());
		ecip.setInvFlag("O");
		ecip.setSelection(billto);//payer
		
		Date fromDate = null;
		Date toDate = null;
		fd="01/01/2006";
		td="04/15/2011";
		if(fd!=null && td!=null && !"null".equals(fd) && !"null".equals(td))
		{
			int ffy=Integer.parseInt(fd.substring(6,10))-1900;
			int ffd=Integer.parseInt(fd.substring(3,5));
			int ffm=Integer.parseInt(fd.substring(0,2))-1;
			int tty=Integer.parseInt(td.substring(6,10))-1900;
			int ttd=Integer.parseInt(td.substring(3,5));
			int ttm=Integer.parseInt(td.substring(0,2))-1;
			fromDate = new Date(ffy,ffm,ffd);
			toDate = new Date(tty,ttm,ttd);
			
		}
		else
		{
			fromDate = new Date(106,4,1);
			toDate = new Date(106,8,10);
		}
		
		log4j.log("fromDatefromDatefromDate:"+fromDate,"W");
		log4j.log("toDatetoDatetoDatetoDate:"+toDate,"W");
		
		ecip.setFromDate(fromDate);
		ecip.setToDate(toDate);
		
		newParams.createContainer();
		newParams.setObject(ioparams);
		newParams.setObject(ecip);
		Session.prepareParams(newParams);

		
		SeqInv = (ReturnObjFromRetrieve) SalesInvManager.getCustomerInvoices(newParams);
		lineItems = (ReturnObjFromRetrieve)SeqInv.getFieldValue("LINEITEMS");
                //ezc.ezcommon.EzLog4j.log("lineItems>>>>>>>>>>>>"+lineItems.toEzcString() ,"I");
                
		try{
			lineItems.sort(new String[]{"postingDate"},true);
		}catch(Exception e){}

		int rowno = 0;
		String custbillNum="",invNum="",delDocNo="",invAm="",pd="",bd="";
		double total=0;
		ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
		String  formatkey=(String)session.getValue("formatKey");	

		dlineItems=new ReturnObjFromRetrieve();
		String objColumns[]={"BILLINGDOCUMENTNO","SAPINVOICENO","DELIVERYDOCUMENTNO","INVOICEDATE","DUEDATE","INVOICEVALUE","CUSTOMERPONO"};
		dlineItems.addColumns(objColumns);

		if (lineItems!=null)
		{
			rowno = lineItems.getRowCount();
			for (int i= 0; i<rowno ; i++)
			{
				if("RV".equals(lineItems.getFieldValueString(i,"DocType")) )
				{
					Date postingDate= (Date)lineItems.getFieldValue(i,"PstngDate");
					Date blineDate	= (Date)lineItems.getFieldValue(i,"BlineDate");
					invNum 		= lineItems.getFieldValueString(i,"DocNo");
					custbillNum 	= lineItems.getFieldValueString(i,"RefDoc").trim();
					delDocNo 	= lineItems.getFieldValueString(i,"RefKey1").trim();
					invAm 		= lineItems.getFieldValueString(i,"Amount");
					
					String custPoNo = lineItems.getFieldValueString(i,"AllocNmbr");

					pd = formatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY);
					if(pd.length() != 10)
						pd = "&nbsp;";

					bd = formatDate.getStringFromDate(blineDate,formatkey,FormatDate.MMDDYYYY);
					if(bd.length() != 10)
						bd = "&nbsp;";

					dlineItems.setFieldValue("BILLINGDOCUMENTNO",custbillNum);
					dlineItems.setFieldValue("SAPINVOICENO",invNum);
					dlineItems.setFieldValue("DELIVERYDOCUMENTNO",delDocNo);
					dlineItems.setFieldValue("INVOICEDATE",FormatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY));
					dlineItems.setFieldValue("DUEDATE",formatDate.getStringFromDate(blineDate,formatkey,FormatDate.MMDDYYYY));
					dlineItems.setFieldValue("INVOICEVALUE",invAm);
					dlineItems.setFieldValue("CUSTOMERPONO",custPoNo);
					dlineItems.addRow();
					invcount++;
					total=total+Double.parseDouble(invAm);
				}	
			}
		}
		if(dlineItems!=null)
		{
			session.removeValue("InvoiceReturnObject");
			session.removeValue("InvoiceTotal");
		}
		if(dlineItems!=null && invcount>0)
		{
			session.putValue("InvoiceReturnObject",dlineItems);
			session.putValue("InvoiceTotal",myFormat.getCurrencyString(total));  
		}	
	}
	
%>