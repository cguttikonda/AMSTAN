<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	String delegationid =request.getParameter("delegationid");
	ezc.ezparam.ReturnObjFromRetrieve listRet=null;
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziRoleConditionsParams params= new ezc.ezworkflow.params.EziRoleConditionsParams();
	params.setRoleNo("Role1"); //Hard Coded
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getConditionsList(mainParams);


	ezc.ezparam.EzcParams mainParamsd = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziDelegationInfoParams paramsd= new ezc.ezworkflow.params.EziDelegationInfoParams();
	mainParamsd.setObject(paramsd);
	Session.prepareParams(mainParamsd);
	ezc.ezparam.ReturnObjFromRetrieve listRet2=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getDelegationsList(mainParamsd);



	ezc.ezparam.ReturnObjFromRetrieve listRet1=null; //new ezc.ezparam.ReturnObjFromRetrieve();

	if(delegationid!=null && !delegationid.equals("sel"))
	{
		ezc.ezparam.EzcParams mainParamsc = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziDelegationConditionsParams paramsc= new ezc.ezworkflow.params.EziDelegationConditionsParams();
		paramsc.setDelegationId("'"+delegationid+"'");
		mainParamsc.setObject(paramsc);
		Session.prepareParams(mainParamsc);
		listRet1=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getDelegationConditionsList(mainParamsc);
		
	}




%>
