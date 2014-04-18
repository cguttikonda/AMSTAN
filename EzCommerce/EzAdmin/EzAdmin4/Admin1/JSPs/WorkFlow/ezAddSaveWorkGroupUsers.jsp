<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupUsersTable addTable= new ezc.ezworkflow.params.EziWorkGroupUsersTable();

	String grpid=request.getParameter("groups");
	String chkVals[]=request.getParameterValues("chk1");
	java.util.StringTokenizer stk=null;
	for(int i=0;i<chkVals.length;i++)
	{
		stk=new java.util.StringTokenizer(chkVals[i],",");
		
		ezc.ezworkflow.params.EziWorkGroupUsersTableRow addParams= new ezc.ezworkflow.params.EziWorkGroupUsersTableRow();
		addParams.setEffectiveFrom("01/01/2000");	//setEffectiveFrom(request.getParameter("effectivefrom"));
		addParams.setEffectiveTo("01/01/2999");	//setEffectiveTo(request.getParameter("effectiveto"));
		addParams.setGroupId(request.getParameter("groups"));
		addParams.setUserId(stk.nextToken());
		addParams.setSyskey(stk.nextToken());
		addParams.setSoldTo(stk.nextToken());
		addTable.appendRow(addParams);
	}
	addMainParams.setObject(addTable);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addWorkGroupUsers(addMainParams);

	response.sendRedirect("ezWorkGroupUsersList.jsp?groups="+grpid);
%>
