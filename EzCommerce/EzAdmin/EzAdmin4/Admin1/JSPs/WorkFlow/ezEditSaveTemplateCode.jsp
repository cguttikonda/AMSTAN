<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iUnbind.jsp"%>
<%
	ezc.ezparam.EzcParams editMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeParams editParams= new ezc.ezworkflow.params.EziTemplateCodeParams();
	editParams.setCode(request.getParameter("tempCode"));
	editParams.setLang(request.getParameter("lang"));
	editParams.setDesc(request.getParameter("desc"));
	editParams.setAuthKey(request.getParameter("aKey"));
	editMainParams.setObject(editParams);
	Session.prepareParams(editMainParams);
	EzWorkFlowManager.updateTemplate(editMainParams);
 
	response.sendRedirect("ezTemplateCodeList.jsp");
%>
