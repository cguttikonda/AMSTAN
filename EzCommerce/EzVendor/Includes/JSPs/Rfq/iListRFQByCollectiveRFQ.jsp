<%	
	int myRetCnt = 0;
	String matNumber = "";
	java.util.Hashtable proposedHash = new java.util.Hashtable();
	String collNo = request.getParameter("collectiveRFQNo");
	String urlFrom=request.getParameter("urlFrom");
	

	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezc.ezparam.ReturnObjFromRetrieve myRet = null;
	ezirfqheaderparams.setCollectiveRFQNo(collNo);	
	ezirfqheaderparams.setExt1("QCS");	
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	
	try
	{
		myRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting QCFs List:"+e);
	}
	
	java.util.Vector rfqVector = new java.util.Vector();
	if(myRet!=null)
	{
		myRetCnt =  myRet.getRowCount();
		for(int i=0;i<myRetCnt;i++)	
		{
			if(i==0)
				matNumber = myRet.getFieldValueString(i,"MATERIAL");
				
			if("Y".equals(myRet.getFieldValueString(i,"STATUS")))	
			{
				rfqVector.addElement(myRet.getFieldValueString(i,"RFQ_NO")); 
			}	
		}
	}
	
%>	