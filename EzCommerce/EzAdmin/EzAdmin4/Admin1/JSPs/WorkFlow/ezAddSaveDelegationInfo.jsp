<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziDelegationInfoParams addParams= new ezc.ezworkflow.params.EziDelegationInfoParams();
	addParams.setTemplateCode(request.getParameter("TemplateCode"));
	addParams.setDelegationId(request.getParameter("DelegationId"));
	addParams.setSourceUser(request.getParameter("SourceUser"));
	addParams.setDestUser(request.getParameter("DestUser"));
	addParams.setValidFrom(request.getParameter("ValidFrom"));
	addParams.setValidTo(request.getParameter("ValidTo"));
	addMainParams.setObject(addParams);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addDelegation(addMainParams);
 
	response.sendRedirect("ezDelegationInfoList.jsp");
%>
