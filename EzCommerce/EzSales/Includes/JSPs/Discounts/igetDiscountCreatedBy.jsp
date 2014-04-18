<%
	String userRole_C	= (String)session.getValue("UserRole");
	String discCreated_C 	= "";
	boolean applyDisc_C	= true;
	/*
	ArrayList desireStep_C 	= new ArrayList();
	
	if("CU".equals(userRole_C))
	{
		desireStep_C.add("-1");
	}
	else if("CM".equals(userRole_C))
	{
		desireStep_C.add("0");
	}
	
	ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlow_C = new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezparam.ReturnObjFromRetrieve retsoldto_C = null;
	
	ezc.ezparam.EzcParams mainParams_C = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams wfparams_C = new ezc.ezworkflow.params.EziWFParams();
	wfparams_C.setTemplate((String)session.getValue("Templet"));
	wfparams_C.setSyskey((String)session.getValue("SalesAreaCode"));
	wfparams_C.setParticipant((String)session.getValue("Participant"));
	wfparams_C.setDesiredSteps(desireStep_C);
	mainParams_C.setObject(wfparams_C);
	Session.prepareParams(mainParams_C);
	
	retsoldto_C = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow_C.getWorkFlowUsers(mainParams_C);
	
	if(retsoldto_C != null)
	{
		int wfcount = retsoldto_C.getRowCount();
		String[] superiors = new String[wfcount];
		
		for(int i=0;i<wfcount;i++)
		{
			superiors[i] = retsoldto_C.getFieldValueString(i,"EU_ID");
			if(discCreated_C.trim().length() == 0)
				discCreated_C = superiors[i].trim();
			else
				discCreated_C += "','"+superiors[i].trim();
		}
	}
	*/
	//out.println("::::"+userRole_C+"::::");

	java.util.ArrayList salesRepRes_List = new java.util.ArrayList();
	
	String salesRepRes = (String)session.getValue("SALESREPRES");
	String salesRep_C = "";

	try
	{
		StringTokenizer stEcadVal = new StringTokenizer(salesRepRes,"¥");

		while(stEcadVal.hasMoreTokens())
		{
			String salesRep_A = (String)stEcadVal.nextElement();
			String salesRep_AId = salesRep_A.split("¤")[0];
			
			if(!salesRepRes_List.contains(salesRep_AId))
				salesRepRes_List.add(salesRep_AId);

			salesRep_C = salesRep_C+"','"+salesRep_AId;
		}
	}
	catch(Exception e){}
	
	if(salesRep_C.startsWith("','"))
		salesRep_C = salesRep_C.substring(3);
	
	if("CU".equals(userRole_C) || "CUSR".equals(userRole_C))
		discCreated_C = salesRep_C;	//(String)session.getValue("SALESREPRES");
	else if("CM".equals(userRole_C))
	{
		String lUserId = Session.getUserId();
		if(salesRepRes_List.contains(lUserId))
			discCreated_C = salesRep_C;
		else
			applyDisc_C = false;
	}
%>