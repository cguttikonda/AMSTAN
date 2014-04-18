<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams editMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionStatParams editParams= new ezc.ezworkflow.params.EziActionStatParams();
	editParams.setAuthKey(request.getParameter("AuthKey"));
	editParams.setAction(request.getParameter("Action"));
	editParams.setResultStatus(request.getParameter("ResultStatus"));
	editMainParams.setObject(editParams);
	Session.prepareParams(editMainParams);
	EzWorkFlowManager.updateActionStat(editMainParams);
 
	response.sendRedirect("ezActionStatList.jsp");
%>
