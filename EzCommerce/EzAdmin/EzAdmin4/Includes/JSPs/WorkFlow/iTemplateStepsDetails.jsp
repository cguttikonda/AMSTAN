<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams detailsParams= new ezc.ezworkflow.params.EziTemplateStepsParams();
	String chkValue=request.getParameter("chk1");
	java.util.StringTokenizer st=new java.util.StringTokenizer(chkValue,",");

	String tCode=st.nextToken();
	String sCode=st.nextToken();
	String tDesc=request.getParameter("tempDesc");

	detailsParams.setCode(tCode);
	detailsParams.setStep(sCode);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplteStepDetails(detailsMainParams);
%>
