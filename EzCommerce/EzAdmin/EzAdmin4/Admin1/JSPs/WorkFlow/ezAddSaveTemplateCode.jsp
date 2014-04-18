<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String lang=request.getParameter("lang");
	String aKey=request.getParameter("aKey");
	String desc=request.getParameter("desc");
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeParams addParams= new ezc.ezworkflow.params.EziTemplateCodeParams();
	addParams.setLang(lang);
	addParams.setAuthKey(aKey);
	addParams.setDesc(desc);
	addMainParams.setObject(addParams);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addTemplate(addMainParams);
	response.sendRedirect("ezTemplateCodeList.jsp");
%>
