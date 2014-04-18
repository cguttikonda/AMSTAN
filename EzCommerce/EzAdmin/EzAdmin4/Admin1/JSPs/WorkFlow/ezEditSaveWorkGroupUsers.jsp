<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String grpid=request.getParameter("groupid");
	ezc.ezparam.EzcParams editMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupUsersParams editParams= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
	String users=request.getParameter("users");
	editParams.setUserId(users);
	editParams.setGroupId(request.getParameter("groupid"));
	editParams.setEffectiveFrom(request.getParameter("EffectiveFrom"));
	editParams.setEffectiveTo(request.getParameter("EffectiveTo"));
	editMainParams.setObject(editParams);
	Session.prepareParams(editMainParams);
	EzWorkFlowManager.updateWorkGroupUser(editMainParams);
	response.sendRedirect("ezWorkGroupUsersList.jsp?groups="+grpid);
%>
