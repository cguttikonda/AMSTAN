<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziAttributesParams params= new ezc.ezworkflow.params.EziAttributesParams();
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getAttributesList(mainParams);

%>
