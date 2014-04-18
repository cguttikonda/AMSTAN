<%
	String firstValue 	= (String)session.getValue("FIRST");
	String finalValue 	= (String)session.getValue("FINAL");
	 RQSTFROM 	= request.getParameter("RQSTFROM");	
	String actionList	= "";
	
	if("N".equals(finalValue))
		showSubmit = true;
	else	
		showSubmit = false;
		
	if("Y".equals(firstValue))
		showReject = false;
	else	
		showReject = true;			
	
	String currentPurchaseArea			=	(String)session.getValue("SYSKEY");
	java.util.Hashtable  purchaseGroupTempStore	= 	(java.util.Hashtable)session.getValue("PURGROUPS");
	String currentPurchaseGroup 			=  	(String)purchaseGroupTempStore.get(currentPurchaseArea);


	ezc.ezworkflow.client.EzWorkFlowManager workflowManager		= new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezparam.EzcParams workflowMainParams 			= new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionsParams  workflowActionParams 	= new ezc.ezworkflow.params.EziActionsParams();
	workflowActionParams.setFlag("Y");
	if("Y".equals(request.getParameter("ISDELEGATE")))
	{
		ezc.ezparam.ReturnObjFromRetrieve wfHierarchy =	getWFHierarchy(Session,currentPurchaseArea,newtemplet);
		for(int i=0;i<wfHierarchy.getRowCount();i++)
		{
			if("G".equals(participantType) && nextParticipant.equals(wfHierarchy.getFieldValueString(i,"OWNERPARTICIPANT")) && participantType.equals(wfHierarchy.getFieldValueString(i,"OPTYPE")))
			{
				workflowActionParams.setRole(wfHierarchy.getFieldValueString(i,"ROLE"));
				workflowActionParams.setUserId(wfHierarchy.getFieldValueString(i,"USER_ID"));
				break;
			}
			if("R".equals(participantType) && nextParticipant.equals(wfHierarchy.getFieldValueString(i,"ROLE")))
			{
				workflowActionParams.setRole(wfHierarchy.getFieldValueString(i,"ROLE"));
				workflowActionParams.setUserId(wfHierarchy.getFieldValueString(i,"USER_ID"));
				break;
			}
		}
	}
	else
	{
		workflowActionParams.setRole(wfRole);
		workflowActionParams.setUserId(Session.getUserId());
	}	
	workflowActionParams.setPurchaseGroup(currentPurchaseGroup);
	workflowActionParams.setAuthKey((String)hashOrderType.get(orderType));
	workflowActionParams.setValue(netOrderAmount);
	workflowMainParams.setObject(workflowActionParams);
	Session.prepareParams(workflowMainParams);
	ezc.ezparam.ReturnObjFromRetrieve workflowRetObj = (ezc.ezparam.ReturnObjFromRetrieve)workflowManager.getActionsList(workflowMainParams);		
	if(workflowRetObj != null)
	{
		actionList = workflowRetObj.getFieldValueString(0,"ACTIONS");
		if(actionList.indexOf("RELEASED") != -1)	
		{
			showRelease = true;
			showSubmit  = false;
		}	
		else	
		{
			showSubmit  = true;
			showRelease = false;
		}
	}	

%>