<%
	String unbindStr="OrganogramLevels";
%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziOrganogramLevelsParams orgParams= new ezc.ezworkflow.params.EziOrganogramLevelsParams();

	String myLevel = request.getParameter("level");
	String myFlag=request.getParameter("myFlag");
	String parent=request.getParameter("parent");
	String templateCode=request.getParameter("templateCode");
	String orgCode=request.getParameter("organogramCode");
	String orgDesc=request.getParameter("orgDesc");

	String desc = request.getParameter("description");
	String participant = request.getParameter("participant");

	String chk1 = orgCode+","+templateCode+","+orgDesc;

	String orgRole="";
	String temp=request.getParameter("level");
	java.util.StringTokenizer stk=new java.util.StringTokenizer(temp,",");
	String orgLevel = stk.nextToken();

	if(myFlag==null || "".equals(myFlag.trim()))
	{
		orgRole = stk.nextToken();
	}
	String orgOpType = stk.nextToken();

	orgParams.setCode(request.getParameter("orgCode"));
	orgParams.setLevel(orgLevel);
	orgParams.setParticipantType(orgOpType);
	orgParams.setParticipant(participant);
	orgParams.setLang(request.getParameter("lang"));
	orgParams.setDescription(desc);
	orgParams.setParent(parent);

	myParams.setObject(orgParams);
	Session.prepareParams(myParams);
	EzWorkFlowManager.updateOrganogramLevels(myParams);
%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iMemoryManager.jsp"%>
<%
	if(myFlag!=null && myFlag.equals("N"))
		response.sendRedirect("ezNextOrganogramLevelsByParticipant.jsp?orgCode="+orgCode+"&participant="+parent);
	else
		response.sendRedirect("ezListOrganogramsLevels.jsp?level="+myLevel+"&chk1="+chk1+"&searchcriteria="+mySearchCriteria);
%>
