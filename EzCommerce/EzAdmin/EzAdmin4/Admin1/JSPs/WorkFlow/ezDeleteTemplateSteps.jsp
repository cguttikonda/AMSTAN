<%
	String unbindStr="Templatesteps";
%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String tCode=request.getParameter("tempCode");
	String tDesc=request.getParameter("tempDesc");

	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	String chkValue=request.getParameter("chk1");
	
	java.util.StringTokenizer setVal=new java.util.StringTokenizer(chkValue,",");
 	ezc.ezworkflow.params.EziTemplateStepsParams params= new ezc.ezworkflow.params.EziTemplateStepsParams();
 		
	params.setCode(setVal.nextToken());
	params.setStep(setVal.nextToken());
		
		
	myParams.setObject(params);
	Session.prepareParams(myParams);
	EzWorkFlowManager.deleteTemplateSteps(myParams);
%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iMemoryManager.jsp"%>
<% 
	response.sendRedirect("ezTemplateStepsList.jsp?chk1="+tCode+","+tDesc);
%>

