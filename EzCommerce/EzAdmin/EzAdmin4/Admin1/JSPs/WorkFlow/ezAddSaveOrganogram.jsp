<%
	String unbindStr="Organograms";
%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%

	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziOrgonagramParams orgParams= new ezc.ezworkflow.params.EziOrgonagramParams();
		
	
	orgParams.setSysKey(request.getParameter("syskey"));
	orgParams.setLang(request.getParameter("lang"));
	orgParams.setTemplate(request.getParameter("template"));
	orgParams.setDescription(request.getParameter("description"));
		
	myParams.setObject(orgParams);
	Session.prepareParams(myParams);
	EzWorkFlowManager.addOrganogram(myParams);
%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iMemoryManager.jsp"%>
<%              
	response.sendRedirect("ezListOrganograms.jsp");
	
%>
