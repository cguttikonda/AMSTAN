<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>

<%
	
	int myRetCount=0;
	
	/*
	String sysKey = (String) session.getValue("SYSKEY");
	String soldTo = (String) session.getValue("SOLDTO");
	String userType =(String)session.getValue("UserType");*/
	
	/*
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	mainParams.setLocalStore("Y");	    
	ezc.ezvendorapp.params.EziPurchaseOrderParams iParams =  new ezc.ezvendorapp.params.EziPurchaseOrderParams();
	iParams.setSysKey(sysKey);
	if("3".equals(userType)){
		iParams.setDocStatus("N");
		iParams.setSoldTo(soldTo);
	}else{
		iParams.setDocStatus("K','M','N");
		iParams.setSoldTo(soldTo);
	}	

	mainParams.setObject(iParams);	
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams);
	
	if(ret != null)
	{
		myRetCount=ret.getRowCount();
		if(myRetCount > 0)
		{
			ret.sort(new String[]{"DOCDATE"},false);
		}
	}*/
	
	java.sql.Date FromDate=new java.sql.Date(106,1,1);
	ezc.ezparam.EzPurchHdrXML ret =null;
	ezc.client.EzPurchaseManager PoManager = new ezc.client.EzPurchaseManager();
	ezc.ezparam.EzPSIInputParameters iparams = new ezc.ezparam.EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams Params = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurchaseInputParams testParams = new ezc.ezpurchase.params.EziPurchaseInputParams();
	testParams.setSelectionFlag("O");
	testParams.setDocType("K");
	//testParams.setFromDate(FromDate);
	//testParams.setPurGroup(myPurGrp);
	//testParams.setPurOrg(myPurOrg);
	Params.createContainer();
	Params.setObject(iparams);
	Params.setObject(testParams);
	Session.prepareParams(Params);
	try{

		ret = (ezc.ezparam.EzPurchHdrXML)PoManager.ezPurchaseOrderList(Params);
		
		//out.println("ret===========>"+ret.toEzcString());

	}catch(Exception e){ }
	
	if(ret != null)
	{
		myRetCount=ret.getRowCount();
		if(myRetCount > 0)
		{
			ret.sort(new String[]{"ORDERDATE"},false);
		}
	}
		
		
	
	
	
	
	
%>
