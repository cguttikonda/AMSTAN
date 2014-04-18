<%
	String unbindStr="Templatesteps";
%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String tCode=request.getParameter("tempCode");
	String tDesc=request.getParameter("tempDesc");

	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams addParams= new ezc.ezworkflow.params.EziTemplateStepsParams();
	addParams.setCode(tCode);
	addParams.setRole(request.getParameter("role"));
	addParams.setStepDesc(request.getParameter("StepDesc"));
	addParams.setOwnerParticipant(request.getParameter("op"));
	addParams.setOwnerParticipantType(request.getParameter("opType"));
	addParams.setFYIParticipant(request.getParameter("fyi"));
	addParams.setFYIParticipantType(request.getParameter("fyiType"));
	if(request.getParameter("isMandatory")==null)
		addParams.setIsManadatory("N");
	else
		addParams.setIsManadatory("Y");
	myParams.setObject(addParams);
	Session.prepareParams(myParams);
	EzWorkFlowManager.addTemplateStep(myParams);
%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iMemoryManager.jsp"%>
<%
	response.sendRedirect("ezTemplateStepsList.jsp?chk1="+tCode+","+tDesc);
%>