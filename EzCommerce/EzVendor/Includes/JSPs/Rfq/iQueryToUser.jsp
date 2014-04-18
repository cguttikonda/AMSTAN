<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%!
	private String getUserName(ezc.session.EzSession Session,String participant,String participantType,String syskey)
	{
		ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlow = new ezc.ezworkflow.client.EzWorkFlowManager();
		String userName = "";
		if("G".equals(participantType))
		{
			ezc.ezworkflow.params.EziWorkGroupUsersParams wgParams = new ezc.ezworkflow.params.EziWorkGroupUsersParams();
			wgParams.setGroupId("'"+participant+"'");
			ezc.ezparam.EzcParams wgMainParams = new ezc.ezparam.EzcParams(false);
			wgMainParams.setObject(wgParams);
			Session.prepareParams(wgMainParams);
			ezc.ezparam.ReturnObjFromRetrieve wgRet =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupUsers(wgMainParams);
			if(syskey.equals(wgRet.getFieldValueString(0,"SYSKEY")))
			userName 	= wgRet.getFieldValueString(0,"USERID")+"¥"+wgRet.getFieldValueString(0,"FIRSTNAME")+" "+wgRet.getFieldValueString(0,"MIDDLENAME")+" "+wgRet.getFieldValueString(0,"LAST_NAME");
			for(int j=1;j<wgRet.getRowCount();j++)
			{
				if(syskey.equals(wgRet.getFieldValueString(j,"SYSKEY")))
				userName += "," + wgRet.getFieldValueString(j,"USERID")+"¥"+wgRet.getFieldValueString(j,"FIRSTNAME")+" "+wgRet.getFieldValueString(j,"MIDDLENAME")+" "+wgRet.getFieldValueString(j,"LAST_NAME");
			}
		}	
		if("R".equals(participantType))
		{
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
			params.setRoleNo("'"+participant+"'");
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(mainParams);
			if(listRet != null)
			{
				for(int i=0;i<listRet.getRowCount();i++)
				{
					String groupId = "'"+listRet.getFieldValueString(i,"GROUP_ID")+"'";
					ezc.ezworkflow.params.EziWorkGroupUsersParams wgParams = new ezc.ezworkflow.params.EziWorkGroupUsersParams();
					wgParams.setGroupId(groupId);
					ezc.ezparam.EzcParams wgMainParams = new ezc.ezparam.EzcParams(false);
					wgMainParams.setObject(wgParams);
					Session.prepareParams(wgMainParams);
					ezc.ezparam.ReturnObjFromRetrieve wgRet =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupUsers(wgMainParams);
					if(syskey.equals(wgRet.getFieldValueString(0,"SYSKEY")))
					userName 	= wgRet.getFieldValueString(0,"USERID")+"¥"+wgRet.getFieldValueString(0,"FIRSTNAME")+" "+wgRet.getFieldValueString(0,"MIDDLENAME")+" "+wgRet.getFieldValueString(0,"LAST_NAME");
					for(int j=1;j<wgRet.getRowCount();j++)
					{
						if(syskey.equals(wgRet.getFieldValueString(j,"SYSKEY")))
							userName += "," + wgRet.getFieldValueString(j,"USERID")+"¥"+wgRet.getFieldValueString(j,"FIRSTNAME")+" "+wgRet.getFieldValueString(j,"MIDDLENAME")+" "+wgRet.getFieldValueString(j,"LAST_NAME");
					}
				}	
			}
		}	
		return userName;
	}
%>
<%
	String tCode 		= (String)session.getValue("TEMPLATE");
	String userGroup 	= (String)session.getValue("USERGROUP");
	String userRole 	= (String)session.getValue("USERROLE");
	String sysKey 		= (String)session.getValue("SYSKEY");
	
	String userId		= (String)Session.getUserId();
	String owner = "",ownerType = "",selected="";
	int hashSize = 0,initCount=0;
	java.util.StringTokenizer stoken = null,stoken1=null;
	java.util.Hashtable userHash = new java.util.Hashtable();
	/*
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams params= new ezc.ezworkflow.params.EziTemplateStepsParams();
	params.setCode(tCode);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retRoles=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams);
	*/
	ezc.ezparam.ReturnObjFromRetrieve retRoles = getWFHierarchy(Session,sysKey,tCode);
	
	int stepCount = 0;
	if(retRoles != null)
	{
		
		retRoles.sort(new String[]{"STEP"},true);
		
		stepCount = retRoles.getRowCount();
		int counter = 0;
		for(int i=0;i<stepCount;i++)
		{
			owner 		= retRoles.getFieldValueString(i,"OWNERPARTICIPANT");
			ownerType	= retRoles.getFieldValueString(i,"OPTYPE");
			if(userGroup.equals(owner) || userRole.equals(owner) || userId.equals(owner))
			{
				break;
			}
			else
			{
				try{
					owner = getUserName(Session,owner,ownerType,(String)session.getValue("SYSKEY"));
					if(owner.indexOf(",") != -1)
					{
						stoken 		= new java.util.StringTokenizer(owner,",");
						while(stoken.hasMoreElements())
						{
							owner 		= stoken.nextToken();
							stoken1 	= new java.util.StringTokenizer(owner,"¥");
							owner 		= stoken1.nextToken();
							ownerType 	= stoken1.nextToken();
							userHash.put(counter+"",owner+"¥"+ownerType);
							counter++;
						}	
					}
					else
					{
						stoken1 	= new java.util.StringTokenizer(owner,"¥");
						owner 		= stoken1.nextToken();
						ownerType 	= stoken1.nextToken();
						userHash.put(counter+"",owner+"¥"+ownerType);
						counter++;
					}
				}
				catch(Exception ex){userHash.put("-","-");}
			}
		}
	}
	hashSize = userHash.size();
%>	
