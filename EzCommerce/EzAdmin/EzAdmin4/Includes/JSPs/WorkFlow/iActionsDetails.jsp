<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionsParams detailsParams= new ezc.ezworkflow.params.EziActionsParams();
	String chkValue=request.getParameter("chk1");
	detailsParams.setCode(chkValue);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getActionDetails(detailsMainParams);
	

%>
