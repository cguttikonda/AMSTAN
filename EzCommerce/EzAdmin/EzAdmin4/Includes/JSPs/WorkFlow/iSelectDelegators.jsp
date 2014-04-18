<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%
	
	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );
	int retRolesCount = 0;
	if(retRoles != null)
		retRolesCount = retRoles.getRowCount();
	
	
	String selected = "",levelKey = "",levelValue = "";
	String level = "",delSrcLevel = "" , delDstLevel = "";	
	String actionRole 	= "";
	String actionDelRole	= "";
	String delDestLevel	= "";   
	
	int listGroupCount = 0;
	int listGroupCount1 = 0;
	int listUserCount  = 0;
	int listUserCount1  = 0;
	
	java.util.Hashtable hashLevel = new java.util.Hashtable();
	hashLevel.put("G","Group Level");
	hashLevel.put("U","User Level");
	java.util.Enumeration enum1Level = hashLevel.keys();
	

	if(request.getParameter("Role") != null)
		actionRole = request.getParameter("Role");
		
	if(request.getParameter("DelRole") != null)
		actionDelRole = request.getParameter("DelRole");

		

	if(request.getParameter("Level") != null)
		level = request.getParameter("Level");

	if(request.getParameter("delSrcLevel") != null)	
		delSrcLevel = request.getParameter("delSrcLevel");
		
	if(request.getParameter("delDestLevel") != null)	
		delDestLevel = request.getParameter("delDestLevel");
	
		
	if(request.getParameter("delDstLevel") != null)		
		delDstLevel = request.getParameter("delDstLevel");
		
		
	ezc.ezparam.ReturnObjFromRetrieve listGroupRet = null;
	ezc.ezparam.ReturnObjFromRetrieve listGroupRet1 = null;
	ezc.ezparam.ReturnObjFromRetrieve listUserRet = null;
	ezc.ezparam.ReturnObjFromRetrieve listUserRet1 = null;
	String destLabel = "";
	destLabel = "Delegated Group";
	if(actionRole!=null && level != null && !"".equals(actionRole) && !"".equals(level))
	{
		
		ezc.ezparam.EzcParams mainGroupParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams groupParams= new ezc.ezworkflow.params.EziWorkGroupsParams();
		groupParams.setRoleNo(actionRole);
		mainGroupParams.setObject(groupParams);
		Session.prepareParams(mainGroupParams);
		listGroupRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainGroupParams);
		listGroupCount = listGroupRet.getRowCount();
		
		ezc.ezparam.EzcParams mainGroupParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams groupParams1= new ezc.ezworkflow.params.EziWorkGroupsParams();
		groupParams1.setRoleNo(actionDelRole);
		mainGroupParams1.setObject(groupParams1);
		Session.prepareParams(mainGroupParams1);
		listGroupRet1=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainGroupParams1);
		listGroupCount1 = listGroupRet1.getRowCount();
		
		if("U".equals(level))
		{
			destLabel = "Delegated User";
			ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupUsersParams paramsu= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
			paramsu.setGroupId("'"+request.getParameter("delSrcLevel")+"'");
			mainParamsu.setObject(paramsu);
			Session.prepareParams(mainParamsu);
			listUserRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupUsers(mainParamsu);		
			listUserCount = listUserRet.getRowCount();
			
			ezc.ezparam.EzcParams mainParamsu1 = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupUsersParams paramsu1= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
			paramsu1.setGroupId("'"+delDestLevel+"'");
			mainParamsu1.setObject(paramsu1);
			Session.prepareParams(mainParamsu1);
			listUserRet1=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupUsers(mainParamsu1);		
			listUserCount1 = listUserRet1.getRowCount();

			
		}
	}	
	
%>