<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%

	String grpid=request.getParameter("groups");
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupUsersParams deleteParams= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
	String chkValue=request.getParameter("chk1");
	
	StringTokenizer setVal=new StringTokenizer(chkValue,",");	
	deleteParams.setGroupId(setVal.nextToken());
	deleteParams.setUserId(setVal.nextToken());
	deleteParams.setSyskey(setVal.nextToken());
	deleteParams.setSoldTo(setVal.nextToken());
	deleteMainParams.setObject(deleteParams);
	Session.prepareParams(deleteMainParams);
	EzWorkFlowManager.deleteWorkGroupUsers(deleteMainParams);

	response.sendRedirect("ezWorkGroupUsersList.jsp?groups="+grpid);

%>
