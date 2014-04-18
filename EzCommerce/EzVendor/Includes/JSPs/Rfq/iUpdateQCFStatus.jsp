<%@ page import = "ezc.ezworkflow.params.EziWFDocHistoryParams,ezc.ezworkflow.params.EziWFParams" %>
<jsp:useBean id="EzWorkFlow" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" /> 
	
<%	

	String sessionRole	=	(String)session.getValue("ROLE");
	String userRole 	= 	(String)session.getValue("USERROLE");	
	String template		=	(String)session.getValue("TEMPLATE");
	String userGroup	=	(String)session.getValue("USERGROUP");
	String action		=	request.getParameter("actionNum");
	String quantity		=	request.getParameter("quantity");
	String prevStatus 	= 	request.getParameter("prevStatus");
	String nextPart 	= 	request.getParameter("nextPart");
	String rejectToUser 	= 	request.getParameter("rejectToUser");
  String totAPPQCFVal 	= 	request.getParameter("totAPPQCFVal");
  String totAPPQCFQty 	= 	request.getParameter("totAPPQCFQty");
  String totAPPQCFUOM 	= 	request.getParameter("totAPPQCFUOM");
  
  
  
  
  
	if(rejectToUser != null)
		rejectToUser = rejectToUser.trim();
	String userId 		=	Session.getUserId();
	
	String reqTemplate = request.getParameter("templateVal");
	
	if("".equals(reqTemplate) || reqTemplate == null || "null".equals(reqTemplate))
		reqTemplate = template;
	if("".equals(nextPart) || nextPart == null || "null".equals(nextPart))
		nextPart = userGroup;
		
		
	String refString	=	isByPass+"#"+byPassCount;
	String dispMessage = "",msgText	= "",msgSubject	= "",sendToUser	= "",partType = "",delPart = "";
    	String delPartType = "",status = "",actionCode = "",lnk ="",roleL = "",sysKeyL = "";
	String templateL = "",participantL = "",userGroupL  = "";
	
	
	ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams eziWfparams = new ezc.ezworkflow.params.EziWFParams();
	ezc.ezworkflow.params.EziWFDocHistoryParams eziWfDocHis =new ezc.ezworkflow.params.EziWFDocHistoryParams();
	eziWfparams.setUserId(quantity);
	eziWfparams.setRole(sessionRole);
	eziWfDocHis.setSysKey(sysKey);
	eziWfDocHis.setDocId(qcfNum);
	eziWfDocHis.setStatus(prevStatus);
	eziWfDocHis.setTemplateCode(reqTemplate);
	eziWfDocHis.setAuthKey("QCF_RELEASE");
	eziWfparams.setParticipant(nextPart);
	eziWfDocHis.setParticipant(nextPart);
	eziWfDocHis.setModifiedBy(Session.getUserId());
	eziWfDocHis.setAction(action);
	eziWfDocHis.setRef1(refString);
	eziWfDocHis.setSoldTo("0#"+isDelegate);
	eziWfDocHis.setComments(comments);
  
  if(totAPPQCFVal!=null && !"null".equals(totAPPQCFVal)&& !"".equals(totAPPQCFVal.trim()))
  eziWfDocHis.setWFDocValue(totAPPQCFVal);
  if(totAPPQCFQty!=null && !"null".equals(totAPPQCFQty)&& !"".equals(totAPPQCFQty.trim())){
    eziWfDocHis.setWFDocQty(totAPPQCFQty);
    eziWfDocHis.setWFDocUOM(totAPPQCFUOM);
    eziWfDocHis.setWFDocCurr("INR");
    
  }
  
  
  
	if(rejectToUser != null && (!"null".equals(rejectToUser)) && (!"".equals(rejectToUser)))
	{
		try{
			StringTokenizer userToken = new StringTokenizer(rejectToUser,"¥");
			eziWfDocHis.setNextParticipantStep(userToken.nextToken());
			eziWfDocHis.setNextParticipantRole(userToken.nextToken());
			eziWfDocHis.setNextParticipant(userToken.nextToken());
			eziWfDocHis.setNextParticipantType(userToken.nextToken());
		}catch(Exception ex){System.out.println("Exception while setting tokens in rejection");}	
		
	}
	ezcParams.setObject(eziWfparams);
	ezcParams.setObject(eziWfDocHis);
	Session.prepareParams(ezcParams);
	ezc.ezparam.ReturnObjFromRetrieve ret = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.updateWFDoc(ezcParams);
	if(ret!=null)
	{
		if(ret.getRowCount() > 0 && qcfNum!=null && !"".equals(qcfNum))
		{
			ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			mainParams.setLocalStore("Y");
			ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
			qcfParams.setQcfCode(qcfNum);
			qcfParams.setCommentNo(qcsCommentNo);
			qcfParams.setQcfUser(user);
			qcfParams.setQcfComments(comments);
			qcfParams.setQcfType("COMMENTS");
			qcfParams.setQcfDestUser(user);
			qcfParams.setQcfExt1("$$");
			mainParams.setObject(qcfParams);
			Session.prepareParams(mainParams);
			qcfManager.addQcfComment(mainParams);
			sendToUser 	= ret.getFieldValueString(0,"PARTICIPANT");
			partType 	= ret.getFieldValueString(0,"PARTICIPANT_TYPE");
			delPart 	= ret.getFieldValueString(0,"DELPARTICIPANT");
			delPartType 	= ret.getFieldValueString(0,"DELPARTICIPANTTYPE");
			status 		= ret.getFieldValueString(0,"STATUS");
			actionCode 	= ret.getFieldValueString(0,"ACTIONCODE");
			roleL   	= ret.getFieldValueString(0,"PARTICIPANT");	
			sysKeyL 	= ret.getFieldValueString(0,"SYSKEY");
			templateL 	= ret.getFieldValueString(0,"TEMPLATE");
			participantL 	= ret.getFieldValueString(0,"PARTICIPANT");
		}	
	}	
	
	
	if("G".equals(partType))
	{
		String groupId = "'"+sendToUser+"'";
		if("G".equals(delPartType))
			groupId += ",'"+delPart+"'";
		sendToUser = "";	
		ezc.ezworkflow.params.EziWorkGroupUsersParams wgParams = new ezc.ezworkflow.params.EziWorkGroupUsersParams();
		wgParams.setGroupId(groupId);
		ezc.ezparam.EzcParams wgMainParams = new ezc.ezparam.EzcParams(false);
		wgMainParams.setObject(wgParams);
		Session.prepareParams(wgMainParams);
		ezc.ezparam.ReturnObjFromRetrieve wgRet =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupUsers(wgMainParams);
		String extId ="";
		if(sysKeyL.equals(wgRet.getFieldValueString(0,"SYSKEY")))
		{
			userGroupL  	= wgRet.getFieldValueString(0,"GROUP_ID");
			sendToUser 	= wgRet.getFieldValueString(0,"USERID");
			extId 	= wgRet.getFieldValueString(0,"EMAIL");
			if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
				sendToUser += "," + extId;
		}		
		for(int j=1;j<wgRet.getRowCount();j++)
		{
			if(sysKeyL.equals(wgRet.getFieldValueString(j,"SYSKEY")))
			{
				sendToUser += "," + wgRet.getFieldValueString(j,"USERID");
				extId = wgRet.getFieldValueString(j,"EMAIL");
				if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
					sendToUser += "," + extId;
			}		
		}
	}	
	if("R".equals(partType))
	{
		String extId = "";
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
		params.setRoleNo(sendToUser);
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve listRet=(ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(mainParams);
		sendToUser = "";
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
				if(sysKeyL.equals(wgRet.getFieldValueString(0,"SYSKEY")))
				{
					userGroupL  	= wgRet.getFieldValueString(0,"GROUP_ID");
					sendToUser 	= wgRet.getFieldValueString(0,"USERID");
					extId 	= wgRet.getFieldValueString(0,"EMAIL");
					if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
						sendToUser += "," + extId;
				}		
				for(int j=1;j<wgRet.getRowCount();j++)
				{
					if(sysKeyL.equals(wgRet.getFieldValueString(j,"SYSKEY")))
					{
						sendToUser += "," + wgRet.getFieldValueString(j,"USERID");
						extId = wgRet.getFieldValueString(j,"EMAIL");
						if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
							sendToUser += "," + extId;
					}		
				}		
			}	
		}
	}
    
	if("U".equals(delPartType))
		sendToUser += "," + delPart;
		
	if(sendToUser.startsWith(","))
		sendToUser = sendToUser.substring(1);	
    	
    	
	String msgString = "";
	String delegateText = " and also delegated to ";
	
	if(action.equals("100067"))
	{
	   dispMessage="QCF approved";
	   sendToUser = ret.getFieldValueString(0,"INITIATOR");
	   msgSubject ="QCF No : "+qcfNum+" approved by "+Session.getUserId();
	   msgText = "Dear Sir/Madam,<BR>QCf Number "+qcfNum+" approved<BR>Regards,"+Session.getUserId();
	}
	else if(action.equals("100068"))
	{
	   String isDelegatex = "";
	   String participant = ret.getFieldValueString(0,"PARTICIPANT");
	   String parttype = ret.getFieldValueString(0,"PARTICIPANT_TYPE");
	   String delegateTo="";
	   if("DELEGATE".equals((ret.getFieldValueString(0,"WFTYPE")).trim()))
	   {
		isDelegatex = "Y";
		delegateTo = ret.getFieldValueString(0,"DELPARTICIPANT");
		delegateText += delegateTo;
	   }								    
	   else								    
	   {								    
		isDelegatex = "N";
		delegateTo = "";
		delegateText = "";
	   }	
	   dispMessage="QCF returned to "+sendToUser;
	   msgSubject ="QCF No : "+qcfNum+" returned by "+Session.getUserId();
	   //String link= "http://"+request.getServerName()+"/j2ee/ezPrePostQCF.jsp";
	   String link= "http://"+request.getServerName()+"/j2ee/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/JSPs/ezOfflineLogin.jsp?DEFAULT_PAGE=QCF";
	   //String link= "http://"+request.getServerName()+"/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/QCF/ezPrePostQCF.jsp?collectiveRFQNo="+qcfNum+"&template="+template+"&isDelegate="+isDelegatex+"&participant="+participant+"&partType="+partType+"&syskey="+sysKey+"&delegateTo="+delegateTo;
	   link = "<br><a href="+link+" target=_blank>Click here to process the QCF.</a>";
	   String disp = "Please click on the following link for details. <Br>";	
	   msgText = "<br>QCf Number "+qcfNum+" is rejected for further clarification "+delegateText+".<br>"+disp+link+"<br>Best Regards,<br>"+Session.getUserId();
	   //sendToUser = ret.getFieldValueString(0,"INITIATOR")+","+ret.getFieldValueString(0,"MAIL_EXTS");
	}
	else if(action.equals("100066"))
	{
		msgString = ret.getFieldValueString(0,"PARTICIPANT");	
		dispMessage="QCF submitted to "+sendToUser;
		String isDelegatex = "";
		String delegateTo="";
		if("DELEGATE".equals((ret.getFieldValueString(0,"WFTYPE")).trim()))
		{
			isDelegatex = "Y";
			delegateTo = ret.getFieldValueString(0,"DELPARTICIPANT");
			delegateText += delegateTo;
		}	
		else	
		{
			isDelegatex = "N";
			delegateTo = "";
			delegateText = "";
		}
		String participant = ret.getFieldValueString(0,"PARTICIPANT");
		String parttype = ret.getFieldValueString(0,"PARTICIPANT_TYPE");
		//String link= "http://"+request.getServerName()+"/j2ee/ezPrePostQCF.jsp";
		String link= "http://"+request.getServerName()+"/j2ee/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/JSPs/ezOfflineLogin.jsp?DEFAULT_PAGE=QCF";
		link = "<br><a href="+link+" target=_blank>Click here to process the QCF.</a>";
		String disp = "Please click on the following link for details. <Br>";	
		msgSubject ="QCF No : "+qcfNum+" submitted by "+Session.getUserId();
		msgText = "<br>QCf Number "+qcfNum+" is submitted for further approval "+delegateText+".<br>"+disp+link+"<br>Best Regards,<br>"+Session.getUserId();
	}
