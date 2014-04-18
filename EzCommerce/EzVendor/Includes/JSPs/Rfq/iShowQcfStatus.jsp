<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../Misc/iGetUserName.jsp" %>
<%@ include file="../Misc/iWFMethods.jsp" %>
<%
	String tCode		= (String)session.getValue("TEMPLATE");	
	String sessionRole 	= (String)session.getValue("ROLE");
	String syskey 		= (String)session.getValue("SYSKEY");
	String loginType 	= "";
	if(request.getParameter("loginType") != null)
		loginType = request.getParameter("loginType");
	
	String auth_key = "QCF_RELEASE";
	String docDesc = "QCF";
	
	String collectiveRfqNo 	= "0";
	String statusMessage	= "";	
	String createdBy 	= "";
	String currentStatus 	= "";
	String actionBy 	= "";
	String toAct		= "";
	String qcfNetPrice	= "";
	String actionsList 	= "";
	boolean checkStatus	= false;
	String finalApprover 	= "";
	String appRole		= "";
	String appDesc		= "";
	String appFont		= "";
	String userName		= "";
	String soldto = "0";
	ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
	
	if(request.getParameter("COLNO") != null)
		collectiveRfqNo 	= 	request.getParameter("COLNO");
	if(request.getParameter("NETPR") != null)
		qcfNetPrice 		= 	request.getParameter("NETPR");
	if(request.getParameter("AUTH") != null)
	{
		if("PO".equals(request.getParameter("AUTH")))
		{
			auth_key = "PO_RELEASE";		
			docDesc = "Purchase Order";
		}	
		if("CON".equals(request.getParameter("AUTH"))) 
		{
			auth_key = "CON_RELEASE";			
			docDesc = "Contract";
		}	
	}	
	if(request.getParameter("SOLDTO") != null)
	{
		soldto = request.getParameter("SOLDTO");			
	}
	
		
	if("Y".equals(loginType))
	{
		java.util.Hashtable collSysHash=(java.util.Hashtable)session.getValue("COLLSYSKEY");
		syskey   = (String)collSysHash.get(collectiveRfqNo);
		java.util.Hashtable sysKeyTemp=(java.util.Hashtable)session.getValue("SYSKEYTEMPLATE");
		tCode = (String)sysKeyTemp.get(syskey);
	}		
		
		
	
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	

	ezc.ezparam.ReturnObjFromRetrieve retRoles = getWFHierarchy(Session,syskey,tCode);
	
	String sysKey		=	(String)session.getValue("SYSKEY");
	java.util.Hashtable  purGroupsHash	= (java.util.Hashtable)session.getValue("PURGROUPS");
	String currentPurchaseGroup =  (String)purGroupsHash.get(sysKey);
	
	retRoles.sort(new String[]{"STEP"},true);
	
	ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();	
	
	
	//System.out.println("CHECKLIST");
	
	ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	wfParams.setAuthKey(auth_key);
	wfParams.setSysKey(sysKey);
	wfParams.setDocId(collectiveRfqNo);
	wfParams.setSoldTo(soldto);
	wfMainParams.setObject(wfParams);
	Session.prepareParams(wfMainParams);
	ezc.ezparam.ReturnObjFromRetrieve wfDetailsRet=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getWFDocDetails(wfMainParams);	
	int wfCount = 0;
	java.util.Hashtable approvedHash = new java.util.Hashtable();
	if(wfDetailsRet != null)
	{
		wfCount 	= wfDetailsRet.getRowCount();
		if(wfCount > 0)
		{
			createdBy 	= wfDetailsRet.getFieldValueString(wfCount-1,"CREATEDBY");
			currentStatus 	= wfDetailsRet.getFieldValueString(wfCount-1,"STATUS");
			java.util.Date stsDate	= (java.util.Date)wfDetailsRet.getFieldValue(wfCount-1,"ACTIONON");
			String statusDate = fD.getStringFromDate(stsDate,".",fD.DDMMYYYY);
			//statusDate 	= fd.getStringFromDate(statusDate,".",ezc.ezutil.FormatDate.DDMMYYYY)+"";
			actionBy	= wfDetailsRet.getFieldValueString(wfCount-1,"ACTIONBY");
			toAct		= wfDetailsRet.getFieldValueString(wfCount-1,"NEXTPARTICIPANT");
			
			
			if("SUBMITTED".equals(currentStatus))
				currentStatus = "QCF Submitted by "+getUserName(Session,actionBy,"U",(String)session.getValue("SYSKEY"))+" on "+statusDate;
			if("APPROVED".equals(currentStatus.trim()))
			{
				currentStatus = "QCF Approved by "+actionBy+" on "+statusDate;
				toAct = "&nbsp;";
			}
			else
			{
				int counter = 0;
				String font = "";
				String roleToCheck = "";
				boolean checkRoleCon=true; 
				String userId = "";
				for(int i=0;i<retRoles.getRowCount();i++)
				{
					roleToCheck = retRoles.getFieldValueString(i,"ROLE");
					userId = getUserName(Session,retRoles.getFieldValueString(i,"OWNERPARTICIPANT"),retRoles.getFieldValueString(i,"OPTYPE")+"¥ID",(String)session.getValue("SYSKEY"));

					actionsList = "";
					ezc.ezworkflow.client.EzWorkFlowManager ezActionManager = new ezc.ezworkflow.client.EzWorkFlowManager();
					ezc.ezworkflow.params.EziActionsParams  wfp = new ezc.ezworkflow.params.EziActionsParams();
					ezc.ezparam.EzcParams wfMainP = new ezc.ezparam.EzcParams(false);
					wfp.setFlag("Y");
					wfp.setRole(roleToCheck);
					wfp.setValue(qcfNetPrice);
					wfp.setAuthKey(auth_key);
					wfp.setUserId(userId);
					wfp.setPurchaseGroup(currentPurchaseGroup);
					wfMainP.setObject(wfp);
					Session.prepareParams(wfMainP);
					ezc.ezparam.ReturnObjFromRetrieve wfr=(ezc.ezparam.ReturnObjFromRetrieve)ezActionManager.getActionsList(wfMainP);

					if(wfr!=null)
					{
						actionsList = wfr.getFieldValueString(0,"ACTIONS");
						userName = getUserName(Session,retRoles.getFieldValueString(i,"OWNERPARTICIPANT"),retRoles.getFieldValueString(i,"OPTYPE"),(String)session.getValue("SYSKEY"));
						//if(i == 0)
						//{
							if(userName.startsWith("<BR>"))
								userName = userName.substring(4);
						//}						
						if(actionsList.indexOf("APPROVED") > 0 && checkRoleCon && "QCF_RELEASE".equals(auth_key))
						{
							finalApprover = userName;
							checkRoleCon = false;
						}	
						else if(actionsList.indexOf("RELEASED") > 0 && checkRoleCon && ("PO_RELEASE".equals(auth_key) || "CON_RELEASE".equals(auth_key)))
						{
							finalApprover = userName;
							checkRoleCon = false;
						}	

						if(!approvedHash.contains(retRoles.getFieldValueString(i,"ROLE")))
						{
							System.out.println(toAct+":"+retRoles.getFieldValueString(i,"ROLE"));
							if((toAct).equals(retRoles.getFieldValueString(i,"OWNERPARTICIPANT")))
								font = "Y";
							else
								font = "N";
							if(!"VIEWROLE".equals(retRoles.getFieldValueString(i,"ROLE")))
								approvedHash.put(""+i,retRoles.getFieldValueString(i,"ROLE")+"¥"+(i+1)+"."+userName+"¥"+font);
							counter++;
						}	
					}	
				}				
			}
			if("REJECTED".equals(currentStatus))
				currentStatus = docDesc+" Rejected by "+actionBy+" on "+statusDate;
		}
	}	
%>
