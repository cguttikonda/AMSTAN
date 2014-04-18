
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>

<%
	String template=request.getParameter("template");
	String sysKey=request.getParameter("syskey");
	String participant=request.getParameter("participant");
	String desiredStep=request.getParameter("desiredStep");

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
	params.setTemplate(template);
	params.setSyskey(sysKey);
	params.setParticipant(participant);
	params.setDesiredStep(desiredStep);
	//params.setPartnerFunction("VN");
	mainParams.setObject(params);
	out.println(params.getPartnerFunction());
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve usersRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);

	//out.println(usersRet);	
%>