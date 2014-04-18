<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionStatParams addParams= new ezc.ezworkflow.params.EziActionStatParams();
	addParams.setAuthKey(request.getParameter("AuthKey"));
	addParams.setResultStatus(request.getParameter("ResultStatus"));
	addParams.setAction(request.getParameter("Action"));
	addMainParams.setObject(addParams);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addActionStat(addMainParams);
 
	response.sendRedirect("ezActionStatList.jsp");
%>
