<%@ page import = "ezc.ezworkflow.params.EziWFDocHistoryParams,ezc.ezworkflow.params.EziWFParams" %>
<jsp:useBean id="EzWorkFlow" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" /> 

<%	

	
	ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(false);

	ezc.ezworkflow.params.EziWFParams eziWfparams = new ezc.ezworkflow.params.EziWFParams();
	ezc.ezworkflow.params.EziWFDocHistoryParams eziWfDocHis =new ezc.ezworkflow.params.EziWFDocHistoryParams();
	String userRole = (String)session.getValue("USERROLE");	
	
	
	String action=request.getParameter("actionNum");
	eziWfparams.setRole((String)session.getValue("ROLE"));
	eziWfDocHis.setSysKey(sysKey);
	eziWfDocHis.setDocId(qcfNum);
	eziWfDocHis.setTemplateCode((String)session.getValue("TEMPLATE"));
	
	eziWfDocHis.setAuthKey("PO_LIST");
	eziWfDocHis.setParticipant((String)session.getValue("USERGROUP"));
	eziWfDocHis.setCreatedBy(Session.getUserId());
	eziWfDocHis.setModifiedBy(Session.getUserId());
	eziWfDocHis.setAction(action.trim());
	
	
	ezcParams.setObject(eziWfparams);
	ezcParams.setObject(eziWfDocHis);

	Session.prepareParams(ezcParams);
	EzWorkFlow.updateWFDoc(ezcParams);	
	

%>
