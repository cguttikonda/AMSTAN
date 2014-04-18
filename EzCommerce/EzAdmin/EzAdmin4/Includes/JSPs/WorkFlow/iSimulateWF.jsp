<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>

<%
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeParams params= new ezc.ezworkflow.params.EziTemplateCodeParams();
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve templatesRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplatesList(mainParams);
	
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziAttributesParams params1= new ezc.ezworkflow.params.EziAttributesParams();
	mainParams1.setObject(params1);
	Session.prepareParams(mainParams1);
	ezc.ezparam.ReturnObjFromRetrieve attributesRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getAttributesList(mainParams1);


%>
