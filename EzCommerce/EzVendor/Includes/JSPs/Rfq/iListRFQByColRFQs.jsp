
<%	
	int myRetCnt1 = 0;
	String rfqs = request.getParameter("collectiveRFQNo");
	int cc=0;
	java.util.StringTokenizer stk = new  java.util.StringTokenizer(rfqs,"$");

	try
	{
		while(stk.hasMoreTokens())
		{
			stk.nextToken();
			cc++;
		}
	}
	catch(Exception e)
	{
		System.out.println("COUNT@@@@@@@@@@@@@3"+e);
	}
	
	String[] collRfqNo = new String[cc];//request.getParameterValues("collectiveRFQNo");
	
	java.util.StringTokenizer stk1 = new  java.util.StringTokenizer(rfqs,"$");
	int indx = 0;
	try
	{
		while(stk1.hasMoreTokens())
		{
			collRfqNo[indx]= stk1.nextToken();
			indx++;
		}
	}
	catch(Exception e)
	{
		System.out.println("COUNT@@@@@@@@@@@@@3"+e);
	}
	
	
	String colNums = "";
	
	for(int c=0;c<collRfqNo.length;c++)
	{
		if(c==0)
			colNums = collRfqNo[c];
		else	
			colNums = colNums+"#"+collRfqNo[c];
	}
	

	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	
	ezc.ezparam.ReturnObjFromRetrieve[] collRfqRet = new ezc.ezparam.ReturnObjFromRetrieve[collRfqNo.length];	
	
	for(int i=0;i<collRfqNo.length;i++)
	{
		ezirfqheaderparams.setCollectiveRFQNo(collRfqNo[i]);	
		ezirfqheaderparams.setExt1("QCS");
		ezirfqheaderparams.setStatus("C");
		ezcparams.setObject(ezirfqheaderparams);
		ezcparams.setLocalStore("Y");
		Session.prepareParams(ezcparams);

		try
		{
			collRfqRet[i] = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
		}
		catch(Exception e)
		{
			System.out.println("Exception Occured while getting QCFs List:"+e);
		}
	}
	

	java.util.Set notCommonVendors = new java.util.HashSet();
	java.util.Set commonVendors = new java.util.HashSet();
	java.util.Set rfqNumbers = new java.util.HashSet();
		
	
	//The following For loop for getting common vendors in selected qcfs.
	
	for(int fndCmnVndrs=0;fndCmnVndrs<collRfqNo.length;fndCmnVndrs++)
	{
		for(int k=0;k<collRfqRet[fndCmnVndrs].getRowCount();k++)
		{
			if(("R".equals(collRfqRet[fndCmnVndrs].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
			{
				boolean b = notCommonVendors.add(collRfqRet[fndCmnVndrs].getFieldValueString(k,"VENDOR")+"#"+collRfqRet[fndCmnVndrs].getFieldValueString(k,"PLANT"));
				if(!b)
				{
					commonVendors.add(collRfqRet[fndCmnVndrs].getFieldValueString(k,"VENDOR")+"#"+collRfqRet[fndCmnVndrs].getFieldValueString(k,"PLANT"));
					rfqNumbers.add(collRfqRet[fndCmnVndrs].getFieldValueString(k,"RFQ_NO"));
				}
			}
		}
		
	}
	
	//The following For loop for getting common vendors count.
	
	int cmnVendorCnt = 0;
	for(int clRfq=0;clRfq<collRfqNo.length;clRfq++)
	{
		for(int k=0;k<collRfqRet[clRfq].getRowCount();k++)
		{

			if(commonVendors.contains(collRfqRet[clRfq].getFieldValueString(k,"VENDOR")+"#"+collRfqRet[clRfq].getFieldValueString(k,"PLANT")));
			{
				cmnVendorCnt++;
			}
		}

	}
	
	//The following Code for filling cmnVndrsRetObj for common vendors display.
	
	String[] cmnVndrRfqs = new String[cmnVendorCnt]; 
	String[] cmnVndrData = new String[cmnVendorCnt];
	String[] cmnCmnVndr = new String[cmnVendorCnt];
	
	int cntForCmnVendRet = 0;
	for(int a=0;a<collRfqNo.length;a++)
	{
		for(int k=0;k<collRfqRet[a].getRowCount();k++)
		{
			if(("R".equals(collRfqRet[a].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
			{
				if(commonVendors.contains(collRfqRet[a].getFieldValueString(k,"VENDOR")+"#"+collRfqRet[a].getFieldValueString(k,"PLANT")));
				{
					cmnVndrRfqs[cntForCmnVendRet] = collRfqRet[a].getFieldValueString(k,"RFQ_NO");
					cmnCmnVndr[cntForCmnVendRet] = collRfqRet[a].getFieldValueString(k,"VENDOR");
					cmnVndrData[cntForCmnVendRet] =collRfqRet[a].getFieldValueString(k,"VENDOR")+"##"+collRfqRet[a].getFieldValueString(k,"MATERIAL")+"##"+collRfqRet[a].getFieldValueString(k,"UOM")+"##"+collRfqRet[a].getFieldValueString(k,"PLANT")+"##"+collRfqRet[a].getFieldValueString(k,"PRICE")+"##"+collRfqRet[a].getFieldValueString(k,"RFQ_NO");
					cntForCmnVendRet++;
				}
			}
		}

	}
		
	String[] fieldNames = {"RFQ_NOs","VENDOR","RFQ_DATA"};
	ezc.ezparam.ReturnObjFromRetrieve cmnVndrsRetObj = new ezc.ezparam.ReturnObjFromRetrieve(fieldNames);
	
	int vndrCnt = 0;
		
	for(int b=0;b<collRfqNo.length;b++)
	{
		for(int k=0;k<collRfqRet[b].getRowCount();k++)
		{
			if(("R".equals(collRfqRet[b].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
			{
				if(commonVendors.contains(collRfqRet[b].getFieldValueString(k,"VENDOR")+"#"+collRfqRet[b].getFieldValueString(k,"PLANT")));
				{
					cmnVndrsRetObj.setFieldValue("RFQ_NOs",cmnVndrRfqs[vndrCnt]);
					cmnVndrsRetObj.setFieldValue("VENDOR",cmnCmnVndr[vndrCnt]);
					cmnVndrsRetObj.setFieldValue("RFQ_DATA",cmnVndrData[vndrCnt]);
					cmnVndrsRetObj.addRow();
					vndrCnt++;
				}
			}
		}
	
	}

	
%>	