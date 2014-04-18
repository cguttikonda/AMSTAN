<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupsParams addParams= new ezc.ezworkflow.params.EziWorkGroupsParams();
	String roleNo = request.getParameter("Role");
	addParams.setRoleNo(roleNo);
	addParams.setGroupId((request.getParameter("GroupId")).toUpperCase());
	addParams.setLang(request.getParameter("Lang"));
	addParams.setDesc(request.getParameter("Desc"));
	addParams.setType(request.getParameter("wgType"));
	addMainParams.setObject(addParams);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addWorkGroup(addMainParams);

	response.sendRedirect("ezWorkGroupsList.jsp?role="+roleNo+"&searchcriteria="+mySearchCriteria);
%>
