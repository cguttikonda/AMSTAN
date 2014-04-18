<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>

<%
	ezc.ezparam.EzcParams editMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionsParams editParams= new ezc.ezworkflow.params.EziActionsParams();
	
	editMainParams.setLocalStore("Y");
	
	editParams.setCode(request.getParameter("Code"));
	editParams.setLang(request.getParameter("Lang"));
	editParams.setDesc(request.getParameter("Desc"));
	editParams.setDirection(request.getParameter("Direction"));
	editParams.setAvailCondition(request.getParameter("AvailCondition"));
	editParams.setWFStatOrAction(request.getParameter("WFStatOrAction"));
	editMainParams.setObject(editParams);
	Session.prepareParams(editMainParams);
	
	EzWorkFlowManager.editAction(editMainParams);
 
	response.sendRedirect("ezActionsList.jsp");
%>
