<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams editMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziEscalationParams editParams= new ezc.ezworkflow.params.EziEscalationParams();
	editParams.setCode(request.getParameter("Code"));
	editParams.setDescription(request.getParameter("Description"));
	String level=request.getParameter("Level");
	editParams.setLevel(level);
		
	String template="";
	if(level.equals("1"))
	{
		template=request.getParameter("Template");
		if("-".equals(template))
			template="0";
		editParams.setTemplate(template);
	}	
	else if(level.equals("5"))
	{
		template=request.getParameter("Template1");
		if("-".equals(template))
			template="0";
		editParams.setTemplate(template);
		editParams.setRole(request.getParameter("Role1"));
		
	}	
	else if(level.equals("6"))
	{
		template=request.getParameter("Template2");
		if("-".equals(template))
			template="0";
		editParams.setTemplate(template);
		editParams.setGroupId(request.getParameter("GroupId1"));
	}	
	else
	{
		template=request.getParameter("Template");
		if("-".equals(template))
			template="0";
		editParams.setTemplate(template);
		editParams.setGroupId(request.getParameter("GroupId"));
		editParams.setRole(request.getParameter("Role"));
	}	
		
	//editParams.setUser(request.getParameter("User"));
	editParams.setUser(request.getParameter("op"));
	editParams.setDuration(request.getParameter("Duration"));
	editParams.setType(request.getParameter("Type"));
	
	String move = request.getParameter("MoveSign")+""+request.getParameter("MoveCount");
	editParams.setMove(move);
	
	editMainParams.setObject(editParams);
	Session.prepareParams(editMainParams);
	EzWorkFlowManager.updateEscalation(editMainParams);
 
	response.sendRedirect("ezEscalationList.jsp");
%>
