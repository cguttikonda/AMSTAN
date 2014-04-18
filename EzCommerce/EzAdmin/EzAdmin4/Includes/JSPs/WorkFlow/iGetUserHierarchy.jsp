<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>

<%
	String user	= request.getParameter("participant");
	String userType	= request.getParameter("userType");

	if(userType!= null && !"null".equals(userType) && !"".equals(userType))
		userType = userType.trim();
	if(user==null || "null".equals(user))
		user = "";
	
	int listRetCount= 0;
	String lable1 = "",lable2 = "",userId="",userName="";	
	ezc.ezparam.ReturnObjFromRetrieve listRet = null;
	if(user!= null && !"null".equals(user) && !"".equals(user) )
	{
		ezc.ezparam.EzcParams mainParams	= new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziOrganogramLevelsParams params = new ezc.ezworkflow.params.EziOrganogramLevelsParams();
		params.setCode(user);
		params.setDescription("USERHIERARCHY");
		if("SOLDTO".equals(userType) || "SOLDTO"==userType)
			params.setParticipantType("SOLDTO");
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsDetails(mainParams);
	
		if(listRet!= null)
		{
			listRetCount = listRet.getRowCount();
		}	
	}
	
	if("SOLDTO".equals(userType) || "SOLDTO"==userType)
	{
		lable1 	= "Sold To";
		lable2 	= "User Id";
	}	
	else
	{
		lable1 	= "User Id";
		lable2 	= "Sold To";
	}	
%>
