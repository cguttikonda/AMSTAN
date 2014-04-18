
<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziEscalationParams detailsParams= new ezc.ezworkflow.params.EziEscalationParams();
	String chkValue=request.getParameter("chk1");
	
	detailsParams.setCode(chkValue);
	
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getEscalationDetails(detailsMainParams);
%>
