<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<%
	String template		= (String)session.getValue("Templet");
	String group		= (String)session.getValue("UserGroup");
	String catalog_area	= (String)session.getValue("SalesAreaCode");
	String desiredStep	= "";
	String superiorsusers 	= "";
	String participant	= "";
	String sabardinates 	= "";

	ArrayList desireStepV 	= new ArrayList();
	ArrayList downStepV 	= new ArrayList();
	if(userRole.equals("CU"))
	{
		desireStepV.add("-1");
		desireStepV.add("-2");
		desireStepV.add("-3");

	}else if(userRole.equals("CM"))
	{
		downStepV.add("1");
		desireStepV.add("-1");
		desireStepV.add("-2");

	}else if(userRole.equals("LF"))
	{
		desireStepV.add("-1");
		downStepV.add("1");
		downStepV.add("2");

	}else if(userRole.equals("BP"))
	{
		downStepV.add("1");
		downStepV.add("2");
		downStepV.add("3");
	}


	ezc.ezparam.ReturnObjFromRetrieve retsoldto = null;
	ezc.ezparam.ReturnObjFromRetrieve retsoldtoDown = null;

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams wfparams= new ezc.ezworkflow.params.EziWFParams();
	wfparams.setTemplate(template);
	wfparams.setSyskey(catalog_area);
	wfparams.setParticipant((String)session.getValue("Participant"));


	wfparams.setDesiredSteps(desireStepV);
	mainParams.setObject(wfparams);
	Session.prepareParams(mainParams);
	retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);


	wfparams.setDesiredSteps(downStepV);
	mainParams.setObject(wfparams);
	Session.prepareParams(mainParams);
	retsoldtoDown=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

	if(retsoldto != null)
	{
		int wfcount = retsoldto.getRowCount();
		String[] superiors = new String[wfcount];
		for(int i=0;i<wfcount;i++)
		{
			superiors[i] = retsoldto.getFieldValueString(i,"EU_ID");
			if(superiorsusers.trim().length() == 0)
				superiorsusers = superiors[i];
			else
				superiorsusers += "','"+superiors[i];

		}
	}
	if(retsoldtoDown != null)
	{
		int wfcount = retsoldtoDown.getRowCount();
		String[] sabardinate = new String[wfcount];
		for(int i=0;i<wfcount;i++)
		{
			sabardinate[i] = retsoldtoDown.getFieldValueString(i,"EU_ID");
			if(sabardinates.trim().length() == 0)
				sabardinates = sabardinate[i];
			else
				sabardinates += "','"+sabardinate[i];
		}
	}
%>