%>

<%
		try{
			ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
			ezc.ezparam.EzcParams auditParams	= new ezc.ezparam.EzcParams(true);
			ezc.ezpreprocurement.params.EziWFAuditTrailParams wfAuditTrailParams = new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
			auditParams.setLocalStore("Y");
			wfAuditTrailParams.setEwhExt1("$$");
			wfAuditTrailParams.setEwhDocId(qcfNum);
			auditParams.setObject(wfAuditTrailParams);
			Session.prepareParams(auditParams);
			ezc.ezparam.ReturnObjFromRetrieve retGetWFAuditTrailNos = (ezc.ezparam.ReturnObjFromRetrieve)qcfManager.ezGetWFAuditTrailNo(auditParams);
			int auditNo = retGetWFAuditTrailNos.getRowCount();


			String dateObj = request.getParameter("lastModifiedDate");
			String hoursString = getHoursString(dateObj);		

			auditParams = new ezc.ezparam.EzcParams(false);
			auditParams.setLocalStore("Y");
			ezc.ezpreprocurement.params.EziQcfAuditLogParams qcfLogParams = new ezc.ezpreprocurement.params.EziQcfAuditLogParams();
			qcfLogParams.setQcfCode(qcfNum);
			qcfLogParams.setQcfCategory("QCF");
			qcfLogParams.setQcfRejectPeriod("0");
			qcfLogParams.setQcfQueryPeriod("0");
			qcfLogParams.setQcfElapsedPeriod(hoursString);
			qcfLogParams.setQcfActionBy(userGroup);
			qcfLogParams.setQcfAuditNo(auditNo+"");
			qcfLogParams.setQcfLineType("A");
			auditParams.setObject(qcfLogParams);
			Session.prepareParams(auditParams);
			qcfManager.addQcfAuditLog(auditParams);	


			if(action.equals("100068"))
			{
				qcfLogParams.setQcfLineType("R");
				qcfLogParams.setQcfRejectPeriod(hoursString);
				qcfLogParams.setQcfElapsedPeriod("0");
				auditParams.setObject(qcfLogParams);
				Session.prepareParams(auditParams);
				qcfManager.addQcfAuditLog(auditParams);			
			}
		}catch(Exception ex)
		{
			System.out.println("Exception while storing the data into AuditLog");
		}
		
		
%>