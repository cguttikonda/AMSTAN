
<%
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionStatParams params1= new ezc.ezworkflow.params.EziActionStatParams();
	mainParams1.setObject(params1);
	Session.prepareParams(mainParams1);
	ezc.ezparam.ReturnObjFromRetrieve listStatRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getActionStatsList(mainParams1);
%>
