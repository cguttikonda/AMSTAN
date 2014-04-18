 <%@ include file="../../Library/Globals/errorPagePath.jsp"%>
 <%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*,ezc.ezpreprocurement.params.*,ezc.ezworkflow.params.*" %>
 <jsp:useBean id="Session" class ="ezc.session.EzSession" scope="session"></jsp:useBean>
 <jsp:useBean id="AppManager" class ="ezc.ezvendorapp.client.EzVendorAppManager" scope="page"></jsp:useBean>
 <jsp:useBean id="EzWorkFlow" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" /> 
 <jsp:useBean id="PreProManager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" scope="session" />


<%
	String docNos[]=request.getParameterValues("chk1");
	String orderType = request.getParameter("type");
	ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams eziWfparams 		= new ezc.ezworkflow.params.EziWFParams();
	ezc.ezworkflow.params.EziWFDocHistoryParams eziWfDocHis = new ezc.ezworkflow.params.EziWFDocHistoryParams();
	
	EziWFAuditTrailTable myAuditTab = new EziWFAuditTrailTable();
        EziWFAuditTrailTableRow myAuditTabRow 	= null;	
        String myAuditDocNos="";

	String sessionRole = (String)session.getValue("ROLE");
	String userRole    = (String)session.getValue("USERROLE");	
	String template	   = (String)session.getValue("TEMPLATE");
	String userGroup   = (String)session.getValue("USERGROUP");
	String sysKey 	   = (String)session.getValue("SYSKEY");
	String userId 	   = Session.getUserId();
	String soldTo      = (String)session.getValue("SOLDTO");
	
	ezc.ezvendorapp.params.EzPOAcknowledgementTableRow tableRow=null;
	ezc.ezvendorapp.params.EzPOAcknowledgementTable table=new ezc.ezvendorapp.params.EzPOAcknowledgementTable();
	
	if(docNos!=null && docNos.length>0)
	{
		FormatDate formatDate = new FormatDate();
    		String date=formatDate.getStringFromDate(new java.util.Date(),".",FormatDate.DDMMYYYY);
    		 
    		 
    		 
    		java.util.Hashtable myAuditHT=new java.util.Hashtable();
    		
    		for(int i=0;i<docNos.length;i++)
		{
			if("".equals(myAuditDocNos))
			myAuditDocNos=docNos[i];
			else
			myAuditDocNos +="','"+docNos[i];
		}	
    		
		if(!"".equals(myAuditDocNos)){
			ezcParams = new ezc.ezparam.EzcParams(true);
			ezcParams.setLocalStore("Y");
			EziWFAuditTrailParams eziWFHistoryParams= new EziWFAuditTrailParams();
			eziWFHistoryParams.setEwhDocId(myAuditDocNos);
			ezcParams.setObject(eziWFHistoryParams);
			Session.prepareParams(ezcParams);
			ReturnObjFromRetrieve auditNoRetObj = (ReturnObjFromRetrieve)PreProManager.ezGetWFAuditTrailNo(ezcParams);

			if(auditNoRetObj!=null){
				for(int i=0;i<auditNoRetObj.getRowCount();i++){
					myAuditHT.put(auditNoRetObj.getFieldValueString(i,"DOC_NO"),auditNoRetObj.getFieldValueString(i,"AUDIT_NO"));
				}
			}
		}
    		 
    		 

		for(int i=0;i<docNos.length;i++)
		{
			tableRow = new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
			tableRow.setDocNo(docNos[i]);
			tableRow.setDocStatus("D");
			tableRow.setModifiedOn(date);
			table.appendRow(tableRow);
			
			eziWfparams.setRole(sessionRole);
			eziWfparams.setParticipant(userGroup);
			eziWfDocHis.setAction("100080");
			eziWfDocHis.setParticipant(userGroup);
			eziWfDocHis.setStatus("DELETED");
			eziWfDocHis.setSysKey(sysKey);
			eziWfDocHis.setTemplateCode(template);
			if("P".equals(orderType)){
				eziWfDocHis.setAuthKey("PO_RELEASE");
			}else{
				eziWfDocHis.setAuthKey("CON_RELEASE");
			}
			
			eziWfDocHis.setIsPrtlBlkReqd("Y");
			
			eziWfDocHis.setModifiedBy(userId);
			eziWfDocHis.setCreatedBy(userId);
			eziWfDocHis.setSoldTo(soldTo);
			eziWfDocHis.setRef2("");
			eziWfDocHis.setDocId(docNos[i]);
			ezcParams.setObject(eziWfparams);
			ezcParams.setObject(eziWfDocHis);
			Session.prepareParams(ezcParams);
			ezc.ezparam.ReturnObjFromRetrieve retPoWorkFlow = null;
			try
			{
				retPoWorkFlow = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.updateWFDoc(ezcParams);	
			}catch(Exception err){}	
			
			String myAuditNoTemp=(String)myAuditHT.get(docNos[i]);
			          
			if(myAuditNoTemp==null||"null".equals(myAuditNoTemp)|| "".equals(myAuditNoTemp.trim())) myAuditNoTemp="1";
			myAuditTabRow=new EziWFAuditTrailTableRow();
			myAuditTabRow.setEwhAuditTrailNo(myAuditNoTemp);
			myAuditTabRow.setEwhDocId(docNos[i]);
			myAuditTabRow.setEwhType("");
			myAuditTabRow.setEwhSourceParticipant((Session).getUserId());
			myAuditTabRow.setEwhSourceParticipantType("");
			myAuditTabRow.setEwhDestParticipant("");
			myAuditTabRow.setEwhDestParticipantType("");
			if("P".equals(orderType))
			myAuditTabRow.setEwhComments("PO Deleted From Portal");
			else
			myAuditTabRow.setEwhComments("Contract Deleted From Portal");
			myAuditTab.appendRow(myAuditTabRow);
			
			
			
		}
		
		
		if(myAuditTab.getRowCount()>0)
		{
			ezcParams = new ezc.ezparam.EzcParams(true);
			ezcParams.setLocalStore("Y");
			ezcParams.setObject(myAuditTab);
			Session.prepareParams(ezcParams);
			PreProManager.ezAddWFAuditTrail(ezcParams);
		}	

		
		
		
		
		
		ezcParams = new ezc.ezparam.EzcParams(true);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(table);
		Session.prepareParams(ezcParams);
		AppManager.ezUpdatePOAcknowledgement(ezcParams);	
	}
	response.sendRedirect("ezGetLocalPOList.jsp?type="+orderType);
	
%>

