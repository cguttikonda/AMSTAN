\<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
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
				superiorsusers = (superiors[i]).trim();
			else
				superiorsusers += "','"+(superiors[i]).trim();

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
				sabardinates = (sabardinate[i]).trim();
			else
				sabardinates += "','"+(sabardinate[i]).trim();
		}
	}
	
	ReturnObjFromRetrieve partnersRet = null;
	String soldTo = (String) session.getValue("AgentCode");
	
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

		partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	}

	int partnersRetCnt = 0;
	String subuserIds="";
	
	if(partnersRet!=null)
	{
		for(int i=partnersRet.getRowCount()-1;i>=0;i--)
		{
			String tempuserId = partnersRet.getFieldValueString(i,"EU_ID");

			if("".equals(subuserIds))
			{
				subuserIds=(partnersRet.getFieldValueString(i,"EU_ID")).trim();
			}
			else
			{
				subuserIds=subuserIds+"','"+(partnersRet.getFieldValueString(i,"EU_ID")).trim();
			}
		}
		
		partnersRetCnt = partnersRet.getRowCount();
	}	
%>
