
<%	
	int retsldcnt = 0;
	String vndrCodes = (String)session.getValue("SOLDTOS");
		
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
	ezc.ezparam.ReturnObjFromRetrieve myRet = null;	
	
	if ((fromDate!=null)&&(toDate!=null))
	{
		ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
		ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
			
		String SysKey = (String)session.getValue("SYSKEY");
		String soldTo = (String)session.getValue("SOLDTO");	
		ezirfqheaderparams.setSoldTo(vndrCodes);
		ezirfqheaderparams.setStatus("C");
		ezirfqheaderparams.setExt1("LINKAGEREPORT");	
		ezirfqheaderparams.setExt2(fromDate);	
		ezirfqheaderparams.setExt3(toDate);
		ezirfqheaderparams.setSysKey(SysKey);
		ezcparams.setObject(ezirfqheaderparams);
		ezcparams.setLocalStore("Y");
		Session.prepareParams(ezcparams);
		
		try
		{
			myRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
		}
		catch(Exception e)
		{
			System.out.println("Exception Occured while getting RFQ List:"+e);
		}
	}	
	int Count= 0;
	if(myRet!=null)
		Count = myRet.getRowCount();
	if (fromDate == null)
		fromDate = "";
	if (toDate == null)
		toDate = "";	
			
%>	