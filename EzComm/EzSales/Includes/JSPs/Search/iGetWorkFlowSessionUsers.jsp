<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%
	template	= (String)session.getValue("Templet");
	group		= (String)session.getValue("UserGroup");
	catalog_area	= (String)session.getValue("SalesAreaCode");
	desiredStep	= "";
	superiorsusers 	= "";
	participant	= "";
	sabardinates 	= "";

	desireStepV 	= new ArrayList();
	downStepV 	= new ArrayList();
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


	ezc.ezparam.ReturnObjFromRetrieve retsoldto_N = null;
	ezc.ezparam.ReturnObjFromRetrieve retsoldtoDown_N = null;

	mainParams = new ezc.ezparam.EzcParams(false);
	wfparams= new ezc.ezworkflow.params.EziWFParams();
	wfparams.setTemplate(template);
	wfparams.setSyskey(catalog_area);
	wfparams.setParticipant((String)session.getValue("Participant"));
//out.println("Participant>>>>>>>>>>>>>>>>>>>>"+session.getValue("Participant"));

	wfparams.setDesiredSteps(desireStepV);
	mainParams.setObject(wfparams);
	Session.prepareParams(mainParams);
	retsoldto_N=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);
//out.println("retsoldto_N>>>>>>>>>>>>>>>>>>>>"+retsoldto_N.toEzcString());
//log4j.log("retsoldto_N::::::::"+retsoldto_N.toEzcString(),"D");
	wfparams.setDesiredSteps(downStepV);
	mainParams.setObject(wfparams);
	Session.prepareParams(mainParams);
	retsoldtoDown_N=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);
	log4j.log("retsoldtoDown_N::::::::"+retsoldtoDown_N.toEzcString(),"D");
	//out.println("retsoldtoDown_N>>>>>>>>>>>>>>>>>>>>"+retsoldtoDown_N.toEzcString());
	if(retsoldto_N != null)
	{
		int wfcount = retsoldto_N.getRowCount();
		String[] superiors = new String[wfcount];
		for(int i=0;i<wfcount;i++)
		{
			superiors[i] = retsoldto_N.getFieldValueString(i,"EU_ID");
			if(superiorsusers.trim().length() == 0)
				superiorsusers = (superiors[i]).trim();
			else
				superiorsusers += "','"+(superiors[i]).trim();

		}
	}
	if(retsoldtoDown_N != null)
	{
		int wfcount = retsoldtoDown_N.getRowCount();
		String[] sabardinate = new String[wfcount];
		for(int i=0;i<wfcount;i++)
		{
			sabardinate[i] = retsoldtoDown_N.getFieldValueString(i,"EU_ID");
			if(sabardinates.trim().length() == 0)
				sabardinates = (sabardinate[i]).trim();
			else
				sabardinates += "','"+(sabardinate[i]).trim();
		}
	}
	
	ReturnObjFromRetrieve partnersRet_N = null;
	soldTo = (String) session.getValue("AgentCode");
	
	if(catalog_area!=null && soldTo!=null)
	{
		soldTo = soldTo.trim();
	
		String mySoldTo = "";
		
		try
		{
			soldTo = Long.parseLong(soldTo)+"";
			mySoldTo = "0000000000"+soldTo;
			mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
		}
		catch(Exception ex){mySoldTo = soldTo;}
	
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(catalog_area);
		adminUtilsParams.setPartnerValueBy(mySoldTo);

		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		partnersRet_N = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	}

	int partnersRetCnt_N = 0;
	subuserIds="";
	
	if(partnersRet_N!=null)
	{
		for(int i=partnersRet_N.getRowCount()-1;i>=0;i--)
		{
			String tempuserId = partnersRet_N.getFieldValueString(i,"EU_ID");

			if("".equals(subuserIds))
			{
				subuserIds=(partnersRet_N.getFieldValueString(i,"EU_ID")).trim();
			}
			else
			{
				subuserIds=subuserIds+"','"+(partnersRet_N.getFieldValueString(i,"EU_ID")).trim();
			}
		}
		
		partnersRetCnt_N = partnersRet_N.getRowCount();
	}	
%>
