<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziAttributesParams addParams= new ezc.ezworkflow.params.EziAttributesParams();
	addParams.setLang(request.getParameter("Lang"));
	addParams.setDescription(request.getParameter("Description"));
	addParams.setContainer(request.getParameter("Container"));
	addParams.setStructField(request.getParameter("StructField"));
	addParams.setRoleNo(request.getParameter("Role"));
	addParams.setType(request.getParameter("Type"));
	addMainParams.setObject(addParams);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addAttribute(addMainParams);
	response.sendRedirect("ezAttributesList.jsp");
%>
