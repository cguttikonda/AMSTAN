<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String orgCode = request.getParameter("orgCode");
	String participant = request.getParameter("participant");
	participant = participant.toUpperCase();
	String level = request.getParameter("level");
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	
	ezc.ezworkflow.params.EziOrganogramLevelsParams params= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
	params.setCode(orgCode);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsDetails(mainParams);

	ezc.ezparam.ReturnObjFromRetrieve desiredUsersRet=(ReturnObjFromRetrieve)EzWorkFlowManager.getDesiredUsers(listRet,participant);
	for (int i=0;i<listRet.getRowCount();i++)
	{
		if(participant.equals(listRet.getFieldValueString(i,"PARTICIPANT")))
		{
			level = listRet.getFieldValueString(i,"ORGLEVEL");
		}
	}
%>
