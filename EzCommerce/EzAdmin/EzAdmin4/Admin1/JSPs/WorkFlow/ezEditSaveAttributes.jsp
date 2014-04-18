<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams editMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziAttributesParams editParams= new ezc.ezworkflow.params.EziAttributesParams();
	editParams.setAttributeId(request.getParameter("AttributeId"));
	editParams.setLang(request.getParameter("Lang"));
	editParams.setDescription(request.getParameter("Description"));
	editParams.setContainer(request.getParameter("Container"));
	editParams.setStructField(request.getParameter("StructField"));
	editParams.setType(request.getParameter("Role"));
	editParams.setType(request.getParameter("Type"));
	editMainParams.setObject(editParams);
	Session.prepareParams(editMainParams);
	EzWorkFlowManager.updateAttribute(editMainParams);
 
	response.sendRedirect("ezAttributesList.jsp");
%>
