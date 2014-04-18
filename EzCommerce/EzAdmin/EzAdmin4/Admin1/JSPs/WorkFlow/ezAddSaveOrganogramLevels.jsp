<%
	String unbindStr="OrganogramLevels";
%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziOrganogramLevelsParams orgParams= new ezc.ezworkflow.params.EziOrganogramLevelsParams();

	String templateCode=request.getParameter("templateCode");
	String orgCode=request.getParameter("organogramCode");
	String orgDesc = request.getParameter("orgDesc");
	String chk1 = orgCode+","+templateCode+","+orgDesc;
	orgParams.setCode(request.getParameter("orgCode"));

	String temp=request.getParameter("level");
	java.util.StringTokenizer stk=new java.util.StringTokenizer(temp,",");
	String level = stk.nextToken();
	String role = stk.nextToken();
	String opType = stk.nextToken();

	orgParams.setLevel(level);
	orgParams.setParticipantType(opType);
	orgParams.setParticipant(request.getParameter("participant"));
	orgParams.setLang(request.getParameter("lang"));
	orgParams.setDescription(request.getParameter("description"));
	orgParams.setParent(request.getParameter("parent"));

	myParams.setObject(orgParams);
	Session.prepareParams(myParams);
	EzWorkFlowManager.addOrganogramLevels(myParams);

	level = request.getParameter("level");
%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iMemoryManager.jsp"%>
<%
	response.sendRedirect("ezListOrganogramsLevels.jsp?chk1="+chk1+"&level="+level+"&searchcriteria="+mySearchCriteria);
%>
