<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>

<%
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeParams params= new ezc.ezworkflow.params.EziTemplateCodeParams();
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplatesList(mainParams);
	int listCount = 0;
	if(listRet != null)
		listCount = listRet.getRowCount();

%>
