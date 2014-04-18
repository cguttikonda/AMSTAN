<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	ezc.ezparam.EzcParams editMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupsParams editParams= new ezc.ezworkflow.params.EziWorkGroupsParams();
	String role = request.getParameter("Role");
	editParams.setRoleNo(role);
	editParams.setGroupId(request.getParameter("GroupId"));
	editParams.setLang(request.getParameter("Lang"));
	editParams.setDesc(request.getParameter("Desc"));
	editParams.setType(request.getParameter("wgType"));
	editMainParams.setObject(editParams);
	Session.prepareParams(editMainParams);
	EzWorkFlowManager.updateWorkGroup(editMainParams);

	response.sendRedirect("ezWorkGroupsList.jsp?role="+role+"&searchcriteria="+mySearchCriteria);
%>
