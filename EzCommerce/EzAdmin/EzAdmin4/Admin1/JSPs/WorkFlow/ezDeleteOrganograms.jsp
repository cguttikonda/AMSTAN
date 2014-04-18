<%
	String unbindStr="Organograms";
%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziOrgonagramParams deleteParams= new ezc.ezworkflow.params.EziOrgonagramParams();
	String[] chkValue=request.getParameterValues("chk1");
	
	java.util.StringTokenizer stk=new java.util.StringTokenizer(chkValue[0],",");
	String val=stk.nextToken();
	String templateCode=stk.nextToken();
	String orgDesc=stk.nextToken();
	
	for(int i=1;i<chkValue.length;i++)
	{
		java.util.StringTokenizer stk1=new java.util.StringTokenizer(chkValue[i],",");
		val +=","+stk1.nextToken();
		templateCode=stk1.nextToken();
		orgDesc=stk1.nextToken();
	}
	 
	deleteParams.setCode(val);
	myParams.setObject(deleteParams);
	Session.prepareParams(myParams);
	EzWorkFlowManager.deleteOrganograms(myParams);
%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iMemoryManager.jsp"%>
<%
	response.sendRedirect("ezListOrganograms.jsp");
%>
