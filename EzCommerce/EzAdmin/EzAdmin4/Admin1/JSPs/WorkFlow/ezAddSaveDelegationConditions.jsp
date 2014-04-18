<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String delegationid=request.getParameter("delegationid");
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziDelegationConditionsTable addTable= new ezc.ezworkflow.params.EziDelegationConditionsTable();
	String conditionid[]=request.getParameterValues("chk1");
	if(conditionid == null)
	{
		ezc.ezworkflow.params.EziDelegationConditionsTableRow addParams= new ezc.ezworkflow.params.EziDelegationConditionsTableRow();
		addParams.setDelegationId(request.getParameter("delegationid"));
		addTable.appendRow(addParams);
	}
	else
	{
		for(int i=0;i<conditionid.length;i++)
		{
			ezc.ezworkflow.params.EziDelegationConditionsTableRow addParams= new ezc.ezworkflow.params.EziDelegationConditionsTableRow();
			addParams.setDelegationId(request.getParameter("delegationid"));
			addParams.setConditionId(conditionid[i]);
			addTable.appendRow(addParams);
		}
	}	
		addMainParams.setObject(addTable);
		Session.prepareParams(addMainParams);
		EzWorkFlowManager.addDelegationCondition(addMainParams);
		

	response.sendRedirect("ezDelegationConditionsList.jsp?delegationid="+delegationid);
%>
