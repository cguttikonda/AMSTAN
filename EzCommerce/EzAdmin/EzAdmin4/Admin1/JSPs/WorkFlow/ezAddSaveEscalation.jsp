<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String level = request.getParameter("Level");
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziEscalationParams addParams= new ezc.ezworkflow.params.EziEscalationParams();
	addParams.setLang("EN");
	addParams.setDescription(request.getParameter("Description"));
	addParams.setLevel(level);

/*	String template=request.getParameter("Template");
	if("-".equals(template))
		template="0";
*/		
	addParams.setTemplate("0");
	if("G".equals(level))
		addParams.setGroupId(request.getParameter("GroupId"));
	addParams.setRole("-");	//request.getParameter("Role"));
	if("U".equals(level))
		addParams.setUser(request.getParameter("GroupId"));	//request.getParameter("op"));
	addParams.setDuration(request.getParameter("Duration"));
	addParams.setType("R");	//request.getParameter("Type"));
      	String move="1";	//request.getParameter("MoveSign")+""+request.getParameter("MoveCount");      	
	addParams.setMove(move);
	addParams.setDocType(request.getParameter("docType"));
	addMainParams.setObject(addParams);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addEscalation(addMainParams);
 	response.sendRedirect("ezEscalationList.jsp");
%>
