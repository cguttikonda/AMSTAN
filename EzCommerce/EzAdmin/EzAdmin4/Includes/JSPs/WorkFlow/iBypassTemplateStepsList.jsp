<%
	ezc.ezparam.ReturnObjFromRetrieve listBypassRet = null;
	String tCode= "",sourceStep="",destinationStep ="";

	if(request.getParameter("template") != null)
		tCode= request.getParameter("template");
		
	if(request.getParameter("srcLevel") != null)
		sourceStep= request.getParameter("srcLevel");
	if(request.getParameter("dstLevel") != null)
		destinationStep= request.getParameter("dstLevel");

		
	int listBypassCount = 0;	
	if(tCode!=null)
	{
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziTemplateStepsParams tempParams= new ezc.ezworkflow.params.EziTemplateStepsParams();
		tempParams.setCode(tCode);
		mainParams1.setObject(tempParams);
		Session.prepareParams(mainParams1);
		listBypassRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams1);
		listBypassCount = listBypassRet.getRowCount();
	}	
%>
