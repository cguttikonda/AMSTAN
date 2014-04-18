<%

	String soldTo = request.getParameter("soldTo");
	String upd = request.getParameter("upd");
	int custCatCnt = 0;
	ReturnObjFromRetrieve retCustCat = null;
	String noDataStatement = "";
	java.util.ArrayList selCustCat = new java.util.ArrayList();
	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0;


	int soldToCnt=0;
	ArrayList desiredSteps=new ArrayList();
	desiredSteps.add("1");
	ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
	paramsu.setTemplate((String)session.getValue("Templet"));
	paramsu.setSyskey((String)session.getValue("SalesAreaCode"));
	paramsu.setPartnerFunction("AG");
	paramsu.setParticipant((String)session.getValue("UserGroup"));
	paramsu.setDesiredSteps(desiredSteps);
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	ezc.ezparam.ReturnObjFromRetrieve retSoldTo =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
	if(retSoldTo!=null && retSoldTo.getRowCount()>0)
		soldToCnt = retSoldTo.getRowCount();

	String logInUserId	= Session.getUserId();
	
	String userId="",bPart="";
	java.util.ArrayList bpAuth = new java.util.ArrayList();
	mainParamsu = new ezc.ezparam.EzcParams(false);
	paramsu = new ezc.ezworkflow.params.EziWFParams();
	paramsu.setTemplate((String)session.getValue("Templet"));
	paramsu.setSyskey((String)session.getValue("SalesAreaCode"));
	paramsu.setParticipant((String)session.getValue("UserGroup"));
	paramsu.setDesiredSteps(desiredSteps);
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	
	ReturnObjFromRetrieve retsoldtoUid = (ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
	if(retsoldtoUid!=null)
	{
		for(int k=0;k<retsoldtoUid.getRowCount();k++)
		{
			userId = retsoldtoUid.getFieldValueString(k,"EU_ID");
			bPart = retsoldtoUid.getFieldValueString(k,"EU_BUSINESS_PARTNER");
			
			ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setSys_Key("0");
			uparams.createContainer();
			uparams.setUserId(userId);
			uparams.setObject(ezcUserNKParams);
			Session.prepareParams(uparams);
			ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));
			if(retobj!=null)
			{
				String isSubUser = "";
				String ecadVal = "";
			
				for(int j=0;j<retobj.getRowCount();j++)
				{
					if("ISSUBUSER".equals(retobj.getFieldValueString(j,"EUD_KEY")))
					{
						isSubUser = retobj.getFieldValueString(j,"EUD_VALUE");
					}
					if("SALESREPRES".equals(retobj.getFieldValueString(j,"EUD_KEY")))
					{
						ecadVal = retobj.getFieldValueString(j,"EUD_VALUE");
					}
					if(!"Y".equals(isSubUser))
					{
						try
						{
							StringTokenizer stEcadVal = new StringTokenizer(ecadVal,"¥");

							while(stEcadVal.hasMoreTokens())
							{
								String salesRep_A = (String)stEcadVal.nextElement();
								String salesRep_AId = salesRep_A.split("¤")[0];

								if(logInUserId.equalsIgnoreCase(salesRep_AId.trim()))
								{
									bpAuth.add(bPart);
								}
							}
						}
						catch(Exception e){}
					}
				}
			}			
		}
	}
	for(int i=soldToCnt-1;i>=0;i--)
	{
		String bPartner=retSoldTo.getFieldValueString(i,"EC_BUSINESS_PARTNER");
		if(!bpAuth.contains(bPartner))
			retSoldTo.deleteRow(i);
	}
	if(retSoldTo!=null)
		soldToCnt = retSoldTo.getRowCount();

	if(soldTo!=null)
	{
	
		EzcParams ezcpparams = new EzcParams(true);
		EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
		cnetParams.setQuery("order by cds_Cat.CatID");
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);

		retCat = (ReturnObjFromRetrieve)CnetManager.ezGetCnetCategories(ezcpparams);
		//log4j.log("retCat>>>>"+retCat.toEzcString(),"I");
		if(retCat!=null)
			retCatCnt = retCat.getRowCount();
	

		
		EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
		EzCustomerItemCatParams ecic = new EzCustomerItemCatParams();
		
		catalogParams.setType("GET_CUST");
		ecic.setSoldTo(soldTo);
		catalogParams.setLocalStore("Y");
		catalogParams.setObject(ecic);
		Session.prepareParams(catalogParams);
		
		retCustCat =(ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParams);
		
		if(retCustCat!=null && retCustCat.getRowCount()>0)
		{
			custCatCnt = retCustCat.getRowCount();
			for(int k=0;k<custCatCnt;k++)
			{
				selCustCat.add(retCustCat.getFieldValueString(k,"ECI_ITEMCAT"));
			}
		}
	}
%>