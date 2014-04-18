<%
	String unbindStr="OrganogramLevels";
%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziOrganogramLevelsParams deleteParams= new ezc.ezworkflow.params.EziOrganogramLevelsParams();

	String templateCode=request.getParameter("templateCode");
	String orgCode=request.getParameter("orgCode");
	String orgDesc=request.getParameter("orgDesc");
	

	String chk1 = orgCode+","+templateCode+","+orgDesc;	

	String[] chkValue=request.getParameterValues("chk");
	java.util.StringTokenizer stk = new java.util.StringTokenizer(chkValue[0],"#");
	String val=stk.nextToken();
	String level = stk.nextToken();
	String participant = "'"+stk.nextToken()+"'";
	String lang = stk.nextToken();
	String desc = stk.nextToken();
	String parent = stk.nextToken();
	
	for(int i=1;i<chkValue.length;i++)
	{
		java.util.StringTokenizer stk1 = new java.util.StringTokenizer(chkValue[i],"#");
		val +=","+stk1.nextToken();
		level +=","+stk1.nextToken();
		participant += ",'"+stk1.nextToken()+"'";
		lang += ","+stk1.nextToken();
		desc += ","+stk1.nextToken();
		parent += ","+stk1.nextToken();		
	}
	 
	deleteParams.setCode(val);
	deleteParams.setLevel(level);
	deleteParams.setParticipant(participant);
	myParams.setObject(deleteParams);
	Session.prepareParams(myParams);
	EzWorkFlowManager.deleteOrganogramLevels(myParams);
	level = request.getParameter("level");
%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iMemoryManager.jsp"%>
<%
	response.sendRedirect("ezListOrganogramsLevels.jsp?chk1="+chk1+"&level="+level+"&searchcriteria="+mySearchCriteria);
%>
