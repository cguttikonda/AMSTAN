<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	params.setAuthKey("'"+"EDIT_SR"+"'");
	params.setSysKey("'"+"555501"+"'");
	params.setDocId("'"+"238"+"'");
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocDetails(mainParams);


%>