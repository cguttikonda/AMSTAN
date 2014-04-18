<%

	if(base!=null && !"null".equals(base) && !"".equals(base))
	{
		ReturnObjFromRetrieve SeqInv = null;
		EzCustomerParams ioparams = new EzCustomerParams();
		ezc.customer.invoice.params.EzcCustomerInvoiceParams newParams=new ezc.customer.invoice.params.EzcCustomerInvoiceParams();
		EziCustomerInvoiceParams ecip = new EziCustomerInvoiceParams();
		
		/*
		int ffy	= Integer.parseInt(fd.substring(6,10))-1900;
		int ffd	= Integer.parseInt(fd.substring(3,5));
		int ffm	= Integer.parseInt(fd.substring(0,2))-1;
		int tty	= Integer.parseInt(td.substring(6,10))-1900;
		int ttd	= Integer.parseInt(td.substring(3,5));
		int ttm	= Integer.parseInt(td.substring(0,2))-1;
		
		Date fromDate	= new Date(ffy,ffm,ffd);
		Date toDate 	= new Date(tty,ttm,ttd);
		*/
		
		Date fromDate = null;
		Date toDate = null;
		
		//Date toDay = new Date();
		
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
			fromDate = new Date(toDay.getYear(),4,1);
			toDate 	= new Date(toDay.getYear(),toDay.getMonth(),toDay.getDay());
		}		
		
	 	ecip.setFromDate(fromDate);
		ecip.setToDate(toDate);
		ecip.setInvFlag("C");
		ecip.setSelection(billto);
		ecip.setCustomer(billto);
		
		newParams.createContainer();
		newParams.setObject(ioparams);
		newParams.setObject(ecip);
		Session.prepareParams(newParams);
		SeqInv = (ReturnObjFromRetrieve) SalesInvManager.getCustomerInvoices(newParams);
		
		lineItems= (ReturnObjFromRetrieve)SeqInv.getFieldValue("LINEITEMS");
		lineItems.toEzcString();
		dlineItems=new ReturnObjFromRetrieve();
		String objColumns[]={"BILLINGDOCUMENTNO","SAPINVOICENO","DELIVERYDOCUMENTNO","CLEARDATE","INVOICEDATE","DUEDATE","INVOICEVALUE"};						
		dlineItems.addColumns(objColumns);
		
		if (lineItems!=null)
		{
			rowno = lineItems.getRowCount();
			int invcount = 0;
			if (rowno > 0)
			{
				
				String invNum = null;
				String custInvNum = null;
				String custbillNum=null;
				String invAm = null;
				Date postingDate=null;
				Date blineDate=null;
				Date clearDate=null;
				for (int i= 0; i<rowno ; i++)
				{


					postingDate	= (Date)lineItems.getFieldValue(i,"PstngDate");
					blineDate	= (Date)lineItems.getFieldValue(i,"BlineDate");
					invNum 		= lineItems.getFieldValueString(i,"DocNo");
					custInvNum 	= lineItems.getFieldValueString(i,"AllocNmbr").trim();
					custbillNum 	= lineItems.getFieldValueString(i,"RefDoc").trim();
					invAm 		= lineItems.getFieldValueString(i,"Amount");
					clearDate	= (Date)lineItems.getFieldValue(i,"ClearDate");
					
					dlineItems.setFieldValue("BILLINGDOCUMENTNO",custbillNum);
					dlineItems.setFieldValue("SAPINVOICENO",invNum);
					dlineItems.setFieldValue("DELIVERYDOCUMENTNO"," ");
					dlineItems.setFieldValue("INVOICEDATE",FormatDate.getStringFromDate(postingDate,forkey,FormatDate.MMDDYYYY));
					dlineItems.setFieldValue("CLEARDATE",FormatDate.getStringFromDate(clearDate,forkey,FormatDate.MMDDYYYY));
					dlineItems.setFieldValue("DUEDATE"," ");
					dlineItems.setFieldValue("INVOICEVALUE",invAm);
					dlineItems.addRow();
					total=total+Double.parseDouble(invAm);
				}
			}
		}
		
		if(dlineItems!=null)
		{
			session.removeValue("InvoiceReturnObject");
			session.removeValue("InvoiceTotal");
		}
		if(dlineItems!=null && dlineItems.getRowCount()>0)
		{
			session.putValue("InvoiceReturnObject",dlineItems);
			session.putValue("InvoiceTotal",total+"");
		}		
	}	
%>
