<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	String conditionId = request.getParameter("chk1");
	String canByPassString = "";
	boolean showExtra = false;

	String firstExtraHeader = "";
	String firstExtraData = "";
	String secondExtraHeader = "";
	String secondExtraData = "";

	ezc.ezparam.ReturnObjFromRetrieve detailsRet=null;
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziRoleConditionsParams detailsParams= new ezc.ezworkflow.params.EziRoleConditionsParams();
	detailsParams.setConditionId(conditionId);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	try
	{
		detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getConditionDetails(detailsMainParams);
		if(detailsRet != null)
		{
			if("100001".equals(detailsRet.getFieldValueString("DOC_NO")))
			{
				showExtra = true;
				firstExtraHeader	= "Created By";
				secondExtraHeader 	= "Can ByPass";
				
				ezc.ezparam.EzcParams bypassMainParams = new ezc.ezparam.EzcParams(false);
				ezc.ezworkflow.params.EziByPassInfoParams byPassInfoParams=new ezc.ezworkflow.params.EziByPassInfoParams();
				byPassInfoParams.setConditionId(conditionId);
				bypassMainParams.setObject(byPassInfoParams);
				Session.prepareParams(bypassMainParams);
				ezc.ezparam.ReturnObjFromRetrieve bypassRet = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getByPassList(bypassMainParams);
				
				if(bypassRet != null) 
				{
					int sourceStep = Integer.parseInt(bypassRet.getFieldValueString("SOURCE_LEVEL"));
					int destStep   = Integer.parseInt(bypassRet.getFieldValueString("DEST_LEVEL"));
					
					ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
					ezc.ezworkflow.params.EziTemplateStepsParams params= new ezc.ezworkflow.params.EziTemplateStepsParams();
					params.setCode("111111");
					mainParams.setObject(params);
					Session.prepareParams(mainParams);
					ezc.ezparam.ReturnObjFromRetrieve retRoles=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams);
					//retRoles.sort(new String[]{"STEP"},false);
					for(int j=retRoles.getRowCount()-1;j>=0;j--)
					{
						int templateStep = Integer.parseInt(retRoles.getFieldValueString(j,"STEP"));
						if(templateStep == sourceStep)
						{
							firstExtraData 		= retRoles.getFieldValueString(j,"OWNERPARTICIPANT");
						}	
						if(templateStep <= sourceStep || templateStep >destStep)
							retRoles.deleteRow(j);
						else if(templateStep != sourceStep)
							secondExtraData = retRoles.getFieldValueString(j,"ROLE")+"<Br>"+secondExtraData;
					}
				}
			}
			if("100002".equals(detailsRet.getFieldValueString("DOC_NO")))
			{
				showExtra = true;
				firstExtraHeader	= "Delegator";
				secondExtraHeader 	= "Delegated To";
				
				ezc.ezparam.EzcParams delMainParams = new ezc.ezparam.EzcParams(false);
				ezc.ezworkflow.params.EziDelegateApproverParams delInfoParams=new ezc.ezworkflow.params.EziDelegateApproverParams();
				delInfoParams.setConditionId(conditionId);
				delMainParams.setObject(delInfoParams);
				Session.prepareParams(delMainParams);
				ezc.ezparam.ReturnObjFromRetrieve delAppRet = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.ezGetDelegateApproversList(delMainParams);
				delAppRet.toEzcString();
				if(delAppRet != null)
				{
					firstExtraData	=	delAppRet.getFieldValueString("SOURCE_PARTICIPANT");
					secondExtraData	=	delAppRet.getFieldValueString("DEST_PARTICIPANT");
				}	
			}
			
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured in iEditConditionDetails.jsp"+e);
	}

%>
