<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	
	String selected = "",levelKey = "",levelValue = "";
	String level = "",delSrcLevel = "" , delDstLevel = "";	
	String actionRole 	= (request.getParameter("actionRole")).toUpperCase();
	String lineIndex 	= request.getParameter("lineIndex");
	
	int listGroupCount = 0;
	int listUserCount  = 0;
	
	java.util.Hashtable hashLevel = new java.util.Hashtable();
	hashLevel.put("G","Group Level");
	hashLevel.put("U","User Level");
	java.util.Enumeration enumLevel = hashLevel.keys();
	

	if(request.getParameter("Level") != null)
		level = request.getParameter("Level");

	if(request.getParameter("delSrcLevel") != null)	
		delSrcLevel = request.getParameter("delSrcLevel");
		
	if(request.getParameter("delDstLevel") != null)		
		delDstLevel = request.getParameter("delDstLevel");
		
		
	ezc.ezparam.ReturnObjFromRetrieve listGroupRet = null;
	ezc.ezparam.ReturnObjFromRetrieve listUserRet = null;
	
	String destLabel = "Destination Group";
	if(level != null)
	{
		ezc.ezparam.EzcParams mainGroupParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams groupParams= new ezc.ezworkflow.params.EziWorkGroupsParams();
		groupParams.setRoleNo(actionRole);
		mainGroupParams.setObject(groupParams);
		Session.prepareParams(mainGroupParams);
		listGroupRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainGroupParams);
		listGroupCount = listGroupRet.getRowCount();
		if("U".equals(level))
		{
			destLabel = "Destination User";
			ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupUsersParams paramsu= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
			paramsu.setGroupId("'"+request.getParameter("delSrcLevel")+"'");
			mainParamsu.setObject(paramsu);
			Session.prepareParams(mainParamsu);
			listUserRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupUsers(mainParamsu);		
			listUserCount = listUserRet.getRowCount();
			listUserRet.toEzcString();
		}
	}	
	
%>