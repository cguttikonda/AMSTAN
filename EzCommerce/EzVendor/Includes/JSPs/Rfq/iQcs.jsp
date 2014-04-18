<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@include file="iListRFQByCollectiveRFQ.jsp"%>
<%
	String qcfNetPrice = "";
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	String colectiveNo= request.getParameter("collectiveRFQNo");
	String type = request.getParameter("Type");
	String isdelegate = request.getParameter("isdelegate");
	
	String sysKey=(String)session.getValue("SYSKEY");
	session.putValue("COLLECTIVERFQNO",colectiveNo);
	ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	mainParams.setLocalStore("Y");
	ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
	qcfParams.setQcfCode(colectiveNo);
	qcfParams.setQcfType("COMMENTS");
	qcfParams.setQcfExt1("$$");
	mainParams.setObject(qcfParams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve qcsRet = (ezc.ezparam.ReturnObjFromRetrieve)qcfManager.getMaxCommentNo(mainParams);
	
	String commentNo = "";
	if(qcsRet!= null || !"null".equals(qcsRet))
	{
		commentNo = qcsRet.getFieldValueString("COMMENT_NO");
		if(commentNo == "null" || "null".equals(commentNo))
			commentNo = "1";
	}		
	else
		commentNo = "1";
	
	qcsRet = (ezc.ezparam.ReturnObjFromRetrieve)qcfManager.getQcfCommentList(mainParams);
	int qcsCount = 0;
	if(qcsRet != null)
	{
		qcsCount = qcsRet.getRowCount();
	}	


	java.util.Hashtable ranksHash=new java.util.Hashtable();
	
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	
	JCO.Function function= EzSAPHandler.getFunction("Z_EZ_QCS");
	
	JCO.ParameterList impParams = function.getImportParameterList();
	impParams.setValue(colectiveNo,"CRFQNO");
	
	JCO.Client client = EzSAPHandler.getSAPConnection();
	client.execute(function);
	
	JCO.Table  intEkko 	= function.getTableParameterList().getTable("INT_EKKO");	//Purchase doc header...
	JCO.Table  intEkpo 	= function.getTableParameterList().getTable("INT_EKPO");	//Purchase doc items...
	JCO.Table  intKonv 	= function.getTableParameterList().getTable("INT_KONV");	//Conditions(item)......
	JCO.Table  intLFA1 	= function.getTableParameterList().getTable("INT_LFA1");	//Vendor Master........	
	JCO.Table  intT685T 	= function.getTableParameterList().getTable("INT_T685T");
	
	
	int totalQLines= intEkpo.getNumRows();
	
	Vector materails= new Vector();
	Vector conditions= new Vector();
	
	String headerCols [] = new String[] {"QUOTE_NO", "VENDOR_NO" ,"VENDOR_NAME","COND_NO" ,"LAND1","RANK"};
	String detailCols [] = new String[] {"QUOTE_NO", "MATNR","NETPR","NETVALUE","QTY","MATDESC"};
	String conCols 	  [] = new String[] {"CODE","DESC", "STEP","COUNTER" };
	String conValCols [] = new String[] {"COND_NO","KEY", "NET_VALUE" };
	String vendorCols [] = new String[] {"VENDOR_NO","NAME" };
	
	
	
	ezc.ezparam.ReturnObjFromRetrieve retHeader	= new ezc.ezparam.ReturnObjFromRetrieve(headerCols);
	ezc.ezparam.ReturnObjFromRetrieve retDetails	= new ezc.ezparam.ReturnObjFromRetrieve(detailCols);
	ezc.ezparam.ReturnObjFromRetrieve retConds	= new ezc.ezparam.ReturnObjFromRetrieve(conCols);
	ezc.ezparam.ReturnObjFromRetrieve retValues	= new ezc.ezparam.ReturnObjFromRetrieve(conValCols);
	ezc.ezparam.ReturnObjFromRetrieve retVendor	= new ezc.ezparam.ReturnObjFromRetrieve(vendorCols);
	
	String [] myFinalCols= null;
	ezc.ezparam.ReturnObjFromRetrieve myFinalRet=null;
	
	/*
		Quoted Vendors return obj...............
	*/
	
	do
	{
		retVendor.setFieldValue("VENDOR_NO", intLFA1.getString("LIFNR"));
		retVendor.setFieldValue("NAME",intLFA1.getString("NAME1") );
		retVendor.addRow();
	}
	
	while(intLFA1.nextRow());
	
	/*
		Quotation header return obj.............(For each vendor........)
	*/
	
	do
	{
		retHeader.setFieldValue("QUOTE_NO", intEkko.getString("EBELN"));
		retHeader.setFieldValue("VENDOR_NO",intEkko.getString("LIFNR") );
		for(int i=0;i<retVendor.getRowCount();i++)
		{
			if(retVendor.getFieldValueString(i,"VENDOR_NO").equals(intEkko.getString("LIFNR")))
			{
				retHeader.setFieldValue("VENDOR_NAME",retVendor.getFieldValueString("NAME") );	
				break;
			}		
		}
			
		retHeader.setFieldValue("COND_NO",intKonv.getString("KNUMH") );
		retHeader.addRow();
						
	}
	
	while(intEkko.nextRow());
	
	
	
	if(intEkko.getNumRows() != 0)
	{

		/*
			Quotation details for each vendor..........
		*/
		do
		{
			String matCode= intEkpo.getString("EMATN");
			retDetails.setFieldValue("QUOTE_NO",intEkpo.getString("EBELN"));
			retDetails.setFieldValue("MATDESC",intEkpo.getString("TXZ01"));
			retDetails.setFieldValue("MATNR",matCode);
			retDetails.setFieldValue("QTY",intEkpo.getString("KTMNG"));

			double netPrice= Double.parseDouble(intEkpo.getString("NETPR"));
			double netValue= Double.parseDouble(intEkpo.getString("EFFWR"));

			retDetails.setFieldValue("NETPR",new java.lang.Double(netPrice));
			retDetails.setFieldValue("NETVALUE",new java.lang.Double(netValue));
			retDetails.addRow();
			if( ! materails.contains(matCode))
			{
			    materails.add(matCode);					
			}

		}
		while(intEkpo.nextRow());
		
		
		/*
			Sort Quotation details by price.............
		*/
		retDetails.sort(new String[]{"NETPR"},true);
	
		
		/*
			Condition Hash table creation............
		*/
		Hashtable myCondDesc= new Hashtable();
		do
		{
			String condCode= intT685T.getString("KSCHL");
			if( ! myCondDesc.containsKey(condCode))
			{
			    myCondDesc.put(condCode, intT685T.getString("VTEXT"));

			}
		}
		while(intT685T.nextRow());
	
	
		/*
			To deside Net Value depends upon the condition key................
		*/
		double dummyDouble = 0;
		double basePrice = 0;
		double value = 0;
		do
		{


			retValues.setFieldValue("COND_NO",intKonv.getString("KNUMH"));
			retValues.setFieldValue("KEY",intKonv.getString("KSCHL"));

			String key = intKonv.getString("KSCHL");
			double qt = Double.parseDouble(retDetails.getFieldValueString("QTY"));
			if(key.equals("PB00"))
			{
				dummyDouble = Double.parseDouble(intKonv.getString("KBETR"));
				basePrice = dummyDouble * Double.parseDouble(retDetails.getFieldValueString("QTY")); 
				value = basePrice;
			}	
			else if(key.equals("RA01"))
			{

				String val = intKonv.getString("KBETR");
				if(val.indexOf("-")>0)
				{
				  val = val.substring(0,val.length()-1);
				}  
				double value1 = Double.parseDouble(val) / 10.0;			
				value = (value1*100)/(basePrice*qt); 
				value = value * qt;
			}	
			else if(key.equals("RB00") || key.equals("RC00"))
			{
				String val = intKonv.getString("KBETR");
				if(val.indexOf("-")>0)
				{
				  val = val.substring(0,1);
				}  
				double value1 = Double.parseDouble(val);
				value = value1 * qt;
			}
			else if(key.equals("FRC2") || key.equals("FRB2"))
			{
				value = Double.parseDouble(intKonv.getString("KBETR")) * qt;
			}
			else if(key.equals("ZHAD") || key.equals("ZHND"))
			{
				value = Double.parseDouble(intKonv.getString("KBETR"));
			}


			retValues.setFieldValue("NET_VALUE",new java.lang.Double(value));
			retValues.addRow();

		}
		
		while(intKonv.nextRow());
	
		/*
			Conditions return obj creation.................
		*/
		/*
		retConds.setFieldValue("CODE", "PB00");
		retConds.setFieldValue("DESC", "Basic Price");
		retConds.setFieldValue("STEP", "1");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
	
		retConds.setFieldValue("CODE", "ZAED");
		retConds.setFieldValue("DESC", "Excise Duty");
		retConds.setFieldValue("STEP", "2");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
	
	
		retConds.setFieldValue("CODE", "ZACS");
		retConds.setFieldValue("DESC", "Education Cess");
		retConds.setFieldValue("STEP", "3");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();


		retConds.setFieldValue("CODE", "ZATX");
		retConds.setFieldValue("DESC", "Salex Tax");
		retConds.setFieldValue("STEP", "4");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
		
		retConds.setFieldValue("CODE", "ZPAC");
		retConds.setFieldValue("DESC", "Packing & Forwarding");
		retConds.setFieldValue("STEP", "5");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();


		retConds.setFieldValue("CODE", "FRB2");
		retConds.setFieldValue("DESC", "Freight");
		retConds.setFieldValue("STEP", "6");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
	
		retConds.setFieldValue("CODE", "ZACF");
		retConds.setFieldValue("DESC", "C & f Charges");
		retConds.setFieldValue("STEP", "7");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();

		retConds.setFieldValue("CODE", "ZIN1");
		retConds.setFieldValue("DESC", "Insurance");
		retConds.setFieldValue("STEP", "8");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
		
		retConds.setFieldValue("CODE", "PTERMS");
		retConds.setFieldValue("DESC", "Payment Terms");
		retConds.setFieldValue("STEP", "9");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
		
		retConds.setFieldValue("CODE", "ZAOC");
		retConds.setFieldValue("DESC", "Interest adj. for Payment Terms");
		retConds.setFieldValue("STEP", "10");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();


		retConds.setFieldValue("CODE", "PBXX");
		retConds.setFieldValue("DESC", "CIF Price");
		retConds.setFieldValue("STEP", "11");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();


		retConds.setFieldValue("CODE", "ZACD");
		retConds.setFieldValue("DESC", "Custom Duties");
		retConds.setFieldValue("STEP", "12");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
	
		retConds.setFieldValue("CODE", "TEXT1");
		retConds.setFieldValue("DESC", "Diff. of Price in comp. with 120 days credit @6%");
		retConds.setFieldValue("STEP", "13");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
		
		retConds.setFieldValue("CODE", "TEXT2");
		retConds.setFieldValue("DESC", "Currency");
		retConds.setFieldValue("STEP", "14");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
		
		retConds.setFieldValue("CODE", "TEXT3");
		retConds.setFieldValue("DESC", "Total Price in Foreign Currency");
		retConds.setFieldValue("STEP", "15");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();


		retConds.setFieldValue("CODE", "TEXT4");
		retConds.setFieldValue("DESC", "Total Price in INR");
		retConds.setFieldValue("STEP", "16");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
	
		retConds.setFieldValue("CODE", "TEXT5");
		retConds.setFieldValue("DESC", "Exchange Rate / Basic CIF");
		retConds.setFieldValue("STEP", "17");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();

		retConds.setFieldValue("CODE", "TEXT6");
		retConds.setFieldValue("DESC", "CIF Value Lacs");
		retConds.setFieldValue("STEP", "18");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();

		retConds.setFieldValue("CODE", "TEXT7");
		retConds.setFieldValue("DESC", "Total Cust. Duty Excl. CVD (Lacs)");
		retConds.setFieldValue("STEP", "19");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();


		retConds.setFieldValue("CODE", "RC00");
		retConds.setFieldValue("DESC", "Discount");
		retConds.setFieldValue("STEP", "20");
		retConds.setFieldValue("COUNTER","1");
		retConds.addRow();
		*/
		
		if (client!=null)
		{
			JCO.releaseClient(client);
			client = null;
			function=null;
		}
	
		
		/*
			To deside the Rank of each vendor quotation ...
		*/
		for(int i=0;i<retDetails.getRowCount();i++)
		{

				for(int j=0;j<retHeader.getRowCount();j++)
				{
					if(retHeader.getFieldValueString(j,"QUOTE_NO").equals(retDetails.getFieldValueString(i,"QUOTE_NO")))
					{
						retHeader.setFieldValueAt("RANK", new java.lang.Integer(i+1),j);
						break;
					}


				}
		}
	
	
		int  totalQuotes=retHeader.getRowCount();

		retHeader.sort(new String[]{"RANK"},true);

		myFinalCols = new String[totalQuotes+2];
		myFinalCols[0]="CODE";
		myFinalCols[1]="DESC";

		for(int i=2;i<myFinalCols.length;i++)
		{
			myFinalCols[i]= "VAL" + (i-1);
		}
		myFinalRet= new ezc.ezparam.ReturnObjFromRetrieve(myFinalCols);
	
		for(int i=0;i<retConds.getRowCount();i++)
		{

			String tempCondCode= retConds.getFieldValueString(i, "CODE");
			String tempCondDesc= retConds.getFieldValueString(i, "DESC");
			String tempValue= null;

			String [] values= new String[totalQuotes];

			int myCounter=0;
			for(int j=0;j<retHeader.getRowCount();j++)
			{
				
				String tempNumber= retHeader.getFieldValueString(j,"COND_NO");
				for(int p=0;p<retValues.getRowCount();p++)
				{
					
					if(retValues.getFieldValueString(p,"KEY").equals(tempCondCode) && retValues.getFieldValueString(p,"COND_NO").equals(tempNumber))
					{
						if(!"0.0".equals(retValues.getFieldValueString(p,"NET_VALUE")))
						{
							values[myCounter] = retValues.getFieldValueString(p,"NET_VALUE");		
							break;
						}
					}		
					

				}

				myCounter++;

			}                         

			myFinalRet.setFieldValue("CODE",tempCondCode);
			myFinalRet.setFieldValue("DESC",tempCondDesc);
			for(int k=0;k<totalQuotes;k++)
			{

				myFinalRet.setFieldValue("VAL" + (k+1),values[k]);
			}
			myFinalRet.addRow();

		}
	}


	qcfNetPrice = myFormat.getCurrencyString(retDetails.getFieldValueString(0,"NETVALUE"))+"";
	
	ezc.ezworkflow.client.EzWorkFlowManager wfm = new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezworkflow.params.EziActionsParams  wfp = new ezc.ezworkflow.params.EziActionsParams();
	ezc.ezparam.EzcParams wfMainP = new ezc.ezparam.EzcParams(false);
	wfp.setFlag("Y");
	wfp.setRole((String)session.getValue("ROLE"));
	wfp.setAuthKey("QCF_RELEASE");
	wfp.setValue(qcfNetPrice);
	wfMainP.setObject(wfp);
	Session.prepareParams(wfMainP);
	ezc.ezparam.ReturnObjFromRetrieve wfr=(ezc.ezparam.ReturnObjFromRetrieve)wfm.getActionsList(wfMainP);
	String actionsList = "";
	if(wfr!=null)
	{
		actionsList = wfr.getFieldValueString(0,"ACTIONS");	
	}	
	System.out.println("----------------"+actionsList);
	
	
	
	
	ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	wfParams.setAuthKey("QCF_RELEASE");
	wfParams.setSysKey(sysKey);
	wfParams.setDocId(colectiveNo);
	wfParams.setSoldTo("0");
	wfMainParams.setObject(wfParams);
	Session.prepareParams(wfMainParams);
	ezc.ezparam.ReturnObjFromRetrieve wfDetailsRet=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getWFDocDetails(wfMainParams);	
	
	String initiator = "";
	if(wfDetailsRet!= null)
	{
		if(wfDetailsRet.getRowCount() > 0)
			initiator = wfDetailsRet.getFieldValueString(0,"INITIATOR");
	}
	String actionCheck = wfDetailsRet.getFieldValueString(wfDetailsRet.getRowCount()-1,"ACTION");
	
	//For knowing, Is there any attachments for a Collective RFQ Number?
	
	ezc.ezparam.ReturnObjFromRetrieve retUploadDocs = null;
	ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setObjectNo("'"+(String) session.getValue("SYSKEY")+"QCF"+colectiveNo+"'");
	myParams.setObject(uDocsParams);
	Session.prepareParams(myParams);
	try
	{
		retUploadDocs = (ezc.ezparam.ReturnObjFromRetrieve)uploadManager.getUploadedDocs(myParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting Upload docs:"+e);	
	}
	int noOfDocs = 0;
	if(retUploadDocs!= null)
	{
		noOfDocs = retUploadDocs.getRowCount();
	}
	
%>		