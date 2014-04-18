<%!
	private ezc.ezparam.ReturnObjFromRetrieve getWFHierarchy(ezc.session.EzSession Session,String syskey,String template)
	{
		ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziOrganogramLevelsParams params= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
		params.setTemplate(template);
		params.setSysKey(syskey);
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsDetails(mainParams);
		return listRet;
	}	
	
	private String checkForQCF(ezc.session.EzSession Session,String vndrCodes,String fromDate,String toDate,String sysKey,String poNum)
	{
		ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
		ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
		ezirfqheaderparams.setSoldTo(vndrCodes);
		ezirfqheaderparams.setStatus("C");
		ezirfqheaderparams.setExt1("LINKAGEREPORT");	
		ezirfqheaderparams.setExt2(fromDate);	
		ezirfqheaderparams.setExt3(toDate);
		ezirfqheaderparams.setSysKey(sysKey);
		ezirfqheaderparams.setPOorCon("Y");
		ezirfqheaderparams.setPONo(poNum);
		ezcparams.setObject(ezirfqheaderparams);
		ezcparams.setLocalStore("Y");
		Session.prepareParams(ezcparams);
		ezc.ezparam.ReturnObjFromRetrieve myRet = null;
		try{
			myRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
		}catch(Exception ex){}	
		String poconQCFNumber = "N/A";
		if(myRet!=null)
		{
			int myRetCount = myRet.getRowCount();
			if(myRetCount > 0)
			{
				poconQCFNumber = myRet.getFieldValueString(0,"COLLETIVE_RFQ_NO");
			}
		}
		return poconQCFNumber;
	}
	
	private String getUserRole(ezc.session.EzSession Session,String participant)
	{
		ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlow = new ezc.ezworkflow.client.EzWorkFlowManager();
		String userRole = "";
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
		params.setUserId(participant);
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(mainParams);
		if(listRet != null)
		{
			userRole = listRet.getFieldValueString(0,"ROLE");
		}
		return userRole;
	}
	
	private String getDesiredValue(ezc.session.EzSession Session,String purchaseArea,String returnDefaultType)
	{
		String returnValue = "";
		try{
			ezc.client.EzSystemConfigManager esManager = new ezc.client.EzSystemConfigManager();
			ezc.ezparam.EzcSysConfigParams sparams1 = new ezc.ezparam.EzcSysConfigParams();
			ezc.ezparam.EzcSysConfigNKParams snkparams1 = new ezc.ezparam.EzcSysConfigNKParams();
			snkparams1.setLanguage("EN");
			snkparams1.setSystemKey(purchaseArea);
			snkparams1.setSiteNumber(200);
			sparams1.setObject(snkparams1);
			Session.prepareParams(sparams1);
			ezc.ezparam.ReturnObjFromRetrieve retdef = (ezc.ezparam.ReturnObjFromRetrieve)esManager.getCatAreaDefaults(sparams1);	
			if(retdef != null)
			{
				int defsCount = 0;
				defsCount = retdef.getRowCount();
				for(int i=0;i<defsCount;i++)
				{
					if(returnDefaultType.equals(retdef.getFieldValueString(i,"ECAD_KEY")))
					{
						returnValue = retdef.getFieldValueString(i,"ECAD_VALUE");
					}
				}
			}
		}catch(Exception ex){}
		return returnValue;
	}	
%>	