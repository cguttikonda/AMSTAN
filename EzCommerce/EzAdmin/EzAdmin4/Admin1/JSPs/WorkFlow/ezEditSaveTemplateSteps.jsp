<%
	String unbindStr="Templatesteps";
%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String tCode=request.getParameter("tempCode");
	String sCode=request.getParameter("stepCode");
	String tDesc=request.getParameter("tempDesc");
	String isMandatory=request.getParameter("isMandatory");
	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams editParams= new ezc.ezworkflow.params.EziTemplateStepsParams();
	editParams.setCode(tCode);
	editParams.setStep(sCode);
	editParams.setRole(request.getParameter("role"));
	editParams.setStepDesc(request.getParameter("StepDesc"));
	editParams.setOwnerParticipant(request.getParameter("op"));
	editParams.setOwnerParticipantType(request.getParameter("opType"));
	editParams.setFYIParticipant(request.getParameter("fyi"));
	editParams.setFYIParticipantType(request.getParameter("fyiType"));
	if(isMandatory == null || "null".equals(isMandatory))
		editParams.setIsManadatory("N");
	else
		editParams.setIsManadatory("Y");
	myParams.setObject(editParams);
	Session.prepareParams(myParams);
	EzWorkFlowManager.updateTemplateStep(myParams);


out.println(editParams.getIsManadatory());
%>
<%
	response.sendRedirect("ezTemplateStepsList.jsp?chk1="+tCode+","+tDesc);
%>
