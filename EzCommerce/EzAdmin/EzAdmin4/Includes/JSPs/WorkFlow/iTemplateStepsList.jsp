<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	String temp=request.getParameter("chk1");
	java.util.StringTokenizer stk=new java.util.StringTokenizer(temp,",");
	String tCode=stk.nextToken();
	String tDesc=stk.nextToken();

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams params= new ezc.ezworkflow.params.EziTemplateStepsParams();
	params.setCode(tCode);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams);
%>
