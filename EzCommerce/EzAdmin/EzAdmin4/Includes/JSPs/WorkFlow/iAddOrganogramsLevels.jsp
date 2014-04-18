<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ include file="../../Lib/EzWorkFlowBean.jsp" %>
<%
	// To get List of Steps
	String templateCode=request.getParameter("templateCode");
	String orgCode=request.getParameter("orgCode");
	String orgDesc=request.getParameter("orgDesc");

	String level = null;
	String role =null;
	String opType =null;
	String tempLevel = request.getParameter("level");
	java.util.StringTokenizer myStk = new java.util.StringTokenizer(tempLevel,",");
	level = myStk.nextToken();
	role = myStk.nextToken();
	opType = myStk.nextToken();

	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams stepsParams= new ezc.ezworkflow.params.EziTemplateStepsParams();
	stepsParams.setCode(templateCode);
	myParams.setObject(stepsParams);
	Session.prepareParams(myParams);
	ezc.ezparam.ReturnObjFromRetrieve retSteps=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(myParams);

	// To get List of Roles
	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );

	// To get List of Work Groups
	ezc.ezparam.ReturnObjFromRetrieve retGroups = null;
	if(role!=null)
	{
		ezc.ezparam.EzcParams myWGParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams workGroupParams= new ezc.ezworkflow.params.EziWorkGroupsParams();
		workGroupParams.setRoleNo(role);
		myWGParams.setObject(workGroupParams);
		Session.prepareParams(myWGParams);
		retGroups=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(myWGParams);
	}
	//To get Organogram Details
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziOrganogramLevelsParams params1= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
	params1.setCode(orgCode);
	mainParams1.setObject(params1);
	Session.prepareParams(mainParams1);
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<");
	ezc.ezparam.ReturnObjFromRetrieve levels=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsList(mainParams1);
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<");
%>
