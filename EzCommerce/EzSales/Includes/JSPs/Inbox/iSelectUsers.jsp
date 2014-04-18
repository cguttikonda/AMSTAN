<%
	
	ReturnObjFromRetrieve retUser = null;
	String language = "EN";
	String client = "200";
	EzcUserParams uparams= new EzcUserParams();
	Session.prepareParams(uparams);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	uparams.createContainer();
	boolean result_flag = uparams.setObject(ezcUserNKParams);
	retUser = (ReturnObjFromRetrieve)UserManager.getBussPartnerUsers(uparams);

	ezc.client.EzcPurchaseUtilManager utilManager = new ezc.client.EzcPurchaseUtilManager(Session);
	String currSysKey = utilManager.getDefaultPurArea();
	String defErpVendor = utilManager.getUserDefErpVendor();


	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	//String defErpSoldTo = (String) UtilManager.getUserDefErpSoldTo();
	
%>