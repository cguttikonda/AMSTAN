<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<%

	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retcat = null;
	ReturnObjFromRetrieve retsoldtoSU = null;
	ReturnObjFromRetrieve retSyskey=null;
	
	String busPartner = (String)session.getValue("BussPart");


	/********** Login user syskeys call **********/
	ezc.client.EzcUtilManager UtilManagerSA = new ezc.client.EzcUtilManager(Session);
	
	retSyskey = (ReturnObjFromRetrieve)UtilManagerSA.getUserCatalogAreas();	
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

	/*EzcUserParams uparams3= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams3 = new EzcUserNKParams();
	ezcUserNKParams3.setCatalog_Number(catalogNumber);

	String[] partFunctions = {"AG","VN"};
	ezcUserNKParams3.setPartnerFunctions(partFunctions);
	ezcUserNKParams3.setLanguage("EN");
	uparams3.setUserId(user_id);
	uparams3.createContainer();
	uparams3.setObject(ezcUserNKParams3);
	Session.prepareParams(uparams3);*/
	
	EzcBussPartnerParams bussparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bussNKParams = new EzcBussPartnerNKParams();
	bussparams.setBussPartner(busPartner);
	bussNKParams.setCatalog_Number("0");
	bussNKParams.setLanguage("EN");
	bussparams.createContainer();
	boolean flag = bussparams.setObject(bussNKParams);

	Session.prepareParams(bussparams);	

	ezc.ezcommon.EzLog4j.log("<<<retsoldtoSU>>>>>>>>>>>>>."+user_id,"I");

	//retsoldtoSU = (ReturnObjFromRetrieve)UserManager.getUserCustomers(bussparams);
	retsoldtoSU = (ReturnObjFromRetrieve)BPManager.getBussPartnerSoldTo(bussparams);
	
	//out.println("<<<retsoldtoSU>>>"+retsoldtoSU.toEzcString());

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
	String exclMat = "";
	
	//out.println("<<<retobj>>>"+retobj.toEzcString());
	
	if(retobj!=null)
	{
		for(int i=0;i<retobj.getRowCount();i++)
		{
			if("SUAUTH".equals(retobj.getFieldValueString(i,"EUD_KEY")))
			{
				suAuth = retobj.getFieldValueString(i,"EUD_VALUE");
			}
			if("EXCLUSIVE_MAT".equals(retobj.getFieldValueString(i,"EUD_KEY")))
			{
				exclMat = retobj.getFieldValueString(i,"EUD_VALUE");
			}
		}
	}
	//out.println("<<<suAuth>>>"+suAuth);
	//out.println("<<<exclMat>>>"+exclMat);
	
	/*************** Sub User Defaults - end **************/
	
	/*************** Sub User Authorizations - Start **************/
		
				
		EzcParams subUserRolesParamsMisc = new EzcParams(false);
		EziMiscParams subUserRolesParams = new EziMiscParams();

		ReturnObjFromRetrieve subUserRolesRetObj = null;

		subUserRolesParams.setIdenKey("MISC_SELECT");

		String queryDWN=
		"SELECT * from EZC_USER_AUTH "+
		" WHERE EUA_USER_ID='"+subUserId+"' ORDER by EUA_AUTH_KEY ";

		subUserRolesParams.setQuery(queryDWN);

		subUserRolesParamsMisc.setLocalStore("Y");
		subUserRolesParamsMisc.setObject(subUserRolesParams);
		Session.prepareParams(subUserRolesParamsMisc);	

		try
		{
			subUserRolesRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(subUserRolesParamsMisc);
		}
		catch(Exception e){}	
	
		Hashtable suAuthRolesHT = new Hashtable();
		
		if(subUserRolesRetObj!=null && subUserRolesRetObj.getRowCount()>0)
		{
			
			for(int rt=0;rt<subUserRolesRetObj.getRowCount();rt++){
				if (! suAuthRolesHT.containsKey(subUserRolesRetObj.getFieldValueString(rt,"EUA_AUTH_KEY"))){
					suAuthRolesHT.put(subUserRolesRetObj.getFieldValueString(rt,"EUA_AUTH_KEY"),subUserRolesRetObj.getFieldValueString(rt,"EUA_AUTH_VALUE"));
				}
			}
		}
	/*************** Sub User Defaults - end **************/
%>