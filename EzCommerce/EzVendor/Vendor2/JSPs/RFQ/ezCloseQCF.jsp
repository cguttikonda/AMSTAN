<%@ page import ="java.util.*,ezc.ezutil.*,ezc.ezpreprocurement.params.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iWFMethods.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<jsp:useBean id="wfHistoryManager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" scope="session" />
<%!
	private String checkDetails(ezc.session.EzSession Session,String collNo,String syskey)
	{
		ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
		ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
		wfParams.setAuthKey("QCF_RELEASE");
		wfParams.setSysKey(syskey);
		wfParams.setDocId(collNo);
		wfParams.setSoldTo("0");
		wfMainParams.setObject(wfParams);
		Session.prepareParams(wfMainParams);
		ezc.ezparam.ReturnObjFromRetrieve wfDetailsRet=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getWFDocDetails(wfMainParams);
		String user=(Session.getUserId()).trim();
		String status = null;
		if(wfDetailsRet != null)
		{	
			status = wfDetailsRet.getFieldValueString(wfDetailsRet.getRowCount()-1,"STEP");
		}
		return status;
	}	
	public String getMailIds(ezc.session.EzSession Session,String sendToUser,String partType,String syskey)
	{
		ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlow = new ezc.ezworkflow.client.EzWorkFlowManager();
		String userGroupL="";
		if("G".equals(partType))
		{
			String groupId = "'"+sendToUser+"'";
			ezc.ezworkflow.params.EziWorkGroupUsersParams wgParams = new ezc.ezworkflow.params.EziWorkGroupUsersParams();
			wgParams.setGroupId(groupId);
			ezc.ezparam.EzcParams wgMainParams = new ezc.ezparam.EzcParams(false);
			wgMainParams.setObject(wgParams);
			Session.prepareParams(wgMainParams);
			ezc.ezparam.ReturnObjFromRetrieve wgRet =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupUsers(wgMainParams);
			String extId ="";
			sendToUser = "";
			if(wgRet != null)
			{
				if(syskey.equals(wgRet.getFieldValueString(0,"SYSKEY")))
				{
					userGroupL  	= wgRet.getFieldValueString(0,"GROUP_ID");
					sendToUser 	= wgRet.getFieldValueString(0,"USERID");
					extId 	= wgRet.getFieldValueString(0,"EMAIL");
					if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
						sendToUser += "," + extId;
				}		
				for(int j=1;j<wgRet.getRowCount();j++)
				{
					if(syskey.equals(wgRet.getFieldValueString(0,"SYSKEY")))
					{
						sendToUser += "," + wgRet.getFieldValueString(j,"USERID");
						extId = wgRet.getFieldValueString(j,"EMAIL");
						if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
							sendToUser += "," + extId;
					}		
				}
			}	
		}	
		if("R".equals(partType))
		{
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
			params.setRoleNo(sendToUser);
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			ezc.ezparam.ReturnObjFromRetrieve listRet=(ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(mainParams);
			String extId ="";
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
					if(syskey.equals(wgRet.getFieldValueString(0,"SYSKEY")))
					{
						userGroupL  	= wgRet.getFieldValueString(0,"GROUP_ID");
						sendToUser 	= wgRet.getFieldValueString(0,"USERID");
						extId 	= wgRet.getFieldValueString(0,"EMAIL");
						if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
							sendToUser += "," + extId;
					}		
					for(int j=1;j<wgRet.getRowCount();j++)
					{
						if(syskey.equals(wgRet.getFieldValueString(j,"SYSKEY")))
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
		return sendToUser;
	}
%>
<%
	java.util.Vector roleVector = new java.util.Vector();
	roleVector.addElement("PRESIDENT");
	roleVector.addElement("CEO");
	roleVector.addElement("VIEWROLE");
	
	String retMessage   = "Error Occured";	
	String reasons	    = request.getParameter("reasons");
	
	reasons	= "3$"+reasons;	//Add Type of Exception+$+reason 

	ezc.ezparam.EzcParams rfqezcparams				     	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderTable ezirfqheadertable 	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
	ezc.ezpreprocurement.params.EziRFQDetailsTable ezirfqdetailstable 	= new ezc.ezpreprocurement.params.EziRFQDetailsTable();
	ezc.ezpreprocurement.params.EziRFQDetailsTableRow ezirfqdetailstablerow = null;
	
	int retCount = myRet.getRowCount();
	for(int i=0;i<retCount;i++)
	{
		ezc.ezpreprocurement.params.EziRFQHeaderTableRow ezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();
	
		ezirfqheadertablerow.setRFQNo(myRet.getFieldValueString(i,"RFQ_NO")); 		
		ezirfqheadertablerow.setStatus("C"); 
		ezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
		ezirfqheadertable.appendRow(ezirfqheadertablerow);
		retMessage = "QCF Closed Successfully";
	}	
	
	rfqezcparams.setObject(ezirfqheadertable);
	rfqezcparams.setObject(ezirfqdetailstable);
	rfqezcparams.setLocalStore("Y");
	Session.prepareParams(rfqezcparams);
	ezrfqmanager.ezUpdateRFQ(rfqezcparams);
	
	ezc.ezparam.EzcParams historyMainParams = new ezc.ezparam.EzcParams(false);
	historyMainParams.setLocalStore("Y");
	ezc.ezpreprocurement.params.EziWFAuditTrailParams eziWFHistoryParams= new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
	eziWFHistoryParams.setEwhDocId(collNo);
	historyMainParams.setObject(eziWFHistoryParams);
	Session.prepareParams(historyMainParams);
	ezc.ezparam.ReturnObjFromRetrieve wfMyRet = (ezc.ezparam.ReturnObjFromRetrieve)wfHistoryManager.ezGetWFAuditTrailNo(historyMainParams);
	String historyNo = "";
	if(wfMyRet != null)
	{
		historyNo = wfMyRet.getFieldValueString(0,"AUDIT_NO");
		if(historyNo == "null")
			historyNo = "1";
	}
	else
		historyNo = "1";
	eziWFHistoryParams.setEwhAuditTrailNo(historyNo);
	eziWFHistoryParams.setEwhDocId(collNo);
	eziWFHistoryParams.setEwhType("QCF_CLOSED");
	eziWFHistoryParams.setEwhSourceParticipant((String)Session.getUserId());
	eziWFHistoryParams.setEwhSourceParticipantType("");
	eziWFHistoryParams.setEwhDestParticipant("");
	eziWFHistoryParams.setEwhDestParticipantType("");
	eziWFHistoryParams.setEwhComments(reasons);
	historyMainParams.setObject(eziWFHistoryParams);
	Session.prepareParams(historyMainParams);
	wfHistoryManager.ezAddWFAuditTrail(historyMainParams);
	
	
	String participant 	= "";
	String participant_type = "";
	String role 		= "";
	String syskey		= "";
	String template		= "";

	boolean sendInfMail = false;
	ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlow = new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezparam.EzcParams qryMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	params.setAuthKey("'QCF_RELEASE'");
	params.setStatus("'SUBMITTED','REJECTED','APPROVED'");
	qryMainParams.setObject(params);
	Session.prepareParams(qryMainParams);
	ezc.ezparam.ReturnObjFromRetrieve retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(qryMainParams);		
	if(retobj != null)
	{
		int returnCount = retobj.getRowCount();
		String docId="";
		for(int i=0;i<returnCount;i++)
		{
			docId=(retobj.getFieldValueString(i,"DOCID")).trim();
			if(docId.equals(collNo))
			{
				sendInfMail = true;
				participant 		= (retobj.getFieldValueString(i,"NEXTPARTICIPANT")).trim();
				participant_type 	= (retobj.getFieldValueString(i,"PARTICIPANTTYPE")).trim();
				syskey			= (retobj.getFieldValueString(i,"SYSKEY")).trim();
				template		= getDesiredValue(Session,syskey,"WFTEMPLATE");
				if("R".equals(participant_type))
					role 			= participant;
				else
					role 			= getUserRole(Session,participant);
				break;
			}
		}
	}
	
	if(sendInfMail)
	{
		String qcfClosedMessage = "QCF "+collNo+" Closed by "+(String)Session.getUserId();
		String currentStep	=	checkDetails(Session,collNo,syskey);
		String sendToUser = "";
		if(currentStep != null)
		{
			int curStep = Integer.parseInt(currentStep);
			ReturnObjFromRetrieve closeMailRet = getWFHierarchy(Session,syskey,template);
			
			if(closeMailRet != null)
			{
				int recCount = closeMailRet.getRowCount();
				for(int i=0;i<recCount;i++)
				{
					int chkStep = Integer.parseInt(closeMailRet.getFieldValueString(i,"STEP"));
					if(chkStep <= curStep)
					{
						sendToUser += (getMailIds(Session,closeMailRet.getFieldValueString(i,"OWNERPARTICIPANT"),closeMailRet.getFieldValueString(i,"OPTYPE"),syskey)).trim()+",";
					}	
				}
				sendToUser = sendToUser.substring(0,sendToUser.length()-1);
				String msgSubject = qcfClosedMessage;
				String msgText = "Hi,<BR><BR>"+qcfClosedMessage+"<BR><BR><B>Reason : </B><BR>"+reasons.substring(reasons.indexOf("$")+1,reasons.length());
				String objNo 		= collNo;
				String attachString 	= "";
				out.println(sendToUser);
%>
				<%@ include file="../Purorder/ezSendMail.jsp" %>
<%
			}	
		}	
	}	
	try
	{
		ReturnObjFromRetrieve finalRet = new ReturnObjFromRetrieve(new String[]{"PARTICIPANT","PARTICIPANT_TYPE","ROLE","STATUS","SYSKEY","DOCID","TEMPLATE","AUTHKEY","MODIFIEDBY","ACTIONCODE","DELPARTICIPANT","DELPARTICIPANTTYPE","ADDORUPDATE","PREVPARTICIPANT","PREVPARTICIPANT_TYPE","INITIATOR","WFTYPE","MAIL_EXTS","COMMENTS"});
		finalRet.setFieldValue("PARTICIPANT"		,	participant);
		finalRet.setFieldValue("PARTICIPANT_TYPE"	,	participant_type);
		finalRet.setFieldValue("ROLE"			,	role);
		finalRet.setFieldValue("STATUS"			,	"QCF_DELETEJOB");
		finalRet.setFieldValue("SYSKEY"			,	syskey);
		finalRet.setFieldValue("DOCID"			,	collNo);
		finalRet.setFieldValue("TEMPLATE"		,	template);
		finalRet.setFieldValue("AUTHKEY"		,	"QCF_DELETEJOB");
		finalRet.setFieldValue("MODIFIEDBY"		,	"-");
		finalRet.setFieldValue("ACTIONCODE"		,	"-");
		finalRet.setFieldValue("DELPARTICIPANT"		,	"-");
		finalRet.setFieldValue("DELPARTICIPANTTYPE"	,	"-");
		finalRet.setFieldValue("ADDORUPDATE"		,	"UPDATE");
		finalRet.setFieldValue("PREVPARTICIPANT"	,	participant);
		finalRet.setFieldValue("PREVPARTICIPANT_TYPE"	,	participant_type);
		finalRet.setFieldValue("INITIATOR"		,	"-");
		finalRet.setFieldValue("WFTYPE"			,	"-");
		finalRet.setFieldValue("MAIL_EXTS"		,	"-");
		finalRet.setFieldValue("COMMENTS"		,	"-");
		finalRet.addRow();
		
		EzWorkFlow.doEscalate(finalRet,qryMainParams);
	}catch(Exception ex)
	{
		System.out.println("While Deleting the Scheduled Job");
		ex.printStackTrace();
	}
	
	response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+retMessage);	
%>
