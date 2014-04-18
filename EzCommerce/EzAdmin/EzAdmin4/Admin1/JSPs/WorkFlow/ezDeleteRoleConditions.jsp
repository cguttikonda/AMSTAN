<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String roleId=request.getParameter("Role");
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziRoleConditionsParams deleteParams= new ezc.ezworkflow.params.EziRoleConditionsParams();
	String[] chkValue=request.getParameterValues("chk1");

        String rIds=chkValue[0];
	
		
	for(int i=1;i<chkValue.length;i++)
 	{
		rIds += ","+chkValue[i];
 	}
 	
 	deleteParams.setConditionId(rIds);
	//deleteParams.setRoleNo(roleId);

 	 
	deleteMainParams.setObject(deleteParams);
	Session.prepareParams(deleteMainParams);
	EzWorkFlowManager.deleteConditions(deleteMainParams);

	EzWorkFlowManager.getRules(deleteMainParams);
 
	response.sendRedirect("ezRoleConditionsList.jsp?Role="+roleId);
	
%>
