<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%@ page import="java.util.Date,java.text.*" %>
<%
	ezc.ezparam.EzcParams editMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziDelegationInfoParams editParams= new ezc.ezworkflow.params.EziDelegationInfoParams();
	editParams.setTemplateCode(request.getParameter("TemplateCode"));
	editParams.setDelegationId(request.getParameter("DelegationId"));
	editParams.setSourceUser(request.getParameter("SourceUser"));
	editParams.setDestUser(request.getParameter("DestUser"));
	
	editParams.setValidFrom(request.getParameter("ValidFrom"));
	editParams.setValidTo(request.getParameter("ValidTo"));
	editMainParams.setObject(editParams);
	Session.prepareParams(editMainParams);
	EzWorkFlowManager.updateDelegation(editMainParams);
 
	response.sendRedirect("ezDelegationInfoList.jsp");
%>
