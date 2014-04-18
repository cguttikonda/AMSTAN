<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%

	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionsParams addParams= new ezc.ezworkflow.params.EziActionsParams();
		
	
	addParams.setLang(request.getParameter("Lang"));
	addParams.setCode(request.getParameter("acode"));
	addParams.setDesc(request.getParameter("Desc"));
	addParams.setDirection(request.getParameter("Direction"));
	addParams.setAvailCondition(request.getParameter("AvailCondition"));
	addParams.setWFStatOrAction(request.getParameter("WFStatOrAction"));
		
	addMainParams.setObject(addParams);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addAction(addMainParams);
              
	response.sendRedirect("ezActionsList.jsp");
	
%>
