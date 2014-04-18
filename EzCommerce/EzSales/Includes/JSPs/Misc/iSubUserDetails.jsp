<%

	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retcat = null;
	ReturnObjFromRetrieve retsoldto = null;
	ReturnObjFromRetrieve retSyskey=null;


	/********** Login user syskeys call **********/
	
	if(session.getValue("CRI_CUST_SAS")!=null)
		retSyskey = (ReturnObjFromRetrieve)session.getValue("CRI_CUST_SAS");
	//out.println("<<<retSyskey>>>"+retSyskey.toEzcString());

	/********** Selected sub user details call **********/
	
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
	bNKParams.setLanguage("EN");
	bparams.createContainer();
	bparams.setObject(bNKParams);
	Session.prepareParams(bparams);

	EzcUserParams uparams= new EzcUserParams();
	uparams.setUserId(user_id);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	uparams.createContainer();
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);

	ret = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);

	//out.println("ret"+ret.toEzcString());

	retcat = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparams);
	String catalogNumber = retcat.getFieldValueString(0,"EPC_NO"); 
	String catalogName = retcat.getFieldValueString(0,"EPC_NAME");
	
	//out.println("retcat"+retcat.toEzcString());
	/********** Selected sub user syskeys call **********/

	EzcUserParams uparams3= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams3 = new EzcUserNKParams();
	ezcUserNKParams3.setCatalog_Number(catalogNumber);

	String[] partFunctions = {"AG","VN"};
	ezcUserNKParams3.setPartnerFunctions(partFunctions);
	ezcUserNKParams3.setLanguage("EN");
	uparams3.setUserId(user_id);
	uparams3.createContainer();
	uparams3.setObject(ezcUserNKParams3);
	Session.prepareParams(uparams3);

	ezc.ezcommon.EzLog4j.log("<<<retsoldto>>>>>>>>>>>>>."+user_id,"I");

	retsoldto = (ReturnObjFromRetrieve)UserManager.getUserCustomers(uparams3);
	
	//out.println("<<<retsoldto>>>"+retsoldto.toEzcString());

	/*************** Sub User Defaults - Start **************/
	
	String subUserId = ret.getFieldValueString(0,"EU_ID");
	
	ezc.ezparam.EzcUserParams uparams_UD = new ezc.ezparam.EzcUserParams();
	EzcUserNKParams ezcUserNKParams_UD = new EzcUserNKParams();
	ezcUserNKParams_UD.setLanguage("EN");
	ezcUserNKParams_UD.setSys_Key("0");
	uparams_UD.createContainer();
	uparams_UD.setUserId(subUserId);
	uparams_UD.setObject(ezcUserNKParams_UD);
	Session.prepareParams(uparams_UD);
	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UserManager.getAddUserDefaults(uparams_UD));

	String suAuth = "";
	
	//out.println("<<<retobj>>>"+retobj.toEzcString());
	
	if(retobj!=null)
	{
		for(int i=0;i<retobj.getRowCount();i++)
		{
			if("SUAUTH".equals(retobj.getFieldValueString(i,"EUD_KEY")))
			{
				suAuth = retobj.getFieldValueString(i,"EUD_VALUE");
			}
		}
	}
	//out.println("<<<suAuth>>>"+suAuth);
	
	/*************** Sub User Defaults - end **************/
%>