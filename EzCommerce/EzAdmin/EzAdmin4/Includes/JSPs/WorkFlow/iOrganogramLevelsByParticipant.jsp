<%
	String orgCode = request.getParameter("orgCode");

	ezc.ezparam.ReturnObjFromRetrieve levelRet = null;

	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	if(orgCode!=null)
	{
		ezc.ezworkflow.params.EziOrganogramLevelsParams orgParams= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
		orgParams.setCode(orgCode);
		myParams.setObject(orgParams);
		Session.prepareParams(myParams);
		levelRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsDetails(myParams);
	}
%>
