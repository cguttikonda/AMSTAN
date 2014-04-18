<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	String temp=request.getParameter("chk1");
	java.util.StringTokenizer stk=new java.util.StringTokenizer(temp,",");
	String orgCode=stk.nextToken();
	String templateCode=stk.nextToken();
	String orgDesc=stk.nextToken();

	String level = null;
	String role = null;
	String opType = null;
	String tempLevel = request.getParameter("level");
	if(tempLevel!=null && !"".equals(tempLevel.trim()) && !tempLevel.equals("sel"))
	{
		java.util.StringTokenizer myStk = new java.util.StringTokenizer(tempLevel,",");
		level = myStk.nextToken();
		role = myStk.nextToken();
		opType = myStk.nextToken();
	}

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziOrganogramLevelsParams params= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
	params.setCode(orgCode);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsList(mainParams);


	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams stepsParams= new ezc.ezworkflow.params.EziTemplateStepsParams();
	stepsParams.setCode(templateCode);
	myParams.setObject(stepsParams);
	Session.prepareParams(myParams);
	ezc.ezparam.ReturnObjFromRetrieve retSteps=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(myParams);

	if(level!=null)
	{
		int deleteCount = listRet.getRowCount();
		for(int i=deleteCount-1;i>=0;i--)
		{
			if(!(level.equals(listRet.getFieldValueString(i,"ORGLEVEL"))))
			{
				listRet.deleteRow(i);
			}
		}
	}
	java.util.TreeSet alphaTree = new java.util.TreeSet();
	String alphaName = null;
	int myRowCount = 0;
	if(level!=null && !"null".equals(level))
	{
		myRowCount = listRet.getRowCount();
		for(int i=0;i<myRowCount;i++)
		{
			alphaName = listRet.getFieldValueString(i,"PARTICIPANT");
			alphaTree.add((alphaName.substring(0,1)).toUpperCase());
		}
	}
	String searchPartner=request.getParameter("searchcriteria");
	if(alphaTree.size()>0 && "$".equals(searchPartner))
		searchPartner=(String)alphaTree.first()+"*";	
%>
